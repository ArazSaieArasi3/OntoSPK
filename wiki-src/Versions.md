# Versions and source identity

| Object | Current identity |
| --- | --- |
| Public distribution target | 2.0.0; verify the tag and release record on GitHub |
| Native conceptual model | 0.41.0 |
| Logical profile revision | 0.43.0 |
| Source assembly provenance | 0.45.0 |
| Documentation baseline | Public core, 22 October 2026; live Wiki/Pages acceptance follows in 2.0.1 |

These labels identify different objects. Retained fixture and schema filenames keep their original revisions for reproducibility. The OWL ontology metadata is documented in [Formalization](Formalization).

The stable ontology-core source is the private `product-ontology` tag `v2.0.0`, commit `beb0194b23d5794307742f9214d780e823ff829f`. The public repository has a separate history and selected scope; the [distribution manifest](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/distribution-manifest.json) records both source identity and file hashes. The earlier public candidate was based on source commit `e12c23ce04232a695116376435fe48d33d8b14c0`.

The canonical native model and logical profile preserve their exact SHA-256 digests. Generated references and execution receipts have their own hashes. The physical database is outside this core distribution.

The private source has a stable `v2.0.0` release. The [public Releases page](https://github.com/ArazSaieArasi3/OntoSPK/releases) records whether and when the public `v2.0.0` tag was published. Published tags and release payloads must not be silently replaced. Documentation-only improvements do not automatically create a new semantic model version.
