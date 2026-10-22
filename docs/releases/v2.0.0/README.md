# OntoSPK 2.0 ontology core

This page describes the public package being prepared from the stable ontology-core source. The public GitHub release is pending. Its semantic baseline consists of native model 0.41.0 and bounded logical profile 0.43.0. Existing native identifiers and ontology IRIs have not been renamed.

## Included

- The native conceptual model, class and relation catalogues, selected and full figures, and structural reference.
- The bounded OWL profile, declared SHACL shapes, formal description, competency-question contracts and synthetic fixtures.
- Reproducible finite checks and human-readable interpretation of their scope. The public source also contains executable validation harnesses, including finite SQL admission fixtures; these are testing aids, not an ontology-to-production-database release.
- Public guide, logical reference, comparison with related ontologies, citation metadata and notices for included third-party documentation components.

## Evidence and interpretation

The native structure contains 101 local conceptual classes, 27 external handles, 286 associations and 34 generalizations. The 892 structural expressions are source-to-reference comparisons, not independent logical proofs. The current bounded evaluation includes 374 exact-answer comparisons over 56 competency-question contracts, 13 HermiT outcomes and four targeted SHACL contrasts. Five reasoner populations and four SHACL populations are *intentionally invalid* and pass only when rejected for the expected reason. See [evaluation](../../guide/Quality.md) and [limitations](../../guide/Limitations.md).

The external handles identify conceptual boundaries. They do not establish imported-class equivalence, exact external IRIs or consent by the owners of other ontologies. Full modal/causal UFO semantics, expert acceptance, production deployment and browser acceptance of a separate application are not established by these finite controls.

The [external-reference register](../../guide/External-References.md) explains all 27 handles and the 17 preserved locators that use a private research namespace. The [publication-boundary review](publication-boundary-review.md) records the current candidate and historical inspection. The [release plan](../../development/release-plan.md) gives the finite work and exit criteria for the public increments.

## Separate work

Physical SQLite or PostgreSQL packages, an operational database, the separate Explorer application, industrial datasets and manuscript binaries are not part of the selected ontology core. Historical synthetic implementation material in earlier public commits remains part of Git history; this scope statement does not claim to erase that history.

## Release identity

The source release is private `product-ontology` `v2.0.0`, commit `beb0194b23d5794307742f9214d780e823ff829f`. Its original native-model SHA-256 is `b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed`; the logical profile SHA-256 is `153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12`. The public source tree has a different history and a separately recorded distribution manifest. The eventual public tag and downloads must be built and verified from the accepted public commit.

No project-wide reuse licence has been selected. [Licensing](../../../LICENSING.md) and [third-party notices](../../../THIRD_PARTY_NOTICES.md) define the current state. A DOI has not been assigned.
