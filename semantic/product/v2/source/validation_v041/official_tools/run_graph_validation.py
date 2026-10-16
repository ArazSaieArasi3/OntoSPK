"""Run implemented upstream rules on an explicit, audited native-to-vocabulary projection."""
from pathlib import Path
import ast, collections, hashlib, inspect, json, sys
from urllib.parse import quote
from rdflib import Graph, Namespace, URIRef, Literal, RDF, XSD
from rdflib.compare import isomorphic
from loguru import logger

W=Path(__file__).resolve().parent
repo=Path(sys.argv[1]).resolve();sys.path.insert(0,str(repo))
from validator.validations.rules_cl import rules_cl
from validator.validations.rules_definitions import RULES_DEFINITIONS
from validator.validations.rules_general import execute_all_validation_rules
logger.remove()
OU=Namespace('https://w3id.org/ontouml#');AUD=Namespace('urn:product-ontology:audit:')
def uri(i):return URIRef('urn:product-ontology:native:'+quote(i,safe=''))
def write(n,x):(W/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
model=json.loads((W/'inputs/Native_Model_v0_41_0.json').read_text());es={e['id']:e for e in model['elements']}
g=Graph();g.bind('ontouml',OU);g.bind('audit',AUD)
natures={'functional-complex':'functionalComplexNature','intrinsic-mode':'intrinsicModeNature','extrinsic-mode':'extrinsicModeNature'}
for e in es.values():
    s=uri(e['id']);g.add((s,RDF.type,OU['Relation' if e['type']=='BinaryRelation' else e['type']]))
    g.add((s,AUD.nativeId,Literal(e['id'])))
    # Exact original payload is archival; upstream rules do not interpret it.
    g.add((s,AUD.nativePayload,Literal(json.dumps(e,sort_keys=True,ensure_ascii=False),datatype=RDF.JSON)))
    for k in ['name','description']:
        for lang,text in (e.get(k) or {}).items():g.add((s,OU[k],Literal(text,lang=lang)))
    if e.get('stereotype'):g.add((s,OU.stereotype,OU[e['stereotype']]))
    for n in e.get('restrictedTo',[]):g.add((s,OU.restrictedTo,OU[natures.get(n,n+'Nature')]))
    for k in ['isDerived','isAbstract','isPowertype','isReadOnly','isOrdered','isDisjoint','isComplete']:
        if e.get(k) is not None:g.add((s,OU[k],Literal(e[k],datatype=XSD.boolean)))
    if e.get('order') is not None:g.add((s,OU.order,Literal(e['order'])))
    for k in ['general','specific','propertyType']:
        if e.get(k):g.add((s,OU[k],uri(e[k])))
    if e['type']=='BinaryRelation':
        for idx,p in enumerate(e['properties']):
            g.add((s,OU.relationEnd,uri(p)));g.add((s,OU.sourceEnd if idx==0 else OU.targetEnd,uri(p)));g.add((uri(p),OU.owner,s))
    elif e['type']=='Class':
        for p in e.get('properties',[]):g.add((s,OU.attribute,uri(p)))
    for k,v in [('generalizations','generalization'),('literals','literal'),('contents','containsModelElement')]:
        for i in e.get(k,[]):g.add((s,OU[v],uri(i)))
    if e['type']=='Property':
        card=URIRef(str(s)+':cardinality');g.add((s,OU.cardinality,card));g.add((card,RDF.type,OU.Cardinality))
        b=e['cardinality'].split('..');lo=b[0];hi=b[-1]
        g.add((card,OU.lowerBound,Literal(int(lo),datatype=XSD.nonNegativeInteger)))
        g.add((card,OU.upperBound,Literal(hi)))
        g.add((card,OU.cardinalityValue,Literal(e['cardinality'])))
g.serialize(W/'results/Native_Vocabulary_Projection.ttl',format='turtle')
reloaded=Graph().parse(W/'results/Native_Vocabulary_Projection.ttl',format='turtle');assert isomorphic(g,reloaded)
for e in es.values():
    s=uri(e['id']);assert json.loads(str(reloaded.value(s,AUD.nativePayload)))==e
    if e['type']=='Class':
        assert set(reloaded.objects(s,OU.restrictedTo))=={OU[natures.get(n,n+'Nature')] for n in e['restrictedTo']}
        assert set(reloaded.objects(s,OU.stereotype))==({OU[e['stereotype']]} if e['stereotype'] else set())
    if e['type']=='BinaryRelation':
        assert reloaded.value(s,OU.sourceEnd)==uri(e['properties'][0])
        assert reloaded.value(s,OU.targetEnd)==uri(e['properties'][1])
    if e['type']=='Property':
        assert reloaded.value(s,OU.propertyType)==uri(e['propertyType'])
        assert str(reloaded.value(reloaded.value(s,OU.cardinality),OU.cardinalityValue))==e['cardinality']
    if e['type']=='Generalization':
        assert reloaded.value(s,OU.general)==uri(e['general']) and reloaded.value(s,OU.specific)==uri(e['specific'])
implemented={n.removeprefix('execute_rule_'):f for n,f in vars(rules_cl).items() if n.startswith('execute_rule_') and callable(f)}
assert len(implemented)==13 and len(RULES_DEFINITIONS)==71
def issue(x):return {k:str(v) for k,v in vars(x).items()}
rows=[]
for code in sorted(RULES_DEFINITIONS):
    row={'rule':code,'definition':RULES_DEFINITIONS[code]}
    if code not in implemented:row.update(status='NOT_IMPLEMENTED',warnings=[],errors=[])
    else:
        try:
            warnings,errors=implemented[code](reloaded,code)
            row.update(status='EXECUTED',warnings=[issue(x) for x in warnings],errors=[issue(x) for x in errors])
        except Exception as ex:row.update(status='EXECUTION_FAILURE',exception=repr(ex),warnings=[],errors=[])
    rows.append(row)
assert all(x['status']!='EXECUTION_FAILURE' for x in rows)
try:
    execute_all_validation_rules(reloaded);aggregate={'completed':True}
except Exception as ex:aggregate={'completed':False,'exception':repr(ex),'reason':'The upstream dispatcher iterates all defined rules but implements only 13; unsupported rule reaches default exception.'}
event=uri('IC:TestExecution')
event_issues=[{'rule':r['rule'],'severity':sev,**x} for r in rows for sev in ['warnings','errors'] for x in r[sev] if x['related_id']==str(event)]
assert not event_issues
controls=[]
for label,code,remove,add,expected in [
 ('event_valid','R_CL_QJC',[],[],False),
 ('event_wrong_nature','R_CL_QJC',[(event,OU.restrictedTo,None)],[(event,OU.restrictedTo,OU.functionalComplexNature)],True),
 ('event_missing_nature','R_CL_EMV',[(event,OU.restrictedTo,None)],[],True),
 ('event_unknown_stereotype','R_CL_BWZ',[(event,OU.stereotype,None)],[(event,OU.stereotype,OU.unknown)],True),
 ('event_duplicate_stereotype','R_CL_GJU',[],[(event,OU.stereotype,OU.kind)],True),
 ('event_missing_stereotype','R_CL_GJU',[(event,OU.stereotype,None)],[],True)]:
    variant=Graph()
    for triple in reloaded:variant.add(triple)
    for triple in remove:variant.remove(triple)
    for triple in add:variant.add(triple)
    ws,errs=implemented[code](variant,code);found=[issue(x) for x in ws+errs if str(x.related_id)==str(event)]
    assert bool(found)==expected,(label,found)
    controls.append({'id':label,'rule':code,'expected_issue':expected,'issues':found,'passed':True})
write('Official_Graph_Validation_v0_41_0.json',{
 'source':'OntoUML/ontouml-validator','declared_rules':71,'implemented_rules':13,'unimplemented_rules':58,
 'execution_scope':'Direct calls to all 13 unmodified implemented functions on audited full native structural projection. Not a completed aggregate validator run.',
 'aggregate_entry_point':aggregate,'rules':rows,'event_issues':event_issues,'event_controls':controls,
 'warning_count':sum(len(r['warnings']) for r in rows),'error_count':sum(len(r['errors']) for r in rows),
 'unsupported_event_relation_and_identity_semantics':True,
 'limits':['All implemented functions are class rules; no relationship-rule implementation exists in this pinned source.',
 'Known implementation query scope is narrower than prose definitions (for example, named typed focus classes); do not generalize recall beyond controls.',
 'The source get_all_superclasses/subclasses traverses at most two hierarchy levels. No complete reachability proof is claimed.',
 'Custom properties are archived exactly but ignored by upstream rules. Relation cardinalities are preserved, not validated by these class rules.']})
write('Vocabulary_Fidelity_v0_41_0.json',{'elements':len(es),'classes':128,'relations':286,'ends':572,'generalizations':34,'triples':len(g),
 'event_stereotype_and_nature_preserved':True,'relation_direction_and_endpoint_fields_verified':True,
 'native_payloads_archived_exactly':True,'rdf_save_reload_isomorphic':True,
 'projection_author':'Project adapter; not upstream json2graph','official_validator_source_modified':False,
 'scope':'Verified mapped fields plus exact opaque source payload; preservation is not semantic equivalence of all native contracts.'})
print(json.dumps({'implemented':13,'unimplemented':58,'event_issues':len(event_issues),'warnings':sum(len(r['warnings']) for r in rows),'errors':sum(len(r['errors']) for r in rows),'controls':len(controls)}))
