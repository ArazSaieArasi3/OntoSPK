# Reader documentation parity

This source audit compares the accepted Wiki snapshot, authored guide and current generated Pages. It checks full normalized text, headings and ordered link destinations, local reader routing and anchors; it is not a fresh readback of the mutable live Wiki or proof of scientific completeness. The historical Wiki receipt and frozen documentation snapshots remain unchanged.

**Result: PASS.** 15 Wiki pages; 19 authored reader pages including the current method, diagram and publication explanations; 0 errors.

| Authored source | Pages route | Headings | Links |
| --- | --- | ---: | ---: |
| docs/guide/Citation.md | docs/guide/Citation.html | 1 | 6 |
| docs/guide/Competency-Questions.md | docs/guide/Competency-Questions.html | 1 | 2 |
| docs/guide/Conceptual-Model.md | docs/guide/Conceptual-Model.html | 1 | 3 |
| docs/guide/Constraints.md | docs/guide/Constraints.html | 1 | 3 |
| docs/guide/Domains.md | docs/guide/Domains.html | 1 | 3 |
| docs/guide/External-References.md | docs/guide/External-References.html | 6 | 10 |
| docs/guide/Formalization.md | docs/guide/Formalization.html | 5 | 10 |
| docs/guide/Home.md | docs/guide/Home.html | 6 | 23 |
| docs/guide/Limitations.md | docs/guide/Limitations.html | 1 | 2 |
| docs/guide/Overview.md | docs/guide/Overview.html | 1 | 5 |
| docs/guide/Quality.md | docs/guide/Quality.html | 2 | 7 |
| docs/guide/References.md | docs/guide/References.html | 1 | 7 |
| docs/guide/Reproduce.md | docs/guide/Reproduce.html | 2 | 1 |
| docs/guide/Versions.md | docs/guide/Versions.html | 1 | 6 |
| docs/guide/Visualization.md | docs/guide/Visualization.html | 2 | 3 |
| docs/handbook/current-status.md | docs/status/index.html | 6 | 19 |
| docs/handbook/diagram-provenance.md | docs/reference/diagrams/index.html | 6 | 10 |
| docs/handbook/formal-verification.md | docs/reference/formal/method.html | 9 | 15 |
| docs/handbook/publication-handoff.md | docs/reference/publication/index.html | 7 | 24 |

Whitespace and the existing Home publication-status sentence adapter are normalized. Current-context asides are checked separately and excluded from historical-content equality. All authored handbook explanations are compared with their own Markdown sources. The finite fault-detection tests exercise paragraph deletion, heading changes, broken routes, misdirected existing links, absent current context and swapped diagram images.

Reproduce: `python tools/publication/audit_documentation.py` and `python tools/publication/test_documentation_audit.py`.
