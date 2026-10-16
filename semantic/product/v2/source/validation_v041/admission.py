"""Combined population gate over the real retained SQLite projection.

An ACCEPTED_SCOPED receipt means the supplied synthetic/declared population
passed these pinned engineering gates. It never means independent acceptance.
The unchanged legacy snapshot table stays 'draft'; receipts are explicit.
"""
import json
import sqlite3
from pathlib import Path
from rdflib import Graph, URIRef, Literal, RDF, Namespace
from rdflib.compare import isomorphic
from pyshacl import validate
import event_contracts as event
import representation_bridge as bridge
import sql_projection as sql

ROOT=Path(__file__).resolve().parent
P=Namespace('urn:productium:specification-profile:')
D=Namespace('urn:product-ontology:delivery-profile:0.5:')
FULL_SHAPES=Graph().parse(ROOT/'inputs/complete-reporting-v0_16.shacl.ttl')
IDENTITY_SHAPES=Graph().parse(ROOT/'inputs/identity-slice.shacl.ttl')
ONTOLOGY=Graph().parse(ROOT/'inputs/Retained_Formal_Profile_v0_15_0.ttl')
PROFILE='combined-identity-event-v0.35.0'

class Rejected(ValueError):
    def __init__(self,stage,detail):self.stage=stage;self.detail=detail

def connect(path=':memory:',initialize=True):
    db=sql.connect(path,initialize=initialize)
    db.executescript('''
    CREATE TABLE IF NOT EXISTS admission_receipt(
      snapshot_id TEXT PRIMARY KEY NOT NULL REFERENCES snapshot(snapshot_id),
      profile TEXT NOT NULL, graph_sha256 TEXT NOT NULL, triple_count INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS historical_binding(
      kind TEXT NOT NULL, iri TEXT NOT NULL, binding TEXT NOT NULL,
      first_snapshot TEXT NOT NULL REFERENCES admission_receipt(snapshot_id),
      PRIMARY KEY(kind,iri));
    CREATE TRIGGER IF NOT EXISTS receipt_no_update BEFORE UPDATE ON admission_receipt
      BEGIN SELECT RAISE(ABORT,'IMMUTABLE_RECEIPT'); END;
    CREATE TRIGGER IF NOT EXISTS receipt_no_delete BEFORE DELETE ON admission_receipt
      BEGIN SELECT RAISE(ABORT,'RECEIPT_DELETE_FORBIDDEN'); END;
    CREATE TRIGGER IF NOT EXISTS receipt_no_replace BEFORE INSERT ON admission_receipt
      WHEN EXISTS(SELECT 1 FROM admission_receipt WHERE snapshot_id=NEW.snapshot_id)
      BEGIN SELECT RAISE(ABORT,'RECEIPT_ALREADY_EXISTS'); END;
    CREATE TRIGGER IF NOT EXISTS binding_no_update BEFORE UPDATE ON historical_binding
      BEGIN SELECT RAISE(ABORT,'IMMUTABLE_HISTORY_BINDING'); END;
    CREATE TRIGGER IF NOT EXISTS binding_no_delete BEFORE DELETE ON historical_binding
      BEGIN SELECT RAISE(ABORT,'HISTORY_DELETE_FORBIDDEN'); END;
    CREATE TRIGGER IF NOT EXISTS binding_no_replace BEFORE INSERT ON historical_binding
      WHEN EXISTS(SELECT 1 FROM historical_binding WHERE kind=NEW.kind AND iri=NEW.iri)
      BEGIN SELECT RAISE(ABORT,'HISTORY_BINDING_ALREADY_EXISTS'); END;
    ''')
    return db

def event_projection(graph):
    """Only the declared event-check slice, not the graph used for persistence."""
    fixture=dict(types={},edges=[],ended={})
    for s,typ in graph.subject_objects(RDF.type):
        if typ in bridge.REVERSE_CLASSES:
            fixture['types'].setdefault(str(s),[]).append(bridge.REVERSE_CLASSES[typ])
    for s,p,o in graph:
        if p in bridge.REVERSE:
            relation,direction=bridge.REVERSE[p];source,target=str(s),str(o)
            if direction=='INVERSE':source,target=target,source
            fixture['edges'].append([relation,source,target])
        elif p==bridge.ENDED:
            fixture['ended'].setdefault(str(s),[]).append(str(o))
    return fixture

def preflight(graph):
    if not any(graph.subjects(RDF.type,P.TestExecution)):
        raise Rejected('scope','AT_LEAST_ONE_TYPED_COMPLETED_EVENT_REQUIRED')
    for s,p,o in graph:
        if not isinstance(s,URIRef) or not isinstance(p,URIRef) or not isinstance(o,(URIRef,Literal)):
            raise Rejected('scope','CONTROLLED_PROFILE_USES_IRI_RESOURCES_AND_LITERALS')
        if p==RDF.type:
            if str(o) not in sql.BY_IRI:raise Rejected('scope','UNMAPPED_ASSERTED_CLASS')
        elif str(p) not in sql.TABLE_FOR:
            raise Rejected('scope','UNMAPPED_PREDICATE')

def assess_graph(graph):
    preflight(graph)
    identity_ok,_,identity_report=validate(graph,shacl_graph=IDENTITY_SHAPES,inference='none')
    if not identity_ok:raise Rejected('identity_shacl',identity_report)
    full_ok,_,full_report=validate(graph,shacl_graph=FULL_SHAPES,ont_graph=ONTOLOGY,inference='none')
    if not full_ok:raise Rejected('retained_reporting_shacl',full_report)
    fixture=event_projection(graph)
    event_ok,errors=event.sql_check(fixture)
    if not event_ok:raise Rejected('event_sql',errors)
    event_ok,report=event.shacl_check(fixture)
    if not event_ok:raise Rejected('event_shacl',report)
    return dict(identity_shacl=True,retained_reporting_shacl=True,event_sql=True,event_shacl=True)

def bindings(graph):
    result=[]
    for node in graph.subjects(RDF.type,P.ProductRealization):
        values=list(graph.objects(node,P.realizesVersion))
        if len(values)!=1:raise Rejected('history','ONE_REALIZATION_VERSION_REQUIRED')
        result.append(('realization_version',str(node),str(values[0])))
    for node in graph.subjects(RDF.type,P.ProductCapability):
        values=list(graph.subjects(P.bearsCapability,node))
        if len(values)!=1:raise Rejected('history','ONE_CAPABILITY_BEARER_REQUIRED')
        result.append(('capability_bearer',str(node),str(values[0])))
    for typ,kind in [(P.TestExecution,'completed_event'),(P.TestResult,'completed_result')]:
        for node in graph.subjects(RDF.type,typ):
            incident={t for t in graph if t[0]==node or t[2]==node}
            value=json.dumps(sorted(' '.join(x.n3() for x in t) for t in incident),separators=(',',':'))
            result.append((kind,str(node),value))
    return sorted(set(result))

def verified_export(db,snapshot):
    receipt=db.execute('SELECT graph_sha256,triple_count FROM admission_receipt WHERE snapshot_id=?',(snapshot,)).fetchone()
    if receipt is None:raise Rejected('receipt','NO_SCOPED_ACCEPTANCE_RECEIPT')
    graph=sql.export_graph(db,snapshot)
    if sql.digest(graph)!=receipt[0] or len(graph)!=receipt[1]:
        raise Rejected('integrity','STORED_GRAPH_DIFFERS_FROM_ACCEPTED_RECEIPT')
    return graph

def admit(db,snapshot,graph):
    if not isinstance(snapshot,str) or not snapshot.strip():
        return dict(status='REJECTED',stage='input',detail='NONEMPTY_SNAPSHOT_ID_REQUIRED')
    if db.in_transaction:
        raise RuntimeError('Admission owns its transaction; finish the caller transaction first.')
    db.execute('BEGIN IMMEDIATE')
    stages={}
    try:
        receipt=db.execute('SELECT profile,graph_sha256 FROM admission_receipt WHERE snapshot_id=?',(snapshot,)).fetchone()
        if receipt:
            restored=verified_export(db,snapshot)
            if receipt[0]!=PROFILE or not isomorphic(restored,graph):
                raise Rejected('idempotency','SNAPSHOT_ID_CONFLICT')
            db.rollback();return dict(status='ACCEPTED_SCOPED',idempotent_replay=True,snapshot=snapshot)
        # No input is dropped: the FULL asserted graph enters actual domain tables.
        preflight(graph)
        sql.load_graph(db,snapshot,graph);stages['physical_sql_import']=True
        missing=sql.minimum_audit(db,snapshot)
        if missing:raise Rejected('native_minima',missing)
        stages['native_minima']=True
        stages.update(assess_graph(graph))
        restored=sql.export_graph(db,snapshot)
        if not isomorphic(restored,graph):raise Rejected('roundtrip','ASSERTED_GRAPH_CHANGED')
        stages['asserted_roundtrip']=True
        rows=bindings(graph)
        for kind,iri,value in rows:
            old=db.execute('SELECT binding FROM historical_binding WHERE kind=? AND iri=?',(kind,iri)).fetchone()
            if old and old[0]!=value:raise Rejected('history',dict(kind=kind,iri=iri,reason='IMMUTABLE_BINDING_CONFLICT'))
        stages['history']=True
        db.execute('INSERT INTO admission_receipt VALUES(?,?,?,?)',(snapshot,PROFILE,sql.digest(graph),len(graph)))
        for kind,iri,value in rows:
            if not db.execute('SELECT 1 FROM historical_binding WHERE kind=? AND iri=?',(kind,iri)).fetchone():
                db.execute('INSERT INTO historical_binding VALUES(?,?,?,?)',(kind,iri,value,snapshot))
        if list(db.execute('PRAGMA foreign_key_check')):raise Rejected('integrity','FOREIGN_KEY_VIOLATION')
        db.commit()
        return dict(status='ACCEPTED_SCOPED',snapshot=snapshot,idempotent_replay=False,triples=len(graph),stages=stages,
                    evidence='SYNTHETIC_OR_DECLARED_ONLY',independent_acceptance=False,legacy_snapshot_status='draft')
    except (Rejected,sqlite3.IntegrityError) as exc:
        db.rollback()
        return dict(status='REJECTED',stage=exc.stage if isinstance(exc,Rejected) else 'physical_sql_import',
                    detail=exc.detail if isinstance(exc,Rejected) else str(exc),completed_stages=stages)
    except Exception:
        db.rollback();raise
