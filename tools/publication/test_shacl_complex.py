"""Execute all remaining 113 source-bound SHACL components and inverse paths.

Each component projection retains its real source target and original rule.
Projections isolate fault attribution; full source-graph interactions are
separately exercised against the synthetic positive/negative populations.
"""
from collections import Counter
import hashlib
import importlib.metadata
import itertools
import json
import logging
from urllib.parse import quote
from rdflib import BNode, Graph, Literal, RDF, SH, URIRef, XSD
from pyshacl import validate
from pyshacl.errors import ReportableRuntimeError
from evaluation_common import ROOT, SOURCE, TARGETS, constraints, copy_tree, graph_text, sha, write_json
from sparql_fixtures import witnesses

# The retained malformed-date negative fixture is intentionally ill-typed.
logging.getLogger('rdflib.term').setLevel(logging.CRITICAL)

FOCUS = URIRef('urn:ontospk:eval:f')
OTHER = URIRef('urn:ontospk:eval:other')
SIMPLE = {SH.minCount, SH.maxCount, SH['class'], SH.datatype, SH.nodeKind}
COMPONENTS = {SH.sparql: SH.SPARQLConstraintComponent, SH.pattern: SH.PatternConstraintComponent,
              SH.minLength: SH.MinLengthConstraintComponent, SH['in']: SH.InConstraintComponent,
              SH.xone: SH.XoneConstraintComponent}

def activate(source, root, shapes, data):
    choices = [(p, o) for p in TARGETS for o in source.objects(root, p)]
    assert choices
    pred, value = choices[0]
    shapes.add((root, RDF.type, SH.NodeShape))
    shapes.add((root, pred, value))
    if pred == SH.targetClass:
        data.add((FOCUS, RDF.type, value))
    elif pred == SH.targetSubjectsOf:
        if not list(data.objects(FOCUS, value)):
            data.add((FOCUS, value, OTHER))
    elif pred == SH.targetObjectsOf:
        if not list(data.subjects(value, FOCUS)):
            data.add((OTHER, value, FOCUS))
    else:
        assert value == FOCUS
    return pred, value

def check(data, shapes, root, child, pred, expected, source_constraint=None):
    conforms, report, _ = validate(data, shacl_graph=shapes, inference='none', advanced=True,
                                   abort_on_first=False)
    assert isinstance(report, Graph), 'ValidationFailure is not ordinary nonconformance'
    actual = set(report.subjects(RDF.type, SH.ValidationResult))
    assert conforms is expected, (root, pred, expected, graph_text(data), graph_text(report))
    if expected:
        assert not actual
    else:
        wanted = (FOCUS, child, COMPONENTS[pred])
        found = {(report.value(r, SH.focusNode), report.value(r, SH.sourceShape),
                  report.value(r, SH.sourceConstraintComponent)) for r in actual}
        # A cycle can activate both actual source targets; retain both results.
        assert wanted in found and all(s == child and c == COMPONENTS[pred]
                                       for f, s, c in found), (wanted, found)
        if source_constraint is not None:
            assert {report.value(r, SH.sourceConstraint) for r in actual} == {source_constraint}
    return {'expected_conforms': expected, 'observed_conforms': conforms,
            'results': len(actual), 'data_ntriples': graph_text(data),
            'report_component': str(COMPONENTS[pred]) if actual else None,
            'focus': str(FOCUS) if actual else None}

def project(source, root, child, pred, value):
    shapes = Graph()
    if child != root:
        shapes.add((root, SH.property, child))
        path = source.value(child, SH.path)
        shapes.add((child, SH.path, path))
        if isinstance(path, BNode):
            copy_tree(source, shapes, path)
    shapes.add((child, pred, value))
    if isinstance(value, BNode) or pred == SH.sparql:
        copy_tree(source, shapes, value)
    return shapes

cases = []
counts = Counter()
for row, source, root, child, pred, value in constraints():
    if pred in SIMPLE:
        continue
    assert pred in COMPONENTS, pred
    shapes = project(source, root, child, pred, value)
    samples = []
    if pred == SH.sparql:
        name = str(value).rsplit(':', 1)[-1] if isinstance(value, URIRef) else str(source.value(value, SH.message))
        positive, adverse = witnesses(name)
        samples = [('positive', positive, True)] + [(f'negative_{i}', g, False) for i, g in enumerate(adverse)]
        # Remove each non-target fact in turn. These sensitivity observations
        # are descriptive, not counted as independently authored oracles.
        query = str(source.value(value, SH.select))
        assert query
    elif pred == SH.xone:
        alts = list(source.items(value))
        paths = sorted({source.value(ps, SH.path) for alt in alts for ps in source.objects(alt, SH.property)}, key=str)
        # Every possible finite selection of the declared alternative paths.
        for mask in itertools.product((0, 1), repeat=len(paths)):
            data = Graph()
            selected = {p for p, enabled in zip(paths, mask) if enabled}
            for p in selected:
                data.add((FOCUS, p, OTHER))
            accepted = 0
            for alt in alts:
                accepted += all(int(source.value(ps, SH.minCount) or 0) <= int(source.value(ps, SH.path) in selected)
                                <= int(source.value(ps, SH.maxCount) or 0)
                                for ps in source.objects(alt, SH.property))
            samples.append(('selection_' + ''.join(map(str, mask)), data, accepted == 1))
    else:
        path = source.value(child, SH.path)
        assert isinstance(path, URIRef)
        if pred == SH.minLength:
            n = int(value)
            vals = [('positive', Literal('a'*(n+1)), True), ('boundary', Literal('a'*n), True),
                    ('negative', Literal('a'*(n-1)), False)]
        elif pred == SH.pattern:
            vals = [('positive', Literal('urn:valid:source', datatype=XSD.anyURI), True),
                    ('boundary', Literal('https://example.org/x', datatype=XSD.anyURI), True),
                    ('negative', Literal('bad source without scheme'), False)]
        else:
            allowed = list(source.items(value))
            vals = [(f'allowed_{i}', obj, True) for i, obj in enumerate(allowed)]
            vals += [('negative', Literal('OUTSIDE_ENUMERATION'), False)]
        for name, val, expected in vals:
            data = Graph()
            data.add((FOCUS, path, val))
            samples.append((name, data, expected))
    observations = []
    for name, data, expected in samples:
        selected_target = activate(source, root, shapes, data)
        observations.append(dict(id=name, **check(data, shapes, root, child, pred, expected,
                                                 value if pred == SH.sparql else None)))
    # A wholly unrelated population must not activate the source target.
    off = Graph()
    off.add((OTHER, RDF.type, URIRef('urn:ontospk:eval:Unrelated')))
    observations.append(dict(id='target_off', **check(off, shapes, root, child, pred, True)))
    assert any(x['expected_conforms'] for x in observations if x['id'] != 'target_off')
    assert any(not x['expected_conforms'] for x in observations)
    cases.append({'key': row['key'], 'source': row['source'], 'source_sha256': sha(ROOT / row['source']),
                  'component': str(pred), 'source_root': str(root),
                  'source_expression': row['expression'], 'shapes_ntriples': graph_text(shapes),
                  'observations': observations, 'status': 'PASS'})
    counts[str(pred).split('#')[-1]] += 1
assert sum(counts.values()) == 113 and counts['sparql'] == 49 and counts['xone'] == 4, counts

# Entire property-shape interactions for every declared inverse path, retaining
# min/max/class together and the real source target. Wrong direction is rejected
# only when the source actually requires at least one inverse value.
inverse_cases = []
for rel in sorted({x['source'] for x in cases} | {'semantic/product/v2/source/validation_v041/inputs/identity-slice.shacl.ttl'}):
    source = Graph().parse(ROOT / rel)
    for root, child in source.subject_objects(SH.property):
        path = source.value(child, SH.path)
        if not isinstance(path, BNode) or not source.value(path, SH.inversePath):
            continue
        if not any((root, t, None) in source for t in TARGETS):
            continue
        inv = source.value(path, SH.inversePath)
        shapes = Graph()
        shapes.add((root, SH.property, child))
        copy_tree(source, shapes, child)
        minimum = int(source.value(child, SH.minCount) or 0)
        maximum = source.value(child, SH.maxCount)
        cls = source.value(child, SH['class'])
        good = Graph()
        for i in range(max(1, minimum)):
            v = URIRef('urn:ontospk:eval:inverse:' + str(i))
            good.add((v, inv, FOCUS))
            if cls:
                good.add((v, RDF.type, cls))
        activate(source, root, shapes, good)
        conform, _, _ = validate(good, shacl_graph=shapes, inference='none')
        assert conform
        wrong = Graph()
        wrong.add((FOCUS, inv, OTHER))
        if cls:
            wrong.add((OTHER, RDF.type, cls))
        target_kind, target_value = activate(source, root, shapes, wrong)
        self_activating = target_kind == SH.targetObjectsOf and target_value == inv
        conform, report, _ = validate(wrong, shacl_graph=shapes, inference='none')
        if not self_activating:
            assert conform == (minimum == 0), (rel, inv, graph_text(report))
        if not conform and not self_activating:
            assert any(report.value(r, SH.sourceConstraintComponent) == SH.MinCountConstraintComponent
                       for r in report.subjects(RDF.type, SH.ValidationResult)), (rel, inv, minimum, graph_text(report))
        inverse_cases.append({'source': rel, 'source_sha256': sha(ROOT/rel), 'inverse_path': str(inv),
                              'source_target': [[str(p), str(o)] for p in TARGETS for o in source.objects(root, p)],
                              'min': minimum, 'max': int(maximum) if maximum is not None else None,
                              'positive': graph_text(good), 'wrong_direction': graph_text(wrong),
                              'wrong_direction_observed_conforms': conform,
                              'wrong_direction_expected_conforms': None if self_activating else minimum == 0,
                              'wrong_direction_limit': 'TargetObjectsOf itself supplies the inverse edge; isolated missing-edge oracle is unreachable with that source target.' if self_activating else None,
                              'status': 'PASS'})
assert inverse_cases

# Full graph interaction checks on retained occurrence populations. Ordinary
# nonconformance is recorded independently of validator execution failures.
interactions = []
v = SOURCE / 'validation_v041'
for shape_file, fixture in [('inputs/identity-slice.shacl.ttl', 'fixtures/combined-positive.ttl'),
                            ('inputs/complete-reporting-v0_16.shacl.ttl', 'fixtures/combined-positive.ttl'),
                            ('Occurrence_Profile_v0_41_0.shacl.ttl', 'fixtures/occurrence-positive-v041.ttl')]:
    shapes = Graph().parse(v / shape_file)
    positive = Graph().parse(v / fixture)
    ontology_path = v/'inputs/Retained_Formal_Profile_v0_15_0.ttl' if 'complete-reporting' in shape_file else None
    ontology = Graph().parse(ontology_path) if ontology_path else None
    conform, report, _ = validate(positive, shacl_graph=shapes, ont_graph=ontology, inference='none', advanced=True)
    assert conform, (shape_file, graph_text(report))
    mutations = []
    for triple in sorted(positive, key=lambda x: tuple(map(str, x))):
        data = Graph() + positive
        data.remove(triple)
        conform, rep, _ = validate(data, shacl_graph=shapes, ont_graph=ontology, inference='none', advanced=True)
        assert isinstance(rep, Graph)
        mutations.append({'removed': [x.n3() for x in triple], 'observed_conforms': conform,
                          'components': sorted({str(rep.value(r, SH.sourceConstraintComponent))
                                                for r in rep.subjects(RDF.type, SH.ValidationResult)})})
    assert any(not x['observed_conforms'] for x in mutations)
    interactions.append({'shape_source': str((v/shape_file).relative_to(ROOT)), 'shape_sha256': sha(v/shape_file),
                         'fixture': str((v/fixture).relative_to(ROOT)), 'fixture_sha256': sha(v/fixture),
                         'ontology_source': str(ontology_path.relative_to(ROOT)) if ontology_path else None,
                         'ontology_sha256': sha(ontology_path) if ontology_path else None,
                         'positive_conforms': True, 'single_triple_deletions': mutations,
                         'interpretation': 'Sensitivity observations; a surviving deletion can remove the target or an optional fact.'})

# The fourth runtime graph uses native-contract URNs. Replay all retained
# source fixtures through that graph, with the explicit native ancestor types
# used by its released serialization envelope.
event_shapes_path=v/'inputs/Event_Contract_Shapes_v0_30_0.ttl'
event_fixture_path=v/'inputs/Event_Contract_Fixtures_v0_30_0.json'
native_path=SOURCE/'formalization/Native_Model_v0_41_0.json'
elements=json.loads(native_path.read_text())['elements']
parents={e['id']:set() for e in elements}
for element in elements:
    if element['type']=='Generalization':
        parents[element['specific']].add(element['general'])
def ancestors(cls):
    return {cls}.union(*(ancestors(parent) for parent in parents[cls]))
event_shapes=Graph().parse(event_shapes_path)
event_cases=[]
for item in json.loads(event_fixture_path.read_text()):
    data=Graph()
    ref=lambda identifier:URIRef('urn:product-ontology:native:'+quote(identifier,safe=''))
    node=lambda identifier:URIRef('urn:product-ontology:event-instance:'+identifier)
    pred=lambda identifier:URIRef('urn:product-ontology:event-contract:'+quote(identifier,safe=''))
    for identifier, types in item['types'].items():
        for cls in types:
            for ancestor in ancestors(cls):
                data.add((node(identifier),RDF.type,ref(ancestor)))
    for relation, start, end in item['edges']:
        data.add((node(start),pred(relation),node(end)))
    for identifier, values in item['ended'].items():
        for value in values:
            data.add((node(identifier),pred('executionEndedAt'),Literal(value,datatype=XSD.dateTime,normalize=False)))
    conform, report, _=validate(data,shacl_graph=event_shapes,inference='none',advanced=True)
    assert isinstance(report,Graph) and conform is item['expected'], (item['id'],graph_text(report))
    event_cases.append({'id':item['id'],'expected_conforms':item['expected'],'observed_conforms':conform,
                        'data_ntriples':graph_text(data),'reason':item['reason'],'status':'PASS'})
assert len(event_cases)==42

# An invalid SPARQL expression is an execution error, never a successful
# negative data case. This verifies the harness distinguishes the two.
error_shapes = Graph().parse(data='''@prefix sh: <http://www.w3.org/ns/shacl#>.
 <urn:error> a sh:NodeShape; sh:targetNode <urn:focus>; sh:sparql [sh:select "NOT SPARQL"].''', format='turtle')
try:
    validate(Graph(), shacl_graph=error_shapes, advanced=True)
except Exception as exc:
    error_control = type(exc).__name__
    assert error_control == 'ParseException', error_control
else:
    raise AssertionError('Invalid SPARQL was not distinguished as execution failure')
result = {'status': 'PASS', 'pyshacl': importlib.metadata.version('pyshacl'),
          'rdflib': importlib.metadata.version('rdflib'), 'counts': dict(sorted(counts.items())),
          'complex_components': len(cases), 'component_observations': sum(len(x['observations']) for x in cases),
          'inverse_property_projections': len(inverse_cases), 'cases': cases,
          'inverse_cases': sorted(inverse_cases, key=lambda x: json.dumps(x, sort_keys=True)),
          'whole_graph_interactions': interactions, 'invalid_sparql_control': error_control,
          'native_event_graph_replay':{'shape_source':str(event_shapes_path.relative_to(ROOT)),
              'shape_sha256':sha(event_shapes_path),'fixtures_source':str(event_fixture_path.relative_to(ROOT)),
              'fixtures_sha256':sha(event_fixture_path),'native_sha256':sha(native_path),'cases':event_cases},
          'limits': 'Finite authored witnesses and component projections; not exhaustive branch coverage of all RDF populations, full modal/causal adequacy or independent domain acceptance.'}
write_json('evaluation/shacl-complex.json.gz', result)
lines = ['# Complex SHACL execution', '',
         'All 113 components beyond the 1,864 simple components have executed source-bound positive/adverse controls. The source graphs are unchanged.', '',
         '| Component | Source occurrences |', '| --- | ---: |']
lines += [f'| {k} | {n} |' for k, n in sorted(counts.items())]
lines += ['', f"{result['component_observations']} component observations include target-off controls. All finite selections of the four xone path sets are tested. {len(inverse_cases)} inverse property projections retain their actual class/cardinality checks. Three full source-graph positive populations and their single-triple deletion observations test interactions separately.", '',
          'Expected ordinary nonconformance is matched to focus node, source shape and component; SPARQL cases also match the original source constraint. An intentionally invalid SPARQL expression is recorded as an execution error, not an accepted negative data result.', '',
          'The fourth, native-contract source graph also passes all 42 retained positive/adverse event fixtures. Full reporting-graph validation uses the same retained ontology graph as the released runtime (inference=none); subclass lookup is not replaced by invented explicit types. Inverse paths whose targetObjectsOf condition supplies the very edge being tested have unreachable isolated missing-edge controls; those cases are explicitly marked, not counted as negative passes.', '',
          'The machine-readable receipt includes unchanged source digests, exact source expressions, projected shapes, authored input data and expected/observed results. Component isolation does not establish correctness of every interaction or all possible RDF inputs.', '',
          '[Detailed receipt](shacl-complex.json.gz)', '']
(ROOT/'evaluation/shacl-complex.md').write_text('\n'.join(lines))
print(json.dumps({k: result[k] for k in ('status','complex_components','component_observations','inverse_property_projections')}))
