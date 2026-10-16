"""Controlled import/export using the unchanged v0.16 physical DDL (438 tables).

Adapted from the retained database.py. Table names come only from pinned maps;
native ancestry is from the current v0.30 model. Storing a draft is not acceptance.
"""
import csv
import hashlib
import sqlite3
from pathlib import Path
from rdflib import Graph, URIRef, BNode, Literal, RDF
import event_contracts as c

ROOT=Path(__file__).resolve().parent
def rows(name):return list(csv.DictReader((ROOT/'inputs'/name).open(encoding='utf-8-sig')))
CLASSES={r['native_id']:r for r in rows('Class_Table_Mapping_v0_16_0.csv')}
BY_IRI={r['iri']:r for r in CLASSES.values()}
TABLE_FOR={r['predicate']:r['table_name'] for r in rows('Property_Table_Mapping_v0_16_0.csv')}
RELATIONS=rows('Relation_OWL_SQL_Crosswalk_v0_16_0.csv')
DDL=ROOT/'inputs/domain_schema_v016.sql'

def connect(path=':memory:', initialize=True):
    db=sqlite3.connect(path,timeout=10)
    db.execute('PRAGMA foreign_keys=ON')
    if initialize:db.executescript(DDL.read_text())
    return db

def termid(db,value,snapshot):
    if isinstance(value,URIRef):key=('IRI',str(value),'','','')
    elif isinstance(value,BNode):key=('BNODE',str(value),'','',snapshot)
    elif isinstance(value,Literal):key=('LITERAL',str(value),str(value.datatype or ''),value.language or '','')
    else:raise TypeError(type(value))
    found=db.execute('SELECT term_id FROM term WHERE kind=? AND lexical=? AND datatype=? AND language=? AND blank_scope=?',key).fetchone()
    return found[0] if found else db.execute('INSERT INTO term(kind,lexical,datatype,language,blank_scope) VALUES(?,?,?,?,?)',key).lastrowid

def digest(graph):
    # Lexical asserted-graph fingerprint; no blank-node canonicalization claim.
    return hashlib.sha256('\n'.join(sorted(' '.join(x.n3() for x in t) for t in graph)).encode()).hexdigest()

def load_graph(db,snapshot,graph):
    db.execute('SAVEPOINT import_snapshot')
    try:
        db.execute('INSERT INTO snapshot(snapshot_id,source_path,source_sha256) VALUES(?,?,?)',(snapshot,'SYNTHETIC_v035',digest(graph)))
        ids={x:termid(db,x,snapshot) for t in sorted(graph,key=lambda t:tuple(x.n3() for x in t)) for x in t}
        resources={x for s,p,o in graph for x in (s,o) if isinstance(x,(URIRef,BNode))}
        for value in resources:db.execute('INSERT INTO entity VALUES(?,?)',(snapshot,ids[value]))
        memberships={}
        for subject,kind in graph.subject_objects(RDF.type):
            db.execute('INSERT INTO asserted_type VALUES(?,?,?)',(snapshot,ids[subject],ids[kind]))
            if str(kind) in BY_IRI:
                own=BY_IRI[str(kind)]['native_id']
                for parent in c.ancestors(own):
                    if parent in CLASSES:
                        key=(parent,ids[subject]);memberships[key]=max(memberships.get(key,0),int(parent==own))
        for (kind,entity),explicit in memberships.items():
            db.execute('INSERT INTO '+CLASSES[kind]['table_name']+' VALUES(?,?,?)',(snapshot,entity,explicit))
        for subject,predicate,obj in sorted(graph,key=lambda t:tuple(x.n3() for x in t)):
            if predicate==RDF.type:continue
            if str(predicate) in TABLE_FOR:
                db.execute('INSERT INTO '+TABLE_FOR[str(predicate)]+' VALUES(?,?,?)',(snapshot,ids[subject],ids[obj]))
            else:db.execute('INSERT INTO residual_statement VALUES(?,?,?,?)',(snapshot,ids[subject],ids[predicate],ids[obj]))
        db.execute('RELEASE import_snapshot')
    except Exception:
        db.execute('ROLLBACK TO import_snapshot');db.execute('RELEASE import_snapshot');raise

def export_graph(db,snapshot):
    terms={}
    for i,k,l,d,lang,scope in db.execute('SELECT * FROM term'):
        terms[i]=URIRef(l) if k=='IRI' else BNode(l) if k=='BNODE' else Literal(l,datatype=URIRef(d) if d and not lang else None,lang=lang or None,normalize=False)
    graph=Graph()
    for s,t in db.execute('SELECT entity_id,class_id FROM asserted_type WHERE snapshot_id=?',(snapshot,)):
        graph.add((terms[s],RDF.type,terms[t]))
    for predicate,table in TABLE_FOR.items():
        for s,o in db.execute('SELECT subject_id,object_id FROM '+table+' WHERE snapshot_id=?',(snapshot,)):
            graph.add((terms[s],URIRef(predicate),terms[o]))
    for s,p,o in db.execute('SELECT subject_id,predicate_id,object_id FROM residual_statement WHERE snapshot_id=?',(snapshot,)):
        graph.add((terms[s],terms[p],terms[o]))
    return graph

def minimum_audit(db,snapshot):
    failures=[]
    for relation in RELATIONS:
        for end in ['source','target']:
            minimum,_=c.bounds(relation[end+'_cardinality'])
            focus=relation[('target' if end=='source' else 'source')+'_id']
            if not minimum or focus not in CLASSES:continue
            column,other=('object_id','subject_id') if end=='source' else ('subject_id','object_id')
            if relation['direction']=='INVERSE':column,other=other,column
            query=('SELECT e.entity_id,COUNT(l.'+other+') FROM '+CLASSES[focus]['table_name']+' e LEFT JOIN '+relation['table_name']+
                   ' l ON l.snapshot_id=e.snapshot_id AND l.'+column+'=e.entity_id WHERE e.snapshot_id=? GROUP BY e.entity_id HAVING COUNT(l.'+other+') < ?')
            for entity,count in db.execute(query,(snapshot,minimum)):
                failures.append(dict(relation=relation['relation_id'],end=end,entity=entity,minimum=minimum,observed=count))
    return failures
