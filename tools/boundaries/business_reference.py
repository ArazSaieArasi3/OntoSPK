"""Explicit local record gate for five Business reference-only handles.

This adapter is separate from the frozen core runtime. Conformance says nothing
about target membership, owner acceptance or truth/dereferenceability of IRIs.
"""
from pathlib import Path
from urllib.parse import urlsplit
import argparse
import json
import re

ROOT=Path(__file__).resolve().parents[2]
CONTRACT=ROOT/'evaluation/business-boundary-review.json'
ALLOWED_FIELDS={'handle','kind','target','source','version','class_locator',
                'equivalentClass','sameAs','semantic_equivalence','owner_acceptance'}

def absolute_iri(value):
    if not isinstance(value,str) or not value or re.search(r'[\s<>"{}|\\^`]',value):return False
    if re.search(r'%(?![0-9A-Fa-f]{2})',value):return False
    try:
        parsed=urlsplit(value)
        if parsed.scheme in ('http','https'):
            if parsed.port is not None and not 1 <= parsed.port <= 65535:return False
            return bool(parsed.hostname) and not parsed.username and not parsed.password
        if parsed.scheme=='urn':
            return bool(re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9-]{0,31}:.+',parsed.path))
    except ValueError:
        return False
    return False

def assess(reference, report=None):
    result={'status':'REJECTED','semantic_equivalence':False,'owner_acceptance':False,
            'target_membership_verified':False,'source_truth_verified':False,'network_access_performed':False}
    if not isinstance(reference,dict):return dict(result,errors=['REFERENCE_OBJECT_REQUIRED'])
    report=report or json.loads(CONTRACT.read_text())
    contracts={r['native_id']:r for r in report['rows']}
    handle=reference.get('handle')
    if not isinstance(handle,str) or handle not in contracts:
        return dict(result,status='REVIEW_REQUIRED',errors=['OUTSIDE_REVIEWED_BUSINESS_SCOPE'])
    contract=contracts[handle];errors=[]
    if set(reference)-ALLOWED_FIELDS:errors.append('UNSUPPORTED_REFERENCE_FIELDS')
    if reference.get('kind')!=contract['allowed_target_kind']:errors.append('TARGET_KIND_MISMATCH')
    if not absolute_iri(reference.get('target')):errors.append('TARGET_IRI_REQUIRED')
    if not absolute_iri(reference.get('source')):errors.append('SOURCE_IRI_REQUIRED')
    version=reference.get('version')
    if not isinstance(version,str) or not version.strip():errors.append('VERSION_REQUIRED')
    if 'class_locator' in reference and reference['class_locator']!=contract['recorded_owner_class_locator']:
        errors.append('UNREVIEWED_CLASS_LOCATOR')
    if any(reference.get(flag) is not None and reference.get(flag) is not False
           for flag in ('equivalentClass','sameAs','semantic_equivalence','owner_acceptance')):
        errors.append('OWNER_ALIGNMENT_NOT_AUTHORIZED')
    return dict(result,status='REJECTED' if errors else 'LOCAL_REFERENCE_CONFORMING_ONLY',
                errors=errors,handle=handle,display_label=contract['display_label'],
                contract_revision=report['review_id'],
                supplied_class_locator_status=contract['owner_locator_interpretation'] if 'class_locator' in reference else 'NOT_SUPPLIED')

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--input',type=Path,required=True);args=ap.parse_args()
    outcome=assess(json.loads(args.input.read_text()))
    print(json.dumps(outcome,indent=2))
    raise SystemExit(0 if outcome['status']=='LOCAL_REFERENCE_CONFORMING_ONLY' else 2 if outcome['status']=='REVIEW_REQUIRED' else 1)
