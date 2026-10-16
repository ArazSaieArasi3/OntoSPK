"""Bounded v0.41 occurrence reporting and atomic SQLite admission.

Source assertions remain assertions. This profile neither implements all UFO-B
semantics nor establishes accepted equivalence to ROoST. The original v0.35
population gate is retained and invoked after the additional explicit checks.
"""
import datetime as dt
import json
import re
import sqlite3
from pathlib import Path
from urllib.parse import urlsplit
from rdflib import Graph, Namespace, URIRef, Literal, RDF, XSD, BNode
from rdflib.collection import Collection
from pyshacl import validate
import admission as base
import sql_projection as sql

ROOT=Path(__file__).resolve().parent
P=base.P; D=base.D
Q=Namespace('urn:ontospk:occurrence-profile:0.41:')
SH=Namespace('http://www.w3.org/ns/shacl#')
FIELDS={
 'executionStartedAt':(XSD.dateTime,0,1),
 'startTimeKnowledge':(XSD.string,1,1),
 'executionSource':(XSD.anyURI,1,None),
 'executionStage':(XSD.string,1,1),
 'targetParticipation':(XSD.string,1,1),
 'participationSource':(XSD.anyURI,0,None),
 'executionCode':(XSD.anyURI,0,1),
 'codeUseSource':(XSD.anyURI,0,None),
 'roostCandidate':(XSD.boolean,1,1)}
# Existing mapped property tables and predicates stay unchanged.
for index,key in enumerate(FIELDS):sql.TABLE_FOR[str(Q[key])]='profile041_value_'+str(index)
base.PROFILE='combined-occurrence-reporting-v0.41.0'

def iri(value):
 if not isinstance(value,str) or re.search(r'\s',value):return False
 p=urlsplit(value)
 return bool((p.scheme=='urn' and p.path) or (p.scheme in ['http','https'] and p.netloc))

def time_value(value):
 """Explicit envelope, including timezone and real calendar validation."""
 if not isinstance(value,Literal) or value.datatype!=XSD.dateTime:return None
 text=str(value)
 if not base.event.valid_time(text) or not re.search(r'(Z|[+-]\d\d:\d\d)$',text):return None
 try:return dt.datetime.fromisoformat(text.replace('Z','+00:00'))
 except ValueError:return None

def make_shapes():
 g=Graph();g.bind('q',Q);g.bind('sh',SH)
 shape=Q.EventShape
 for triple in [(shape,RDF.type,SH.NodeShape),(shape,SH.targetClass,P.TestExecution)]:g.add(triple)
 for key,(dtype,lo,hi) in FIELDS.items():
  prop=BNode();g.add((shape,SH.property,prop));g.add((prop,SH.path,Q[key]));g.add((prop,SH.datatype,dtype));g.add((prop,SH.minCount,Literal(lo)))
  if hi is not None:g.add((prop,SH.maxCount,Literal(hi)))
  if key in ['startTimeKnowledge','executionStage','targetParticipation']:
   options={'startTimeKnowledge':['known','unknown'],'executionStage':['setup_only','test_exercised'],'targetParticipation':['supported','unestablished']}[key]
   head=BNode();Collection(g,head,[Literal(x,datatype=XSD.string) for x in options]);g.add((prop,SH['in'],head))
  if dtype==XSD.anyURI:g.add((prop,SH.pattern,Literal(r'^(urn:[^\s]+|https?://[^\s/]+[^\s]*)$')))
 def constraint(message,body):
  node=BNode();g.add((shape,SH.sparql,node));g.add((node,SH.message,Literal(message)))
  g.add((node,SH.select,Literal('SELECT $this WHERE { '+body+' }')))
 constraint('Known start requires one start; unknown start requires none.',f'''$this <{Q.startTimeKnowledge}> ?k .
 FILTER ((?k="known" && NOT EXISTS {{$this <{Q.executionStartedAt}> ?v}}) || (?k="unknown" && EXISTS {{$this <{Q.executionStartedAt}> ?v}}))''')
 constraint('Supported participation requires a source; unestablished participation has no positive source.',f'''$this <{Q.targetParticipation}> ?k .
 FILTER ((?k="supported" && NOT EXISTS {{$this <{Q.participationSource}> ?v}}) || (?k="unestablished" && EXISTS {{$this <{Q.participationSource}> ?v}}))''')
 constraint('Setup-only attempts must be aborted and have unestablished target participation.',f'''$this <{Q.executionStage}> "setup_only"^^<{XSD.string}> . FILTER (NOT EXISTS {{$this <{Q.targetParticipation}> "unestablished"^^<{XSD.string}>}} || NOT EXISTS {{?r <{P.recordsExecution}> $this; <{D.resultOutcome}> "aborted"}})''')
 constraint('An exercised test needs supported participation.',f'''$this <{Q.executionStage}> "test_exercised"^^<{XSD.string}> . FILTER NOT EXISTS {{$this <{Q.targetParticipation}> "supported"^^<{XSD.string}>}}''')
 constraint('ROoST candidate requires exercised code and causal evidence.',f'''$this <{Q.roostCandidate}> true . FILTER (NOT EXISTS {{$this <{Q.executionStage}> "test_exercised"^^<{XSD.string}>}} || NOT EXISTS {{$this <{Q.targetParticipation}> "supported"^^<{XSD.string}>}} || NOT EXISTS {{$this <{Q.executionCode}> ?c}} || NOT EXISTS {{$this <{Q.codeUseSource}> ?s}})''')
 constraint('Code-use sources require a code target.',f'''$this <{Q.codeUseSource}> ?s . FILTER NOT EXISTS {{$this <{Q.executionCode}> ?c}}''')
 constraint('Observed start must not follow observed end.',f'''$this <{Q.executionStartedAt}> ?s; <{D.executionEndedAt}> ?e . FILTER (?s > ?e)''')
 # Literal serialization/calendar/timezone validation is additionally enforced
 # by time_value in the SQL path; SHACL alone is not the whole gate.
 return g
SHAPES=make_shapes()

def shacl_check(graph):
 ok,_,report=validate(graph,shacl_graph=SHAPES,inference='none',advanced=True)
 return bool(ok),str(report)

def sql_check(graph):
 db=sqlite3.connect(':memory:');db.execute('CREATE TABLE triple(s TEXT,p TEXT,o TEXT,datatype TEXT,is_literal INTEGER)')
 db.executemany('INSERT INTO triple VALUES(?,?,?,?,?)',[(str(s),str(p),str(o),str(o.datatype or '') if isinstance(o,Literal) else '',int(isinstance(o,Literal))) for s,p,o in graph])
 errors=[]
 events=list(graph.subjects(RDF.type,P.TestExecution))
 if not events:errors.append('NO_CONCLUDED_ATTEMPT')
 for event in events:
  values={}
  for key,(dtype,lo,hi) in FIELDS.items():
   vs=list(graph.objects(event,Q[key]));values[key]=vs
   if len(vs)<lo or (hi is not None and len(vs)>hi):errors.append(key+':count')
   for value in vs:
    if not isinstance(value,Literal) or value.datatype!=dtype or value.language:errors.append(key+':datatype')
    if dtype==XSD.anyURI and not iri(str(value)):errors.append(key+':absolute_iri')
  one=lambda k:str(values[k][0]) if len(values[k])==1 else None
  knowledge=one('startTimeKnowledge');stage=one('executionStage');participation=one('targetParticipation')
  if knowledge not in ['known','unknown']:errors.append('START_KNOWLEDGE_ENUM')
  if stage not in ['setup_only','test_exercised']:errors.append('STAGE_ENUM')
  if participation not in ['supported','unestablished']:errors.append('PARTICIPATION_ENUM')
  if knowledge=='known' and len(values['executionStartedAt'])!=1:errors.append('KNOWN_START_REQUIRED')
  if knowledge=='unknown' and values['executionStartedAt']:errors.append('UNKNOWN_START_MUST_BE_ABSENT')
  if participation=='supported' and not values['participationSource']:errors.append('PARTICIPATION_SOURCE_REQUIRED')
  if participation=='unestablished' and values['participationSource']:errors.append('UNESTABLISHED_WITH_SOURCE')
  outcomes=db.execute('SELECT o FROM triple WHERE s IN (SELECT s FROM triple WHERE p=? AND o=?) AND p=?',(str(P.recordsExecution),str(event),str(D.resultOutcome))).fetchall()
  if stage=='setup_only' and (outcomes!=[('aborted',)] or participation!='unestablished'):errors.append('SETUP_ONLY_NOT_A_TEST_EXERCISE')
  if stage=='test_exercised' and participation!='supported':errors.append('EXERCISED_PARTICIPATION_REQUIRED')
  if values['codeUseSource'] and not values['executionCode']:errors.append('CODE_SOURCE_WITHOUT_CODE')
  candidate=one('roostCandidate')
  if candidate not in ['true','false']:errors.append('BOOLEAN_LEXICAL')
  if candidate=='true' and (stage!='test_exercised' or participation!='supported' or not values['executionCode'] or not values['codeUseSource']):errors.append('ROOST_SUBSET_WITNESS_REQUIRED')
  for predicate in [Q.executionStartedAt,D.executionEndedAt]:
   for value in graph.objects(event,predicate):
    if time_value(value) is None:errors.append('TIME_ENVELOPE_OR_TIMEZONE')
  starts=values['executionStartedAt'];ends=list(graph.objects(event,D.executionEndedAt))
  if len(ends)!=1:errors.append('ONE_KNOWN_END_REQUIRED')
  if len(starts)==len(ends)==1:
   start,end=time_value(starts[0]),time_value(ends[0])
   if start and end and start>end:errors.append('START_AFTER_END')
 for result in graph.subjects(RDF.type,P.TestResult):
  for value in graph.objects(result,D.resultRecordedAt):
   if time_value(value) is None:errors.append('REPORT_TIME_ENVELOPE_OR_TIMEZONE')
 # New profile predicates must never be attached to an unrelated/untagged node.
 for key in FIELDS:
  for subject in graph.subjects(Q[key],None):
   if (subject,RDF.type,P.TestExecution) not in graph:errors.append('UNTYPED_PROFILE_SUBJECT')
 db.close();return not errors,sorted(set(errors))

def connect(path=':memory:',initialize=True):
 db=base.connect(path,initialize=initialize)
 for index,key in enumerate(FIELDS):
  db.execute('CREATE TABLE IF NOT EXISTS profile041_value_'+str(index)+'(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id))')
 db.executescript('''CREATE TABLE IF NOT EXISTS occurrence_observation(
  observation_id TEXT PRIMARY KEY,event_iri TEXT NOT NULL,field TEXT NOT NULL,
  assertion TEXT NOT NULL,source TEXT NOT NULL,recorded_at TEXT NOT NULL,
  supersedes TEXT REFERENCES occurrence_observation(observation_id));
  CREATE TRIGGER IF NOT EXISTS observation_no_update BEFORE UPDATE ON occurrence_observation BEGIN SELECT RAISE(ABORT,'IMMUTABLE_OBSERVATION'); END;
  CREATE TRIGGER IF NOT EXISTS observation_no_delete BEFORE DELETE ON occurrence_observation BEGIN SELECT RAISE(ABORT,'IMMUTABLE_OBSERVATION'); END;
  CREATE TRIGGER IF NOT EXISTS observation_no_replace BEFORE INSERT ON occurrence_observation WHEN EXISTS(SELECT 1 FROM occurrence_observation WHERE observation_id=NEW.observation_id) BEGIN SELECT RAISE(ABORT,'IMMUTABLE_OBSERVATION'); END;''')
 return db

def admit(db,snapshot,graph):
 if db.in_transaction:raise RuntimeError('Admission requires a completed caller transaction.')
 ok,errors=sql_check(graph)
 if not ok:return dict(status='REJECTED',stage='occurrence_sql',detail=errors)
 ok,report=shacl_check(graph)
 if not ok:return dict(status='REJECTED',stage='occurrence_shacl',detail=report)
 receipt=base.admit(db,snapshot,graph)
 if receipt['status']=='ACCEPTED_SCOPED':receipt.update(profile='0.41.0',occurrence_sql=True,occurrence_shacl=True,roost_equivalence=False)
 return receipt

def append_observation(db,observation_id,event_iri,field,assertion,source,recorded_at,supersedes=None):
 """Append a sourced correction assertion without rewriting the accepted graph."""
 if db.in_transaction:raise RuntimeError('Observation append owns its transaction.')
 if not all(iri(x) for x in [observation_id,event_iri,source]):return {'status':'REJECTED','reason':'ABSOLUTE_IRI_REQUIRED'}
 if field not in ['executionStartedAt','executionEndedAt','targetParticipation','resultOutcome']:return {'status':'REJECTED','reason':'UNSUPPORTED_OBSERVATION_FIELD'}
 timestamp=time_value(Literal(recorded_at,datatype=XSD.dateTime,normalize=False))
 if timestamp is None:return {'status':'REJECTED','reason':'INVALID_OBSERVATION_TIME'}
 if field.endswith('At') and time_value(Literal(assertion,datatype=XSD.dateTime,normalize=False)) is None:return {'status':'REJECTED','reason':'INVALID_ASSERTED_TIME'}
 if field=='targetParticipation' and assertion not in ['supported','unestablished']:return {'status':'REJECTED','reason':'INVALID_PARTICIPATION_ASSERTION'}
 if field=='resultOutcome' and assertion not in ['passed','failed','aborted','inconclusive','unknown']:return {'status':'REJECTED','reason':'INVALID_OUTCOME_ASSERTION'}
 db.execute('BEGIN IMMEDIATE')
 try:
  if not db.execute("SELECT 1 FROM historical_binding WHERE kind='completed_event' AND iri=?",(event_iri,)).fetchone():raise ValueError('UNKNOWN_ACCEPTED_EVENT')
  if supersedes:
   old=db.execute('SELECT event_iri,field,recorded_at FROM occurrence_observation WHERE observation_id=?',(supersedes,)).fetchone()
   if not old or old[:2]!=(event_iri,field):raise ValueError('INVALID_SUPERSESSION')
   if timestamp<dt.datetime.fromisoformat(old[2].replace('Z','+00:00')):raise ValueError('OBSERVATION_TIME_REVERSED')
  db.execute('INSERT INTO occurrence_observation VALUES(?,?,?,?,?,?,?)',(observation_id,event_iri,field,assertion,source,recorded_at,supersedes));db.commit()
  return dict(status='RECORDED_ASSERTION',changes_accepted_occurrence=False,independent_acceptance=False)
 except (ValueError,sqlite3.IntegrityError) as exc:
  db.rollback();return dict(status='REJECTED',reason=str(exc))

if __name__=='__main__':SHAPES.serialize(ROOT/'Occurrence_Profile_v0_41_0.shacl.ttl',format='turtle')
