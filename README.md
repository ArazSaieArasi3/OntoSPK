# OntoSPK

OntoSPK is an ontology for modeling software product knowledge across planning, definition, requirements, experience, delivery, testing, marketing, evidence and realization. It distinguishes a continuing product from its versions, specifications, realizations and execution records.

The public repository is preparing the **2.0.0 ontology-core distribution**, derived from the stable private source release. It contains a conceptual model, a bounded OWL profile, graph constraints and competency-question fixtures. The public release has not yet been published; independent semantic review remains open.

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

Curated explanations are maintained in `docs/guide`. The Wiki snapshot is derived from those pages. The static portal in `docs` provides the generated logical reference, diagrams, downloads and WebVOWL. See [documentation publication status](docs/publication-status.json) before assuming that a live Wiki or Pages deployment exists.

The test populations are synthetic. Passing the documented finite controls does not establish complete UFO modal or causal adequacy, independent domain validation, external-owner acceptance or production readiness. The physical database and Explorer are separate work; neither is part of this ontology-core distribution.

## Version and rights

The distribution combines native model 0.41.0 and logical profile 0.43.0. Technical filenames retain the revisions of their schema or fixture contracts; those revisions are not alternative distribution versions. Semantic identifiers are preserved. See [source identity and release state](docs/guide/Versions.md).

No project-wide reuse licence has yet been selected. See [LICENSING.md](LICENSING.md) and [third-party notices](THIRD_PARTY_NOTICES.md).
