# Citation and publication evidence handoff

This page is the repository handoff for manuscript author review. It identifies the public core, later evidence increments, reproducible results and outstanding scientific limits. Proposed manuscript wording below is a draft for the authors; no manuscript file is edited or correspondence sent by publishing this handoff.

## What to cite

Cite core v2.0.0 for the ontology model. Cite the exact evidence release when reporting its executed checks, and use that release's immutable tag/commit rather than a mutable branch or the current site route. The [release record](https://github.com/ArazSaieArasi3/OntoSPK/releases) determines actual publication state. A source-prepared release plan is not a published release.

No DOI has been assigned in the current repository metadata or release records reviewed for this handoff. The root [CITATION.cff](../../CITATION.cff) describes the core. Release-specific [v2.0.7 citation metadata](../releases/v2.0.7/CITATION.cff) identifies the documentation/diagram increment if that tag is actually published. No project-wide reuse licence has been selected; [rights and third-party notices](../../LICENSING.md) remain applicable. DOI registration (#29) requires an actual deposit service, rights/metadata review and a returned identifier; none is invented here.

## Release and evidence map

| Release | Published scope | Citation interpretation |
| --- | --- | --- |
| [v2.0.0](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.0) | Public native model and bounded OWL/SHACL core | The unchanged ontology-core identity; its Git tag resolves the model source. |
| [v2.0.1](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.1) | Wiki, versioned Pages, WIDOCO and WebVOWL | Documentation release, distinct from the frozen documentation source mapping and the ontology core. |
| [v2.0.2](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.2) | Expanded finite evaluation | Source-bound SHACL, HermiT, ROBOT and competency-question evidence. |
| [v2.0.3](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.3) | Accepted boundary-preservation evidence | Current reference-only use; no new external equivalence or private-repository publication. |
| [v2.0.4](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.4) | Bounded local identity/event review | Local review and tests with an explicitly retained Mode-profile decision. |
| [v2.0.5](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.5) | Separate editorial annotation view | Same logical axioms; 494 original ROBOT findings resolved and 318 retained. |
| [v2.0.6](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.6) | Executed bounded FOL pilot | Representative finite searches and independently checked certificates; no universal proof. |

The v2.0.7 increment packages the reviewed diagrams, complete Wiki-to-Pages coverage and this author-review handoff. Its preparation and the current site build do not alone establish publication: use the actual release record and its source-bound manifest before citing it as released. Earlier release tags, payloads, frozen documentation mappings and all 543 semantic files retain their identities.

## Executed results and limits

| Evidence | Recorded executed result | Limit that must accompany interpretation |
| --- | --- | --- |
| [Expanded finite evaluation](../../evaluation/v2.0.2-closeout.md) | All 1,977 SHACL component occurrences accounted for; 121 named OWL classes satisfiable; 71 HermiT scenarios; 56 CQ contracts with 374 exact-answer comparisons | Synthetic finite controls; overlapping denominators are not a semantic-correctness percentage. CQ mutation survivors remain disclosed. |
| [Metadata comparison](../../evaluation/robot-metadata-tests.md) | Annotated view preserves logical axioms and retains 318 default ROBOT findings: 34 ERROR, 211 WARN, 73 INFO | The default command still exits 1; the report is not clean and no reuse licence is selected. |
| [FOL pilot](../../evaluation/fol-pilot.md) | 1,784 native and 22 profile-family disagreement searches at sizes two/three; 19 scenarios, 11 SAT and 8 UNSAT; eight detected translation faults | Exact finite sizes, separate signatures, abstract datatypes and scoped admission joins; no unbounded OWL/UFO equivalence or modal/causal proof. |
| [Diagram review](../../evaluation/diagram-provenance.md) | 40 displayed classes and 59 relationships checked; six stale historical manifest fields disclosed; two source-derived domain views | Selected-view navigation is not native navigability; sparse domain view omits 275 associations; no recovered editable draw.io source or full-model figure is claimed. |
| [Reader coverage](../../evaluation/documentation-parity.md) | All fifteen accepted Wiki reader pages are compared with current Pages by content, headings and link destination; controlled regressions are detected | The deterministic CI audit covers the accepted source snapshot, not continuous live Wiki monitoring or scientific acceptance. |

The full [formal verification method](formal-verification.md) and [diagram explanation](diagram-provenance.md) are available within the site. Full native-profile conformity, independent domain/expert acceptance, external-owner equivalence and production readiness remain separate questions. The ProductCapability Mode-profile decision is [#48](https://github.com/ArazSaieArasi3/OntoSPK/issues/48). The present increment does not resolve it.

## Proposed manuscript wording for author review

The following is a proposed availability/evidence statement, not an automatic replacement in the manuscript:

> The OntoSPK ontology core and its versioned documentation and evaluation artifacts are publicly available in the project repository. The released evidence distinguishes native conceptual commitments, a bounded OWL profile, graph-validation contracts and a representative finite first-order verification pilot. Reported checks are tied to their exact sources and assumptions and do not establish complete semantic adequacy or independent expert acceptance.

For an IEEE-style reference to the core, the author can use:

> A. Saie Arasi, “OntoSPK: An Ontology for Software Product Knowledge,” ontology core, ver. 2.0.0, 2026. [Online]. Available: https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.0. Accessed: Oct. 24, 2026.

Use a separate exact evidence-release reference when citing specific executed results. Preserve the manuscript's existing author/affiliation style, page limit, figure selection and approved wording. Numeric implementation inventories on this handoff page do not authorize adding them to the manuscript.

## Remaining publication decisions

- Register a persistent identifier only after deposit eligibility, rights, exact archived version and actual service access are verified (#29).
- Review the specific native Mode-profile decision before stronger OntoUML/UFO conformity claims (#48).
- Keep boundary-contract changes and private sibling repositories deferred under the owner's existing instruction (#25–#27).
- Keep sourced concept pages deferred for their separate schema/scope discussion (#37).

This handoff is delivered through the public documentation and linked repository issue for author review. It does not send third-party messages or claim acceptance of the proposed manuscript statement.
