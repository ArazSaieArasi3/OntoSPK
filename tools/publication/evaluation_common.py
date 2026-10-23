"""Shared deterministic evidence helpers; never changes a released source."""
from pathlib import Path
import gzip
import hashlib
import json
from rdflib import BNode, Graph, Literal, RDF, SH, URIRef
from rdflib.compare import to_canonical_graph

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / 'semantic/product/v2/source'
PREDICATES = {SH.minCount, SH.maxCount, SH['class'], SH.datatype, SH.nodeKind,
              SH['in'], SH.pattern, SH.minLength, SH.maxLength, SH.minInclusive,
              SH.maxInclusive, SH.minExclusive, SH.maxExclusive, SH.hasValue,
              SH.equals, SH.disjoint, SH.lessThan, SH.lessThanOrEquals, SH.closed,
              SH.ignoredProperties, SH.node, SH['and'], SH['or'], SH['not'], SH.xone,
              SH.qualifiedValueShape, SH.qualifiedMinCount, SH.qualifiedMaxCount,
              SH.uniqueLang, SH.languageIn, SH.sparql}
TARGETS = (SH.targetClass, SH.targetNode, SH.targetSubjectsOf, SH.targetObjectsOf)

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def term(g, value):
    if isinstance(value, BNode):
        return sorted(((str(p), term(g, o)) for p, o in g.predicate_objects(value)),
                      key=lambda pair: json.dumps(pair, sort_keys=True))
    if isinstance(value, Literal):
        return {'value': str(value), 'datatype': str(value.datatype) if value.datatype else None,
                'language': value.language}
    return str(value)

def graph_text(g):
    return '\n'.join(sorted(' '.join(t.n3() for t in triple) + ' .'
                            for triple in to_canonical_graph(g))) + '\n'

def write_json(path, data):
    path = ROOT / path
    content = (json.dumps(data, indent=2, sort_keys=True) + '\n').encode()
    if path.suffix == '.gz':
        content = gzip.compress(content, mtime=0)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(content)

def constraints():
    """Resolve every planned key against the actual source expression."""
    with gzip.open(ROOT / 'evaluation/coverage-register.json.gz', 'rt') as f:
        rows = [r for r in json.load(f)['rows'] if r['group'] == 'shacl_constraint']
    for rel in sorted({r['source'] for r in rows}):
        graph = Graph().parse(ROOT / rel)
        for row in (r for r in rows if r['source'] == rel):
            exp = row['expression']
            root_name = exp['node_shape']
            # Complex components all have named source roots. Simple blank
            # roots remain covered by the separate #15 runner.
            if not root_name.startswith('urn:'):
                continue
            root = URIRef(root_name)
            pred = URIRef(exp['component'])
            if pred in {SH.minCount, SH.maxCount, SH['class'], SH.datatype, SH.nodeKind}:
                continue
            candidates = []
            pending, seen = [(root, None)], set()
            while pending:
                node, path = pending.pop()
                if node in seen:
                    continue
                seen.add(node)
                for value in graph.objects(node, pred):
                    if json.loads(json.dumps(term(graph, value))) == exp['parameter'] and (
                        json.loads(json.dumps(term(graph, path))) if path is not None else None
                    ) == exp['path']:
                        candidates.append((node, value))
                for edge in (SH.property, SH.node, SH.qualifiedValueShape, SH['not']):
                    for child in graph.objects(node, edge):
                        pending.append((child, graph.value(child, SH.path) if edge == SH.property else path))
                for edge in (SH['or'], SH['and'], SH.xone):
                    for head in graph.objects(node, edge):
                        pending.extend((child, path) for child in graph.items(head))
            assert len(candidates) == 1, (row['key'], len(candidates))
            child, value = candidates[0]
            yield row, graph, root, child, pred, value

def copy_tree(source, dest, node, seen=None):
    seen = set() if seen is None else seen
    if node in seen:
        return
    seen.add(node)
    for p, o in source.predicate_objects(node):
        dest.add((node, p, o))
        if isinstance(o, BNode):
            copy_tree(source, dest, o, seen)
