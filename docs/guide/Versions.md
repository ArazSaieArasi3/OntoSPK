# Versions and source identity

| Object | Current identity |
| --- | --- |
| Public distribution target | 2.0.0-rc.1 — unreleased candidate |
| Native conceptual model | 0.41.0 |
| Logical profile revision | 0.43.0 |
| Source assembly provenance | 0.45.0 |
| Documentation baseline | DB-2026.10.1 — candidate |

These labels identify different objects. Retained fixture and schema filenames keep their original revisions for reproducibility. The OWL ontology metadata is documented in [Formalization](Formalization.md).

The public package is a selected distribution from source commit `e12c23ce04232a695116376435fe48d33d8b14c0`; the [distribution manifest](../../distribution-manifest.json) records hashes and transformations. Public repository commits differ from development commits because the public package has a different history and scope.

Common semantic artifacts preserve exact bytes. Generated references, execution receipts and rebuilt database artifacts have their own hashes. Their byte identity is not assumed to equal earlier generated outputs.

No published GitHub Release is declared by this documentation baseline. Stable 2.0.0 requires a separate release decision. Published tags and release payloads must not be silently replaced. Documentation-only improvements do not automatically create a new semantic model version.
