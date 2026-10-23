"""Resolve the five Business boundary policies from already public inputs.

No private owner ontology is downloaded, copied, or treated as an accepted
alignment. The dated repository-visibility observation is kept separate from
the reproducible extraction of the public native/logical contracts.
"""
from pathlib import Path
import csv
import hashlib
import json
from rdflib import Graph, OWL, RDF, RDFS, URIRef
from evaluation_common import ROOT, SOURCE, sha, write_json

NATIVE=SOURCE/'formalization/Native_Model_v0_41_0.json'
LOGICAL=SOURCE/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
CROSSWALK=SOURCE/'validation_v041/inputs/Relation_OWL_SQL_Crosswalk_v0_16_0.csv'
PROJECTION=ROOT/'semantic/product/v2/reference/native-class-projection.csv'
REGISTER=ROOT/'evaluation/external-boundary-status.json'
assert sha(NATIVE)=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
assert sha(LOGICAL)=='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12'
model=json.loads(NATIVE.read_text());elements={e['id']:e for e in model['elements']}
graph=Graph().parse(LOGICAL)
with CROSSWALK.open(encoding='utf-8-sig') as f:crosswalk={r['relation_id']:r for r in csv.DictReader(f)}
with PROJECTION.open(encoding='utf-8-sig') as f:projection={r['native_id']:r for r in csv.DictReader(f)}
historical={r['native_id']:r for r in json.loads(REGISTER.read_text())['rows']}
ids=sorted(i for i in elements if i.startswith('EXT:Business:'))
assert ids==['EXT:Business:BusinessCapability','EXT:Business:BusinessGoal','EXT:Business:BusinessRule',
             'EXT:Business:Service','EXT:Business:ValueProposition']
expected_kinds={'BusinessCapability':'business_capability','BusinessGoal':'business_goal',
                'BusinessRule':'business_rule','Service':'business_service','ValueProposition':'value_proposition'}
rows=[];relations=[]
for identifier in ids:
    element=elements[identifier];contract=element['customProperties']['v0_17_boundary_contract']
    local_name=identifier.split(':')[-1]
    kind=contract['allowed_target_kinds']
    assert kind==expected_kinds[local_name]
    assert element['stereotype'] is None and contract['ufo_stereotype']=='UNASSIGNED'
    assert contract['semantic_equivalence']=='NOT_ASSERTED'
    assert not projection[identifier]['mapped_iri']
    incident=[]
    proxies=set()
    for relation in model['elements']:
        if relation['type']!='BinaryRelation':continue
        ends=[elements[p] for p in relation['properties']]
        if not any(p['propertyType']==identifier for p in ends):continue
        assert ends[1]['propertyType']==identifier
        mapped=crosswalk[relation['id']]
        predicate=URIRef(mapped['predicate'])
        assert (predicate,RDF.type,OWL.ObjectProperty) in graph
        assert mapped['direction']=='SAME' and mapped['external_typing']=='UNVERIFIED_BOUNDARY'
        ranges=sorted(str(x) for x in graph.objects(predicate,RDFS.range) if isinstance(x,URIRef))
        proxies.update(x for x in ranges if x.startswith('urn:product-ontology:external-boundary:'))
        record={'native_relation_id':relation['id'],'title':relation['name']['en'],
                'source_id':ends[0]['propertyType'],'target_id':ends[1]['propertyType'],
                'per_source_target_bounds':ends[1]['cardinality'],
                'per_target_source_bounds':ends[0]['cardinality'],
                'logical_predicate':str(predicate),'logical_ranges':ranges,
                'logical_role':'generic reference target' if local_name=='BusinessRule' else 'local boundary placeholder',
                'owner_equivalence':False}
        incident.append(record);relations.append(record)
    if local_name=='BusinessRule':
        assert len(incident)==1 and incident[0]['per_source_target_bounds']=='1'
        assert incident[0]['logical_predicate']=='urn:productium:specification-profile:referenceTarget'
        assert not proxies
        representation='BusinessRuleReference is a local reference record; referenceTarget has no asserted BusinessRule owner-class range.'
    else:
        assert len(proxies)==1
        for proxy in proxies:
            assert (URIRef(proxy),RDF.type,OWL.Class) in graph
            assert not list(graph.objects(URIRef(proxy),OWL.equivalentClass))
        representation='The released property range uses a local boundary placeholder, not an imported or owner-equivalent class.'
    rows.append({'native_id':identifier,'display_label':contract['display_label'],
                 'allowed_target_kind':kind,'public_operational_definition':contract['operational_definition'],
                 'definition_source':'OntoSPK v2.0.0 native model, customProperties.v0_17_boundary_contract',
                 'accepted_policy':'REFERENCE_ONLY_WITH_LOCAL_OPERATIONAL_CONTRACT',
                 'recorded_owner_repository':historical[identifier]['recorded_owner_repository'],
                 'recorded_owner_commit':historical[identifier]['recorded_owner_commit'],
                 'recorded_owner_class_locator':contract['owner_class_locator'],
                 'owner_locator_interpretation':'rename candidate only' if local_name=='Service' else 'historically observed same-name declaration only',
                 'accepted_owner_mapping':None,'rejected_alignment':'Automatic equivalentClass/sameAs from names or a source locator',
                 'unresolved_external_question':'Publicly reproducible owner-definition compatibility and foundational alignment are not accepted.',
                 'ufo_stereotype':'UNASSIGNED','semantic_equivalence':'NOT_ASSERTED',
                 'native_projection_status':projection[identifier]['mapping_basis'],
                 'local_logical_boundary_iris':sorted(proxies),'logical_representation':representation,
                 'incident_relations':incident,'frozen_model_effect':'NONE'})
assert len(relations)==8
assert sum(len(r['local_logical_boundary_iris']) for r in rows)==4
business=elements['EXT:Business:Service']['customProperties']['v0_17_boundary_contract']
architecture=elements['EXT:Architecture:Service']['customProperties']['v0_17_boundary_contract']
assert business['allowed_target_kinds']!=architecture['allowed_target_kinds']
service={'native_business_handle':'EXT:Business:Service','business_display_label':business['display_label'],
         'business_allowed_kind':business['allowed_target_kinds'],
         'business_definition':business['operational_definition'],
         'candidate_owner_name':'BusinessService',
         'native_architecture_handle':'EXT:Architecture:Service',
         'architecture_allowed_kind':architecture['allowed_target_kinds'],
         'architecture_definition':architecture['operational_definition'],
         'decision':'Keep the stable Business handle; display Business Service; reject treating architecture_service as its typed record kind. BusinessService remains an owner rename candidate, not an accepted equivalence or an IRI rewrite.',
         'not_claimed':'Different concept IRIs do not assert owl:disjointWith or establish individual inequality.'}
report={'review_id':'BUSINESS-BOUNDARY-REVIEW-1','status':'REFERENCE_ONLY_POLICIES_DECIDED',
        'issue':23,'ontology_core':'v2.0.0','review_scope':'Four named Business targets and one Service rename candidate',
        'public_authority':'The already published OntoSPK operational contracts, not a private owner definition.',
        'source_sha256':{str(p.relative_to(ROOT)):sha(p) for p in (NATIVE,LOGICAL,CROSSWALK,PROJECTION,REGISTER)},
        'owner_metadata_observation':{'repository':'ArazSaieArasi3/business-ontology','visibility':'private',
          'observed_date':'2026-10-23','method':'Authenticated repository metadata and presence of the previously recorded revision; no owner payload copied.',
          'recorded_snapshot':'1cd8e02b4786ac9f0c50f2936912b63e32aed360',
          'public_owner_snapshot_selected':None},
        'rows':rows,'service_decision':service,'relation_count':len(relations),
        'accepted_external_equivalences':0,'new_owned_domain_concepts':0,
        'current_core_typed_adapter_status':'The frozen boundary_profile.assess returns REVIEW_REQUIRED for these five handles because it has no v0_41 typed Business contracts. Do not relabel that legacy outcome as validated.',
        'new_adapter':'tools/boundaries/business_reference.py is a separate explicit reference-record gate; it does not modify or silently replace the frozen runtime.',
        'next_semantic_release':'No native/logical change accepted here. v2.1.0 remains conditional on later scientific decisions; no semantic release is fabricated for this review.',
        'limits':'Local reference structure and public usage are decided; target membership, source truth, public dereferenceability, UFO adequacy and external-owner equivalence are not established.'}
write_json('evaluation/business-boundary-review.json',report)
lines=['# Business boundary contract review','',
       '**Issue #23: the five local reference policies are decided.** Public authority is the existing OntoSPK v2.0.0 operational contract. The separately governed owner repository is private, so no public owner snapshot or owner-equivalent import is accepted. No private owner payload is copied.','',
       '| Stable handle | Public operational meaning in OntoSPK | Accepted local kind | Decision |',
       '| --- | --- | --- | --- |']
lines += [f"| `{r['native_id']}` | {r['public_operational_definition']} | `{r['allowed_target_kind']}` | Keep reference-only; no accepted owner equivalence. |" for r in rows]
lines += ['', 'The definitions above are reproduced from the already public native model, not from the private Business ontology. They explain OntoSPK usage without requiring a reader to fetch a private repository. The four same-name declarations are historical evidence, not definition-equivalence proofs.','',
          '## Service versus BusinessService','',service['decision'],'',
          f"The native architecture service contract uses `{architecture['allowed_target_kinds']}`: {architecture['operational_definition']} The business contract uses `{business['allowed_target_kinds']}`: {business['operational_definition']}",'',
          'The existing stable native ID remains `EXT:Business:Service`, the native display is **Business Service**, and the owner `BusinessService` locator remains a rename candidate. Neither the Business handle nor the architecture handle is retargeted or merged. Different IRIs do not themselves establish disjoint classes or distinct individuals.','',
          '## All eight native uses and their existing logical projection','',
          '| Native relation | Source | Relation | Business target | Targets per source | Existing OWL predicate |',
          '| --- | --- | --- | --- | --- | --- |']
lines += [f"| `{r['native_relation_id']}` | `{r['source_id']}` | {r['title']} | `{r['target_id']}` | `{r['per_source_target_bounds']}` | `{r['logical_predicate']}` |" for r in sorted(relations,key=lambda r:r['native_relation_id'])]
lines += ['', 'Four Business kinds have local OWL boundary placeholders used as ranges by seven relations. BusinessRule instead uses the local `BusinessRuleReference` record and generic `referenceTarget` predicate, with no asserted BusinessRule owner-class range. The native-to-OWL class projection register deliberately asserts no authoritative mapping for any of the five handles. A traced boundary range is not an accepted mapping to the owner ontology.','',
          '## Accepted, rejected and unresolved','',
          '- **Accepted:** five local operational reference contracts, their kinds and the eight released relation signatures. Preserve the core and record target/source/version provenance.',
          '- **Rejected:** automatic equivalence from equal names, an unreviewed Service → BusinessService IRI rename, merging business/architecture service contracts, and adding an owner ontology as a runtime import.',
          '- **Unresolved externally:** authoritative owner-definition compatibility, target membership and UFO typing. These are not needed to choose the current reference-only policy. A future locally owned concept or accepted owner mapping requires an explicit new semantic identity and review, not a change to frozen v2.0.0.','',
          '## Executable reference-record gate','',
          'The released legacy boundary gate returns REVIEW_REQUIRED for all five Business handles: it has no v0_41 typed Business contract. The new **separate adapter** at `tools/boundaries/business_reference.py` implements this reviewed local record policy. It requires a stable handle, an allowed kind, one target IRI, a source IRI and a nonempty version; it rejects equivalence/owner-acceptance flags and an inconsistent supplied class locator. Passing means local record conformance only. It neither proves target membership nor fetches an owner repository.','',
          '```bash','python tools/boundaries/business_reference.py --input reference.json',
          'python tools/publication/test_business_boundary_contract.py','```','',
          'Native, OWL, SHACL, Wiki and existing frozen publication mappings are unchanged. This is a documented/executable reference policy; no new semantic release is claimed. A complete RDF population still needs its existing SHACL validation; a valid JSON reference record is not whole-population or independent scientific acceptance.','',
          '## Public sources and reproducibility','',
          '- [Frozen native contracts](../semantic/product/v2/source/formalization/Native_Model_v0_41_0.json)',
          '- [Frozen logical profile](../semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl)',
          '- [Published historical external register](external-boundary-status.json)',
          '- [Exact source paths, hashes, decisions and eight relation signatures](business-boundary-review.json)',
          '- [Executable contract test report](business-boundary-tests.md)','',
          'Run `python tools/publication/build_business_boundary_review.py` from the repository root to reproduce the public extraction. The private-visibility observation is a dated metadata readback, not a claim that this generator performs an online owner-definition review.','']
(ROOT/'evaluation/business-boundary-review.md').write_text('\n'.join(lines))
print(json.dumps({'status':report['status'],'handles':len(rows),'relations':len(relations),'local_boundary_proxies':4,'accepted_owner_equivalences':0}))
