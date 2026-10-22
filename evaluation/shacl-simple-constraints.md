# Simple SHACL constraint case execution

The four runtime-loaded SHACL source graphs were projected one component at a time, retaining one original target declaration, constraint value, source shape and property path. Each case activates the source target. The runner checks `sh:focusNode`, `sh:sourceShape` and `sh:sourceConstraintComponent` on each violating report, as well as empty reports on conforming graphs. The full graph interaction is reserved for #16.

| Component | Active occurrences |
| --- | ---: |
| `class` | 1,233 |
| `datatype` | 51 |
| `maxCount` | 181 |
| `minCount` | 222 |
| `nodeKind` | 177 |

Total: **1,864** source-linked occurrences. Executed valid: **1,864**, violation: **1,754**, boundary: **1,864**, target-off: **1,108**.

## Logical limits

- 3 occurrences: fault relation itself activates source target.
- 95 occurrences: minCount 0 is tautological for every data graph.
- 14 occurrences: same required class activates targetClass.
- 1 occurrences: source target already entails required minimum.

A `minCount 0` can never fail. A node-level class identical to its target class cannot fail while the target is active. One target relation already satisfies a `minCount 1` in isolation. Three fault relations themselves activate their target, so an inactive-target control cannot be formed for those cases. These are explicit unreachability records, not successful negative tests.

[Case receipts, targets and source hashes](shacl-simple-constraints.json.gz) · [Coverage register](coverage-register.md) · [Shape graph audit](shacl-shapes-audit.md)
