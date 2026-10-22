"""Audit the four SHACL graphs loaded by the public core's validation runtime.

The audit is about graph activation and integrity, not complete data-case coverage.
"""

from collections import Counter, defaultdict
from pathlib import Path
import hashlib
import json

from pyshacl import validate
from pyshacl.errors import ReportableRuntimeError
from rdflib import BNode, Graph, Literal, RDF, SH, URIRef


ROOT = Path(__file__).resolve().parents[2]
BASE = Path("semantic/product/v2/source/validation_v041")
FILES = (
    "Occurrence_Profile_v0_41_0.shacl.ttl",
    "inputs/identity-slice.shacl.ttl",
    "inputs/complete-reporting-v0_16.shacl.ttl",
    "inputs/Event_Contract_Shapes_v0_30_0.ttl",
)
discovered = {p.relative_to(ROOT / BASE).as_posix() for p in (ROOT / BASE).rglob("*.ttl")
              if "sh:NodeShape" in p.read_text(encoding="utf-8") or
              "shacl#NodeShape>" in p.read_text(encoding="utf-8")}
assert discovered == set(FILES), f"Unclassified source SHACL graphs: {sorted(discovered ^ set(FILES))}"
TARGETS = (SH.targetClass, SH.targetNode, SH.targetSubjectsOf, SH.targetObjectsOf)
EDGES = (SH.property, SH.node, SH.qualifiedValueShape, SH["not"])
LIST_EDGES = (SH["or"], SH["and"], SH.xone)


def canonical(g, node, depth=0):
    if isinstance(node, Literal):
        return ("literal", str(node), str(node.datatype or ""), node.language or "")
    if isinstance(node, URIRef):
        return ("iri", str(node))
    if depth > 30:
        raise ValueError("Cyclic or excessively nested shape expression")
    return ("blank", tuple(sorted((str(p), canonical(g, o, depth + 1))
                                  for p, o in g.predicate_objects(node))))


def reachable(g, roots):
    seen = set()
    pending = list(roots)
    while pending:
        node = pending.pop()
        if node in seen:
            continue
        seen.add(node)
        for pred in EDGES:
            pending.extend(g.objects(node, pred))
        for pred in LIST_EDGES:
            for head in g.objects(node, pred):
                pending.extend(g.items(head))
    return seen


def fingerprint(g, node, include_target):
    skip = {RDF.type} | (set() if include_target else set(TARGETS))
    description = tuple(sorted((str(p), canonical(g, o)) for p, o in g.predicate_objects(node)
                               if p not in skip))
    return hashlib.sha256(repr(description).encode()).hexdigest()


def synthetic_controls():
    malformed = Graph().parse(data='''@prefix sh: <http://www.w3.org/ns/shacl#> .
        <urn:shape> a sh:NodeShape ; sh:targetNode <urn:focus> ;
          sh:property [ sh:path "invalid-literal-path" ; sh:minCount -1 ] .''', format="turtle")
    try:
        validate(Graph(), shacl_graph=malformed, meta_shacl=True, advanced=True)
    except ReportableRuntimeError:
        bad_graph = "META_SHACL_REJECTED"
    else:
        raise AssertionError("Malformed shapes graph was not rejected")
    valid = Graph().parse(data='''@prefix sh: <http://www.w3.org/ns/shacl#> .
        <urn:shape> a sh:NodeShape ; sh:targetNode <urn:focus> ;
          sh:property [ sh:path <urn:required> ; sh:minCount 1 ] .''', format="turtle")
    conforms, report, _ = validate(Graph(), shacl_graph=valid, meta_shacl=True, advanced=True)
    assert not conforms and len(set(report.subjects(RDF.type, SH.ValidationResult))) == 1
    return {"malformed_shape_graph": bad_graph,
            "valid_shape_nonconforming_data": "CONFORMS_FALSE_WITH_ONE_VALIDATION_RESULT"}


graphs = []
for name in FILES:
    path = BASE / name
    graph = Graph().parse(ROOT / path)
    nodes = set(graph.subjects(RDF.type, SH.NodeShape))
    active = {n for n in nodes if any((n, t, None) in graph for t in TARGETS)}
    reached = reachable(graph, active)
    all_properties = set(graph.objects(None, SH.property))
    properties = all_properties & reached
    direct_properties = {p for n in active for p in graph.objects(n, SH.property)}
    all_sparql = set(graph.objects(None, SH.sparql))
    sparql = {s for n in reached for s in graph.objects(n, SH.sparql)}
    target_kinds = Counter(str(t).rsplit("#", 1)[-1] for n in active for t in TARGETS
                           for _ in graph.objects(n, t))
    paths = Counter("inverse" if isinstance(graph.value(p, SH.path), BNode) else "direct_iri"
                    if isinstance(graph.value(p, SH.path), URIRef) else "missing_or_other"
                    for p in properties)
    components = Counter(str(predicate).rsplit("#", 1)[-1] for n in reached
                         for predicate, _ in graph.predicate_objects(n)
                         if predicate in {SH.minCount, SH.maxCount, SH.nodeKind, SH.datatype, SH["class"],
                                          SH.pattern, SH["in"], SH.sparql, SH["or"], SH["and"], SH.xone})
    exact = defaultdict(list)
    templates = defaultdict(list)
    for node in active:
        exact[fingerprint(graph, node, True)].append(str(node))
        templates[fingerprint(graph, node, False)].append(str(node))
    conforming_empty, report, _ = validate(Graph(), shacl_graph=graph, meta_shacl=True, advanced=True)
    assert conforming_empty and not list(report.subjects(RDF.type, SH.ValidationResult))
    graphs.append({
        "source": str(path), "sha256": hashlib.sha256((ROOT / path).read_bytes()).hexdigest(),
        "rdf_triples": len(graph), "node_shapes": len(nodes), "targeted_node_shapes": len(active),
        "inactive_node_shapes": len(nodes - active), "target_kinds": dict(sorted(target_kinds.items())),
        "distinct_reachable_property_shapes": len(properties),
        "nested_property_shapes": len(properties - direct_properties),
        "unreachable_property_shapes": len(all_properties - properties),
        "distinct_reachable_sparql_constraints": len(sparql),
        "unreachable_sparql_constraints": len(all_sparql - sparql),
        "property_paths": dict(sorted(paths.items())),
        "selected_component_occurrences": dict(sorted(components.items())),
        "duplicate_target_and_body_clusters": sum(len(v) > 1 for v in exact.values()),
        "duplicate_target_and_body_excess": sum(len(v) - 1 for v in exact.values()),
        "distinct_target_and_body_fingerprints": len(exact),
        "distinct_body_templates": len(templates),
        "reused_body_template_clusters": sum(len(v) > 1 for v in templates.values()),
        "meta_shacl": "CONFORMS", "empty_data_graph": "CONFORMS_NO_TARGETED_RECORDS",
    })

assert len(graphs) == 4
assert sum(x["targeted_node_shapes"] for x in graphs) == 1217
assert sum(x["distinct_reachable_property_shapes"] for x in graphs) == 777
assert sum(x["nested_property_shapes"] for x in graphs) == 40
assert sum(x["distinct_reachable_sparql_constraints"] for x in graphs) == 49
assert all(x["inactive_node_shapes"] == x["unreachable_property_shapes"] ==
           x["unreachable_sparql_constraints"] == 0 for x in graphs)
out = {"scope": "Four runtime-loaded public-core SHACL graphs; shape integrity and activation inventory",
       "status": "GRAPH_AUDIT_EXECUTED; ISOLATED_SIMPLE_COMPONENT_CASES_15_SEPARATE; COMPLEX_CASES_16_PENDING",
       "additional_source_shape_graphs_outside_runtime": [],
       "graphs": graphs, "synthetic_status_controls": synthetic_controls(),
       "interpretation": "Meta-SHACL success and an empty data graph do not prove behavior on targeted records. "
                         "Duplicate structural templates are not independent defect-detection cases; "
                         "each target remains traceable. Nonconformance of a valid shape is a data result, "
                         "whereas meta-SHACL rejection is a malformed-shape error."}
dest = ROOT / "evaluation/shacl-shapes-audit.json"
dest.write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
lines = ["# Active SHACL graph audit", "",
         "This audit covers the four graphs loaded by the public validation runtime. The event-contract "
         "graph has a plain `.ttl` suffix. It was missed by the earlier filename-only coverage register; "
         "the register now traverses logical alternatives and includes its constraints. This changes the "
         "planned denominator, not the frozen v2.0.0 semantic sources or an executed coverage claim.", "",
         "| Graph | Targeted nodes | Reachable property shapes | Nested properties | SPARQL | Exact duplicate excess | Distinct body templates |",
         "| --- | ---: | ---: | ---: | ---: | ---: | ---: |"]
for x in graphs:
    lines.append(f"| `{Path(x['source']).name}` | {x['targeted_node_shapes']} | "
                 f"{x['distinct_reachable_property_shapes']} | {x['nested_property_shapes']} | "
                 f"{x['distinct_reachable_sparql_constraints']} | "
                 f"{x['duplicate_target_and_body_excess']} | {x['distinct_body_templates']} |")
lines += ["", "All four graphs parse and pass meta-SHACL. Every declared node shape has a target; "
          "all `sh:property` and `sh:sparql` nodes are reachable from those targets. "
          "The 40 nested property shapes occur in logical alternatives of the complete-reporting graph. "
          "No other TTL source graph declares a SHACL node shape outside these runtime-loaded graphs. "
          "Repeated templates are reported separately from exact same-target duplicates and are not "
          "treated as independent test outcomes.", "",
          "A controlled malformed-shape graph is rejected by meta-SHACL. A different, valid shape "
          "with a missing required data value returns an ordinary nonconformance report. An empty "
          "data graph conforms because the source graphs have no matching focus nodes in that control; "
          "it does not activate every target. Isolated simple-component case execution is recorded "
          "in #15; graph interactions and complex constraints remain #16.", "", "[Machine-readable counts and source hashes](shacl-shapes-audit.json) · "
          "[Corrected coverage register](coverage-register.md)", ""]
(ROOT / "evaluation/shacl-shapes-audit.md").write_text("\n".join(lines), encoding="utf-8")
print(json.dumps({"graphs": len(graphs), "targets": sum(x["targeted_node_shapes"] for x in graphs),
                  "properties": sum(x["distinct_reachable_property_shapes"] for x in graphs),
                  "exact_duplicate_excess": sum(x["duplicate_target_and_body_excess"] for x in graphs)}))
