# OntoSPK

<!-- current-status:start -->

## Current documentation and evidence

The consolidated documentation/evidence increment is **v2.0.8**, over unchanged ontology core **v2.0.0**. It includes PC-01, corrected native-ID term search, reviewed diagrams and current metadata/DOI accounting. [GitHub Releases](https://github.com/ArazSaieArasi3/OntoSPK/releases) is the authority for actual release publication; the [deployment manifest](https://arazsaiearasi3.github.io/OntoSPK/publication-manifest.json) identifies the live current source. Increment identity alone does not assert that a tag or DOI has been published.

[Current status and remaining work](https://arazsaiearasi3.github.io/OntoSPK/current/status/index.html) · [PC-01 decision](evaluation/capability-profile-review.md) · [FOL method](docs/handbook/formal-verification.md) · [Diagrams](docs/handbook/diagram-provenance.md) · [Residual ROBOT findings](evaluation/metadata-residual-review.md)

<!-- current-status:end -->

OntoSPK is an ontology for modeling software product knowledge across planning, definition, requirements, experience, delivery, testing, marketing, evidence and realization. It distinguishes a continuing product from its versions, specifications, realizations and execution records.

The **2.0.0 ontology-core distribution** is derived from the stable private source release. It contains a conceptual model, a bounded OWL profile, graph constraints and competency-question fixtures. Check [GitHub Releases](https://github.com/ArazSaieArasi3/OntoSPK/releases) for the public release record; independent semantic review remains open.

## Start here

- [Overview and scope](docs/guide/Overview.md)
- [Domains and conceptual model](docs/guide/Domains.md)
- [Formalization and logical semantics](docs/guide/Formalization.md)
- [Complete conceptual reference](semantic/product/v2/reference/README.md)
- [Evaluation and reasoning results](docs/guide/Quality.md)
- [Reproduce the checks](docs/guide/Reproduce.md)
- [Core release scope and evidence](docs/releases/v2.0.0/README.md)
- [External references and ownership boundaries](docs/guide/External-References.md)
- [Release plan and work register](docs/development/release-plan.md)
- [Related ontologies](docs/research/related-ontologies/related-ontology-comparison.md)
- [Versions and source identity](docs/guide/Versions.md)
- [Citation and reuse](docs/guide/Citation.md)

## Model at a glance

| Inventory | Count |
| --- | ---: |
| Local domains | 12 |
| Local conceptual classes | 101 |
| External conceptual handles | 27 |
| Native associations | 286 |
| Generalizations | 34 |
| Structural expressions | 892 |
| Scoped commitments | 22 |

Conceptual classes, named OWL classes and physical SQL tables are different inventories. Their counting methods and boundaries are described in the reference and evaluation pages.

## Documentation and examples

Read the curated guide in the [GitHub Wiki](https://github.com/ArazSaieArasi3/OntoSPK/wiki). It is maintained in `docs/guide` and projected into `wiki-src`; the [publication receipt](evaluation/wiki-publication-verification.md) records the accepted live snapshot. The [published Pages portal](https://arazsaiearasi3.github.io/OntoSPK/) connects the full guide, conceptual catalogue, first-order specification, evaluation reports, WIDOCO reference, term search and downloads. Use [frozen documentation v2.0.1](https://arazsaiearasi3.github.io/OntoSPK/releases/v2.0.1/index.html) for citation or the explicitly mutable [current route](https://arazsaiearasi3.github.io/OntoSPK/current/index.html) for ongoing documentation. The [WebVOWL explorer](https://arazsaiearasi3.github.io/OntoSPK/releases/v2.0.1/explore/index.html) discloses its ten omitted properties and display filters. Documentation v2.0.1 describes ontology core v2.0.0; their versions have distinct meanings. The [Pages and viewer verification receipt](evaluation/pages-publication-verification.md) records live acceptance. See [documentation publication status](docs/publication-status.json) for the separate publication states.

The test populations are synthetic. Passing the documented finite controls does not establish complete UFO modal or causal adequacy, independent domain validation, external-owner acceptance or production readiness. The physical database and Explorer are separate work; neither is part of this ontology-core distribution.

The [expanded finite evaluation v2.0.2](evaluation/v2.0.2-closeout.md) accounts for all 1,977 SHACL component occurrences, checks satisfiability of 121 named OWL classes, executes 71 HermiT scenarios, and replays all 56 CQ contracts. The [current evaluation portal](https://arazsaiearasi3.github.io/OntoSPK/current/evaluation/index.html) connects its reports. The [default ROBOT report](evaluation/robot-report.md) retains 812 editorial/metadata findings, including 288 ERROR; it is not claimed clean. [GitHub Releases](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.2) records publication of this evaluation increment, separately from the frozen ontology core and documentation v2.0.1.

## Version and rights

The [bounded local identity/event review](evaluation/local-identity-review.md) assesses all 37 existing local grounding questions and two updated realization/capability commitments. Its [focused executable evidence](evaluation/local-identity-tests.md) covers 864 declared transition combinations, 25 retained cases, 48 identifier-renaming controls, native taxonomy and occurrence/history contrasts. The concrete Mode profile choice is adopted in [PC-01](evaluation/capability-profile-review.md), closing [#48](https://github.com/ArazSaieArasi3/OntoSPK/issues/48); full native-profile or independent scientific acceptance is not claimed. [v2.0.4 release notes](docs/releases/v2.0.4/RELEASE_NOTES.md) define the documentation/evidence patch over unchanged core v2.0.0.

The [ROBOT metadata source review](evaluation/robot-metadata-review.md) accounts for all 812 baseline findings. A separately versioned [v2.0.5 annotated view](docs/downloads/OntoSPK-v2.0.5-annotated.ttl) resolves 494 and retains 318 findings (34 ERROR, 211 WARN, 73 INFO); the [executed comparison](evaluation/robot-metadata-tests.md) preserves default exit 1 and verifies unchanged logical axioms, all owner-held boundary assertions, 121 satisfiable classes and 374 exact CQ answers. This is not a clean default report or a project licence choice. [Release notes](docs/releases/v2.0.5/RELEASE_NOTES.md) define the distinct editorial artifact; frozen core files and WIDOCO input remain unchanged.


The [Market preservation receipt](evaluation/market-boundary-preservation.md) records the owner's acceptance of existing reference-only use: four named Market handles, 13 native uses, all 27 boundary elements and all 543 semantic files remain unchanged. Publication of sibling private repositories and new cross-ontology wiring are deferred. [v2.0.3 release notes](docs/releases/v2.0.3/RELEASE_NOTES.md) define this documentation/evidence patch; the [release record](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.3) records its publication state.

The [Business boundary review](evaluation/business-boundary-review.md) decides the five local reference-only contracts and traces all eight native relations. A [separate reference-record adapter](tools/boundaries/business_reference.py) implements the reviewed policy, with [executable acceptance evidence](evaluation/business-boundary-tests.md). Business Service retains its stable handle; BusinessService remains an owner rename candidate. No external equivalence or new semantic release is asserted.

The distribution combines native model 0.41.0 and logical profile 0.43.0. Technical filenames retain the revisions of their schema or fixture contracts; those revisions are not alternative distribution versions. Semantic identifiers are preserved. See [source identity and release state](docs/guide/Versions.md).

No project-wide reuse licence has yet been selected. See [LICENSING.md](LICENSING.md) and [third-party notices](THIRD_PARTY_NOTICES.md).
