"""Test source traceability, service separation and fail-closed record behavior."""
from pathlib import Path
import copy
import importlib.util
import json
import subprocess
import sys
import tempfile
from evaluation_common import ROOT, sha, write_json

path=ROOT/'tools/boundaries/business_reference.py'
spec=importlib.util.spec_from_file_location('business_reference',path)
adapter=importlib.util.module_from_spec(spec);spec.loader.exec_module(adapter)
report=json.loads((ROOT/'evaluation/business-boundary-review.json').read_text())
native=json.loads((ROOT/'semantic/product/v2/source/formalization/Native_Model_v0_41_0.json').read_text())
native_elements={e['id']:e for e in native['elements']}
for row in report['rows']:
    assert not native_elements[row['native_id']]['customProperties'].get('v0_41_boundary_contract')
for source,digest in report['source_sha256'].items():assert sha(ROOT/source)==digest
assert len(report['rows'])==5 and report['relation_count']==8
assert report['accepted_external_equivalences']==report['new_owned_domain_concepts']==0
cases=[]
def check(name,data,status,error=None):
    before=copy.deepcopy(data)
    actual=adapter.assess(data,report)
    assert data==before,'Input was mutated'
    assert actual['status']==status,(name,actual)
    if error:assert error in actual['errors'],(name,actual)
    assert not any(actual[f] for f in ('semantic_equivalence','owner_acceptance',
                                     'target_membership_verified','source_truth_verified','network_access_performed'))
    cases.append({'id':name,'input':data,'expected_status':status,'expected_error':error,'actual':actual,'status':'PASS'})

for contract in report['rows']:
    handle=contract['native_id']
    good={'handle':handle,'kind':contract['allowed_target_kind'],'target':'urn:ontospk:synthetic:business-target',
          'source':'https://example.org/declared-source','version':'synthetic-v1'}
    check(handle+':valid',good,'LOCAL_REFERENCE_CONFORMING_ONLY')
    with_locator=dict(good,class_locator=contract['recorded_owner_class_locator'])
    check(handle+':locator_is_not_acceptance',with_locator,'LOCAL_REFERENCE_CONFORMING_ONLY')
    for field,err in [('kind','TARGET_KIND_MISMATCH'),('target','TARGET_IRI_REQUIRED'),('source','SOURCE_IRI_REQUIRED'),('version','VERSION_REQUIRED')]:
        changed=dict(good);del changed[field]
        check(handle+':missing_'+field,changed,'REJECTED',err)
    for field in ('target','source'):
        for value in ('relative/path','https:///missing-host','urn:','urn:only_namespace','https://example.org/bad path','https://example.org/%ZZ',['urn:two:targets'],'https://user:password@example.org/','https://example.org:bad/','https://example.org:65536/','https://example.org:0/'):
            check(handle+':invalid_'+field+'_'+str(len(cases)),dict(good,**{field:value}),'REJECTED',field.upper()+'_IRI_REQUIRED')
    check(handle+':blank_version',dict(good,version='  '),'REJECTED','VERSION_REQUIRED')
    check(handle+':architecture_kind',dict(good,kind='architecture_service'),'REJECTED','TARGET_KIND_MISMATCH')
    for flag in ('equivalentClass','sameAs','semantic_equivalence','owner_acceptance'):
        check(handle+':claim_'+flag,dict(good,**{flag:True}),'REJECTED','OWNER_ALIGNMENT_NOT_AUTHORIZED')
    check(handle+':explicit_false_flags',dict(good,semantic_equivalence=False,owner_acceptance=False),'LOCAL_REFERENCE_CONFORMING_ONLY')
    check(handle+':wrong_locator',dict(good,class_locator='urn:ontospk:synthetic:architecture-service'),'REJECTED','UNREVIEWED_CLASS_LOCATOR')
    check(handle+':rdf_equivalence_field',dict(good,**{'owl:equivalentClass':'urn:example:owner'}),'REJECTED','UNSUPPORTED_REFERENCE_FIELDS')
    check(handle+':other_business_kind',dict(good,kind='business_rule' if contract['allowed_target_kind']!='business_rule' else 'business_goal'),'REJECTED','TARGET_KIND_MISMATCH')
    # Conformance cannot establish truth of source/version or actual membership.
    check(handle+':synthetic_provenance_not_verified',dict(good,source='urn:unknown:source',version='unverified-claim'),'LOCAL_REFERENCE_CONFORMING_ONLY')

check('outside_architecture',{'handle':'EXT:Architecture:Service'},'REVIEW_REQUIRED','OUTSIDE_REVIEWED_BUSINESS_SCOPE')
check('outside_unknown',{'handle':'EXT:Business:Unknown'},'REVIEW_REQUIRED','OUTSIDE_REVIEWED_BUSINESS_SCOPE')
check('malformed_reference',[],'REJECTED','REFERENCE_OBJECT_REQUIRED')
service=next(r for r in report['rows'] if r['native_id']=='EXT:Business:Service')
assert service['display_label']=='Business Service' and service['allowed_target_kind']=='business_service'
assert service['recorded_owner_class_locator'].endswith('#BusinessService')
assert service['accepted_owner_mapping'] is None and service['owner_locator_interpretation']=='rename candidate only'
assert len({r['native_relation_id'] for c in report['rows'] for r in c['incident_relations']})==8
assert len({iri for c in report['rows'] for iri in c['local_logical_boundary_iris']})==4
with tempfile.TemporaryDirectory() as folder:
    inp=Path(folder)/'reference.json'
    for data,expected in [(cases[0]['input'],0),({'handle':'EXT:Architecture:Service'},2),([],1)]:
        inp.write_text(json.dumps(data))
        process=subprocess.run([sys.executable,str(path),'--input',str(inp)],capture_output=True,text=True)
        assert process.returncode==expected,(process.returncode,process.stderr)
        assert json.loads(process.stdout)['status'] in ('REJECTED','REVIEW_REQUIRED','LOCAL_REFERENCE_CONFORMING_ONLY')
out={'status':'PASS','reference_cases':len(cases),'cli_exit_controls':3,'native_handles':5,'native_relations':8,
     'logical_boundary_proxies':4,'review_sha256':sha(ROOT/'evaluation/business-boundary-review.json'),
     'adapter_sha256':sha(path),'cases':cases,
     'limits':'These are local record and source-signature tests. No owner membership, external equivalence, live dereferenceability or full RDF population conformance is established.'}
write_json('evaluation/business-boundary-tests.json',out)
(ROOT/'evaluation/business-boundary-tests.md').write_text('\n'.join([
 '# Business reference contract tests','',
 f"All {len(cases)} reference cases and three CLI exit-status controls pass. The reviewed source inventory contains exactly five Business handles, eight incident native relations and four existing logical boundary proxies.",'',
 'The tests cover all five valid kinds; required target/source/version fields; malformed and multi-valued IRIs; cross-family and wrong-kind substitutions; unreviewed class locators; forbidden equivalence/owner-acceptance flags; unknown payload keys; and out-of-scope handles. Inputs are not mutated. Even a syntactically conforming synthetic source/version returns false for owner acceptance, semantic equivalence, verified target membership, source truth and online access.','',
 'The service alias remains a candidate; the stable Business handle and its Business Service display are preserved. The adapter is a separate gate and does not assert that the frozen legacy runtime already implements these Business contracts.','',
 '[Exact inputs and expected/observed outcomes](business-boundary-tests.json) · [Policy and source traceability](business-boundary-review.md)','']))
print(json.dumps({k:v for k,v in out.items() if k not in ('cases',)}))
