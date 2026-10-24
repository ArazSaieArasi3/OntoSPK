# ROBOT metadata source review — v2.0.5

All 812 baseline findings are reviewed individually with exact source IRIs, local/header/held-boundary grouping and explicit decisions. The frozen core remains v2.0.0. The separate annotated download has its own version IRI and SHA-256; it is not a replacement for the frozen core or WIDOCO reference.

| Decision | Findings |
| --- | ---: |
| ANNOTATION_REPAIRED | 492 |
| RETAIN_AUTHORED_ROOT | 53 |
| RETAIN_NO_LICENCE_SELECTED | 1 |
| RETAIN_OWNER_HELD_BOUNDARY | 122 |
| RETAIN_UNSOURCED_DEFINITION | 144 |

The view copies 101 existing local catalogue/register definitions verbatim, and 137 existing property comments as **elucidations**, not newly invented definitions. Missing labels use the exact authored IRI token with readable spacing. Local duplicate relation labels receive exact endpoint/token qualifiers; their old labels remain alternatives. Every change has an authored-source record. This is internal provenance, not independent literature/expert acceptance.

Shared source comments on 22 distinct properties receive the exact existing property token as an explicit scope qualifier. Their original comment bodies remain verbatim, and no property identities are merged. This prevents ambiguous duplicate elucidations without inventing a new relational meaning.

All 69 declared boundary proxy/relation subjects retain every outgoing assertion, including their labels and comments. All 27 native handles and 543 semantic source files remain unchanged. No sibling/private repository is accessed. External duplicate labels and missing definitions are deliberately retained.

The 53 local superclass findings correspond to 52 native kinds and the EvidenceArtifact category with no authored native parent. No missing native parent was found; no hierarchy axiom is fabricated to satisfy an OBO convention. The other 20 root findings concern owner-held proxies. Full foundational-profile adjudication remains #48.

Unsupported definitions remain explicit editorial debt in the separately planned sourced concept workflow (#37). No label, endpoint or identifier is promoted into a speculative definition. LICENSING.md remains authoritative: no project-wide reuse licence has been selected, and the missing-licence ERROR is retained.

[Download the annotated editorial view](https://github.com/ArazSaieArasi3/OntoSPK/releases/download/v2.0.5/OntoSPK-v2.0.5-annotated.ttl) · [Every finding, change and exact source hash](robot-metadata-review.json.gz) · [Fresh unmodified default-report comparison and logical controls](robot-metadata-tests.md)

The [ROBOT report documentation](https://robot.obolibrary.org/report) describes the default severity/exit behavior. This work does not change its profile, suppress rows, use a base-IRI filter, or redefine ERROR as a pass. The pinned JAR supplies the actual queries; the execution receipt records before/after counts and retained failures.

Reproduce: `python tools/publication/build_metadata_review.py`, then `python tools/publication/test_metadata_view.py --robot /path/to/robot.jar`.
