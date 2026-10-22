"""Build a finite, source-traceable test plan for the released ontology core.

This is an inventory and a test design, not a validation execution receipt.
"""

from collections import Counter
from pathlib import Path
import csv
import gzip
import hashlib
import json

from rdflib import BNode, Graph, Literal, OWL, RDF, SH, URIRef


ROOT = Path(__file__).resolve().parents[2]
SOURCE = Path("semantic/product/v2/source")
OUT = ROOT / "evaluation"


def source(path):
    p = ROOT / path
    return {"path": str(path), "sha256": hashlib.sha256(p.read_bytes()).hexdigest()}


def load(path):
    return json.loads((ROOT / path).read_text(encoding="utf-8"))


def row(group, key, src, expression, method, oracle, positive, negative, boundary, limit):
    return {"group": group, "key": key, "source": str(src), "expression": expression,
            "method": method, "oracle": oracle, "positive_case": positive,
            "negative_case": negative, "boundary_case": boundary, "limitation": limit,
            "execution_status": "PLANNED_NOT_EXECUTED"}


def term(g, value):
    if isinstance(value, BNode):
        # A path expression is recorded by its exact predicate/object structure, not a parser BNode ID.
        return sorted(((str(p), term(g, o)) for p, o in g.predicate_objects(value)),
                      key=lambda pair: json.dumps(pair, sort_keys=True))
    if isinstance(value, Literal):
        return {"value": str(value), "datatype": str(value.datatype) if value.datatype else None,
                "language": value.language}
    return str(value)


sources = []
rows = []
matrix_path = SOURCE / "t52_formalization_v043/Commitment_Matrix_22_v0_43_0.json"
matrix = load(matrix_path)["rows"]
sources.append(source(matrix_path))
for c in matrix:
    methods = {k: c.get(k, "") for k in ("owl", "shacl", "sql", "history")}
    rows.append(row("commitment", c["id"], matrix_path, {"title": c["commitment"],
                    "formulas": c.get("formulas", []), "static_native_formulas": c.get("static_native_formulas", []),
                    "mechanisms": methods}, "Claim-specific OWL / SHACL / structural / policy checks",
                    "Only the stated mechanism and its own expected entailment, conformance or policy outcome",
                    c["positive"], c["negative"], "Explicit equality, absence, and scope edge where applicable",
                    c["limit"]))

owl_path = SOURCE / "t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl"
sources.append(source(owl_path))
g = Graph().parse(ROOT / owl_path)
owl_kinds = ((OWL.Class, "class"), (OWL.ObjectProperty, "object_property"),
             (OWL.DatatypeProperty, "datatype_property"))
for rdf_type, kind in owl_kinds:
    for entity in sorted({x for x in g.subjects(RDF.type, rdf_type) if isinstance(x, URIRef)}, key=str):
        rows.append(row("owl_" + kind, str(entity), owl_path,
                        {"rdf_type": str(rdf_type), "iri": str(entity)},
                        "OWL 2 DL profile and HermiT/ROBOT, plus focused entailment where axiomatized",
                        "Declaration present; named class satisfiable, TBox consistent; applicable axiom's expected entailment",
                        "Consistent typed witness, with its declared entailment if any",
                        "Isolated contradicting assertion only when an axiom actually entails inconsistency",
                        "Omitted facts and no-unique-name cases do not imply rejection",
                        "A bare declaration does not create a closed-world constraint or testable behavioral claim"))

shacl_paths = sorted((ROOT / SOURCE / "validation_v041").rglob("*.shacl.ttl"))
shacl_graphs = []
constraint_predicates = {
    SH.minCount, SH.maxCount, SH["class"], SH.datatype, SH.nodeKind, SH["in"],
    SH.pattern, SH.minLength, SH.maxLength, SH.minInclusive, SH.maxInclusive,
    SH.minExclusive, SH.maxExclusive, SH.hasValue, SH.equals, SH.disjoint,
    SH.lessThan, SH.lessThanOrEquals, SH.closed, SH.ignoredProperties,
    SH.node, SH["and"], SH["or"], SH["not"], SH.xone, SH.qualifiedValueShape,
    SH.qualifiedMinCount, SH.qualifiedMaxCount, SH.uniqueLang, SH.languageIn,
    SH.sparql,
}
targets = (SH.targetClass, SH.targetNode, SH.targetSubjectsOf, SH.targetObjectsOf)
for path in shacl_paths:
    relative = path.relative_to(ROOT)
    sources.append(source(relative))
    shapes = Graph().parse(path)
    active = sorted({n for n in shapes.subjects(RDF.type, SH.NodeShape)
                     if any((n, t, None) in shapes for t in targets)}, key=str)
    shacl_graphs.append({"path": str(relative), "targeted_node_shapes": len(active),
                         "linked_property_shapes": len({p for n in active for p in shapes.objects(n, SH.property)}),
                         "linked_sparql_constraints": len({p for n in active for p in shapes.objects(n, SH.sparql)})})
    for node in active:
        target = sorted((str(p), term(shapes, o)) for p, o in shapes.predicate_objects(node) if p in targets)
        children = [(node, None)] + [(p, term(shapes, shapes.value(p, SH.path)))
                                      for p in shapes.objects(node, SH.property)]
        # Stable ordering for anonymous properties; no BNode identifier is used as a key.
        children.sort(key=lambda pair: json.dumps(pair[1], sort_keys=True))
        for ordinal, (child, prop_path) in enumerate(children):
            constraints = sorted(((str(p), term(shapes, o)) for p, o in shapes.predicate_objects(child)
                                  if p in constraint_predicates), key=lambda item: json.dumps(item, sort_keys=True))
            for index, (predicate, value) in enumerate(constraints):
                key = f"{relative}::{node}::{ordinal}:{index}"
                rows.append(row("shacl_constraint", key, relative,
                                {"node_shape": str(node), "target": target, "path": prop_path,
                                 "component": predicate, "parameter": value},
                                "SHACL data graph validation against this active shapes graph",
                                "Focus node, source shape, constraint component, and expected conformance match",
                                "Targeted conforming focus node with this condition satisfied",
                                "Same targeted node violating this component in isolation",
                                "Missing/extra value, wrong target, inverse path or threshold edge as applicable",
                                "An inventory row is not proof of valid shapes, target activation or fault detection"))

cq_path = SOURCE / "validation_v041/cq_replay/CQ_Contracts_v0_24_0.csv"
sources.append(source(cq_path))
with (ROOT / cq_path).open(encoding="utf-8-sig", newline="") as file:
    cqs = list(csv.DictReader(file))
for c in cqs:
    group = "cq_optional_mapping" if c["execution_status"] == "NOT_EXECUTED_OPTIONAL_MAPPING" else "cq_contract"
    rows.append(row(group, c["cq_id"], cq_path,
                    {"requirement": c["requirement_id"], "question": c["question"],
                     "query": c["query_path"], "fixture": c["fixture_path"],
                     "expected": c["expected_positive_result"]}, "Exact-answer SPARQL replay and data mutation",
                    "Expected answer fields and exact expected tuple set under the recorded answer policy",
                    c["positive_fixture"], c["negative_or_boundary_case"],
                    "Missing critical edge, wrong direction and applicable domain-specific edge",
                    c["answer_policy"] + (" Optional mapping; excluded from the 56 retained replay contracts."
                                          if group == "cq_optional_mapping" else "")))

native_path = SOURCE / "formalization/Native_Model_v0_41_0.json"
relations_path = Path("semantic/product/v2/formal-specification/relation-signatures.json")
axioms_path = SOURCE / "formalization/Structural_Axioms_892.json"
for p in (native_path, relations_path, axioms_path):
    sources.append(source(p))
native = load(native_path)["elements"]
for e in native:
    if e["type"] == "Class":
        rows.append(row("native_class", e["id"], native_path,
                        {"name": (e.get("name") or {}).get("en"), "stereotype": e.get("stereotype"),
                         "scope": "external_handle" if e["id"].startswith("EXT:") else "local"},
                        "Native structural and identity review", "Identifier and recorded classification match native source",
                        "In-scope typed example", "Distinct sortal or scope counterexample",
                        "Identity across changed properties and empty populations",
                        "A stereotype or name alone does not settle UFO identity or owner equivalence"))
    elif e["type"] == "Generalization":
        rows.append(row("native_generalization", e["id"], native_path,
                        {"specific": e["specific"], "general": e["general"]},
                        "Native structural check and OWL subclass comparison",
                        "Subclass endpoint and direction match; inferred membership when projected",
                        "Instance of specific is an instance of general where encoded",
                        "Reverse subsumption is not assumed", "Siblings need not be disjoint or exhaustive",
                        "The native generalization need not prove an OntoUML subkind"))
for s in load(relations_path):
    rows.append(row("native_relation", s["id"], relations_path, s,
                    "Native signature and cardinality check; compare OWL/SHACL only where projected",
                    "Both endpoint classes, predicate direction and each stated multiplicity match",
                    "One permitted source-target pair", "Wrong endpoint or reversed pair",
                    "Zero, one, lower and upper multiplicity edges as specified",
                    "A structural association does not establish modal or causal behavior"))
for a in load(axioms_path)["axioms"]:
    rows.append(row("native_expression", a["id"], axioms_path, a,
                    "Static expression review and fixture-based structural check",
                    "Formula and referenced native identifier match the expected finite configuration",
                    "Configuration satisfying this expression", "Configuration violating this expression",
                    "Relevant zero/one and endpoint cardinality edge",
                    "Source formula is an intended contract; no execution is implied"))

external_path = Path("evaluation/external-boundary-status.json")
sources.append(source(external_path))
for item in load(external_path)["rows"]:
    rows.append(row("external_handle", item["native_id"], external_path, item,
                    "Owner declaration and scoped mapping review", "Owner-approved IRI and meaning, or explicitly unresolved status",
                    "Recorded declaration with independent owner confirmation when available",
                    "Mismatched IRI, renamed candidate or absent declaration",
                    "Composite target and unresolvable namespace decisions",
                    "A historical declaration is neither present public resolvability nor semantic equivalence"))

counts = dict(sorted(Counter(x["group"] for x in rows).items()))
assert counts["commitment"] == 22 and counts["cq_contract"] == 56 and counts["cq_optional_mapping"] == 2
assert counts["native_class"] == 128 and counts["native_relation"] == 286
assert counts["native_generalization"] == 34 and counts["native_expression"] == 892
assert counts["external_handle"] == 27 and counts["owl_class"] == 121
assert len(shacl_graphs) == 3
assert sum(s["targeted_node_shapes"] for s in shacl_graphs) == 1201
assert sum(s["linked_property_shapes"] for s in shacl_graphs) == 722
assert sum(s["linked_sparql_constraints"] for s in shacl_graphs) == 47
assert len({(x["group"], x["key"]) for x in rows}) == len(rows)
register = {"scope": "Released v2.0.0 sources, with the subsequent finite evaluation plan",
            "status": "INVENTORY_AND_CASE_DESIGN_ONLY; no new validation executed",
            "source_sha256": {s["path"]: s["sha256"] for s in sources},
            "method_denominators": counts,
            "shacl_graphs": shacl_graphs,
            "unsupported_claims": ["Temporal continuity is not derived from static OWL restrictions",
                                   "Modal identity and dependence require independent scientific adjudication",
                                   "Causal evidence is not established by event labels or a SHACL pass",
                                   "External-owner equivalence is not established by a historical declaration"],
            "rows": rows}
payload = (json.dumps(register, ensure_ascii=False, separators=(",", ":")) + "\n").encode("utf-8")
(OUT / "coverage-register.json.gz").write_bytes(gzip.compress(payload, compresslevel=9, mtime=0))
table = "\n".join(f"| `{group}` | {count} |" for group, count in counts.items())
(OUT / "coverage-register.md").write_text(
    "# Finite evaluation coverage register\n\n"
    "This is a **test design, not an execution report**. Each machine-readable row records the source, "
    "method, oracle, positive, negative and boundary case, and limitation. "
    "The released native and logical files remain unchanged.\n\n"
    "[Full row register (JSON, gzip)](coverage-register.json.gz) · "
    "[Evaluation plan](comprehensive-coverage-plan.md) · "
    "[Prior finite results](../docs/guide/Quality.md)\n\n"
    "## Distinct denominators\n\n| Inventory | Rows |\n| --- | ---: |\n" + table + "\n\n"
    "These inventories overlap: a native class can also be a bounded OWL declaration, "
    "an external handle is also a native class, and a commitment may be represented by several "
    "structural expressions or constraints. They must not be summed as a global correctness score. "
    "The SHACL count is per active target-reachable component and parameter, including named "
    "and anonymous property shapes; #14 will test graph validity and activation. "
    "The three shapes graphs contain 1,201 targeted node shapes, 722 directly linked "
    "property shapes and 47 linked SPARQL constraints. The CQ source has two additional "
    "optional mapping rows outside the 56 retained replay contracts.\n\n"
    "## Acceptance route\n\n"
    "Issues #14–#16 execute SHACL checks; #17–#20 run OWL, HermiT and ROBOT checks; "
    "#21 replays CQ contracts and mutations; #22 adjudicates findings. "
    "Every planned row starts with `PLANNED_NOT_EXECUTED`. Cases describe designs and do not "
    "claim existing fixtures for each declaration. Reports must retain separate coverage "
    "denominators and count unsupported or untested claims explicitly.\n\n"
    "Temporal continuity, modal identity/dependence, causal evidence and external-owner equivalence "
    "are not established by this finite register. No universal semantic-correctness percentage is asserted.\n",
    encoding="utf-8")
print(json.dumps(counts, sort_keys=True))
