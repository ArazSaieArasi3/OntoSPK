# Versions and source identity

| Object | Current identity |
| --- | --- |
| Public distribution target | 2.0.0 — prepared, GitHub Release pending |
| Native conceptual model | 0.41.0 |
| Logical profile revision | 0.43.0 |
| Source assembly provenance | 0.45.0 |
| Documentation baseline | Public core preparation, 21 October 2026 |

These labels identify different objects. Retained fixture and schema filenames keep their original revisions for reproducibility. The OWL ontology metadata is documented in [Formalization](Formalization.md).

The stable ontology-core source is the private `product-ontology` tag `v2.0.0`, commit `beb0194b23d5794307742f9214d780e823ff829f`. The public repository has a separate history and selected scope; the [distribution manifest](../../distribution-manifest.json) records both source identity and file hashes. The earlier public candidate was based on source commit `e12c23ce04232a695116376435fe48d33d8b14c0`.

The canonical native model and logical profile preserve their exact SHA-256 digests. Generated references and execution receipts have their own hashes. The physical database is outside this core distribution.

The private source has a stable `v2.0.0` release; the public destination does not yet have a `v2.0.0` GitHub Release. Publishing that tag requires the public migration and validation review. Published tags and release payloads must not be silently replaced. Documentation-only improvements do not automatically create a new semantic model version.
