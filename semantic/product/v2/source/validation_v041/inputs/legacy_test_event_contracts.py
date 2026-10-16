"""Bounded native Event instance contracts, checked independently with SHACL and SQL.
No complete UFO-B axiomatization or whole-ontology consistency claim is made.
"""
import copy,datetime,json,sqlite3
from pathlib import Path
from urllib.parse import quote
from rdflib import Graph,Namespace,URIRef,Literal,BNode,RDF,XSD
from pyshacl import validate
W=Path(__file__).resolve().parent
model=json.loads((W/'inputs/Native_Model_v0_41_0.json').read_text());es={e['id']:e for e in model['elements']}
ev=json.loads((W/'inputs/Event_Validation_Input_v0_29_0.json').read_text())
REL=ev['incident_relation_ids'];EV='IC:TestExecution';END='executionEndedAt'
N=Namespace('urn:product-ontology:event-instance:');SH=Namespace('http://www.w3.org/ns/shacl#')
def ref(i):return URIRef('urn:product-ontology:native:'+quote(i,safe=''))
def pred(i):return URIRef('urn:product-ontology:event-contract:'+quote(i,safe=''))
def write(name,x):(W/name).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
parents={i:set() for i in es}
for e in es.values():
 if e['type']=='Generalization':parents[e['specific']].add(e['general'])
def ancestors(t):return {t}|set().union(*(ancestors(p) for p in parents[t]))
def bounds(c):a=c.split('..');return int(a[0]),None if a[-1]=='*' else int(a[-1])
contracts=[]
for rid in REL:
 r=es[rid];a,b=(es[i] for i in r['properties']);contracts.append({'relation':rid,'source':a['propertyType'],'target':b['propertyType'],
 'per_source_bounds':bounds(b['cardinality']),'per_target_bounds':bounds(a['cardinality'])})
shapes=Graph();shapes.bind('sh',SH)
for c in contracts:
 p=pred(c['relation'])
 for direction in ['source','target']:
  shape=BNode();shapes.add((shape,RDF.type,SH.NodeShape));shapes.add((shape,SH.targetClass,ref(c[direction])))
  shapes.add((shape,SH.targetSubjectsOf if direction=='source' else SH.targetObjectsOf,p));shapes.add((shape,SH['class'],ref(c[direction])))
  prop=BNode();shapes.add((shape,SH.property,prop));path=p
  if direction=='target':path=BNode();shapes.add((path,SH.inversePath,p))
  shapes.add((prop,SH.path,path));shapes.add((prop,SH['class'],ref(c['target' if direction=='source' else 'source'])))
  lo,hi=c['per_'+direction+'_bounds'];shapes.add((prop,SH.minCount,Literal(lo)))
  if hi is not None:shapes.add((prop,SH.maxCount,Literal(hi)))
eventShape=N.EventShape;shapes.add((eventShape,RDF.type,SH.NodeShape));shapes.add((eventShape,SH.targetClass,ref(EV)))
timep=BNode();shapes.add((eventShape,SH.property,timep));shapes.add((timep,SH.path,pred(END)));shapes.add((timep,SH.datatype,XSD.dateTime))
shapes.add((timep,SH.minCount,Literal(1)));shapes.add((timep,SH.maxCount,Literal(1)))
suiteRel='REL:W2:147';execRel='REL:W2:090';contains='REL:W2:088';testsRel='ICREL:CP:testsRealization';assessRel='ICREL:CP:assessesSpecification'
versionRel='ICREL:CP:realizesVersion';capVersion='ICREL:CP:specifiesCapability'
suiteShape=N.SuiteShape;shapes.add((suiteShape,RDF.type,SH.NodeShape));shapes.add((suiteShape,SH.targetSubjectsOf,pred(suiteRel)))
def sparql(shape,message,query):
 q=BNode();shapes.add((shape,SH.sparql,q));shapes.add((q,SH.message,Literal(message)));shapes.add((q,SH.select,Literal(query)))
sparql(suiteShape,'Recorded execution must execute a case explicitly contained in the indexing suite.',
 f'SELECT $this WHERE {{ $this <{pred(suiteRel)}> ?e . ?e <{pred(execRel)}> ?case . FILTER NOT EXISTS {{$this <{pred(contains)}> ?case }} }}')
sparql(eventShape,'Assessed capability specification must be linked to the version of the tested realization.',
 f'SELECT $this WHERE {{ $this <{pred(assessRel)}> ?cap . FILTER NOT EXISTS {{ $this <{pred(testsRel)}> ?real . ?real <{pred(versionRel)}> ?v . ?v <{pred(capVersion)}> ?cap }} }}')
shapes.serialize(W/'Event_Contract_Shapes_v0_30_0.ttl',format='turtle')
base={'types':{'e1':[EV],'case1':['IC:TestCase'],'real1':['IC:ProductRealization'],'cap1':['IC:CapabilitySpecification'],
 'condition1':['IC:ConditionSpecification'],'result1':['IC:TestResult'],'ctx1':['IC:AssessmentContextSpecification'],'v1':['IC:ProductVersion']},
 'edges':[['REL:W2:091','e1','result1'],[execRel,'e1','case1'],[testsRel,'e1','real1'],[assessRel,'e1','cap1'],
 ['REL:ORSD05:executionContext','e1','ctx1'],['REL:ORSD05:executionCriterion','e1','condition1'],[versionRel,'real1','v1'],[capVersion,'v1','cap1']],
 'ended':{'e1':['2026-10-14T04:30:00Z']}}
fixtures=[]
def case(id,expected,reason,mutate=lambda x:None):
 x=copy.deepcopy(base);mutate(x);x.update(id=id,expected=expected,reason=reason);fixtures.append(x)
case('completed_record',True,'All seven relation signatures and mandatory recorded-run fields satisfied; suite indexing optional.')
for subtype in sorted(i for i,e in es.items() if e['type']=='Class' and i!='IC:ConditionSpecification' and 'IC:ConditionSpecification' in ancestors(i)):
 case('only_'+subtype.split(':')[-1],True,'ImpAbs counterexample: one criterion of one subtype is sufficient; no quota of every subtype.',lambda x,t=subtype:x['types'].__setitem__('condition1',[t]))
for outcome in ['failed','aborted']:
 case('completed_'+outcome,True,'A consolidated result does not require success; an aborted concluded run is within scope.',lambda x,v=outcome:x.update(outcome_annotation=v))
def addrepeat(x):
 x['types']['e2']=[EV];x['types']['result2']=['IC:TestResult'];x['ended']['e2']=x['ended']['e1'].copy()
 x['edges'] += [[r,'e2','result2' if t=='result1' else t] for r,s,t in x['edges'] if s=='e1']
case('repeat_new_event_same_bindings',True,'Repetition remains a distinct occurrence even with equal case, subject and timestamp.',addrepeat)
def suite(x,valid=True):
 x['types']['suite1']=['IC:TestSuiteSpecification'];x['edges'].append([suiteRel,'suite1','e1'])
 if valid:x['edges'].append([contains,'suite1','case1'])
case('explicit_suite_index',True,'Indexing suite explicitly contains the executed case.',suite)
case('wrong_suite_index',False,'The suite cannot index an execution of a case outside its declared membership.',lambda x:suite(x,False))
for c in contracts:
 rid=c['relation'];lo,hi=c['per_source_bounds']
 if lo>0:
  case('missing_'+rid.split(':')[-1],False,'Required source-to-target minimum is not met.',lambda x,r=rid:x.__setitem__('edges',[e for e in x['edges'] if e[0]!=r]))
 if hi==1:
  def duplicate(x,r=rid,t=c['target']):x['types']['extra']=[t];x['edges'].append([r,'e1','extra'])
  case('multiple_'+rid.split(':')[-1],False,'Maximum one adjacent target exceeded.',duplicate)
 def wrongtarget(x,r=rid):
  if r==suiteRel:suite(x);x['edges'].remove([suiteRel,'suite1','e1']);x['edges'].append([suiteRel,'suite1','case1'])
  else:
   edge=next(e for e in x['edges'] if e[0]==r);x['types'][edge[2]]=['IC:ProductMetricReference']
 case('wrong_target_'+rid.split(':')[-1],False,'Object type violates the native relationship endpoint.',wrongtarget)
case('missing_event_type',False,'Property-based targeting must detect an untyped run.',lambda x:x['types'].__setitem__('e1',[]))
case('specification_as_event',False,'A TestCase specification cannot stand in for the occurring TestExecution.',lambda x:x['types'].__setitem__('e1',['IC:TestCase']))
case('missing_end_time',False,'The completed-event profile requires an end time.',lambda x:x['ended'].__setitem__('e1',[]))
case('multiple_end_times',False,'One consolidated event end time required.',lambda x:x['ended']['e1'].append('2026-10-14T04:31:00Z'))
case('malformed_end_time',False,'A dateTime value is required.',lambda x:x['ended'].__setitem__('e1',['not-a-date']))
def sharedresult(x):
 addrepeat(x);x['types'].pop('result2');x['edges']=[e for e in x['edges'] if e!=['REL:W2:091','e2','result2']];x['edges'].append(['REL:W2:091','e2','result1'])
case('one_result_two_events',False,'A consolidated result belongs to exactly one recorded execution.',sharedresult)
case('unmatched_capability_version',False,'Assessment capability must belong to the tested version.',lambda x:x.__setitem__('edges',[e for e in x['edges'] if e[0]!=capVersion]))
case('no_realization_version',False,'Missing version evidence fails the selected same-version reporting contract.',lambda x:x.__setitem__('edges',[e for e in x['edges'] if e[0]!=versionRel]))
# Native Event counterparts of the three RelComp findings; no coverage propagation.
event_decisions=[d for d in json.loads((W/'inputs/Composition_Decisions_v0_29_0.json').read_text()) if d['direct_event_dependency']]
assert len(event_decisions)==3
for decision in event_decisions:
 rid=decision['orientation']['inner_relation']
 # Use actual endpoint definitions rather than assuming label direction.
 source_type,target_type=[es[p]['propertyType'] for p in es[rid]['properties']]
 def composition(x,r=rid,a=source_type,b=target_type):
  x['types']['condition1']=[a];x['types']['other_condition']=[b];x['edges'].append([r,'condition1','other_condition'])
 case('no_criterion_propagation_'+rid.split(':')[-1],True,'An explicitly checked condition may link to another condition without that condition becoming checked or satisfied.',composition)

def expanded(f):return {(n,t) for n,ts in f['types'].items() for c in ts for t in ancestors(c)}
def graph(f):
 g=Graph()
 for n,t in expanded(f):g.add((N[n],RDF.type,ref(t)))
 for r,s,t in f['edges']:g.add((N[s],pred(r),N[t]))
 for e,values in f['ended'].items():
  for v in values:g.add((N[e],pred(END),Literal(v,datatype=XSD.dateTime,normalize=False)))
 return g
def sql_check(f):
 db=sqlite3.connect(':memory:');db.executescript('CREATE TABLE types(node TEXT,typ TEXT, PRIMARY KEY(node,typ)); CREATE TABLE links(rel TEXT,s TEXT,t TEXT,PRIMARY KEY(rel,s,t)); CREATE TABLE endings(node TEXT,value TEXT);')
 db.executemany('INSERT INTO types VALUES (?,?)',expanded(f));db.executemany('INSERT INTO links VALUES (?,?,?)',f['edges'])
 db.executemany('INSERT INTO endings VALUES (?,?)',[(e,v) for e,vs in f['ended'].items() for v in vs]);errors=[]
 for c in contracts:
  rid=c['relation']
  for side,other,col,opposite in [('source','target','s','t'),('target','source','t','s')]:
   lo,hi=c['per_'+side+'_bounds']
   wrong=db.execute(f'SELECT l.{col} FROM links l WHERE rel=? AND NOT EXISTS(SELECT 1 FROM types t WHERE t.node=l.{col} AND t.typ=?)',(rid,c[side])).fetchall()
   if wrong:errors.append('type:'+rid+':'+side)
   counts=db.execute(f'SELECT ty.node,COUNT(DISTINCT l.{opposite}) FROM types ty LEFT JOIN links l ON ty.node=l.{col} AND l.rel=? WHERE ty.typ=? GROUP BY ty.node',(rid,c[side])).fetchall()
   if any(n<lo or (hi is not None and n>hi) for _,n in counts):errors.append('bound:'+rid+':'+side)
 for (e,) in db.execute('SELECT node FROM types WHERE typ=?',(EV,)):
  values=[r[0] for r in db.execute('SELECT value FROM endings WHERE node=?',(e,))]
  if len(values)!=1:errors.append('end_count')
  for value in values:
   try:datetime.datetime.fromisoformat(value.replace('Z','+00:00'))
   except ValueError:errors.append('end_datatype')
 badsuite=db.execute('SELECT a.s FROM links a JOIN links b ON a.t=b.s AND b.rel=? WHERE a.rel=? AND NOT EXISTS(SELECT 1 FROM links c WHERE c.rel=? AND c.s=a.s AND c.t=b.t)',(execRel,suiteRel,contains)).fetchall()
 if badsuite:errors.append('suite_case_membership')
 badversion=db.execute('SELECT a.s FROM links a WHERE a.rel=? AND NOT EXISTS(SELECT 1 FROM links t JOIN links v ON t.t=v.s AND v.rel=? JOIN links c ON v.t=c.s AND c.rel=? WHERE t.s=a.s AND t.rel=? AND c.t=a.t)',(assessRel,versionRel,capVersion,testsRel)).fetchall()
 if badversion:errors.append('same_tested_version')
 db.close();return not errors,errors
results=[]
for f in fixtures:
 ok,report,text=validate(graph(f),shacl_graph=shapes,inference='none',advanced=True)
 sqlok,errors=sql_check(f)
 results.append({'id':f['id'],'expected':f['expected'],'shacl':bool(ok),'sql':sqlok,'sql_errors':errors,'passed':bool(ok)==sqlok==f['expected']})
 if not results[-1]['passed']:print(results[-1]);print(text)
assert all(x['passed'] for x in results)

# Completed-occurrence ledger: these application checks are separate from static
# ontology validation and do not assert that an ID establishes event identity.
db=sqlite3.connect(':memory:')
db.executescript('''CREATE TABLE occurrences(id TEXT PRIMARY KEY,case_id TEXT,realization TEXT,context TEXT,ended TEXT,result_id TEXT UNIQUE);
CREATE TRIGGER no_rebind BEFORE UPDATE ON occurrences
WHEN OLD.case_id IS NOT NEW.case_id OR OLD.realization IS NOT NEW.realization OR OLD.context IS NOT NEW.context OR OLD.ended IS NOT NEW.ended OR OLD.result_id IS NOT NEW.result_id
BEGIN SELECT RAISE(ABORT,'completed occurrence binding is immutable'); END;''')
db.execute('INSERT INTO occurrences VALUES (?,?,?,?,?,?)',('e1','case1','real1','ctx1','2026-10-14T04:30:00Z','result1'))
ledger=[]
db.execute("UPDATE occurrences SET case_id='case1' WHERE id='e1'");ledger.append({'id':'idempotent_record','expected':'accept','passed':True})
db.execute('INSERT INTO occurrences VALUES (?,?,?,?,?,?)',('e2','case1','real1','ctx1','2026-10-14T04:30:00Z','result2'));ledger.append({'id':'repetition_separate_occurrence','expected':'accept','passed':True})
for col in ['case_id','realization','context','ended','result_id']:
 try:db.execute(f'UPDATE occurrences SET {col}=? WHERE id=?',('changed','e1'));rejected=False
 except sqlite3.IntegrityError:rejected=True
 assert rejected;ledger.append({'id':'rebind_'+col,'expected':'reject','passed':rejected})
write('Event_Contract_Fixtures_v0_30_0.json',fixtures)
write('Event_Contract_Results_v0_30_0.json',{'source_native_model':'Native_Model_v0_41_0.json','relation_signatures':contracts,
 'fixtures':results,'passed':len(results),'total':len(results),'ledger_controls':ledger,
 'scope':'Synthetic finite recorded-run subprofile, seven native relation signatures, explicit end time, suite membership, tested-version capability binding and immutable completed-occurrence binding.',
 'not_claimed':['Full native ontology population validity','Complete UFO-B event semantics','Official anti-pattern execution on Event','Success/satisfaction entailed from assessment','Empirical observation or independent acceptance']})
print(json.dumps({'event_fixtures':len(results),'passed':len(results),'positive':sum(x['expected'] for x in results),'ledger_controls':len(ledger)}))
