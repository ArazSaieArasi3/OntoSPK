"""Positive/negative population and persistence controls on actual physical tables."""
import hashlib
import json
import logging
import sqlite3
import tempfile
from pathlib import Path
from rdflib import Graph, URIRef, Literal, RDF, XSD
from rdflib.compare import isomorphic
import admission as a
import sql_projection as sql
from build_population import build, P, A, D, N

logging.getLogger('rdflib.term').setLevel(logging.CRITICAL)
W=Path(__file__).resolve().parent
for name in ['results','fixtures']:(W/name).mkdir(exist_ok=True)
base=build();results=[]

def clone(graph):return Graph()+graph
def rename(graph,mapping):
    g=Graph()
    for triple in graph:g.add(tuple(mapping.get(t,t) for t in triple))
    return g
def state(db):
    data=[]
    for (name,) in db.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"):
        data.append((name,sorted(db.execute('SELECT * FROM "'+name+'"').fetchall(),key=repr)))
    return hashlib.sha256(repr(data).encode()).hexdigest()
def check(name,passed,detail=None,group='population'):
    results.append(dict(id=name,group=group,passed=bool(passed),detail=detail))
    if not passed:print('FAILED',name,detail,flush=True)

db=a.connect()
receipt=a.admit(db,'baseline',base)
check('combined_baseline',receipt['status']=='ACCEPTED_SCOPED',receipt)
check('all_asserted_triples_recovered',isomorphic(base,a.verified_export(db,'baseline')),{'triples':len(base)},'roundtrip')
check('legacy_snapshot_explicitly_draft',db.execute('SELECT status FROM snapshot').fetchone()[0]=='draft',group='provenance')
before=state(db);replay=a.admit(db,'baseline',clone(base))
check('idempotent_replay_no_writes',replay.get('idempotent_replay') and state(db)==before,replay,'history')

def positive(name,graph):
    receipt=a.admit(db,name,graph)
    ok=receipt['status']=='ACCEPTED_SCOPED'
    roundtrip=ok and isomorphic(graph,a.verified_export(db,name))
    check(name,ok and roundtrip,dict(receipt=receipt,roundtrip=roundtrip))
    graph.serialize(W/'fixtures'/(name+'.ttl'),format='turtle')

positive('same_population_new_snapshot',clone(base))
repeated=rename(base,{N.e1:N.e2,N.result1:N.result2})
positive('repeat_distinct_event_same_inputs',repeated)
both=clone(base);both+=repeated
positive('two_events_one_population',both)
subtype=rename(base,{N.e1:N.e_subtype,N.result1:N.result_subtype,N.condition1:N.req1})
subtype.remove((N.req1,RDF.type,P.ConditionSpecification));subtype.add((N.req1,RDF.type,P.RequirementSpecification))
positive('subtype_explicit_ancestry_roundtrip',subtype)
g=rename(base,{N.e1:N.e_cap2,N.result1:N.result_cap2})
g.add((N.actual2,RDF.type,P.ProductCapability));g.add((N.real1,P.bearsCapability,N.actual2))
positive('multiple_capabilities_one_bearer',g)

def negative(name,mutate=None,graph=None,expected_stage=None,snapshot=None):
    graph=clone(base) if graph is None else graph
    if mutate:mutate(graph)
    before=state(db)
    receipt=a.admit(db,snapshot or 'reject_'+name,graph)
    same=state(db)==before
    ok=receipt['status']=='REJECTED' and same and (expected_stage is None or receipt['stage']==expected_stage)
    check(name,ok,dict(receipt=receipt,all_tables_unchanged=same),group='rejection')
    graph.serialize(W/'fixtures'/('negative_'+name+'.ttl'),format='turtle')

negative('empty_population',graph=Graph(),expected_stage='scope')
negative('missing_realization_type',lambda g:g.remove((N.real1,RDF.type,P.ProductRealization)),expected_stage='physical_sql_import')
negative('missing_actual_capability_type',lambda g:g.remove((N.actual1,RDF.type,P.ProductCapability)),expected_stage='physical_sql_import')
negative('missing_version_binding',lambda g:g.remove((N.real1,P.realizesVersion,None)),expected_stage='native_minima')
def double_version(g):
    g.add((N.v2,RDF.type,P.ProductVersion));g.add((N.product1,P.hasVersion,N.v2));g.add((N.real1,P.realizesVersion,N.v2))
negative('two_versions_for_one_realization',double_version,expected_stage='physical_sql_import')
negative('missing_actual_capability',lambda g:g.remove((N.real1,P.bearsCapability,None)),expected_stage='native_minima')
def double_bearer(g):
    g.add((N.other_real,RDF.type,P.ProductRealization));g.add((N.other_real,P.realizesVersion,N.v1));g.add((N.other_real,P.bearsCapability,N.actual1))
negative('two_bearers_for_one_capability',double_bearer,expected_stage='physical_sql_import')
negative('missing_product_owner_of_version',lambda g:g.remove((N.product1,P.hasVersion,N.v1)),expected_stage='native_minima')
negative('missing_result_execution_link',lambda g:g.remove((N.result1,P.recordsExecution,N.e1)),expected_stage='native_minima')
negative('missing_end_time',lambda g:g.remove((N.e1,D.executionEndedAt,None)),expected_stage='retained_reporting_shacl')
def set_value(subject,predicate,value):
    def mutate(g):g.remove((subject,predicate,None));g.add((subject,predicate,value))
    return mutate
negative('date_only_end_time',set_value(N.e1,D.executionEndedAt,Literal('2026-10-14',datatype=XSD.dateTime,normalize=False)))
negative('result_before_event_end',set_value(N.result1,D.resultRecordedAt,Literal('2026-10-14T04:29:00Z',datatype=XSD.dateTime,normalize=False)),expected_stage='retained_reporting_shacl')
negative('unknown_result_outcome',set_value(N.result1,D.resultOutcome,Literal('perfect')),expected_stage='retained_reporting_shacl')
negative('missing_context_provenance',lambda g:g.remove((N.ctx1,A.contextSource,None)),expected_stage='retained_reporting_shacl')
negative('missing_result_provenance',lambda g:g.remove((N.result1,D.resultSource,None)),expected_stage='retained_reporting_shacl')
negative('missing_capability_version_link',lambda g:g.remove((N.v1,P.specifiesCapability,N.cap1)))
negative('suite_does_not_contain_executed_case',lambda g:g.remove((N.suite1,P.containsCase,N.case1)),expected_stage='retained_reporting_shacl')
negative('datatype_mismatch',set_value(N.ctx1,A.contextDescription,Literal('context',lang='en')),expected_stage='physical_sql_import')
negative('unmapped_predicate',lambda g:g.add((N.e1,URIRef('urn:unmapped:property'),N.case1)),expected_stage='scope')
negative('unmapped_class',lambda g:g.add((N.external,RDF.type,URIRef('urn:unmapped:Class'))),expected_stage='scope')

# Valid individual snapshots that violate accepted cross-snapshot commitments.
version_changed=rename(base,{N.v1:N.v_changed,N.e1:N.e_changed,N.result1:N.result_changed})
negative('historical_realization_version_rebind',graph=version_changed,expected_stage='history')
bearer_changed=rename(base,{N.real1:N.new_bearer,N.e1:N.e_bearer,N.result1:N.result_bearer})
negative('historical_capability_bearer_rebind',graph=bearer_changed,expected_stage='history')
negative('historical_event_case_rebind',graph=rename(base,{N.case1:N.changed_case}),expected_stage='history')
negative('historical_result_outcome_rebind',set_value(N.result1,D.resultOutcome,Literal('passed')),expected_stage='history')
negative('snapshot_identifier_conflict',graph=repeated,snapshot='baseline',expected_stage='idempotency')

# A snapshot loader can intentionally store incomplete drafts. Demonstrate that
# admission is stricter and receipts cannot be inferred from successful INSERT.
with tempfile.TemporaryDirectory() as tmp:
    raw=sql.connect();g=clone(base);g.remove((N.real1,P.bearsCapability,None))
    sql.load_graph(raw,'incomplete_draft',g)
    check('draft_storage_is_not_acceptance',len(sql.minimum_audit(raw,'incomplete_draft'))>0,group='boundary')
    raw.close()
    path=Path(tmp)/'persisted.sqlite';disk=a.connect(path);r=a.admit(disk,'disk',base);disk.close()
    disk=a.connect(path,initialize=False)
    check('disk_reopen_exact_graph',r['status']=='ACCEPTED_SCOPED' and isomorphic(a.verified_export(disk,'disk'),base),group='persistence')
    before=state(disk);rejected=a.admit(disk,'disk-conflict',version_changed)
    check('disk_reopen_history_rejection',rejected['status']=='REJECTED' and rejected['stage']=='history' and state(disk)==before,rejected,'persistence')
    # Storage is accessible as drafts; verified export detects stale receipts.
    disk.execute("DELETE FROM link_bears_capability WHERE snapshot_id='disk'");disk.commit()
    try:a.verified_export(disk,'disk');detected=False
    except a.Rejected as exc:detected=exc.stage=='integrity'
    check('post_admission_graph_tampering_detected',detected,group='boundary');disk.close()

# Static mappings are checked against the CURRENT native model, not labels.
mapping_ok=True
for r in sql.RELATIONS:
    relation=a.event.ELEMENTS[r['relation_id']]
    source,target=[a.event.ELEMENTS[p] for p in relation['properties']]
    mapping_ok &= [source['propertyType'],source['cardinality'],target['propertyType'],target['cardinality']]==[r['source_id'],r['source_cardinality'],r['target_id'],r['target_cardinality']]
check('all_286_physical_relation_contracts_match_current_native',mapping_ok,group='mapping')
check('all_101_local_classes_match_current_native',set(sql.CLASSES)=={k for k,v in a.event.ELEMENTS.items() if v['type']=='Class' and not k.startswith('EXT:')},group='mapping')
check('sqlite_foreign_key_integrity',not list(db.execute('PRAGMA foreign_key_check')),group='integrity')
check('sqlite_integrity_check',db.execute('PRAGMA integrity_check').fetchone()[0]=='ok',group='integrity')
db.close()

# Deliver a separate, clean demonstrator containing only the positive baseline.
demo=W/'Combined_Identity_Event_v0_35_0.sqlite'
if demo.exists():demo.unlink()
db=a.connect(demo);demo_receipt=a.admit(db,'combined-positive-v035',base)
assert demo_receipt['status']=='ACCEPTED_SCOPED'
counts={table:db.execute('SELECT COUNT(*) FROM "'+table+'"').fetchone()[0] for (table,) in db.execute("SELECT name FROM sqlite_master WHERE type='table'")}
populated={k:v for k,v in counts.items() if v}
exported=a.verified_export(db,'combined-positive-v035');exported.serialize(W/'fixtures/combined-recovered.ttl',format='turtle')
base.serialize(W/'fixtures/combined-positive.ttl',format='turtle')
db.close()
summary=dict(version='0.35.0',total=len(results),passed=sum(r['passed'] for r in results),
    groups={g:dict(total=sum(r['group']==g for r in results),passed=sum(r['group']==g and r['passed'] for r in results)) for g in sorted({r['group'] for r in results})},
    results=results,population=dict(triples=len(base),typed_entities=len(set(base.subjects(RDF.type,None))),
        asserted_classes=len(set(base.objects(None,RDF.type))),physical_tables=438,added_gate_tables=2,populated_tables=populated),
    clean_demo_receipt=demo_receipt,scope='One constructed population with its mutations, actual SQLite physical schema and bounded pinned profiles; not an empirical study or whole-ontology semantic validation.')
(W/'results/Integration_Results_v0_35_0.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({k:v for k,v in summary.items() if k not in ['results','population','clean_demo_receipt']},indent=2))
print('POPULATION',json.dumps(summary['population']))
assert all(x['passed'] for x in results)
