"""Synthetic combined identity/Event population. No empirical case claims."""
import copy
import json
from pathlib import Path
from rdflib import Graph, Namespace, Literal, RDF, XSD
import event_contracts as c
import representation_bridge as bridge

W=Path(__file__).resolve().parent
P=Namespace('urn:productium:specification-profile:')
A=Namespace('urn:product-ontology:assessment-profile:0.4:')
D=Namespace('urn:product-ontology:delivery-profile:0.5:')
N=c.N

def build():
    fixture=copy.deepcopy(json.loads((W/'inputs/Event_Contract_Fixtures_v0_30_0.json').read_text())[0])
    fixture['types']['actual1']=['IC:ProductCapability']
    fixture['edges'].append(['ICREL:CP:bearsCapability','real1','actual1'])
    graph=bridge.export_formal(fixture)
    for node,typ in [('product1',P.Product),('scenario1',P.TestScenario),('feature1',P.FeatureSpecification),('suite1',P.TestSuiteSpecification)]:
        graph.add((N[node],RDF.type,typ))
    for s,p,o in [
        (N.product1,P.hasVersion,N.v1),
        (N.case1,P.r87_refinesTestScenario,N.scenario1),
        (N.case1,P.specifiesExpectedCondition,N.condition1),
        (N.scenario1,P.r84_covers,N.feature1),
        (N.scenario1,P.specifiesExpectedCondition,N.condition1),
        (N.suite1,P.containsCase,N.case1),
        (N.suite1,P.r147_hasRecordedExecution,N.e1),
        (N.ctx1,A.contextVersion,N.v1),
        (N.ctx1,A.contextDescription,Literal('Synthetic completed-event and identity integration context')),
        (N.ctx1,A.contextSource,Literal('urn:synthetic:v035:context-source',datatype=XSD.anyURI)),
        (N.result1,D.resultRecordedAt,Literal('2026-10-14T04:31:00Z',datatype=XSD.dateTime,normalize=False)),
        (N.result1,D.resultOutcome,Literal('inconclusive')),
        (N.result1,D.resultSource,Literal('urn:synthetic:v035:result-source',datatype=XSD.anyURI)),
        (N.actual1,P.evaluatedAgainst,N.cap1),
    ]:graph.add((s,p,o))
    return graph

if __name__=='__main__':
    (W/'fixtures').mkdir(exist_ok=True)
    graph=build();graph.serialize(W/'fixtures/combined-positive.ttl',format='turtle')
    print(json.dumps({'triples':len(graph),'typed_entities':len(set(graph.subjects(RDF.type,None)))}))
