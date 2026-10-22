"""Execute isolated, target-activated SHACL component cases from the public core.

This checks each active simple component independently. Interactions between
constraints, logical alternatives, and cross-record rules remain separate work.
"""

from collections import Counter
from pathlib import Path
import gzip
import hashlib
import importlib.metadata
import json

from pyshacl import validate
from rdflib import BNode, Graph, Literal, RDF, SH, URIRef, XSD


ROOT = Path(__file__).resolve().parents[2]
assert importlib.metadata.version("pyshacl") == "0.30.1"
REGISTER = ROOT / "evaluation/coverage-register.json.gz"
OUT = ROOT / "evaluation/shacl-simple-constraints.json.gz"
SUMMARY = ROOT / "evaluation/shacl-simple-constraints.md"
PREDICATES = {SH.minCount, SH.maxCount, SH["class"], SH.datatype, SH.nodeKind}
COMPONENTS = {SH.minCount: SH.MinCountConstraintComponent,
              SH.maxCount: SH.MaxCountConstraintComponent,
              SH["class"]: SH.ClassConstraintComponent,
              SH.datatype: SH.DatatypeConstraintComponent,
              SH.nodeKind: SH.NodeKindConstraintComponent}
TARGETS = (SH.targetClass, SH.targetNode, SH.targetSubjectsOf, SH.targetObjectsOf)
EDGES = (SH.property, SH.node, SH.qualifiedValueShape, SH["not"])
LIST_EDGES = (SH["or"], SH["and"], SH.xone)
FOCUS = URIRef("urn:ontospk:fixture:focus")
OTHER = URIRef("urn:ontospk:fixture:other")
VALUE = URIRef("urn:ontospk:fixture:value")


def term(graph, value):
    if isinstance(value, BNode):
        return sorted(((str(p), term(graph, o)) for p, o in graph.predicate_objects(value)),
                      key=lambda pair: json.dumps(pair, sort_keys=True))
    if isinstance(value, Literal):
        return {"value": str(value), "datatype": str(value.datatype) if value.datatype else None,
                "language": value.language}
    return str(value)


def reachable(graph, root):
    pending = [(root, "root", None)]
    seen = set()
    while pending:
        node, route, path = pending.pop(0)
        if node in seen:
            continue
        seen.add(node)
        yield node, route, path
        edges = []
        for pred in EDGES:
            for child in graph.objects(node, pred):
                edges.append((str(pred), child, term(graph, graph.value(child, SH.path))
                              if pred == SH.property else path))
        for pred in LIST_EDGES:
            for head in graph.objects(node, pred):
                for index, child in enumerate(graph.items(head)):
                    edges.append((str(pred) + f"[{index}]", child, path))
        edges.sort(key=lambda edge: json.dumps((edge[0], term(graph, edge[1])), sort_keys=True))
        for index, (_, child, child_path) in enumerate(edges):
            pending.append((child, f"{route}.{index}", child_path))


def copy_path(source, dest, path):
    if isinstance(path, BNode):
        for predicate, obj in source.predicate_objects(path):
            dest.add((path, predicate, obj))
            if isinstance(obj, BNode):
                copy_path(source, dest, obj)


def fixture_graph(root, child, predicate, parameter, source):
    graph = Graph()
    graph.add((root, RDF.type, SH.NodeShape))
    choices = [(target, obj) for target in TARGETS for obj in source.objects(root, target)]
    choices.sort(key=lambda pair: (pair[0] == SH.targetClass and predicate == SH["class"]
                                   and pair[1] == parameter,
                                   TARGETS.index(pair[0]), str(pair[1])))
    assert choices
    # One real source target is sufficient for activation. Other declared
    # targets can introduce unrelated values in this component projection.
    graph.add((root, *choices[0]))
    if child != root:
        # Project one reachable property constraint onto its source target.
        # This intentionally does not test an enclosing xone/or expression.
        graph.add((root, SH.property, child))
        path = source.value(child, SH.path)
        assert path is not None, (root, child)
        graph.add((child, SH.path, path))
        copy_path(source, graph, path)
    graph.add((child, predicate, parameter))
    return graph


def activated_data(root, source, suppressed=False, focus=FOCUS):
    graph = Graph()
    targets = [(p, o) for p in TARGETS for o in source.objects(root, p)]
    assert targets
    if suppressed:
        return graph
    for pred, obj in targets:
        if pred == SH.targetClass:
            graph.add((focus, RDF.type, obj))
        elif pred == SH.targetNode:
            assert obj == focus, "A concrete targetNode needs its own focus in this fixture"
        elif pred == SH.targetSubjectsOf:
            graph.add((focus, obj, OTHER))
        elif pred == SH.targetObjectsOf:
            graph.add((OTHER, obj, focus))
    return graph


def add_value(graph, path, value, source):
    if isinstance(path, URIRef):
        graph.add((FOCUS, path, value))
    else:
        inverse = source.value(path, SH.inversePath)
        assert isinstance(inverse, URIRef), "Other paths belong to #16"
        graph.add((value, inverse, FOCUS))


def run(graph, shapes, root, child, predicate, expected, focus=FOCUS):
    conforms, report, _ = validate(graph, shacl_graph=shapes, advanced=True,
                                   inference="none", abort_on_first=False)
    results = set(report.subjects(RDF.type, SH.ValidationResult))
    actual = {(report.value(r, SH.focusNode), report.value(r, SH.sourceShape),
               report.value(r, SH.sourceConstraintComponent)) for r in results}
    if expected:
        assert conforms and not results, (root, child, predicate, actual)
    else:
        assert not conforms and actual == {(focus, child, COMPONENTS[predicate])}, (
            root, child, predicate, actual)
    return {"conforms": conforms, "result_count": len(results),
            "focus_node": str(focus) if results else None,
            "source_shape": str(child) if isinstance(child, URIRef) and results else
                            "source_property_blank_node" if results else None,
            "constraint_component": str(COMPONENTS[predicate]) if results else None}


with gzip.open(REGISTER, "rt", encoding="utf-8") as handle:
    register = json.load(handle)
rows = {r["key"]: r for r in register["rows"] if r["group"] == "shacl_constraint"
        and URIRef(r["expression"]["component"]) in PREDICATES}
cases = []
counts = Counter()
limitations = Counter()
sources = {}
for rel in sorted({r["source"] for r in rows.values()}):
    source = Graph().parse(ROOT / rel)
    sources[rel] = hashlib.sha256((ROOT / rel).read_bytes()).hexdigest()
    roots = sorted({node for node in source.subjects(RDF.type, SH.NodeShape)
                    if any((node, target, None) in source for target in TARGETS)},
                   key=lambda node: (0, str(node)) if isinstance(node, URIRef) else
                   (1, json.dumps(term(source, node), sort_keys=True)))
    ordinals = Counter()
    for root in roots:
        if isinstance(root, BNode):
            fingerprint = hashlib.sha256(json.dumps(term(source, root), sort_keys=True).encode()).hexdigest()[:16]
            ordinals[fingerprint] += 1
            root_key = f"blank:{fingerprint}:{ordinals[fingerprint]}"
        else:
            root_key = str(root)
        for child, route, _ in reachable(source, root):
            constraints = sorted(((str(p), term(source, obj), p, obj)
                                  for p, obj in source.predicate_objects(child)
                                  if p in PREDICATES | {SH.sparql, SH["in"], SH.pattern,
                                  SH.minLength, SH.maxLength, SH.minInclusive, SH.maxInclusive,
                                  SH.minExclusive, SH.maxExclusive, SH.hasValue, SH.equals,
                                  SH.disjoint, SH.lessThan, SH.lessThanOrEquals, SH.closed,
                                  SH.ignoredProperties, SH.node, SH["and"], SH["or"], SH["not"],
                                  SH.xone, SH.qualifiedValueShape, SH.qualifiedMinCount,
                                  SH.qualifiedMaxCount, SH.uniqueLang, SH.languageIn}),
                                 key=lambda item: json.dumps(item[:2], sort_keys=True))
            for index, (_, _, predicate, parameter) in enumerate(constraints):
                if predicate not in PREDICATES:
                    continue
                key = f"{rel}::{root_key}::{route}:{index}"
                assert key in rows, key
                path = source.value(child, SH.path) if child != root else None
                assert rows[key]["expression"]["path"] == json.loads(json.dumps(term(source, path))) if path else rows[key]["expression"]["path"] is None, key
                shapes = fixture_graph(root, child, predicate, parameter, source)
                baseline = activated_data(root, shapes)
                positive = Graph() + baseline
                negative = Graph() + baseline
                boundary = Graph() + baseline
                impossible = None
                if predicate in (SH.minCount, SH.maxCount):
                    assert path is not None
                    n = int(parameter)
                    existing = (set(baseline.objects(FOCUS, path)) if isinstance(path, URIRef)
                                else set(baseline.subjects(source.value(path, SH.inversePath), FOCUS)))
                    base_count = len(existing)
                    assert base_count <= n if predicate == SH.maxCount else True, (key, base_count, n)
                    if predicate == SH.minCount:
                        for i in range(max(0, n - base_count)):
                            add_value(positive, path, URIRef(f"urn:ontospk:fixture:item:{i}"), source)
                        for i in range(max(0, n + 1 - base_count)):
                            add_value(boundary, path, URIRef(f"urn:ontospk:fixture:item:{i}"), source)
                        if n <= base_count:
                            impossible = ("minCount 0 is tautological for every data graph" if n == 0
                                          else "source target already entails required minimum")
                        else:
                            for i in range(n - 1 - base_count):
                                add_value(negative, path, URIRef(f"urn:ontospk:fixture:item:{i}"), source)
                    else:
                        for i in range(n - base_count):
                            add_value(positive, path, URIRef(f"urn:ontospk:fixture:item:{i}"), source)
                        for i in range(n + 1 - base_count):
                            add_value(negative, path, URIRef(f"urn:ontospk:fixture:item:{i}"), source)
                        if n > base_count:
                            for i in range(n - 1 - base_count):
                                add_value(boundary, path, URIRef(f"urn:ontospk:fixture:item:{i}"), source)
                elif predicate == SH["class"]:
                    if path is None:
                        positive.add((FOCUS, RDF.type, parameter))
                        boundary.add((FOCUS, RDF.type, parameter))
                        # If the target class already entails this class assertion, no
                        # conforming targeted focus can be made to violate it in isolation.
                        if (root, SH.targetClass, parameter) in source:
                            impossible = "same required class activates targetClass"
                        boundary.add((FOCUS, URIRef("urn:ontospk:fixture:unrelated"), OTHER))
                    else:
                        values = (set(baseline.objects(FOCUS, path)) if isinstance(path, URIRef)
                                  else set(baseline.subjects(source.value(path, SH.inversePath), FOCUS)))
                        if not values:
                            values = {VALUE}
                            add_value(positive, path, VALUE, source)
                            add_value(negative, path, VALUE, source)
                        for value in values:
                            positive.add((value, RDF.type, parameter))
                            if (isinstance(path, URIRef) and (FOCUS, path, value) in boundary) or (
                                    not isinstance(path, URIRef) and
                                    (value, source.value(path, SH.inversePath), FOCUS) in boundary):
                                boundary.add((value, RDF.type, parameter))
                elif predicate == SH.datatype:
                    assert path is not None
                    if parameter == XSD.boolean:
                        good = Literal(True)
                    elif parameter == XSD.dateTime:
                        good = Literal("2026-01-01T00:00:00Z", datatype=XSD.dateTime)
                    else:
                        good = Literal("urn:ontospk:fixture:value", datatype=parameter)
                    add_value(positive, path, good, source)
                    add_value(negative, path, Literal(23, datatype=XSD.integer), source)
                elif predicate == SH.nodeKind:
                    assert parameter == SH.IRI
                    if path is None:
                        if (root, SH.targetNode, None) in shapes:
                            impossible = "fixed IRI targetNode already fixes focus node kind"
                        else:
                            negative = activated_data(root, shapes,
                                                      focus=BNode("fixture_bad_focus"))
                    else:
                        add_value(positive, path, VALUE, source)
                        add_value(negative, path, Literal("not an IRI"), source)
                else:
                    raise AssertionError(predicate)

                checks = {"valid": run(positive, shapes, root, child, predicate, True)}
                if impossible:
                    limitations[impossible] += 1
                    checks["violation"] = {"status": "LOGICALLY_UNREACHABLE", "reason": impossible}
                else:
                    bad_focus = (BNode("fixture_bad_focus") if predicate == SH.nodeKind
                                 and path is None else FOCUS)
                    checks["violation"] = run(negative, shapes, root, child, predicate,
                                              False, focus=bad_focus)
                checks["boundary"] = run(boundary, shapes, root, child, predicate, True)
                if path is not None and not impossible:
                    # Same fault with target activation absent must yield no result.
                    off = activated_data(root, shapes, suppressed=True)
                    for s, p, o in negative:
                        if (s, p, o) not in baseline:
                            off.add((s, p, o))
                    self_activating = any(
                        (p == target and s == FOCUS if kind == SH.targetSubjectsOf else
                         p == target and o == FOCUS if kind == SH.targetObjectsOf else
                         p == RDF.type and s == FOCUS and o == target if kind == SH.targetClass else False)
                        for kind in TARGETS for target in shapes.objects(root, kind)
                        for s, p, o in off)
                    if self_activating:
                        checks["target_off"] = {"status": "SELF_ACTIVATING_FAULT",
                                                "reason": "fault relation itself activates source target"}
                        limitations["fault relation itself activates source target"] += 1
                    else:
                        checks["target_off"] = run(off, shapes, root, child, predicate, True)
                counts[str(predicate).rsplit("#", 1)[-1]] += 1
                cases.append({"register_key": key, "source": rel,
                              "node_shape": root_key,
                              "source_shape": str(child) if isinstance(child, URIRef) else "source_property_blank_node",
                              "source_route": route,
                              "targets": rows[key]["expression"]["target"],
                              "activated_target": [(str(p), str(o)) for p in TARGETS
                                                   for o in shapes.objects(root, p)],
                              "path": rows[key]["expression"]["path"],
                              "component": str(predicate), "parameter": term(source, parameter),
                              "checks": checks})

assert set(rows) == {case["register_key"] for case in cases}
assert sum(counts.values()) == 1864, counts
out = {"scope": "Isolated, target-activated active cardinality/class/datatype/nodeKind components",
       "method": "Projected source component and source target, pySHACL 0.30.1, inference none; exact report focus, source and component asserted",
       "source_sha256": sources, "register_sha256": hashlib.sha256(REGISTER.read_bytes()).hexdigest(),
       "components": dict(sorted(counts.items())), "logical_unreachability": dict(sorted(limitations.items())),
       "executed_cases": len(cases), "cases": cases,
       "limitations": "The projection isolates components; conjunctions, logical alternatives, SPARQL and cross-record effects are not tested here (#16). A boundary is a second conforming edge; tautological constraints cannot produce a violating graph."}
OUT.write_bytes(gzip.compress(json.dumps(out, sort_keys=True,
                                         separators=(",", ":")).encode(), mtime=0))

check_counts = Counter(name for case in cases for name, check in case["checks"].items()
                       if "status" not in check)
lines = ["# Simple SHACL constraint case execution", "",
         "The four runtime-loaded SHACL source graphs were projected one component at a time, retaining "
         "one original target declaration, constraint value, source shape and property path. Each case "
         "activates the source target. The runner checks `sh:focusNode`, `sh:sourceShape` and "
         "`sh:sourceConstraintComponent` on each violating report, as well as empty reports on "
         "conforming graphs. The full graph interaction is reserved for #16.", "",
         "| Component | Active occurrences |", "| --- | ---: |"]
for component, number in sorted(counts.items()):
    lines.append(f"| `{component}` | {number:,} |")
lines += ["", f"Total: **{len(cases):,}** source-linked occurrences. "
          f"Executed valid: **{check_counts['valid']:,}**, violation: **{check_counts['violation']:,}**, "
          f"boundary: **{check_counts['boundary']:,}**, target-off: **{check_counts['target_off']:,}**.", "",
          "## Logical limits", ""]
for reason, number in sorted(limitations.items()):
    lines.append(f"- {number:,} occurrences: {reason}.")
lines += ["", "A `minCount 0` can never fail. A node-level class identical to its target class "
          "cannot fail while the target is active. One target relation already satisfies a "
          "`minCount 1` in isolation. Three fault relations themselves activate their target, "
          "so an inactive-target control cannot be formed for those cases. These are explicit "
          "unreachability records, "
          "not successful negative tests.", "",
          "[Case receipts, targets and source hashes](shacl-simple-constraints.json.gz) · "
          "[Coverage register](coverage-register.md) · [Shape graph audit](shacl-shapes-audit.md)", ""]
SUMMARY.write_text("\n".join(lines), encoding="utf-8")
print(json.dumps({"occurrences": len(cases), "checks": dict(check_counts),
                  "unreachable": dict(limitations)}))
