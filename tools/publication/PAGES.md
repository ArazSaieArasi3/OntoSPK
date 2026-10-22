# Pages publication

The portal uses WIDOCO for the bounded OWL reference and governed pages for the conceptual inventory, first-order specification, guide, evidence and downloads. WebVOWL is an exploratory view with ten explicitly recorded property omissions. Neither view substitutes for the native model or evaluation evidence.

`build_portal.py` regenerates the complete unversioned payload in `docs/`. It leaves the accepted Wiki Markdown unchanged. `audit_pages.py`, `audit_wiki.py` and `check_publication.py` check coverage, graph identity, publication boundaries and local destinations. They do not constitute browser acceptance.

`pages-registry.json` maps each frozen documentation release to an exact Git commit and its `docs` tree. `build_versioned_site.py` extracts those trees from Git, verifies the native and logical source digests, and adds explicit documentation/core version and source metadata. Existing mappings cannot change. New current documentation is served under `current/`; immutable snapshots are served under `releases/vX.Y.Z/`. Documentation v2.0.1 describes ontology core v2.0.0; it introduces no semantic source change.

The Pages workflow deploys `build/site` through GitHub Actions. GitHub Pages must use the GitHub Actions publishing source. Published HTML routes do not imply HTTP content negotiation for ontology IRIs. Tool versions and viewer provenance are recorded in `docs/tool-provenance.json`; each deployment contains a file-hash manifest.

A release is accepted only after live route, browser interaction and download readback. Alternative generators, including pyLODE, remain future design options. Individual sourced concept pages are deferred to issue #37 and are not created by the term search index.

## Pinned viewer compatibility

The publication renderer retains inert hidden controls required by WebVOWL 1.1.7 during view-mode initialization. Removing the ontology-creation menu had removed those controls and caused an upstream null dereference before the graph loaded. The unavailable editing option stays hidden, search has an accessible name and the context banner leaves the viewer title visible. `viewer_compat.py` applies this presentation adjustment to both current and frozen outputs. The deployment manifest records the exact adjustment source hash and deployment commit; the frozen source tree, RDF and graph JSON remain unchanged. Acceptance requires a rendered graph and a working search after deployment.
