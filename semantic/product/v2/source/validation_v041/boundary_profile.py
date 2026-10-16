"""Typed external references. Accepts contract shape, never owner equivalence."""
import json
from pathlib import Path
from occurrence_profile import iri
NATIVE=json.loads((Path(__file__).parent/'inputs/Native_Model_v0_41_0.json').read_text())
ELEMENTS={e['id']:e for e in NATIVE['elements']}

def assess(reference):
 errors=[]
 handle=ELEMENTS.get(reference.get('handle'))
 contract=handle.get('customProperties',{}).get('v0_41_boundary_contract') if handle else None
 if not contract:return dict(status='REVIEW_REQUIRED',errors=['NO_IMPLEMENTED_TYPED_BOUNDARY_CONTRACT'])
 if not iri(reference.get('target')):errors.append('TARGET_IRI_REQUIRED')
 if not iri(reference.get('source')):errors.append('SOURCE_IRI_REQUIRED')
 if not isinstance(reference.get('version'),str) or not reference['version'].strip():errors.append('VERSION_REQUIRED')
 kind=reference.get('kind')
 if kind not in contract['allowed_target_kinds']:errors.append('TARGET_KIND_MISMATCH')
 if reference.get('equivalentClass') or reference.get('sameAs'):errors.append('EQUIVALENCE_NOT_AUTHORIZED')
 if reference.get('roostCandidate') and kind!='executable_code' and reference['handle'].endswith('Test_Script'):errors.append('MANUAL_PROCEDURE_IS_NOT_ROOST_SCRIPT')
 if reference['handle'].endswith('Competitor_Alternative'):
  if any(not isinstance(reference.get(k),str) or not reference[k].strip() for k in contract['required_context']):errors.append('COMPETITIVE_CONTEXT_REQUIRED')
  if kind=='competitor_role' and reference.get('class_locator')!=contract['competitor_class_locator']:errors.append('PINNED_COMPETITOR_CLASS_REQUIRED')
  if kind=='alternative_assertion':
   if reference.get('predicate')!=contract['alternative_property_locator']:errors.append('PINNED_ALTERNATIVE_PREDICATE_REQUIRED')
   if not all(iri(reference.get(k)) for k in ['subject','object']):errors.append('ALTERNATIVE_ENDPOINTS_REQUIRED')
   if reference.get('class_locator'):errors.append('ALTERNATIVE_ASSERTION_IS_NOT_AN_IMPORTED_CLASS')
 return dict(status='REJECTED' if errors else 'CONTRACT_CONFORMING_ONLY',errors=errors,semantic_equivalence=False,owner_acceptance=False)
