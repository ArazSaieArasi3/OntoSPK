# Pages publication

The portal uses WIDOCO for the bounded OWL reference and governed pages for the conceptual inventory, first-order specification, guide, evidence and downloads. WebVOWL is an exploratory view with ten explicitly recorded property omissions. Neither view substitutes for the native model or evaluation evidence.

`build_portal.py` regenerates the complete unversioned payload in `docs/`. It leaves the accepted Wiki Markdown unchanged. `audit_pages.py`, `audit_wiki.py` and `check_publication.py` check coverage, graph identity, publication boundaries and local destinations. They do not constitute browser acceptance.

`pages-registry.json` maps each frozen documentation release to an exact Git commit and its `docs` tree. `build_versioned_site.py` extracts those trees from Git, verifies the native and logical source digests, and adds explicit documentation/core version and source metadata. Existing mappings cannot change. New current documentation is served under `current/`; immutable snapshots are served under `releases/vX.Y.Z/`. Documentation v2.0.1 describes ontology core v2.0.0; it introduces no semantic source change.

The Pages workflow deploys `build/site` through GitHub Actions. GitHub Pages must use the GitHub Actions publishing source. Published HTML routes do not imply HTTP content negotiation for ontology IRIs. Tool versions and viewer provenance are recorded in `docs/tool-provenance.json`; each deployment contains a file-hash manifest.

A release is accepted only after live route, browser interaction and download readback. Alternative generators, including pyLODE, remain future design options. Individual sourced concept pages are deferred to issue #37 and are not created by the term search index.

## Reader completeness contract

Pages is the primary reader entry point. All fifteen accepted Wiki reader pages must be available as complete local guide pages, including their headings, text and corresponding link destinations. `docs/guide` is the authored guide source; `wiki-src` and HTML are projections. The accepted live Wiki snapshot and its receipt stay historical. Current reading context is added by the renderer, not by changing those accepted bytes. New Wiki publication requires its own readback; the parity check is not a live Wiki check.

`docs/handbook/formal-verification.md` is the authored current method explanation, rendered to `reference/formal/method.html`. It connects the frozen formal sources and current evidence, explains FOL/TPTP/OWL/Turtle/Z3, and distinguishes model, documentation and evidence versions. Reader explanations with an existing Pages route stay local; code, certificates and exact source artifacts may link to GitHub with their declared source identity.

`audit_documentation.py` checks the actual Wiki/guide inventory, full normalized content, headings and ordered link destinations. It checks that source-backed reader destinations stay local and all local links/fragments exist. Normalization is limited to whitespace and the existing explicit Home publication-status sentence adapter; the added current-context aside is tested and excluded from baseline equality. The method page is independently compared with its authored Markdown. `test_documentation_audit.py` verifies detection of content loss, heading changes, missing routes and misdirected links. CI reproduces the checked-in deterministic parity report.

The authored handbook also contains `diagram-provenance.md` and `publication-handoff.md`, rendered to `reference/diagrams/index.html` and `reference/publication/index.html`. The parity audit measures all three current explanations and verifies image destinations as well as links. It rejects a swapped but existing diagram image. Figure generation and bounded notation/source checks are in `build_diagram_review.py` and `test_diagram_review.py`. Two domain PNGs retain reviewed presentation bytes and embedded SVG-source hashes; explicit raster refresh uses the optional pinned `diagram-requirements.txt`. CI regenerates SVGs and verifies source binding without assuming cross-platform font rasterization is byte identical.

## Pinned viewer compatibility

The publication renderer retains inert hidden controls required by WebVOWL 1.1.7 during view-mode initialization. Removing the ontology-creation menu had removed those controls and caused an upstream null dereference before the graph loaded. The unavailable editing option stays hidden, search has an accessible name and the context banner leaves the viewer title visible. `viewer_compat.py` applies this presentation adjustment to both current and frozen outputs. The deployment manifest records the exact adjustment source hash and deployment commit; the frozen source tree, RDF and graph JSON remain unchanged. Acceptance requires a rendered graph and a working search after deployment.
