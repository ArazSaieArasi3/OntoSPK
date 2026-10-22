# Finite evaluation coverage register

This is a **test design, not an execution report**. Each machine-readable row records the source, method, oracle, positive, negative and boundary case, and limitation. The released native and logical files remain unchanged.

[Full row register (JSON, gzip)](coverage-register.json.gz) · [Evaluation plan](comprehensive-coverage-plan.md) · [Prior finite results](../docs/guide/Quality.md) · [Subsequent isolated SHACL component execution](shacl-simple-constraints.md)

## Distinct denominators

| Inventory | Rows |
| --- | ---: |
| `commitment` | 22 |
| `cq_contract` | 56 |
| `cq_optional_mapping` | 2 |
| `external_handle` | 27 |
| `native_class` | 128 |
| `native_expression` | 892 |
| `native_generalization` | 34 |
| `native_relation` | 286 |
| `owl_class` | 121 |
| `owl_datatype_property` | 46 |
| `owl_object_property` | 286 |
| `shacl_constraint` | 1977 |

These inventories overlap: a native class can also be a bounded OWL declaration, an external handle is also a native class, and a commitment may be represented by several structural expressions or constraints. They must not be summed as a global correctness score. The SHACL count is per active target-reachable component and parameter, including named and anonymous property shapes; #14 will test graph validity and activation. The four active shapes graphs contain 1,217 targeted node shapes, 777 distinct reachable property shapes (40 nested in logical alternatives) and 49 linked SPARQL constraints. The event-contract graph uses a plain `.ttl` suffix and is included because the runtime loads it. The CQ source has two additional optional mapping rows outside the 56 retained replay contracts.

## Acceptance route

Issues #14–#16 execute SHACL checks; #17–#20 run OWL, HermiT and ROBOT checks; #21 replays CQ contracts and mutations; #22 adjudicates findings. Every planned row starts with `PLANNED_NOT_EXECUTED`. Cases describe designs and do not claim existing fixtures for each declaration. Reports must retain separate coverage denominators and count unsupported or untested claims explicitly.

Temporal continuity, modal identity/dependence, causal evidence and external-owner equivalence are not established by this finite register. No universal semantic-correctness percentage is asserted.
