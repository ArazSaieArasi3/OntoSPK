# Active SHACL graph audit

This audit covers the four graphs loaded by the public validation runtime. The event-contract graph has a plain `.ttl` suffix. It was missed by the earlier filename-only coverage register; the register now traverses logical alternatives and includes its constraints. This changes the planned denominator, not the frozen v2.0.0 semantic sources or an executed coverage claim.

| Graph | Targeted nodes | Reachable property shapes | Nested properties | SPARQL | Exact duplicate excess | Distinct body templates |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `Occurrence_Profile_v0_41_0.shacl.ttl` | 1 | 9 | 0 | 7 | 0 | 1 |
| `identity-slice.shacl.ttl` | 6 | 3 | 0 | 0 | 0 | 5 |
| `complete-reporting-v0_16.shacl.ttl` | 1194 | 750 | 40 | 40 | 0 | 741 |
| `Event_Contract_Shapes_v0_30_0.ttl` | 16 | 15 | 0 | 2 | 0 | 16 |

All four graphs parse and pass meta-SHACL. Every declared node shape has a target; all `sh:property` and `sh:sparql` nodes are reachable from those targets. The 40 nested property shapes occur in logical alternatives of the complete-reporting graph. No other TTL source graph declares a SHACL node shape outside these runtime-loaded graphs. Repeated templates are reported separately from exact same-target duplicates and are not treated as independent test outcomes.

A controlled malformed-shape graph is rejected by meta-SHACL. A different, valid shape with a missing required data value returns an ordinary nonconformance report. An empty data graph conforms because the source graphs have no matching focus nodes in that control; it does not activate every target. Constraint-level positive, negative and boundary cases remain #15 and #16.

[Machine-readable counts and source hashes](shacl-shapes-audit.json) · [Corrected coverage register](coverage-register.md)
