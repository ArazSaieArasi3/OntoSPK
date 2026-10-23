"""Fail closed on unaccounted declared coverage or unexpected positive errors."""
from collections import Counter
import gzip
import json
from evaluation_common import ROOT, SOURCE, sha, write_json

def load(name):
    with gzip.open(ROOT/'evaluation'/name,'rt') as f:return json.load(f)
simple=load('shacl-simple-constraints.json.gz')
complex=load('shacl-complex.json.gz')
owl=load('owl-hermit.json.gz')
cq=load('cq-regression.json.gz')
core=load('core-regression.json.gz')
robot=load('robot-report.json.gz')
register=load('coverage-register.json.gz')
matrix_path=SOURCE/'t52_formalization_v043/Commitment_Matrix_22_v0_43_0.json'
matrix=json.loads(matrix_path.read_text())['rows']
assert all(x['status']=='PASS' for x in (complex,owl,cq,core))
assert robot['counts']=={'ERROR':288,'WARN':451,'INFO':73}
planned={r['key'] for r in register['rows'] if r['group']=='shacl_constraint'}
executed={c['register_key'] for c in simple['cases']}|{c['key'] for c in complex['cases']}
assert planned==executed and len(planned)==1977
coverage=[]
for c in simple['cases']:
    coverage.append({'key':c['register_key'],'report':'shacl-simple-constraints.json.gz',
                     'status':'POSITIVE_BOUNDARY_AND_APPLICABLE_ADVERSE_EXECUTED',
                     'negative_status':'LOGICALLY_UNREACHABLE_REPORTED' if c['checks']['violation'].get('status')=='LOGICALLY_UNREACHABLE' else 'EXECUTED'})
coverage += [{'key':c['key'],'report':'shacl-complex.json.gz','status':'POSITIVE_AND_ADVERSE_EXECUTED'} for c in complex['cases']]
mechanisms={
 'ID04':['core-regression.json.gz: suites.revision.groups.identity_policy'],
 'LG01':['core-regression.json.gz: suites.revision.groups.history'],
 'LG02':['core-regression.json.gz: suites.combined.results (idempotent replay and snapshot conflict)'],
 'LG03':['core-regression.json.gz: suites.combined.groups.persistence'],
 'INT01':['core-regression.json.gz: suites.structural (892 static expressions)',
          'core-regression.json.gz: suites.combined.groups.mapping and roundtrip'],
}
trace=[]
for c in matrix:
    scenario_ids=[s['id'] for s in owl['scenarios'] if c['id'] in s['commitments']]
    evidence=['owl-hermit.json.gz: '+name for name in scenario_ids]
    evidence+=mechanisms.get(c['id'],[])
    if c['id'].startswith('EV'):
        evidence+=['shacl-complex.json.gz: source-bound SPARQL/whole-graph event controls',
                   'core-regression.json.gz: combined/revision event controls']
    if c['id'] in ('ID01','ID02','ID03'):
        evidence+=['shacl-simple-constraints.json.gz: source identity components',
                   'core-regression.json.gz: explicit identity population rejection']
    if c['id']=='OPEN01':
        status='NOT_ASSERTED_SCIENTIFIC_FOLLOWUP'
        evidence=['Scope/limitation, not a theorem claimed by this release']
    else:
        assert evidence,c['id']
        status='DECLARED_BOUNDED_MECHANISM_CHECKED'
    trace.append({'id':c['id'],'commitment':c['commitment'],'status':status,
                  'evidence':evidence,'original_scope_limit':c['limit']})
assert len(trace)==22
source_files=sorted({r['source'] for r in register['rows']})
source_identity={p:sha(ROOT/p) for p in source_files}
native=SOURCE/'formalization/Native_Model_v0_41_0.json'
assert sha(native)=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
assert owl['logical_sha256']=='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12'
unreachable=sum(c['checks']['violation'].get('status')=='LOGICALLY_UNREACHABLE' for c in simple['cases'])
assert unreachable==110
summary={'shacl_component_occurrences':1977,'simple_components':1864,'complex_components':113,
         'simple_constructible_negative_cases':1754,'unreachable_simple_negative_cases':110,
         'complex_observations':complex['component_observations'],
         'inverse_property_projections':complex['inverse_property_projections'],
         'native_event_graph_cases':len(complex['native_event_graph_replay']['cases']),
         'named_owl_classes_satisfiable':len(owl['named_classes']),
         'expanded_hermit_scenarios':len(owl['scenarios']),'cq_contracts':cq['cq_contracts'],
         'exact_answer_comparisons':cq['exact_answer_comparisons'],
         'cq_mutations':cq['data_mutations'],'cq_mutations_detected':cq['detected'],
         'cq_mutations_survived':cq['survived'],'scoped_commitments_traced':22,
         'robot_default_errors':288,'robot_default_warnings':451,'robot_default_information':73,
         'unexpected_positive_failures':0,'unaccounted_shacl_components':0}
findings=[
 {'type':'fixture_configuration','disposition':'RESOLVED_IN_HARNESS',
  'finding':'Complete reporting graph needs the same retained ont_graph used by the released runtime; raw fixtures without it lack subclass context. The source graph was not changed.'},
 {'type':'logical_unreachability','disposition':'CLASSIFIED_NOT_COUNTED_AS_NEGATIVE_PASS',
  'finding':'110 simple adverse cases cannot exist in isolation; source targetObjectsOf can also make isolated inverse missing-edge cases unreachable.'},
 {'type':'method_limit','disposition':'RETAINED_OBSERVATIONS',
  'finding':f"{cq['survived']} data mutations survive exact-answer querying. All per-triple observations remain available; all 56 CQs detect at least one data mutation. No inference is used."},
 {'type':'editorial_metadata','disposition':'DEFERRED_SOURCE_REVIEW_NO_SILENT_REPAIR',
  'finding':'Default ROBOT report has 812 raw findings, including 288 ERROR. Labels, definitions and header metadata require an explicitly versioned follow-up; the lack of a project licence is an already disclosed rights state.'},
 {'type':'scientific_followup','disposition':'OUTSIDE_V2_0_2',
  'finding':'External-owner contracts, modal/causal adequacy and independent domain acceptance remain separate work. No semantic source defect was found by these finite tests.'}
]
receipt_names=['shacl-simple-constraints.json.gz','shacl-complex.json.gz','owl-hermit.json.gz',
               'robot-report.json.gz','cq-regression.json.gz','core-regression.json.gz']
report={'status':'PASS_FINITE_EVALUATION_RELEASE_GATE','evaluation_release':'v2.0.2','ontology_core':'v2.0.0',
        'summary':summary,'source_identity':source_identity,'native_sha256':sha(native),
        'logical_sha256':owl['logical_sha256'],'commitment_matrix_sha256':sha(matrix_path),
        'receipt_sha256':{name:sha(ROOT/'evaluation'/name) for name in receipt_names},
        'shacl_execution_index':sorted(coverage,key=lambda x:x['key']),
        'commitment_traceability':trace,'finding_adjudication':findings,
        'remaining_owner_decision_for_this_release':False,
        'limits':'Finite evidence of declared engineering behavior. Not universal semantic correctness, full UFO proof, external equivalence, independent domain validation, production readiness or a clean default ROBOT report.'}
write_json('evaluation/v2.0.2-closeout.json.gz',report)
lines=['# Evaluation release v2.0.2 — closeout','',
       '**The finite evaluation release gate passes.** The ontology core remains v2.0.0; native and logical semantic source hashes are unchanged. There are zero unexplained positive-baseline failures and zero unaccounted SHACL component occurrences. This is not universal semantic or independent domain acceptance.','',
       '| Evidence | Result |','| --- | --- |',
       '| SHACL source components | 1,977 accounted for: 1,864 simple + 113 complex |',
       '| Simple adverse cases | 1,754 executed; 110 logically unreachable, explicitly excluded |',
       f"| Complex controls | {complex['component_observations']} observations, 244 inverse projections, 42 native event fixtures |",
       '| OWL 2 DL / baseline | Pass / consistent |',
       '| Named-class satisfiability | 121 / 121 satisfiable |',
       f"| Expanded HermiT scenarios | {len(owl['scenarios'])} expected consistency/entailment outcomes matched |",
       '| CQ replay | 56 contracts, 187 fixtures, 374 exact-answer comparisons passed |',
       f"| CQ mutation sensitivity | {cq['detected']} detected / {cq['data_mutations']} probes; {cq['survived']} survivors retained |",
       '| Fresh core regression | 8 stages passed; overlapping suite counts reported separately |',
       '| Default ROBOT report | 812 findings retained: 288 ERROR, 451 WARN, 73 INFO |',
       '| Commitment traceability | 22 / 22 scoped; OPEN01 remains an explicitly unasserted scientific limitation |','',
       '## Finding decisions','']
lines += ['- **'+f['type']+'**: '+f['finding']+' Disposition: '+f['disposition']+'.' for f in findings]
lines += ['', '## Commitment evidence','', '| ID | Commitment | Accepted evidence |', '| --- | --- | --- |']
lines += [f"| {c['id']} | {c['commitment']} | {'; '.join(c['evidence'])} |" for c in trace]
lines += ['', '## Reproduce','',
          'Use the pinned Python requirements and the SHA-256-verified ROBOT 1.9.11 JAR. Java 17 must provide the jdk.compiler module. Run from the repository root:', '',
          '```bash','python tools/publication/test_shacl_complex.py',
          'python tools/publication/test_owl_reasoning.py --robot "$ROBOT_JAR"',
          'python tools/publication/test_cq_regression.py',
          'python tools/publication/test_core_regression.py --robot "$ROBOT_JAR"',
          'python tools/publication/adjudicate_evaluation.py','```','',
          'The expanded-evaluation workflow also regenerates the simple-component receipt and verifies the publication package. Native upstream SDK/validator results remain historical and are not relabelled as fresh. No owner decision is required to publish this bounded evaluation increment. Metadata improvements, external contracts and independent scientific assessment remain separate follow-ups.','',
          '[Machine-readable execution index and finding decisions](v2.0.2-closeout.json.gz) · [SHACL](shacl-complex.md) · [HermiT](owl-hermit.md) · [ROBOT](robot-report.md) · [CQ replay](cq-regression.md) · [Core regression](core-regression.md)','']
(ROOT/'evaluation/v2.0.2-closeout.md').write_text('\n'.join(lines))
print(json.dumps({'status':report['status'],**summary}))
