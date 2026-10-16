"""Fail-closed bridge for eleven explicitly mapped relations, not all ontology data.

This is a serialization mapping, not an owl:equivalentClass/property assertion.
It preserves asserted types and literal lexical forms; it adds no inference.
Unmapped data raises an error instead of being dropped.
"""
import csv
import json
from pathlib import Path
from rdflib import Graph, URIRef, Literal, RDF, XSD
import event_contracts as c

W=Path(__file__).resolve().parent
ROWS=json.loads((W/'Structural_Crosswalk_v0_34_0.json').read_text())
RELATIONS={r['native_relation_id']:(URIRef(r['formal_predicate']),r['formal_direction']) for r in ROWS}
REVERSE={predicate:(rid,direction) for rid,(predicate,direction) in RELATIONS.items()}
if len(REVERSE)!=len(RELATIONS):
    raise ValueError('AMBIGUOUS_SELECTED_PREDICATE_MAPPING')
CLASSES={r['native_id']:URIRef(r['iri']) for r in csv.DictReader(
    (W/'inputs/Class_Table_Mapping_v0_16_0.csv').open(encoding='utf-8-sig'))}
REVERSE_CLASSES={iri:native for native,iri in CLASSES.items()}
if len(REVERSE_CLASSES)!=len(CLASSES):
    raise ValueError('AMBIGUOUS_CLASS_MAPPING')
ENDED=URIRef('urn:product-ontology:delivery-profile:0.5:executionEndedAt')

def export_formal(fixture):
    g=Graph()
    for node,types in fixture['types'].items():
        if not types:
            raise ValueError('UNREPRESENTABLE_EMPTY_TYPE_ENTRY')
        for typ in types:
            if typ not in CLASSES:
                raise ValueError('UNMAPPED_CLASS:'+typ)
            g.add((c.N[node],RDF.type,CLASSES[typ]))
    for rid,s,t in fixture['edges']:
        if rid not in RELATIONS:
            raise ValueError('UNMAPPED_RELATION:'+rid)
        p,direction=RELATIONS[rid]
        if direction=='INVERSE':s,t=t,s
        elif direction!='SAME':raise ValueError('UNSUPPORTED_DIRECTION:'+direction)
        g.add((c.N[s],p,c.N[t]))
    for node,values in fixture['ended'].items():
        if not values:
            raise ValueError('UNREPRESENTABLE_EMPTY_LITERAL_ENTRY')
        for value in values:
            g.add((c.N[node],ENDED,Literal(value,datatype=XSD.dateTime,normalize=False)))
    return g

def local(node):
    if not isinstance(node,URIRef) or not str(node).startswith(str(c.N)):
        raise ValueError('UNMAPPED_INSTANCE_NAMESPACE')
    return str(node)[len(str(c.N)):]

def import_formal(graph):
    f=dict(types={},edges=[],ended={})
    for s,p,o in graph:
        if p==RDF.type:
            if o not in REVERSE_CLASSES:raise ValueError('UNMAPPED_CLASS_IRI')
            f['types'].setdefault(local(s),[]).append(REVERSE_CLASSES[o])
        elif p==ENDED:
            if not isinstance(o,Literal) or o.datatype!=XSD.dateTime:
                raise ValueError('INVALID_END_LITERAL_TYPE')
            f['ended'].setdefault(local(s),[]).append(str(o))
        elif p in REVERSE:
            rid,direction=REVERSE[p];s,t=local(s),local(o)
            if direction=='INVERSE':s,t=t,s
            f['edges'].append([rid,s,t])
        else:
            raise ValueError('UNMAPPED_PREDICATE:'+str(p))
    return c.canonical(f)
