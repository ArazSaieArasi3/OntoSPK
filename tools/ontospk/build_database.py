"""Build the current synthetic occurrence demonstrator and inspect its real schema."""
from pathlib import Path
import csv,gzip,hashlib,json,sqlite3,sys
from rdflib import Graph,RDF
from rdflib.compare import isomorphic

ROOT=Path(__file__).resolve().parents[2];V=ROOT/'semantic/product/v2';S=V/'source/validation_v041'
sys.path.insert(0,str(S));import occurrence_profile as profile
OUT=ROOT/'data-models/product/v2';OUT.mkdir(parents=True,exist_ok=True)
dbpath=OUT/'OntoSPK-v2.0.0-rc.1-synthetic.sqlite'
if dbpath.exists():dbpath.unlink()
db=profile.connect(dbpath)
g=Graph().parse(S/'fixtures/occurrence-positive-v041.ttl')
receipt=profile.admit(db,'ontospk-v2-rc1-synthetic-occurrence',g)
assert receipt['status']=='ACCEPTED_SCOPED',receipt
recovered=profile.base.verified_export(db,'ontospk-v2-rc1-synthetic-occurrence')
assert isomorphic(g,recovered)
db.close();db=profile.connect(dbpath,initialize=False)
assert isomorphic(g,profile.base.verified_export(db,'ontospk-v2-rc1-synthetic-occurrence'))
assert db.execute('PRAGMA integrity_check').fetchone()[0]=='ok'
assert not list(db.execute('PRAGMA foreign_key_check'))
objects=list(db.execute("SELECT type,name,sql FROM sqlite_master WHERE type IN ('table','view','trigger','index') AND name NOT LIKE 'sqlite_%' ORDER BY type,name"))
with (OUT/'schema.sql').open('w') as f:
    f.write('-- Generated SQLite schema including the bounded admission/occurrence profile.\nPRAGMA foreign_keys=ON;\n')
    for kind,name,sql in objects:
        if kind=='table' and sql:f.write(sql+';\n')
    for kind,name,sql in objects:
        if kind!='table' and sql:f.write(sql+';\n')
with (OUT/'data-dictionary.csv').open('w',newline='') as f:
    w=csv.writer(f);w.writerow(['object_type','object_name','column_index','column_name','declared_type','not_null','default','primary_key','population_rows'])
    for kind,name,sql in objects:
        if kind not in ['table','view']:continue
        count=db.execute('SELECT COUNT(*) FROM "'+name+'"').fetchone()[0]
        for cid,col,t,nn,default,pk in db.execute('PRAGMA table_info("'+name+'")'):w.writerow([kind,name,cid,col,t,nn,default,pk,count])
with (OUT/'physical-foreign-keys.csv').open('w',newline='') as f:
    w=csv.writer(f);w.writerow(['table','fk_id','sequence','referenced_table','from_column','to_column','on_update','on_delete'])
    for kind,name,sql in objects:
        if kind!='table':continue
        for row in db.execute('PRAGMA foreign_key_list("'+name+'")'):w.writerow([name,*row[:7]])
tables=[n for k,n,_ in objects if k=='table'];views=[n for k,n,_ in objects if k=='view']
summary={'release':'v2.0.0-rc.1','native':'0.41.0','engine':'SQLite','sqlite_version':sqlite3.sqlite_version,
 'tables':len(tables),'views':len(views),'triggers':sum(k=='trigger' for k,_,_ in objects),
 'asserted_triples':len(g),'typed_entities':len(set(g.subjects(RDF.type))),
 'populated_classes':len(set(g.objects(None,RDF.type))),
 'close_reopen_isomorphic':True,'foreign_key_check':'PASS','integrity_check':'ok',
 'source_fixture':'../../../semantic/product/v2/source/validation_v041/fixtures/occurrence-positive-v041.ttl',
 'data_origin':'SYNTHETIC_ONLY','production_deployment':False,
 'scope':'Full declared physical schema; one selected 13-class occurrence population, not a population of every native class or association.'}
db.close()
summary['database_sha256']=hashlib.sha256(dbpath.read_bytes()).hexdigest()
dbpath.with_suffix('.sqlite.gz').write_bytes(gzip.compress(dbpath.read_bytes(),mtime=0))
(OUT/'DATABASE_BUILD.json').write_text(json.dumps(summary,indent=2)+'\n')
g.serialize(OUT/'synthetic-input.ttl',format='turtle');recovered.serialize(OUT/'synthetic-recovered.ttl',format='turtle')
(OUT/'ERD.md').write_text('''# Physical projection architecture

The full foreign-key inventory is [physical-foreign-keys.csv](physical-foreign-keys.csv); every table, view and column is in [data-dictionary.csv](data-dictionary.csv). This diagram shows representative physical patterns, not all hundreds of tables.

```mermaid
erDiagram
    SNAPSHOT ||--o{ ENTITY : scopes
    TERM ||--o{ ENTITY : identifies
    ENTITY ||--o{ CLASS_MEMBERSHIP : types
    ENTITY ||--o{ PREDICATE_TABLE : subjects
    TERM ||--o{ PREDICATE_TABLE : values
    SNAPSHOT ||--o| ADMISSION_RECEIPT : qualifies
    SNAPSHOT ||--o{ HISTORY_BINDING : records
```

The native-to-class and relation-to-predicate mappings are explicit source CSV files. A physical predicate table may represent an inverse or retained profile helper; its count is not an independent association count. The occurrence profile adds append-only provenance and binding controls to the retained 438-table schema and two base admission tables. Record keys do not prove real-world identity.
''')
print(json.dumps(summary,indent=2))
