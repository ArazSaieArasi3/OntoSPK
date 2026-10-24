"""Trace every local grounding question to a bounded, explicit review decision."""
import json
from collections import Counter
from evaluation_common import ROOT, SOURCE, sha, write_json

NATIVE=SOURCE/'formalization/Native_Model_v0_41_0.json'
REGISTER=SOURCE/'formalization/Class_Grounding_Register_128.json'
MATRIX=SOURCE/'t52_formalization_v043/Commitment_Matrix_22_v0_43_0.json'
DECISIONS=ROOT/'tools/publication/local_identity_decisions.json'
model=json.loads(NATIVE.read_text());elements={e['id']:e for e in model['elements']}
grounding=json.loads(REGISTER.read_text());local={r['id']:r for r in grounding if r['scope']=='LOCAL'}
source=json.loads(DECISIONS.read_text());questions={i:r for i,r in local.items() if r.get('review_question')}
assert len(local)==101 and len(questions)==37
assert all(local[i]['stereotype']==elements[i]['stereotype'] and local[i]['identity_commitment'] for i in local)
assigned=[i for d in source['decisions'] for i in d['native_ids']]
assert len(assigned)==len(set(assigned))==39
assert set(assigned)==set(questions)|{'IC:ProductRealization','IC:ProductCapability'}
rows=[]
for decision in source['decisions']:
    for identifier in decision['native_ids']:
        row=local[identifier]
        rows.append({'native_id':identifier,'source_review_question':row.get('review_question') or 'Updated concrete realization/mode identity commitment (ID03/ID04).',
                     'source_definition':row['definition']['en'],'source_identity_commitment':row['identity_commitment'],
                     'stereotype':row['stereotype'],'decision':decision['id'],
                     'assessment':decision['assessment'],'limit':decision['limit'],
                     'status':decision['status'],'independent_acceptance':False})
report={'status':'BOUNDED_LOCAL_REVIEW_COMPLETE_WITH_RETAINED_LIMITS','issue':28,'release_target':'v2.0.4',
        'review_date':source['review_date'],'ontology_core':'v2.0.0',
        'source_sha256':{p.relative_to(ROOT).as_posix():sha(p) for p in (NATIVE,REGISTER,MATRIX,DECISIONS)},
        'local_classes':101,'local_stereotypes':dict(Counter(r['stereotype'] for r in local.values())),
        'existing_review_questions':37,'reviewed_entries':39,'decision_groups':source['decisions'],'rows':rows,
        'primary_sources':source['sources'],
        'profile_finding':{'native_id':'IC:ProductCapability','native_stereotype':elements['IC:ProductCapability']['stereotype'],
                           'native_isAbstract':elements['IC:ProductCapability']['isAbstract'],
                           'reference_page_abstract':True,'source':'S2','followup_issue':48,
                           'disposition':'Preserve the released concrete project profile; withhold strict reference-profile conformance pending explicit adjudication.'},
        'preserved_scope':{'native_logical_changes':0,'boundary_changes':0,'private_repository_reads_or_changes':0,
                           'new_ontology_imports':0,'new_external_mappings':0},
        'limits':['No independent expert acceptance or empirical continuity truth is established.',
                  'The separate transition policy consumes declared canonical identifiers/evidence; it is not an OWL identity theorem.',
                  'Static bearer cardinality is not a complete modal dependence or disposition-destruction theory.',
                  'Occurrence admission covers concluded reports; target binding does not prove participation or full causal adequacy.',
                  'Legacy application SQL and policy integration are bounded implementation surfaces, not a production guarantee.',
                  'External alignment and ROoST comparison remain owner-deferred; existing candidate text is preserved.']}
assert report['profile_finding']['native_isAbstract'] is False
write_json('evaluation/local-identity-review.json',report)
lines=['# Local identity, bearer and event review — issue #28','',
       '**The bounded local review is complete; scientific limits are retained.** All 37 existing local grounding questions have an explicit assessment. Two updated realization/capability commitments bring the review to 39 entries in ten decision groups. This is a review of existing authored choices, not independent domain acceptance or a full UFO conformance proof.','',
       '## Decisions and rationale','', '| Group | Existing interpretation retained | Limit |','| --- | --- | --- |']
lines += [f"| {d['id']} — {d['title']} | {d['assessment']} | {d['limit']} |" for d in source['decisions']]
lines += ['', '## Question-by-question trace','', '| Native concept | Existing review question | Decision |','| --- | --- | --- |']
lines += [f"| `{r['native_id']}` | {r['source_review_question'].replace('|',' / ')} | {r['decision']} |" for r in rows]
lines += ['', '## One concrete native-profile discrepancy','',
          'The frozen ProductCapability is a concrete `mode` (`isAbstract=false`). The inspected OntoUML Mode page displays `Abstract=True`. Its characterization and one-bearer requirements are compatible with the current native relation, but that does not remove the abstractness discrepancy. Preserve the released instances/profile and withhold a strict full-reference-profile conformance claim. [Issue #48](https://github.com/ArazSaieArasi3/OntoSPK/issues/48) tracks the exact profile choice and migration assessment. A blind flag toggle is not a justified semantic repair.','',
          '## Executed evidence and scope','',
          'The [focused executable tests](local-identity-tests.md) record the finite identity-transition grid, replay of retained cases, bounded native taxonomy/bearer checks, legacy ledger controls and occurrence/history contrasts. They test supplied declarations and finite data. The existing HermiT/SHACL/CQ suite is rerun separately by CI; no theorem about arbitrary worlds, empirical continuity, or full causal adequacy is inferred.','',
          'The transition policy remains separate from combined occurrence admission. An IRI used as evidence is not evidence truth. A documented direct-DML limit of the retained legacy ledger is kept visible, not repaired in the frozen source. These limits are not hidden inside pass percentages.','',
          'All 543 semantic files and all 27 boundaries remain frozen, verified by the [preservation gate](market-boundary-preservation.md). Private repositories, external rewiring and new ROoST alignment remain deferred. This review introduces no axioms, identifiers, stereotypes or model migration. It can be published as documentation/evidence patch v2.0.4; v2.1.0 remains conditional on a later accepted semantic change.','',
          '## Primary comparison sources','']
lines += [f"- [{s['id']}] [{s['url']}]({s['url']}) — observed {s['observed']}; {s['use']}" for s in source['sources']]
lines += ['', 'These sources support conceptual/structural comparison only. gUFO distinguishes endurants, intrinsic modes and events and provides explicit participation relations with bounded UFO-B support. No gUFO import, exact equivalentClass mapping or new foundational profile is asserted.','',
          '[Exact source hashes and all 39 assessments](local-identity-review.json) · [Executable tests](local-identity-tests.md)','',
          'Reproduce: `python tools/publication/build_local_identity_review.py` followed by `python tools/publication/test_local_identity_review.py`.','']
(ROOT/'evaluation/local-identity-review.md').write_text('\n'.join(lines))
print(json.dumps({'status':report['status'],'source_questions':37,'reviewed_entries':39,'decision_groups':10,'retained_profile_findings':1}))
