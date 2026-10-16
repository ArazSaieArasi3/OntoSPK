"""Bounded completed-event profile, v0.34; not full UFO-B semantics.

The seven v0.30 native event signatures are retained. The tested realization's
version signature is now checked too. No capability-inherence completeness is
claimed for this event slice. RDF graphs have set semantics.
"""
import datetime as dt
import json
import re
import sqlite3
from pathlib import Path
from urllib.parse import quote
from rdflib import Graph, Namespace, URIRef, Literal, BNode, RDF, XSD
from pyshacl import validate

ROOT = Path(__file__).resolve().parent
N = Namespace('urn:product-ontology:event-instance:')
SH = Namespace('http://www.w3.org/ns/shacl#')
EV = 'IC:TestExecution'
END = 'executionEndedAt'
VERSION = 'ICREL:CP:realizesVersion'
TESTS = 'ICREL:CP:testsRealization'
ASSESSES = 'ICREL:CP:assessesSpecification'
CAP_VERSION = 'ICREL:CP:specifiesCapability'
EXECUTES = 'REL:W2:090'
RESULT = 'REL:W2:091'
CONTEXT = 'REL:ORSD05:executionContext'
SUITE = 'REL:W2:147'
CONTAINS = 'REL:W2:088'
MODEL = json.loads((ROOT/'inputs/Native_Model_v0_41_0.json').read_text())
ELEMENTS = {e['id']: e for e in MODEL['elements']}
PARENTS = {i: set() for i in ELEMENTS}
for element in ELEMENTS.values():
    if element['type'] == 'Generalization':
        PARENTS[element['specific']].add(element['general'])

# Explicit serialization envelope, not a claim to implement all XSD dateTime:
# CE years 0001..9999, 00..23 hours, 1..6 fractional digits, optional timezone.
# Offset-free timestamps remain floating; they do not establish chronology.
TIME_PATTERN = (r'^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])'
                r'T([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]'
                r'(\.[0-9]{1,6})?(Z|[+-]((0[0-9]|1[0-3]):[0-5][0-9]|14:00))?$')

def valid_time(value):
    if not isinstance(value, str) or not re.fullmatch(TIME_PATTERN, value):
        return False
    try:
        dt.datetime.fromisoformat(value.replace('Z', '+00:00'))
    except ValueError:
        return False
    return True

def ref(identifier):
    return URIRef('urn:product-ontology:native:' + quote(identifier, safe=''))

def pred(identifier):
    return URIRef('urn:product-ontology:event-contract:' + quote(identifier, safe=''))

def ancestors(kind):
    return {kind} | set().union(*(ancestors(p) for p in PARENTS[kind]))

def expanded(fixture):
    return {(node, t) for node, kinds in fixture['types'].items()
            for kind in kinds for t in ancestors(kind)}

def bounds(cardinality):
    parts = cardinality.split('..')
    return [int(parts[0]), None if parts[-1] == '*' else int(parts[-1])]

CONTRACTS = json.loads((ROOT/'inputs/Event_Contract_Results_v0_30_0.json').read_text())['relation_signatures']
a, b = [ELEMENTS[p] for p in ELEMENTS[VERSION]['properties']]
CONTRACTS = CONTRACTS + [dict(relation=VERSION, source=a['propertyType'], target=b['propertyType'],
                            per_source_bounds=bounds(b['cardinality']), per_target_bounds=bounds(a['cardinality']))]

def make_shapes():
    shapes = Graph().parse(ROOT/'inputs/Event_Contract_Shapes_v0_30_0.ttl')
    # Exactly the same eight endpoint/count signatures are evaluated by SQL.
    contract = CONTRACTS[-1]
    for side, other in [('source', 'target'), ('target', 'source')]:
        shape, prop = BNode(), BNode()
        shapes.add((shape, RDF.type, SH.NodeShape))
        shapes.add((shape, SH.targetClass, ref(contract[side])))
        shapes.add((shape, SH.targetSubjectsOf if side == 'source' else SH.targetObjectsOf, pred(VERSION)))
        shapes.add((shape, SH['class'], ref(contract[side])))
        shapes.add((shape, SH.property, prop))
        path = pred(VERSION)
        if side == 'target':
            path = BNode()
            shapes.add((path, SH.inversePath, pred(VERSION)))
        shapes.add((prop, SH.path, path))
        shapes.add((prop, SH['class'], ref(contract[other])))
        lo, hi = contract['per_' + side + '_bounds']
        shapes.add((prop, SH.minCount, Literal(lo)))
        if hi is not None:
            shapes.add((prop, SH.maxCount, Literal(hi)))
    for prop in shapes.objects(N.EventShape, SH.property):
        if (prop, SH.path, pred(END)) in shapes:
            shapes.add((prop, SH.pattern, Literal(TIME_PATTERN)))
    return shapes

SHAPES = make_shapes()

def graph(fixture):
    g = Graph()
    for node, kind in expanded(fixture):
        g.add((N[node], RDF.type, ref(kind)))
    for relation, source, target in fixture['edges']:
        g.add((N[source], pred(relation), N[target]))
    for node, values in fixture['ended'].items():
        for value in values:
            g.add((N[node], pred(END), Literal(value, datatype=XSD.dateTime, normalize=False)))
    return g

def shacl_check(fixture):
    ok, _, report = validate(graph(fixture), shacl_graph=SHAPES, inference='none', advanced=True)
    return bool(ok), report

def sql_check(fixture):
    db = sqlite3.connect(':memory:')
    try:
        db.executescript('CREATE TABLE types(node TEXT,typ TEXT,PRIMARY KEY(node,typ));'
                         'CREATE TABLE links(rel TEXT,s TEXT,t TEXT,PRIMARY KEY(rel,s,t));'
                         'CREATE TABLE endings(node TEXT,value TEXT,PRIMARY KEY(node,value));')
        db.executemany('INSERT INTO types VALUES (?,?)', expanded(fixture))
        db.executemany('INSERT INTO links VALUES (?,?,?)', set(map(tuple, fixture['edges'])))
        db.executemany('INSERT INTO endings VALUES (?,?)',
                       {(e,v) for e,values in fixture['ended'].items() for v in values})
        errors = []
        for contract in CONTRACTS:
            relation = contract['relation']
            for side, col, opposite in [('source','s','t'), ('target','t','s')]:
                lo, hi = contract['per_' + side + '_bounds']
                wrong = db.execute(f'SELECT l.{col} FROM links l WHERE rel=? AND NOT EXISTS '
                                   f'(SELECT 1 FROM types t WHERE t.node=l.{col} AND t.typ=?)',
                                   (relation, contract[side])).fetchall()
                if wrong:
                    errors.append('type:' + relation + ':' + side)
                counts = db.execute(f'SELECT ty.node,COUNT(DISTINCT l.{opposite}) FROM types ty '
                                    f'LEFT JOIN links l ON ty.node=l.{col} AND l.rel=? WHERE ty.typ=? '
                                    'GROUP BY ty.node', (relation, contract[side])).fetchall()
                if any(n < lo or (hi is not None and n > hi) for _, n in counts):
                    errors.append('bound:' + relation + ':' + side)
        for (node,) in db.execute('SELECT node FROM types WHERE typ=?', (EV,)):
            values = [v[0] for v in db.execute('SELECT value FROM endings WHERE node=?', (node,))]
            if len(values) != 1:
                errors.append('end_count')
            if any(not valid_time(v) for v in values):
                errors.append('end_datatype_or_serialization_profile')
        if db.execute('SELECT a.s FROM links a JOIN links b ON a.t=b.s AND b.rel=? WHERE a.rel=? '
                      'AND NOT EXISTS(SELECT 1 FROM links c WHERE c.rel=? AND c.s=a.s AND c.t=b.t)',
                      (EXECUTES, SUITE, CONTAINS)).fetchall():
            errors.append('suite_case_membership')
        if db.execute('SELECT a.s FROM links a WHERE a.rel=? AND NOT EXISTS('
                      'SELECT 1 FROM links t JOIN links v ON t.t=v.s AND v.rel=? '
                      'JOIN links c ON v.t=c.s AND c.rel=? WHERE t.s=a.s AND t.rel=? AND c.t=a.t)',
                      (ASSESSES, VERSION, CAP_VERSION, TESTS)).fetchall():
            errors.append('same_tested_version')
        return not errors, errors
    finally:
        db.close()

def canonical(fixture):
    """Preserve exact lexical time; deduplicate and sort RDF-set fields only."""
    return dict(types={n: sorted(set(ts)) for n, ts in sorted(fixture['types'].items())},
                edges=sorted([list(e) for e in set(map(tuple, fixture['edges']))]),
                ended={n: sorted(set(vs)) for n, vs in sorted(fixture['ended'].items())})
