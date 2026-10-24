"""Execute a finite, source-bound FOL pilot using a pinned independent SMT solver."""
import argparse
from collections import Counter
import gzip
import hashlib
import importlib.metadata
import json
from pathlib import Path
import shutil
import sys
import z3
from fol_finite import ROOT,SPEC,SOURCE,Finite,load,evaluate,restore,witness
from evaluation_common import sha,write_json

ap=argparse.ArgumentParser();ap.add_argument('--capture-witnesses',action='store_true');args=ap.parse_args()
assert importlib.metadata.version('z3-solver')=='4.15.4.0' and z3.get_version_string()=='4.15.4'
lib=Path(z3.__file__).parent/'lib/libz3.so'
assert sha(lib)=='56d9977b9276bcb8cda9973a14058fcaa9f3bfee14ed57408b9faacd76d4d8f3'
work=ROOT/'build/fol-pilot';work.mkdir(parents=True,exist_ok=True)
symbols,theories=load();bindings=json.loads((SPEC/'source-bindings.json').read_text())
assert bindings['native_sha256']=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
assert bindings['profile_sha256']=='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12'
for key in ('native','profile'):assert sha(ROOT/bindings[key+'_source'])==bindings[key+'_sha256']
# Rebuild and rerun the older transcription audit in isolation, never in semantic/.
sys.path.insert(0,str(ROOT/'tools/ontospk'))
import build_fol,check_fol
fresh=work/'fresh-transcription';fresh.mkdir(exist_ok=True)
build_fol.OUT=fresh;build_fol.generate()
rebuilt=[]
for p in sorted(fresh.iterdir()):
    if p.name=='transcription-review.json':continue
    assert p.read_bytes()==(SPEC/p.name).read_bytes(),p.name
    rebuilt.append(p.name)
check_fol.OUT=fresh;check_fol.main()
transcription=json.loads((fresh/'transcription-review.json').read_text())
assert transcription==json.loads((SPEC/'transcription-review.json').read_text())

fixed_path=ROOT/'tools/publication/fol-pilot-witnesses.json.gz'
fixed={} if args.capture_witnesses else json.loads(gzip.decompress(fixed_path.read_bytes()))
captured={};finite_cache={};solver_cache={}
def solver():
    s=z3.Solver();s.set(timeout=30000,random_seed=0);return s

def finite(theory,size):
    key=(theory,size)
    if key not in finite_cache:finite_cache[key]=Finite(size,symbols)
    return finite_cache[key]

def theory_solver(theory,size):
    key=(theory,size)
    if key not in solver_cache:
        f=finite(theory,size);s=solver();s.add([f.ground(a) for name,a in theories[theory]]);solver_cache[key]=s
    return solver_cache[key]

def result(s,expected,identity):
    actual=str(s.check());assert actual!='unknown',(identity,s.reason_unknown())
    assert actual==expected,(identity,actual,expected)
    return actual

def checked_interpretation(model,theory,size):
    arities={symbol:arity for (identifier,arity),symbol in symbols.items()}
    prefix='n_' if theory=='native' else 'o_'
    for symbol,tuples in model.items():
        assert symbol in arities and symbol.startswith(prefix), 'Certificate signature mismatch'
        assert all(len(row)==arities[symbol] and all(type(v) is int and 0<=v<size for v in row) for row in tuples), 'Certificate domain/arity mismatch'
    return restore(model)

def certify(identity,theory,size,model,conditions):
    rows=checked_interpretation(model,theory,size)
    assert all(evaluate(a,rows,size) for name,a in theories[theory]),('Witness violates FOL source',identity)
    assert all(evaluate(a,rows,size) for a in conditions),('Witness violates scenario',identity)

# Differential check: emitted FOF vs direct native integer-count constraints.
differential=[]
for size in (2,3):
    f=finite('native',size);expected=f.native_source()
    for (name,ast),(source,kind,independent) in zip(theories['native'],expected):
        s=solver();s.add(z3.Xor(f.ground(ast),independent));result(s,'unsat',name)
        differential.append({'bound':size,'formula':name,'source_id':source,'family':kind,'disagreement':'unsat'})
    print('native source differential bound',size,'complete',flush=True)
# Check all profile families, including anonymous restrictions and datatype
# predicates as the explicitly declared object-level abstraction only.
profile_differential=[]
for size in (2,3):
    f=finite('profile',size);direct,descriptions=f.profile_source();offset=0
    assert {k:len(v) for k,v in direct.items()}==bindings['profile_expression_families']
    for family,count in sorted(bindings['profile_expression_families'].items()):
        rows=theories['profile'][offset:offset+count];offset+=count
        actual=z3.And([f.ground(a) for name,a in rows])
        independent=z3.And(sorted(direct[family],key=lambda e:e.sexpr()))
        s=solver();s.add(z3.Xor(actual,independent));result(s,'unsat','profile '+family)
        profile_differential.append({'bound':size,'family':family,'formulas':count,'first_formula':rows[0][0],'last_formula':rows[-1][0],'disagreement':'unsat'})
    assert offset==3038
    print('profile source differential bound',size,'complete',flush=True)

P='urn:productium:specification-profile:';D='urn:product-ontology:delivery-profile:0.5:'
def atom(identifier,*values):return ('atom',symbols[(identifier,len(values))],*values)
def a(local,*values):return atom(P+local,*values)
def neg(x):return ('not',x)
def all_(variable,body):return ('forall',(variable,),body)
def conj(x,y):return ('and',x,y)
def implies(x,y):return ('implies',x,y)

cases=[]
def case(identity,theory,size,expected,conditions,meaning):
    cases.append({'id':identity,'theory':theory,'bound':size,'expected':expected,'conditions':conditions,'meaning':meaning})
# Baseline vacuity is explicit; a nonempty universe is never an empty domain.
for theory in ('native','profile'):
    prefix='n_' if theory=='native' else 'o_'
    conditions=[]
    for (identifier,arity),symbol in sorted(symbols.items()):
        if not symbol.startswith(prefix):continue
        conditions.append(neg(('atom',symbol,*([0]*arity))))
    case(theory+'_empty_extensions',theory,1,'sat',conditions,'Nonempty one-object universe, all unary/binary extensions empty; exposes vacuity, not populated adequacy.')
conditions=[('atom',symbol,*([0]*arity)) for (identifier,arity),symbol in sorted(symbols.items()) if symbol.startswith('n_')]
case('native_all_types_one_object','native',1,'sat',conditions,'A populated model of all 892 native structural formulas; overlapping types and self-links show the limited structural theory, not UFO adequacy.')
case('profile_one_object_bound_too_small','profile',1,'unsat',[a('ProductRealization',0)],'UNSAT at bound one is a size limitation; the same seed has a model at bound four.')
case('profile_realization_populated','profile',4,'sat',[a('ProductRealization',0)],'Version, capability and bearer constraints are completed by a nonempty finite witness.')
case('profile_capability_populated','profile',4,'sat',[a('ProductCapability',0)],'A seeded actual capability admits a bearer/version witness.')
case('profile_realization_without_any_version','profile',4,'unsat',[a('ProductRealization',0),all_('V',neg(a('realizesVersion',0,'V')))],'Existence is required; explicit absence of every version contradicts this seeded profile within the bound.')
case('profile_capability_without_any_bearer','profile',4,'unsat',[a('ProductCapability',0),all_('R',neg(a('bearsCapability','R',0)))],'Explicit absence of every bearer conflicts with the actual-mode restriction.')
case('profile_distinct_versions','profile',4,'unsat',[a('ProductRealization',0),a('realizesVersion',0,1),a('realizesVersion',0,2)],'Indices one and two are explicitly distinct objects; two fillers violate exact one.')
case('profile_alias_names','profile',4,'sat',[a('ProductRealization',0),a('realizesVersion',0,1),a('realizesVersion',0,1)],'Two fixture names may refer to the same object index. No unique-name assumption is added.')
case('profile_concluded_execution_populated','profile',10,'sat',[a('TestExecution',0)],'A nonempty execution witness for the entire profile abstraction, with abstract datatype predicates.')
case('profile_result_domain_counterexample','profile',10,'unsat',[a('recordsExecution',0,1),neg(a('TestResult',0))],'No countermodel to the declared domain inference in this finite domain.')
case('profile_inverse_counterexample','profile',10,'unsat',[a('isCarrierInRecord',0,1),neg(a('recordsCarrier',1,0))],'No countermodel to the declared inverse orientation in this finite domain.')
case('profile_chain_counterexample','profile',10,'unsat',[a('isCarrierInRecord',0,1),a('recordsClaim',1,2),neg(a('recordedAttributionTo',0,2))],'No countermodel to the recorded-attribution property chain; no claim-truth assertion is introduced.')
join=all_('V',neg(conj(a('realizesVersion',1,'V'),a('specifiesCapability','V',2))))
case('EV10_join_is_not_a_profile_consequence','profile',10,'sat',[a('testsRealization',0,1),a('assessesSpecification',0,2),join],'Concrete countermodel: the scoped admission join is not an axiom of this published FOL profile.')
case('EV11_suite_closure_is_not_a_profile_consequence','profile',10,'sat',[a('r147_hasRecordedExecution',0,1),a('executes',1,2),neg(a('containsCase',0,2))],'Concrete countermodel: the suite/case admission closure is not an asserted profile implication.')
case('profile_three_cycle_not_excluded','profile',4,'sat',[a('r8_supersedes',0,1),a('r8_supersedes',1,2),a('r8_supersedes',2,0)],'A three-cycle survives asymmetry/irreflexivity; global acyclicity is not provided.')
case('profile_self_loop_excluded','profile',4,'unsat',[a('r8_supersedes',0,0)],'A self-loop violates the declared irreflexivity/asymmetry.')
case('profile_abstract_datatype_overlap','profile',4,'sat',[a('ProductRealization',0),atom('http://www.w3.org/2001/XMLSchema#string',0)],'The object-level export permits datatype/class overlap; it omits OWL object/data-domain separation and literal value semantics.')

observations=[]
for c in cases:
    f=finite(c['theory'],c['bound']);s=theory_solver(c['theory'],c['bound']);s.push();s.add([f.ground(x) for x in c['conditions']])
    smt=s.to_smt2();(work/(c['id']+'.smt2')).write_text(smt)
    actual=result(s,c['expected'],c['id'])
    if actual=='sat':
        observed=witness(f,s.model());certify(c['id'],c['theory'],c['bound'],observed,c['conditions'])
        captured[c['id']]={'theory':c['theory'],'bound':c['bound'],'interpretation':observed}
        if not args.capture_witnesses:
            stored=fixed['cases'][c['id']];assert stored['theory']==c['theory'] and stored['bound']==c['bound']
            certify(c['id'],c['theory'],c['bound'],stored['interpretation'],c['conditions'])
    query_spec={'source_sha256':sha(SPEC/('native-structure.p' if c['theory']=='native' else 'profile-projection.p')),**c}
    query_hash=hashlib.sha256(json.dumps(query_spec,sort_keys=True).encode()).hexdigest()
    s.pop();observations.append({**c,'actual':actual,'query_spec_sha256':query_hash,'raw_smt2_file':c['id']+'.smt2','sat_witness_independently_checked':actual=='sat'})
    print(c['id'],actual,flush=True)
# Guard against well-known plausible translation errors using real source axioms.
mutants=[]
def mutation(identity,theory,original,changed):
    f=finite(theory,2);s=solver();s.add(z3.Xor(f.ground(original),f.ground(changed)))
    result(s,'sat',identity);model=witness(f,s.model());rows=checked_interpretation(model,theory,2)
    assert evaluate(original,rows,2)!=evaluate(changed,rows,2)
    captured[identity]={'theory':'isolated_'+theory,'bound':2,'interpretation':model}
    if not args.capture_witnesses:
        certificate=fixed['cases'][identity];assert certificate['theory']=='isolated_'+theory and certificate['bound']==2
        stored=checked_interpretation(certificate['interpretation'],theory,2);assert evaluate(original,stored,2)!=evaluate(changed,stored,2)
    mutants.append({'id':identity,'theory':theory,'bound':2,'disagreement':'sat','countermodel_checked':True})
name,typing=theories['native'][0];p=typing[2][1][1];body=typing[2][2]
mutation('mutation_reversed_typing','native',typing,('forall',('X','Y'),implies(('atom',p,'Y','X'),body)))
exact=next(a for name,a in theories['native'] if a[0]=='forall' and a[2][0]=='implies' and a[2][2][0]=='exists' and a[2][2][2][0]=='and')
exists=exact[2][2];first=exists[2][1];unique=exists[2][2]
at_most=('forall',('Y','Z'),implies(conj(first,unique[2][1]),('eq','Y','Z')))
mutation('mutation_exact_one_loses_existence','native',exact,('forall',exact[1],implies(exact[2][1],at_most)))
mutation('mutation_exact_one_loses_uniqueness','native',exact,('forall',exact[1],implies(exact[2][1],('exists',('Y',),first))))
general=theories['native'][-1][1]
mutation('mutation_subclass_reversed','native',general,('forall',general[1],implies(general[2][2],general[2][1])))
family={};offset=0
for kind,count in sorted(bindings['profile_expression_families'].items()):family[kind]=[a for name,a in theories['profile'][offset:offset+count]];offset+=count
chain=family['chain'][0];end=chain[2][2]
mutation('mutation_chain_conclusion_reversed','profile',chain,('forall',chain[1],implies(chain[2][1],('atom',end[1],end[3],end[2]))))
inverse=family['inverse'][0];end=inverse[2][2]
mutation('mutation_inverse_orientation_lost','profile',inverse,('forall',inverse[1],('iff',inverse[2][1],('atom',end[1],end[3],end[2]))))
mutation('mutation_functionality_dropped','profile',family['functional'][0],('true',))
disjoint=family['disjoint'][0];mutation('mutation_disjoint_negation_lost','profile',disjoint,('forall',disjoint[1],disjoint[2][1]))
if args.capture_witnesses:
    write_json('tools/publication/fol-pilot-witnesses.json.gz',{'schema':1,'source_spec_sha256':{n:sha(SPEC/n) for n in ('native-structure.p','profile-projection.p')},'cases':captured})
else:
    assert set(fixed['cases'])==set(captured)
    assert fixed['source_spec_sha256']=={n:sha(SPEC/n) for n in ('native-structure.p','profile-projection.p')}
# Portable receipt stores results and a fixed, independently checked certificate;
# fresh solver models/SMT inputs are raw CI artifacts, not volatile Git diffs.
(work/'fresh-witnesses.json').write_text(json.dumps(captured,indent=2,sort_keys=True)+'\n')
(work/'artifact-manifest.json').write_text(json.dumps({'solver':z3.get_version_string(),'files':{p.name:sha(p) for p in sorted(work.glob('*.smt2'))},'fresh_witnesses_sha256':sha(work/'fresh-witnesses.json')},indent=2)+'\n')
inputs=[SPEC/n for n in ('native-structure.p','profile-projection.p','symbols.json','source-bindings.json','relation-signatures.json','transcription-review.json','scoped-contracts.md')]
inputs += [SOURCE/'formalization/Native_Model_v0_41_0.json',SOURCE/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl',ROOT/'tools/ontospk/build_fol.py',ROOT/'tools/ontospk/check_fol.py',ROOT/'tools/publication/fol_finite.py',ROOT/'tools/publication/test_fol_pilot.py',ROOT/'tools/publication/fol-requirements.txt',ROOT/'tools/publication/check_fol_pilot_sources.py',fixed_path]
report={'status':'PASS_BOUNDED_FOL_PILOT_WITH_DISCLOSED_LIMITS','release':'v2.0.6','ontology_core':'v2.0.0',
 'solver':'Z3 '+z3.get_version_string(),'solver_package':'z3-solver==4.15.4.0','solver_library_sha256':sha(lib),
 'source_sha256':{str(p.relative_to(ROOT)):sha(p) for p in inputs},'separate_theories':True,'theories_combined':False,
 'native_formulas':892,'profile_formulas':3038,'reproduced_transcription_files':rebuilt,
 'native_source_differential_checks':len(differential),'profile_family_differential_checks':len(profile_differential),
 'differential_bounds':[2,3],'differential_mismatches':0,'scenario_count':len(cases),'scenario_statuses':dict(Counter(x['actual'] for x in observations)),
 'verified_sat_certificates':len(captured)-len(mutants),'detected_mutations':len(mutants),'unknown_results':0,
 'native_differential':differential,'profile_differential':profile_differential,'scenarios':observations,'mutations':mutants,
 'native_transcription_replay':{'two_object_relation_interpretations':transcription['two_object_relation_interpretations'],'generalization_interpretations':transcription['generalization_interpretations']},
 'findings':[{'id':'FOL01','finding':'Native structural theory permits a one-object populated model with all native types overlapping and all relations reflexive.','disposition':'EXPECTED_STRUCTURAL_SCOPE_NOT_UFO_ADEQUACY'},
 {'id':'FOL02','finding':'EV10 and EV11 scoped joins have finite countermodels in the profile theory.','disposition':'KEEP_SEPARATE_ADMISSION_CONTRACTS_NO_AUTOMATIC_MODEL_REPAIR'},
 {'id':'FOL03','finding':'Asymmetry and irreflexivity permit a three-cycle.','disposition':'NO_GLOBAL_ACYCLICITY_CLAIM'},
 {'id':'FOL04','finding':'Abstract datatype predicates can overlap object classes.','disposition':'FULL_DATATYPE_AND_TWO_SORT_SEMANTICS_NOT_SUPPLIED'},
 {'id':'FOL05','finding':'The one-object populated realization is UNSAT but has a four-object witness.','disposition':'BOUND_FAILURE_IS_NOT_GLOBAL_INCONSISTENCY'}],
 'ontology_wide_consistency_proved':False,'full_owl_equivalence_proved':False,'ufo_modal_causal_semantics_verified':False,'independent_domain_acceptance':False,'manuscript_changed':False,'semantic_sources_changed':False,
 'limits':'SAT certificates are concrete models/countermodels of the stated static FOL fragment. UNSAT excludes a model only at the exact stated finite size. Quantifiers are fully grounded; no unknown/timeout counts as acceptance. No datatype value spaces, temporal/causal adequacy, signature bridge or independent semantic acceptance is asserted.'}
write_json('evaluation/fol-pilot.json.gz',report)
lines=['# First-order verification pilot — v2.0.6','',
 '**The bounded FOL pilot is complete.** The native structural theory (892 formulas) and object-level profile theory (3,038 formulas) retain separate signatures. All semantic source files and existing formal specifications remain unchanged; no manuscript claim is edited.','',
 f"The prior transcription audit was freshly reproduced in isolation, including {transcription['two_object_relation_interpretations']:,} native relation interpretations and {transcription['generalization_interpretations']} generalization interpretations. Z3 4.15.4 then compared all 892 native translations against a separate source encoder at domain sizes two and three (1,784 disagreement searches), and all eleven profile families at both sizes (22 searches). No disagreement model was found within those bounds. Native cardinalities use independently encoded integer counts; profile restrictions/relations are read directly from RDF.",'',
 f"The representative pilot executes {len(cases)} full-theory scenarios: {sum(c['actual']=='sat' for c in observations)} SAT and {sum(c['actual']=='unsat' for c in observations)} UNSAT at their stated finite sizes, with zero unknown results. Every SAT model is checked by a separate Python FOL interpreter, including a fixed public certificate. Eight plausible translation mutations produce independently checked countermodels. Raw SMT-LIB inputs and fresh solver witnesses are included in the CI artifact.",'',
 '| Scenario | Theory / exact domain size | Result | Interpretation |','| --- | --- | --- | --- |']
lines += [f"| {c['id']} | {c['theory']} / {c['bound']} | {c['actual'].upper()} | {c['meaning']} |" for c in observations]
lines += ['', '## Findings and limits','',
 'The all-empty predicate baseline uses a **nonempty** universe and makes vacuity explicit. The nonempty native one-object model demonstrates how weak static typing/cardinality structure is: it is not a valid claim about UFO kinds, disjointness or real-world individuals. The populated profile models test stronger retained restrictions separately.','',
 'Concrete countermodels confirm that EV10/EV11 joins remain admission contracts and that a three-cycle is not excluded by asymmetry/irreflexivity. Abstract datatype predicates permit overlap with object classes; this does not implement OWL datatype value spaces, literal equality, lexical normalization or object/data-domain separation. These are disclosed representation limits, not silently repaired model defects. Profile adjudication remains #48.','',
 'The published function-free TPTP text is read by the retained custom parser; Z3 solves its fully grounded Boolean encoding, not the TPTP source directly. Source-side differential checks at two bounds and an independent witness interpreter provide separate controls, not a universal compiler-correctness proof.','',
 'A failed finite bound is not global inconsistency: a realization seed has no one-object model but has a verified four-object model. SAT witnesses are models of the exact published static fragment. UNSAT results exclude models/countermodels only at the declared exact size. Neither family-level differential checks nor this representative pilot prove full OWL equivalence, temporal/modal/causal adequacy or independent domain acceptance. Native and profile theories are never merged or bridged.','',
 '[Source hashes, every search result and assumptions](fol-pilot.json.gz) · [Fixed model/countermodel certificates](../tools/publication/fol-pilot-witnesses.json.gz) · [Frozen specification and scope](../semantic/product/v2/formal-specification/README.md)','',
 'Reproduce with `python -m pip install -r tools/publication/fol-requirements.txt`, then `python tools/publication/test_fol_pilot.py`. The `--capture-witnesses` option is only for explicitly reviewing new certificate inputs; CI reuses and independently validates the committed certificates.','',
 'Method references: [official Z3 guide](https://microsoft.github.io/z3guide/docs/logic/intro/) and [quantifier guidance](https://microsoft.github.io/z3guide/docs/logic/Quantifiers/). This harness expands quantifiers over explicit finite domains before solving, rather than relying on heuristic instantiation of unbounded quantified formulas.','']
(ROOT/'evaluation/fol-pilot.md').write_text('\n'.join(lines))
print(json.dumps({k:report[k] for k in ('status','native_source_differential_checks','profile_family_differential_checks','scenario_count','scenario_statuses','verified_sat_certificates','detected_mutations','unknown_results')}),flush=True)
