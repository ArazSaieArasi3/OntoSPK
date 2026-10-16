# Constraints and interpretation

| Layer | Purpose | Interpretation |
| --- | --- | --- |
| Conceptual model | Declared kinds, roles, relations and multiplicities | Native modeling commitments. |
| OWL | Logical meaning and entailment | Open-world interpretation; domain and range can infer types. |
| SHACL | Validation of supplied graphs | Explicit target, path and validation conditions. |
| SQLite | Persistence and record integrity | Foreign keys, uniqueness and finite database controls. |
| Admission and history policy | Qualification of a supplied population | Bounded implementation behavior and receipts. |

An OWL domain is not a command to reject every value lacking an explicit type. Absence of a triple does not normally imply falsity. An OWL cardinality is not automatically the same operation as a SQL row count.

The [commitment matrix](../../semantic/product/v2/reference/commitments.md) records which mechanism addresses each commitment. The [occurrence shapes](../../semantic/product/v2/source/validation_v041/Occurrence_Profile_v0_41_0.shacl.ttl), executable policies and mapping CSVs remain inspectable.

Unsupported constructs and pending scientific review are retained in [Limitations](Limitations.md).
