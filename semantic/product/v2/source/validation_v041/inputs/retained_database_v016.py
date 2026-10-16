"""Atomic asserted-graph imports into domain tables; class ancestors are labelled inferred."""
import sqlite3
from rdflib import BNode,Literal
from rdflib.compare import to_isomorphic
from model import *
def connect(path=':memory:',initialize=False):
 db=sqlite3.connect(path);db.execute('PRAGMA foreign_keys=ON')
 assert db.execute('PRAGMA foreign_keys').fetchone()==(1,)
 if initialize:db.executescript((ROOT/'schema/domain_schema.sql').read_text())
 return db
def termid(db,x,snapshot):
 if isinstance(x,URIRef):key=('IRI',str(x),'','','')
 elif isinstance(x,BNode):key=('BNODE',str(x),'','',snapshot)
 elif isinstance(x,Literal):key=('LITERAL',str(x),str(x.datatype or ''),x.language or '','')
 else:raise TypeError(type(x))
 found=db.execute('SELECT term_id FROM term WHERE kind=? AND lexical=? AND datatype=? AND language=? AND blank_scope=?',key).fetchone()
 if found:return found[0]
 return db.execute('INSERT INTO term(kind,lexical,datatype,language,blank_scope) VALUES(?,?,?,?,?)',key).lastrowid
def load_graph(db,snapshot,g,source='synthetic',source_hash=''):
 # Savepoint wraps every part, including terms, so a rejected import leaves no half-populated snapshot.
 db.execute('SAVEPOINT import_snapshot')
 try:
  db.execute('INSERT INTO snapshot(snapshot_id,source_path,source_sha256) VALUES(?,?,?)',(snapshot,source,source_hash))
  ids={x:termid(db,x,snapshot) for t in sorted(g,key=lambda t:tuple(x.n3() for x in t)) for x in t}
  resources={x for s,p,o in g for x in (s,o) if isinstance(x,(URIRef,BNode))}
  for x in resources:db.execute('INSERT INTO entity VALUES(?,?)',(snapshot,ids[x]))
  memberships={}
  for s,c in g.subject_objects(RDF.type):
   db.execute('INSERT INTO asserted_type VALUES(?,?,?)',(snapshot,ids[s],ids[c]))
   if str(c) in class_by_iri:
    own=class_by_iri[str(c)]['native_id']
    for cid in ancestors(own):memberships[(cid,ids[s])]=max(memberships.get((cid,ids[s]),0),int(cid==own))
  for (cid,i),explicit in memberships.items():db.execute(f"INSERT INTO {cm[cid]['table_name']} VALUES(?,?,?)",(snapshot,i,explicit))
  for s,p,o in sorted(g,key=lambda t:tuple(x.n3() for x in t)):
   if p==RDF.type:continue
   if str(p) in table_for:db.execute(f'INSERT INTO {table_for[str(p)]} VALUES(?,?,?)',(snapshot,ids[s],ids[o]))
   else:db.execute('INSERT INTO residual_statement VALUES(?,?,?,?)',(snapshot,ids[s],ids[p],ids[o]))
  db.execute('RELEASE import_snapshot')
 except Exception:
  db.execute('ROLLBACK TO import_snapshot');db.execute('RELEASE import_snapshot');raise
def export_graph(db,snapshot):
 terms={}
 for i,k,l,d,lang,scope in db.execute('SELECT * FROM term'):
  terms[i]=URIRef(l) if k=='IRI' else BNode(l) if k=='BNODE' else Literal(l,datatype=URIRef(d) if d and not lang else None,lang=lang or None,normalize=False)
 g=Graph()
 for s,c in db.execute('SELECT entity_id,class_id FROM asserted_type WHERE snapshot_id=?',(snapshot,)):g.add((terms[s],RDF.type,terms[c]))
 for p,t in table_for.items():
  for s,o in db.execute(f'SELECT subject_id,object_id FROM {t} WHERE snapshot_id=?',(snapshot,)):g.add((terms[s],URIRef(p),terms[o]))
 for s,p,o in db.execute('SELECT subject_id,predicate_id,object_id FROM residual_statement WHERE snapshot_id=?',(snapshot,)):g.add((terms[s],terms[p],terms[o]))
 return g
def cardinality_contracts():
 contracts=[]
 for r in relations:
  for end in ['source','target']:
   low,high=bounds(r[end+'_cardinality']);opposite='target' if end=='source' else 'source';focus_cid=r[opposite+'_id']
   # Count members at the adjacent end for each instance at the opposite end.
   focus='object_id' if end=='source' else 'subject_id';other='subject_id' if end=='source' else 'object_id'
   if r['direction']=='INVERSE':focus,other=other,focus
   contracts.append(dict(relation_id=r['relation_id'],end=end,minimum=low,maximum=high,focus_class=focus_cid,focus_column=focus,counted_column=other,table_name=r['table_name'],focus_scope='LOCAL_CLASS' if focus_cid in cm else 'EXTERNAL_UNIVERSE_NOT_CLASSIFIED'))
 return contracts
def cardinality_audit(db,snapshot):
 violations=[]
 for c in cardinality_contracts():
  if c['focus_class'] not in cm or not c['minimum']:continue
  q=f"SELECT e.entity_id,COUNT(l.{c['counted_column']}) FROM {cm[c['focus_class']]['table_name']} e LEFT JOIN {c['table_name']} l ON l.snapshot_id=e.snapshot_id AND l.{c['focus_column']}=e.entity_id WHERE e.snapshot_id=? GROUP BY e.entity_id HAVING COUNT(l.{c['counted_column']}) < ?"
  for entity,n in db.execute(q,(snapshot,c['minimum'])):violations.append(dict(relation_id=c['relation_id'],end=c['end'],entity_id=entity,observed=n,minimum=c['minimum']))
 return violations
def assess_snapshot(db,snapshot):
 from pyshacl import validate
 g=export_graph(db,snapshot);ok,_,text=validate(g,shacl_graph=Graph().parse(ROOT/'schema/complete-reporting-v0_16.shacl.ttl'),ont_graph=ont,inference='none')
 missing=cardinality_audit(db,snapshot)
 return {'snapshot':snapshot,'native_minimum_violations':missing,'shacl_conforms':bool(ok),'complete_profile_accepted':bool(ok) and not missing,'sql_snapshot_state':'draft','note':'Candidate engineering gate only; not author/domain or independent expert acceptance'},text
