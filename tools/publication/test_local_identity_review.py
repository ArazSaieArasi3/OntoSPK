"""Finite declaration-policy, native-structure and occurrence contrasts for #28."""
from pathlib import Path
from collections import Counter
import copy
import hashlib
import importlib
import itertools
import json
import shutil
import sqlite3
import subprocess
import sys
import tempfile
from rdflib import Graph, RDF, Literal, XSD
from rdflib.compare import isomorphic
from evaluation_common import ROOT, SOURCE, sha, write_json

review=json.loads((ROOT/'evaluation/local-identity-review.json').read_text())
for source,digest in review['source_sha256'].items():assert sha(ROOT/source)==digest
assert review['existing_review_questions']==37 and len(review['rows'])==39
native=json.loads((SOURCE/'formalization/Native_Model_v0_41_0.json').read_text())

def structural_errors(model):
    es={e['id']:e for e in model['elements']};local={i:e for i,e in es.items() if e['type']=='Class' and not i.startswith('EXT:')}
    parents={i:set() for i in local};errors=[]
    for e in es.values():
        if e['type']=='Generalization':parents[e['specific']].add(e['general'])
    def ancestors(i,seen=None):
        seen=set() if seen is None else seen
        if i in seen:raise ValueError('GENERALIZATION_CYCLE')
        return set(parents[i])|set().union(*(ancestors(p,seen|{i}) for p in parents[i]))
    providers={'kind','mode','quality','relator','collective','quantity'}
    try:
        for i,e in local.items():
            an=ancestors(i);roots={p for p in an if local[p]['stereotype'] in providers}
            if e['stereotype'] in providers and roots:errors.append(i+':MULTIPLE_IDENTITY_PROVIDERS')
            if e['stereotype']=='subkind' and len(roots)!=1:errors.append(i+':SUBKIND_PROVIDER')
            if e['stereotype']=='category' and (roots or e['isAbstract'] is not True):errors.append(i+':CATEGORY_PROFILE')
            if e['stereotype']=='event' and roots:errors.append(i+':EVENT_ENDURANT_ANCESTOR')
        mode='IC:ProductCapability';relations=[]
        for r in es.values():
            if r['type']=='BinaryRelation' and r['stereotype']=='characterization':
                ends=[es[p] for p in r['properties']]
                if ends[1]['propertyType']==mode:relations.append(ends)
        if len(relations)!=1 or relations[0][0]['propertyType']!='IC:ProductRealization' or relations[0][0]['cardinality']!='1' or relations[0][1]['cardinality']!='1..*':
            errors.append('CAPABILITY_CHARACTERIZATION')
    except (KeyError,ValueError) as exc:errors.append(str(exc))
    return sorted(errors)

assert structural_errors(native)==[]
native_mutants=[]
for name in ('subkind_second_provider','mode_provider','category_concrete','bearer_cardinality'):
    changed=copy.deepcopy(native);es={e['id']:e for e in changed['elements']}
    if name in ('subkind_second_provider','mode_provider'):
        changed['elements'].append({'id':'synthetic-generalization','type':'Generalization','specific':'IC:RequirementSpecification' if name.startswith('subkind') else 'IC:ProductCapability','general':'IC:Product'})
    elif name=='category_concrete':es['IC:EvidenceArtifact']['isAbstract']=False
    else:es[es['ICREL:CP:bearsCapability']['properties'][0]]['cardinality']='0..*'
    errors=structural_errors(changed);assert errors,name
    native_mutants.append({'id':name,'errors':errors,'status':'EXPECTED_DRIFT_DETECTED'})

def expected(t):
    op=t['operation'];changed=t['before_v']!=t['after_v']
    if changed and op in ('restart','migrate') or not changed and op in ('upgrade','rollback'):return 'REJECTED'
    forced=changed or op in ('clone','recreate') or t['branching'] or t['system_continuity']=='BROKEN'
    if not forced and t['system_continuity']=='UNKNOWN':return 'REVIEW_REQUIRED'
    same_r=not forced
    if (t['before_r']==t['after_r'])!=same_r:return 'REJECTED'
    if same_r and t['disposition_continuity']=='UNKNOWN':return 'REVIEW_REQUIRED'
    same_c=same_r and t['disposition_continuity']=='PRESERVED'
    return 'ACCEPTED' if (t['before_c']==t['after_c'])==same_c else 'REJECTED'

grid=[];replay=[];metamorphic=[];ledger=[];occurrences=[];limits=[]
with tempfile.TemporaryDirectory() as folder:
    isolated=Path(folder)
    shutil.copytree(ROOT/'semantic',isolated/'semantic',ignore=shutil.ignore_patterns('__pycache__'))
    shutil.copytree(ROOT/'tools/ontospk',isolated/'tools/ontospk')
    subprocess.run([sys.executable,str(isolated/'tools/ontospk/bootstrap_inputs.py')],check=True,capture_output=True)
    runtime=isolated/'semantic/product/v2/source/validation_v041'
    sys.path[:0]=[str(runtime),str(runtime/'inputs')]
    policy=importlib.import_module('identity_policy');store=importlib.import_module('identity_runtime_v025')
    for values in itertools.product(('restart','migrate','upgrade','rollback','clone','recreate'),(False,True),('PRESERVED','BROKEN','UNKNOWN'),('PRESERVED','BROKEN','UNKNOWN'),(False,True),(False,True),(False,True)):
        op,version_change,system,disposition,branch,same_r,same_c=values
        t={'operation':op,'before_r':'urn:review:r1','after_r':'urn:review:r1' if same_r else 'urn:review:r2',
           'before_v':'urn:review:v1','after_v':'urn:review:v2' if version_change else 'urn:review:v1',
           'before_c':'urn:review:c1','after_c':'urn:review:c1' if same_c else 'urn:review:c2',
           'system_continuity':system,'disposition_continuity':disposition,'branching':branch,'evidence':'urn:review:synthetic-declaration'}
        before=copy.deepcopy(t);actual=policy.assess(t);want=expected(t)
        assert actual['status']==want and t==before,(t,actual,want)
        grid.append({'id':len(grid)+1,'input':t,'expected_status':want,'actual':actual,'status':'PASS'})
    assert len(grid)==864
    retained=json.loads((runtime/'inputs/identity_transition_cases.json').read_text())
    for case in retained:
        actual=policy.assess(case['input']);assert actual['status']==case['expected_status']
        for key,field in [('expected_realization','realization_identity'),('expected_capability','capability_identity')]:
            if case.get(key) is not None:assert actual.get(field)==case[key]
        replay.append({'id':case['name'],'expected_status':case['expected_status'],'actual':actual,'status':'PASS'})
    assert len(replay)==25
    for case in grid[::18]:
        data=copy.deepcopy(case['input'])
        for key in ['before_r','after_r','before_v','after_v','before_c','after_c','evidence']:
            data[key]='urn:renamed:'+hashlib.sha256(data[key].encode()).hexdigest()
        actual=policy.assess(data);assert actual==case['actual']
        metamorphic.append({'grid_case':case['id'],'bijective_iri_renaming_preserves_decision':True})
    good=retained[0]['input']
    # The ledger is exercised in memory; it remains an old implementation, not a deployed product.
    db=store.connect(':memory:')
    envelope={'request_id':'review-1','workspace':'review','mode':'SCENARIO','transition':good}
    def pop():return {t:sorted(map(tuple,db.execute('SELECT * FROM '+t).fetchall())) for t in ('realization','capability','triple')}
    a=store.submit(db,envelope);assert a['status']=='ACCEPTED' and a['evidence_acceptance']=='DECLARATION_ONLY'
    ledger.append({'id':'declared_evidence_is_not_truth','actual':a,'status':'PASS'})
    before=pop();b=store.submit(db,envelope);assert b['idempotent_replay'] and pop()==before
    ledger.append({'id':'idempotent_record_replay','status':'PASS'})
    conflict=copy.deepcopy(envelope);conflict['transition']['evidence']='urn:review:other-source'
    a=store.submit(db,conflict);assert a['status']=='REJECTED' and pop()==before
    ledger.append({'id':'request_id_conflict','actual':a,'status':'PASS'})
    for label,change in [('persisted_version_conflict',{'before_v':'urn:review:new-v','after_v':'urn:review:new-v'}),
                         ('persisted_bearer_conflict',{'before_r':'urn:review:new-r','after_r':'urn:review:new-r'})]:
        t=dict(good,**change);a=store.submit(db,{'request_id':label,'workspace':'review','mode':'SCENARIO','transition':t})
        assert a['status']=='REJECTED' and pop()==before
        ledger.append({'id':label,'actual':a,'status':'PASS'})
    db.execute('INSERT INTO realization VALUES(?,?,?)',('urn:review:other-r','review',good['before_v']));db.commit()
    try:
        db.execute('UPDATE capability SET bearer=? WHERE iri=?',('urn:review:other-r',good['before_c']));raise AssertionError('Bearer update was allowed')
    except sqlite3.IntegrityError:db.rollback()
    ledger.append({'id':'direct_update_bearer_blocked','status':'PASS'})
    db.execute('DELETE FROM capability WHERE iri=?',(good['before_c'],))
    db.execute('INSERT INTO capability VALUES(?,?,?)',(good['before_c'],'review','urn:review:other-r'));db.commit()
    assert db.execute('SELECT bearer FROM capability WHERE iri=?',(good['before_c'],)).fetchone()[0]=='urn:review:other-r'
    limits.append({'id':'legacy_ledger_direct_delete_reinsert','status':'OBSERVED_LIMIT',
                   'finding':'The old application ledger blocks UPDATE but allows direct DELETE/re-INSERT to replace a capability bearer. Its triple history can then disagree with its capability table.',
                   'scope':'Synthetic in-memory probe of retained identity_runtime_v025; not a new ontology inconsistency or a released production database.',
                   'disposition':'Do not claim direct-DML hardening or end-to-end identity assurance; application hardening is outside the frozen ontology-core distribution.'})
    db.close()
    profile=importlib.import_module('occurrence_profile');population=importlib.import_module('build_population')
    P,D,N,Q=population.P,population.D,population.N,profile.Q
    def lit(value,dtype=XSD.string):return Literal(value,datatype=dtype,normalize=False)
    def setv(g,s,p,o):g.remove((s,p,None));g.add((s,p,o))
    base=population.build()
    for p,v,dtype in [(Q.executionStartedAt,'2026-10-14T04:29:00Z',XSD.dateTime),(Q.startTimeKnowledge,'known',XSD.string),
                      (Q.executionSource,'urn:review:synthetic-observation',XSD.anyURI),(Q.executionStage,'test_exercised',XSD.string),
                      (Q.targetParticipation,'supported',XSD.string),(Q.participationSource,'urn:review:synthetic-participation',XSD.anyURI),
                      (Q.executionCode,'urn:review:synthetic-code',XSD.anyURI),(Q.codeUseSource,'urn:review:synthetic-code-use',XSD.anyURI),
                      (Q.roostCandidate,'true',XSD.boolean)]:base.add((N.e1,p,lit(v,dtype)))
    def setup(g):
        setv(g,N.e1,Q.executionStage,lit('setup_only'));setv(g,N.e1,Q.targetParticipation,lit('unestablished'))
        for p in (Q.participationSource,Q.executionCode,Q.codeUseSource):g.remove((N.e1,p,None))
        setv(g,N.e1,Q.roostCandidate,lit('false',XSD.boolean));setv(g,N.result1,D.resultOutcome,Literal('aborted'))
    def unknown(g):g.remove((N.e1,Q.executionStartedAt,None));setv(g,N.e1,Q.startTimeKnowledge,lit('unknown'))
    tests=[('concluded_code_exercise',lambda g:None,True),('setup_only_aborted',setup,True),('unknown_start',unknown,True),
           ('late_result_record',lambda g:setv(g,N.result1,D.resultRecordedAt,lit('2026-10-15T10:00:00Z',XSD.dateTime)),True),
           ('unknown_start_with_invented_time',lambda g:setv(g,N.e1,Q.startTimeKnowledge,lit('unknown')),False),
           ('missing_known_end',lambda g:g.remove((N.e1,D.executionEndedAt,None)),False),
           ('start_after_end',lambda g:setv(g,N.e1,Q.executionStartedAt,lit('2026-10-14T04:32:00Z',XSD.dateTime)),False),
           ('candidate_without_code',lambda g:g.remove((N.e1,Q.executionCode,None)),False),
           ('candidate_without_code_source',lambda g:g.remove((N.e1,Q.codeUseSource,None)),False),
           ('target_binding_without_supported_participation',lambda g:setv(g,N.e1,Q.targetParticipation,lit('unestablished')),False),
           ('setup_claims_exercise',lambda g:setv(g,N.e1,Q.executionStage,lit('setup_only')),False)]
    def remap(g,mapping):
        out=Graph()
        for s,p,o in g:out.add((mapping.get(s,s),p,mapping.get(o,o)))
        return out
    tests.append(('equal_times_distinct_recorded_attempts',lambda g:g.__iadd__(remap(g,{N.e1:N.e2,N.result1:N.result2})),True))
    for name,change,want in tests:
        g=Graph()+base;change(g);db=profile.connect();a=profile.admit(db,name,g)
        assert (a['status']=='ACCEPTED_SCOPED')==want,(name,a)
        if want:assert a['roost_equivalence'] is False
        occurrences.append({'id':name,'expected_admitted':want,'actual_status':a['status'],'rejection_stage':a.get('stage'),'status':'PASS'})
        db.close()
    db=profile.connect();a=profile.admit(db,'history-base',base);assert a['status']=='ACCEPTED_SCOPED'
    before=profile.base.verified_export(db,'history-base')
    a=profile.append_observation(db,'urn:review:obs1',str(N.e1),'executionStartedAt','2026-10-14T04:28:55Z','urn:review:source','2026-10-15T10:00:00Z')
    assert a['status']=='RECORDED_ASSERTION' and a['changes_accepted_occurrence'] is False
    assert isomorphic(before,profile.base.verified_export(db,'history-base'))
    occurrences.append({'id':'append_observation_keeps_accepted_occurrence','actual':a,'status':'PASS'})
    a=profile.admit(db,'history-rebind',remap(base,{N.case1:N.changed_case}))
    assert a['status']=='REJECTED' and isomorphic(before,profile.base.verified_export(db,'history-base'))
    occurrences.append({'id':'past_event_cannot_rebind_test_case','actual_status':a['status'],'rejection_stage':a.get('stage'),'status':'PASS'})
    db.close()

result={'status':'PASS_BOUNDED_TESTS_WITH_DISCLOSED_LIMITS','identity_grid_cases':len(grid),
        'grid_status_counts':dict(Counter(c['actual']['status'] for c in grid)),
        'retained_case_replays':len(replay),'iri_renaming_controls':len(metamorphic),
        'native_local_classes_checked':101,'native_generalizations_checked':34,'native_adverse_controls':native_mutants,
        'ledger_controls':ledger,'occurrence_controls':occurrences,'implementation_limits':limits,
        'review_sha256':sha(ROOT/'evaluation/local-identity-review.json'),
        'runner_sha256':sha(Path(__file__)),'identity_grid':grid,'retained_cases':replay,'iri_renaming':metamorphic,
        'scientific_acceptance':False,'full_native_profile_conformance':False,
        'limits':'Finite declared-policy space and bounded structural/data controls; not evidence truth, full modal/causal adequacy, independent acceptance or production hardening.'}
write_json('evaluation/local-identity-tests.json.gz',result)
(ROOT/'evaluation/local-identity-tests.md').write_text('\n'.join([
 '# Focused local identity and event tests','',
 f"All {len(grid)} declared identity-policy combinations match their expected outcome; all {len(replay)} retained cases replay and {len(metamorphic)} bijective identifier-renaming controls preserve decisions. Grid axes: six operations, changed/same version, three system-continuity states, three disposition-continuity states, branching, and same/distinct realization and capability identifiers.",'',
 f"The bounded native checks cover 101 local classes and 34 generalizations, unique inherited identity providers, the abstract evidence category and capability characterization. Four memory-only adverse structures are detected. These checks deliberately do not certify the unresolved concrete-Mode abstractness profile in #48.",'',
 f"{len(ledger)} in-memory legacy ledger controls and {len(occurrences)} occurrence/history contrasts pass. Unknown starts, setup-only aborted attempts, late reports, participation evidence, repeated equal-time attempts and append-only observations are distinguished. Acceptance remains a supplied-data/declaration result, with no new external equivalence.",'',
 '**Observed implementation limit:** direct DELETE/re-INSERT can replace a bearer in the old synthetic application ledger despite its UPDATE trigger. The frozen source is not repaired, and direct-DML hardening or production identity assurance is not claimed. The transition policy also remains separate from combined occurrence admission.','',
 '[Exact inputs and observations](local-identity-tests.json.gz) · [Review decisions and remaining scientific limits](local-identity-review.md)','']))
print(json.dumps({k:v for k,v in result.items() if k in ('status','identity_grid_cases','grid_status_counts','retained_case_replays','iri_renaming_controls','native_local_classes_checked','native_generalizations_checked')}))
print(json.dumps({'ledger_controls':len(ledger),'occurrence_controls':len(occurrences),'observed_implementation_limits':len(limits)}))
