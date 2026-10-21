"""Reproducible controls for v0.41; synthetic inputs, bounded conclusions."""
import copy, datetime, hashlib, importlib.util, json, logging, sqlite3, tempfile
from pathlib import Path
from rdflib import Graph, URIRef, Literal, RDF, XSD, OWL
from rdflib.compare import isomorphic
from pyshacl import validate
import occurrence_profile as profile
import boundary_profile as boundary
import event_contracts as event
from build_population import build,P,D,N

logging.getLogger('rdflib.term').setLevel(logging.CRITICAL)
W=Path(__file__).parent;results=[]
INPUT_NATIVE_SHA256=hashlib.sha256((W/'inputs/Native_Model_v0_41_0.json').read_bytes()).hexdigest()
def check(name,passed,detail=None,group='occurrence'):
 results.append(dict(id=name,passed=bool(passed),group=group,detail=detail))
 if not passed:print('FAILED',name,str(detail)[:500],flush=True)
def state(db):
 rows=[]
 for (table,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"):
  rows.append((table,sorted(db.execute('SELECT * FROM "'+table+'"').fetchall(),key=repr)))
 return hashlib.sha256(repr(rows).encode()).hexdigest()
def clone(g):return Graph()+g
def setv(g,s,p,o):g.remove((s,p,None));g.add((s,p,o))
def lit(v,dtype=XSD.string):return Literal(v,datatype=dtype,normalize=False)
def enhanced():
 g=build();Q=profile.Q
 for p,v,t in [
  (Q.executionStartedAt,'2026-10-14T04:29:00Z',XSD.dateTime),
  (Q.startTimeKnowledge,'known',XSD.string),
  (Q.executionSource,'urn:synthetic:attempt-observation',XSD.anyURI),
  (Q.executionStage,'test_exercised',XSD.string),
  (Q.targetParticipation,'supported',XSD.string),
  (Q.participationSource,'urn:synthetic:target-observation',XSD.anyURI),
  (Q.executionCode,'urn:synthetic:test-code',XSD.anyURI),
  (Q.codeUseSource,'urn:synthetic:code-use-observation',XSD.anyURI),
  (Q.roostCandidate,'true',XSD.boolean)]:g.add((N.e1,p,lit(v,t)))
 return g
base=enhanced();Q=profile.Q
db=profile.connect()
def test_graph(name,mutate=None,expected=True,shacl_expected=None):
 g=clone(base)
 if mutate:mutate(g)
 before=state(db);receipt=profile.admit(db,name,g)
 accepted=receipt['status']=='ACCEPTED_SCOPED'
 ok_sql,sqlerrors=profile.sql_check(g);ok_shacl,shreport=profile.shacl_check(g)
 ok=accepted==expected
 if expected:ok &= ok_sql and ok_shacl and isomorphic(g,profile.base.verified_export(db,name))
 else:ok &= state(db)==before
 if shacl_expected is not None:ok &= ok_shacl==shacl_expected
 check(name,ok,dict(receipt=receipt,sql=ok_sql,shacl=ok_shacl,sqlerrors=sqlerrors,unchanged_on_rejection=state(db)==before if not expected else None))
 return g
test_graph('exercised_code_attempt')
def late_report(g):
 setv(g,N.result1,D.resultRecordedAt,lit('2026-10-15T10:00:00Z',XSD.dateTime));remap(g,{N.e1:N.late_event,N.result1:N.late_result})
def setup(g):
 setv(g,N.e1,Q.executionStage,lit('setup_only'));setv(g,N.e1,Q.targetParticipation,lit('unestablished'))
 g.remove((N.e1,Q.participationSource,None));g.remove((N.e1,Q.codeUseSource,None));g.remove((N.e1,Q.executionCode,None))
 setv(g,N.e1,Q.roostCandidate,lit('false',XSD.boolean));setv(g,N.result1,D.resultOutcome,Literal('aborted'))
 # New occurrence and result IDs are needed: this is not a rebinding of e1.
 remap(g,{N.e1:N.setup_event,N.result1:N.setup_result})
def remap(g,m):
 ts=[tuple(m.get(x,x) for x in t) for t in g];g.remove((None,None,None))
 for t in ts:g.add(t)
test_graph('late_report_is_documentation',late_report)
test_graph('setup_abort_target_unestablished',setup)
def unknown(g):
 setv(g,N.e1,Q.startTimeKnowledge,lit('unknown'));g.remove((N.e1,Q.executionStartedAt,None));remap(g,{N.e1:N.unknown_start,N.result1:N.unknown_result})
test_graph('unknown_start_without_fabricated_time',unknown)
test_graph('same_graph_new_snapshot')
test_graph('repeat_new_event_equal_times',lambda g:remap(g,{N.e1:N.repeat,N.result1:N.repeat_result}))
for key in ['startTimeKnowledge','executionSource','executionStage','targetParticipation','roostCandidate']:
 test_graph('missing_'+key,lambda g,k=key:g.remove((N.e1,Q[k],None)),False,False)
test_graph('known_start_missing',lambda g:g.remove((N.e1,Q.executionStartedAt,None)),False,False)
test_graph('unknown_with_invented_start',lambda g:setv(g,N.e1,Q.startTimeKnowledge,lit('unknown')),False,False)
test_graph('start_after_end',lambda g:setv(g,N.e1,Q.executionStartedAt,lit('2026-10-14T04:31:00Z',XSD.dateTime)),False,False)
test_graph('start_date_only',lambda g:setv(g,N.e1,Q.executionStartedAt,lit('2026-10-14',XSD.dateTime)),False)
test_graph('impossible_calendar_date',lambda g:setv(g,N.e1,Q.executionStartedAt,lit('2026-02-30T01:00:00Z',XSD.dateTime)),False)
test_graph('timezone_missing',lambda g:setv(g,N.e1,Q.executionStartedAt,lit('2026-10-14T04:29:00',XSD.dateTime)),False)
test_graph('supported_participation_missing_source',lambda g:g.remove((N.e1,Q.participationSource,None)),False,False)
test_graph('participation_unknown_with_positive_source',lambda g:setv(g,N.e1,Q.targetParticipation,lit('unestablished')),False,False)
test_graph('code_candidate_without_code',lambda g:g.remove((N.e1,Q.executionCode,None)),False,False)
test_graph('code_candidate_without_use_source',lambda g:g.remove((N.e1,Q.codeUseSource,None)),False,False)
test_graph('invalid_stage',lambda g:setv(g,N.e1,Q.executionStage,lit('planned')),False,False)
test_graph('relative_observation_source',lambda g:setv(g,N.e1,Q.executionSource,lit('source.txt',XSD.anyURI)),False,False)
test_graph('untyped_subject_with_profile',lambda g:g.add((N.not_event,Q.executionStage,lit('setup_only'))),False)
test_graph('missing_end_not_fabricated',lambda g:g.remove((N.e1,D.executionEndedAt,None)),False)
test_graph('setup_claims_pass',lambda g:setv(g,N.e1,Q.executionStage,lit('setup_only')),False,False)
test_graph('report_before_end',lambda g:setv(g,N.result1,D.resultRecordedAt,lit('2026-10-14T04:28:00Z',XSD.dateTime)),False)
test_graph('historical_event_source_rewrite',lambda g:setv(g,N.e1,Q.executionSource,lit('urn:synthetic:replacement',XSD.anyURI)),False,True)
before=state(db);r=profile.admit(db,'exercised_code_attempt',base)
check('idempotent_profile_replay',r.get('idempotent_replay') and state(db)==before,r,'history')

# Append-only corrections preserve accepted graph identity and provenance.
args=['urn:obs:1',str(N.e1),'executionStartedAt','2026-10-14T04:28:50Z','urn:source:1','2026-10-15T05:00:00Z']
original=profile.base.verified_export(db,'exercised_code_attempt')
r=profile.append_observation(db,*args)
check('correction_append_preserves_event_graph',r['status']=='RECORDED_ASSERTION' and isomorphic(original,profile.base.verified_export(db,'exercised_code_attempt')),r,'history')
r=profile.append_observation(db,'urn:obs:2',str(N.e1),'executionStartedAt','2026-10-14T04:28:55Z','urn:source:2','2026-10-15T05:01:00Z','urn:obs:1')
check('correction_supersession_chain',r['status']=='RECORDED_ASSERTION',r,'history')
for name,newargs in [
 ('duplicate_observation',args),
 ('missing_source',['urn:obs:3',str(N.e1),'resultOutcome','failed','','2026-10-15T06:00:00Z']),
 ('unknown_event',['urn:obs:4','urn:absent:event','resultOutcome','failed','urn:source:1','2026-10-15T06:00:00Z']),
 ('unsupported_rebinding',['urn:obs:5',str(N.e1),'testsRealization','urn:new:target','urn:source:1','2026-10-15T06:00:00Z']),
 ('nonexistent_supersession',['urn:obs:6',str(N.e1),'resultOutcome','failed','urn:source:1','2026-10-15T06:00:00Z','urn:obs:missing']),
 ('reversed_observation_time',['urn:obs:7',str(N.e1),'executionStartedAt','2026-10-14T04:28:55Z','urn:source:1','2026-10-15T04:00:00Z','urn:obs:1'])]:
 before=state(db);r=profile.append_observation(db,*newargs);check(name,r['status']=='REJECTED' and state(db)==before,r,'history')
for name,statement in [('observation_update',"UPDATE occurrence_observation SET assertion='changed'"),('observation_delete','DELETE FROM occurrence_observation')]:
 try:db.execute(statement);ok=False
 except sqlite3.IntegrityError:db.rollback();ok=True
 check(name,ok,group='history')
with tempfile.TemporaryDirectory() as tmp:
 p=Path(tmp)/'profile.sqlite';disk=profile.connect(p);r=profile.admit(disk,'disk',base);disk.close();disk=profile.connect(p,initialize=False)
 check('extended_graph_disk_roundtrip',r['status']=='ACCEPTED_SCOPED' and isomorphic(base,profile.base.verified_export(disk,'disk')),group='persistence');disk.close()
db.close()

# All retained event scenarios are re-evaluated with both independent methods.
fixtures=json.loads((W/'inputs/Event_Contract_Fixtures_v0_30_0.json').read_text())
for f in fixtures:
 s,se=event.sql_check(f);h,he=event.shacl_check(f)
 check('retained_event_'+f['id'],s==h==f['expected'],dict(sql=s,shacl=h,expected=f['expected']),group='retained_event')

# Replay the 25 identity-transition cases, without claiming gate integration.
spec=importlib.util.spec_from_file_location('identity_policy',W/'inputs/identity_policy.py');policy=importlib.util.module_from_spec(spec);spec.loader.exec_module(policy)
for c in json.loads((W/'inputs/identity_transition_cases.json').read_text()):
 r=policy.assess(c['input']);ok=r['status']==c['expected_status']
 for k,f in [('expected_realization','realization_identity'),('expected_capability','capability_identity')]:
  if c.get(k) is not None:ok &= r.get(f)==c[k]
 check('identity_'+c['name'],ok,r,'identity_policy')

# Reference records are typed without asserting class or target equivalence.
script={'handle':'EXT:ExternalUnresolved:Test_Script','target':'urn:external:script','source':'urn:source:script','version':'1','kind':'executable_code','roostCandidate':True}
plan={**script,'handle':'EXT:ExternalUnresolved:Test_Plan','kind':'test_plan_document','roostCandidate':False}
config={**script,'handle':'EXT:ExternalUnresolved:Configuration','kind':'test_dataset_configuration','roostCandidate':False}
market_contract=boundary.ELEMENTS['EXT:Market:Competitor_Alternative']['customProperties']['v0_41_boundary_contract']
competitor={**script,'handle':'EXT:Market:Competitor_Alternative','kind':'competitor_role','roostCandidate':False,'market':'urn:market:m','focal_product':'urn:product:p','need':'urn:need:n','valid_time':'2026-10-15','class_locator':market_contract['competitor_class_locator']}
alternative={**competitor,'kind':'alternative_assertion','predicate':market_contract['alternative_property_locator'],'subject':'urn:option:a','object':'urn:option:b'};alternative.pop('class_locator')
cases=[('executable_script',script,True),('manual_procedure',dict(script,kind='manual_procedure',roostCandidate=False),True),('manual_as_roost_script',dict(script,kind='manual_procedure'),False),('unqualified_old_script',dict(script,kind='test_script'),False),('test_plan_document',plan,True),('suite_as_plan',dict(plan,kind='test_suite'),False),('dataset_configuration',config,True),('environment_as_dataset',dict(config,kind='test_environment_configuration'),False),('productline_as_dataset',dict(config,kind='product_configuration'),False),('competitor_role',competitor,True),('alternative_assertion',alternative,True),('alternative_as_class',dict(alternative,class_locator='urn:fake:Alternative'),False),('wrong_competitor_class',dict(competitor,class_locator='urn:fake:Competitor'),False),('wrong_alternative_predicate',dict(alternative,predicate='urn:fake:alternativeTo'),False),('alternative_missing_object',dict(alternative,object=''),False)]
for field in ['market','focal_product','need','valid_time']:cases.append(('competitor_missing_'+field,dict(competitor,**{field:''}),False))
for field in ['source','version','target']:cases.append(('script_missing_'+field,dict(script,**{field:''}),False))
for assertion in ['sameAs','equivalentClass']:cases.append(('forbidden_'+assertion,dict(script,**{assertion:True}),False))
for handle,good,bad in [
 ('EXT:EvidenceLayer:Evidence','supporting_evidence','assessment_claim'),
 ('EXT:Market:MarketInsight','market_insight','raw_market_signal'),
 ('EXT:ProductManagement:Metric','metric_definition','observed_metric_value'),
 ('EXT:ExternalUnresolved:Evidence','supporting_evidence','evidence_attribution_record'),
 ('EXT:UXResearch:User_Mental_Model','mental_model_representation','user_mental_state'),
 ('EXT:Market:Pain','customer_pain_point','medical_pain')]:
 c={**script,'handle':handle,'kind':good,'roostCandidate':False}
 cases.extend([(handle+'_typed',c,True),(handle+'_conflation',dict(c,kind=bad),False)])
for name,c,expected in cases:
 r=boundary.assess(c);check(name,(r['status']=='CONTRACT_CONFORMING_ONLY')==expected and not r['semantic_equivalence'] and not r['owner_acceptance'],r,'external_boundary')

# A synthetic RDF boundary fixture checks the local non-conflation rule. It
# does not verify or redistribute an externally governed owner's ontology.
market=Graph()
ns='urn:ontospk:synthetic-market-boundary:'
market.add((URIRef(ns+'CompetitorRole'),RDF.type,OWL.Class))
market.add((URIRef(ns+'alternativeTo'),RDF.type,OWL.ObjectProperty))
check('boundary_competitor_class', (URIRef(ns+'CompetitorRole'),RDF.type,OWL.Class) in market,group='boundary_fixture')
check('boundary_alternative_property',(URIRef(ns+'alternativeTo'),RDF.type,OWL.ObjectProperty) in market,group='boundary_fixture')
check('boundary_no_fabricated_classes',all((URIRef(ns+x),RDF.type,OWL.Class) not in market for x in ['Pain','MarketInsight','AlternativeRelation']),group='boundary_fixture')

profile.SHAPES.serialize(W/'Occurrence_Profile_v0_41_0.shacl.ttl',format='turtle')
base.serialize(W/'fixtures/occurrence-positive-v041.ttl',format='turtle')
summary={'version':'0.41.0','native_sha256':INPUT_NATIVE_SHA256,'total':len(results),'passed':sum(x['passed'] for x in results),'groups':{k:{'total':sum(x['group']==k for x in results),'passed':sum(x['group']==k and x['passed'] for x in results)} for k in sorted({x['group'] for x in results})},'results':results,'new_positive_population_triples':len(base),'scope':'Synthetic profile and regression controls. Independent semantic review, full ROoST integration, complete UFO-B semantics and real browser acceptance remain unexecuted.','independent_acceptances':0}
(W/'results/Revision_Results_v0_41_0.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({k:v for k,v in summary.items() if k!='results'},indent=2))
assert all(r['passed'] for r in results)
