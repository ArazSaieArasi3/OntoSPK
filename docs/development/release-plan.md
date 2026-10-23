# Release plan and work register

This register records the accepted work sequence. GitHub issues hold the current execution state and acceptance evidence. A planned release is not a published release; the [release list](https://github.com/ArazSaieArasi3/OntoSPK/releases) records publication.

## Release policy

Each release has a finite scope and its own acceptance criteria. Publish a completed increment without waiting for unrelated future research. Retain frozen versioned sources and checksums. Documentation and test changes may use a patch release when the native and logical semantics are unchanged. Accepted semantic changes require an explicitly versioned model and migration explanation. Recheck dependencies and observed evidence before tagging; do not count issue creation as implementation progress.

| Release | Scope | Exit |
| --- | --- | --- |
| v2.0.0 | Public ontology core | Frozen native and bounded logical identity; explicit publication boundary, rights state and external-reference caveats; verified finite evidence; accepted migration and release assets. |
| v2.0.1 | Published documentation | Curated Wiki followed by versioned Pages, exhaustive generated reference, diagrams/downloads and a browser-verified WebVOWL view. Native and logical semantics remain those of v2.0.0. |
| v2.0.2 | Expanded finite evaluation | Inventory-derived SHACL/HermiT/ROBOT/CQ coverage, controlled adverse cases, readable findings and reproducible evidence. A semantic defect requiring a model change must use a suitable semantic release instead of silently changing this patch. |
| v2.0.3 | Boundary preservation and public evidence | Owner-accepted current reference-only use; four named Market handles and 13 uses traced; all 27 boundaries and 543 semantic files preserved; reproducible controls and a source-bound release package. No private-repository publication or new wiring. |
| v2.1.0 | Accepted semantic revisions | Only changes justified by resolved external contracts or scientific identity/event review. This release is conditional on actual accepted model changes and does not block the preceding patches. |

The execution order is the public core release, Wiki, Pages/WebVOWL, expanded evaluation, and the bounded v2.0.3 preservation patch. The owner decision of 23 October 2026 accepts all current boundary treatments for present OntoSPK use and defers private-repository publication, replacement concepts and cross-ontology rewiring. This supersedes the earlier self-contained-localization proposal for the current increment. It does not establish external semantic equivalence. Any future accepted native/logical change is explicitly versioned and does not alter frozen v2.0.0.

## v2.0.0

| Work item | Depends on |
| --- | --- |
| [#2: Audit the publication boundary of the ontology-core package](https://github.com/ArazSaieArasi3/OntoSPK/issues/2) | None |
| [#3: Document the status of all 27 external boundary references](https://github.com/ArazSaieArasi3/OntoSPK/issues/3) | #2 |
| [#4: Verify licensing and third-party publication notices](https://github.com/ArazSaieArasi3/OntoSPK/issues/4) | #2 |
| [#5: Reconcile final candidate hashes and execution evidence](https://github.com/ArazSaieArasi3/OntoSPK/issues/5) | #3, #4 |
| [#6: Complete the ontology-core migration pull request](https://github.com/ArazSaieArasi3/OntoSPK/issues/6) | #5 |
| [#7: Publish and verify the public v2.0.0 core release](https://github.com/ArazSaieArasi3/OntoSPK/issues/7) | #6 |

## v2.0.1

| Work item | Depends on |
| --- | --- |
| [#8: Prepare the curated ontology Wiki guide](https://github.com/ArazSaieArasi3/OntoSPK/issues/8) | #7 |
| [#9: Publish the Wiki and verify its navigation](https://github.com/ArazSaieArasi3/OntoSPK/issues/9) | #8 |
| [#10: Publish versioned documentation routes on GitHub Pages](https://github.com/ArazSaieArasi3/OntoSPK/issues/10) | #9 |
| [#11: Publish WebVOWL for the released logical profile](https://github.com/ArazSaieArasi3/OntoSPK/issues/11) | #10 |
| [#12: Verify published documentation and release v2.0.1](https://github.com/ArazSaieArasi3/OntoSPK/issues/12) | #11 |

The [Pages and viewer acceptance receipt](../../evaluation/pages-publication-verification.md) records the live documentation increment. The frozen documentation source and ontology core identity are distinct from the mutable current route. The release list remains the authority for the public v2.0.1 tag.

## v2.0.2

The [finite evaluation closeout](../../evaluation/v2.0.2-closeout.md) records the implementation and executed evidence for #16–#22. Its source-bound execution index accounts for all 1,977 SHACL component occurrences; default ROBOT editorial findings and no-inference CQ mutation survivors remain explicit. Publication is recorded by the public v2.0.2 release and its successful workflow, not by this plan.

| Work item | Depends on |
| --- | --- |
| [#13: Define the finite coverage register for comprehensive evaluation](https://github.com/ArazSaieArasi3/OntoSPK/issues/13) | #7 |
| [#14: Inventory and validate the active SHACL shapes graphs](https://github.com/ArazSaieArasi3/OntoSPK/issues/14) | #13 |
| [#15: Test SHACL cardinality and value constraints](https://github.com/ArazSaieArasi3/OntoSPK/issues/15) | #14 |
| [#16: Test SHACL paths and cross-record constraints](https://github.com/ArazSaieArasi3/OntoSPK/issues/16) | #15 |
| [#17: Verify OWL profile, consistency and named-class satisfiability](https://github.com/ArazSaieArasi3/OntoSPK/issues/17) | #13 |
| [#18: Extend HermiT scenarios for declared logical commitments](https://github.com/ArazSaieArasi3/OntoSPK/issues/18) | #17 |
| [#19: Test open-world, equality and inference assumptions](https://github.com/ArazSaieArasi3/OntoSPK/issues/19) | #17 |
| [#20: Record reproducible ROBOT and reasoner execution reports](https://github.com/ArazSaieArasi3/OntoSPK/issues/20) | #17 |
| [#21: Replay competency contracts and measure defect detection](https://github.com/ArazSaieArasi3/OntoSPK/issues/21) | #13 |
| [#22: Adjudicate coverage findings and publish the evaluation increment](https://github.com/ArazSaieArasi3/OntoSPK/issues/22) | #16, #18, #19, #20, #21 |

## v2.0.3

The [Market preservation receipt](../../evaluation/market-boundary-preservation.md) completes the owner-directed current-use disposition in #24. Its earlier external owner-alignment/localization criteria are superseded for this increment, not reported as executed. No external/private repository is accessed or modified by this work. The patch includes the accepted #23 Business evidence, 90 preservation adverse controls and four disclosed frozen-runtime observations. [Release notes](../releases/v2.0.3/RELEASE_NOTES.md) define the finite scope. Publication requires successful main documentation and expanded evaluation CI plus an exact source-bound archive/manifest; the release list records actual publication.

## v2.1.0

The [Business contract decision](../../evaluation/business-boundary-review.md) resolves #23 as five local reference-only policies, with all eight existing native uses traced and a [tested separate record adapter](../../evaluation/business-boundary-tests.md). The current Market disposition is recorded under v2.0.3. The frozen core is unchanged; v2.1.0 remains conditional on later accepted semantic changes. Owner-definition compatibility remains unasserted. #25–#27 external contract changes and owner-repository work are deferred by owner direction and are not release blockers for the patch. The next active scientific task is #28 restricted to OntoSPK-local identity/event/bearer questions; its external alignment portion remains deferred.

| Work item | Depends on |
| --- | --- |
| [#23: Resolve the Business external-reference contract](https://github.com/ArazSaieArasi3/OntoSPK/issues/23) | #3 |
| [#24: Resolve the Market external-reference contract](https://github.com/ArazSaieArasi3/OntoSPK/issues/24) | #3 |
| [#25: Resolve the ProductLine external-reference contract](https://github.com/ArazSaieArasi3/OntoSPK/issues/25) | #3 |
| [#26: Resolve the Architecture external-reference contract](https://github.com/ArazSaieArasi3/OntoSPK/issues/26) | #3 |
| [#27: Decide unresolved and composite external boundary handles](https://github.com/ArazSaieArasi3/OntoSPK/issues/27) | #3 |
| [#28: Review identity, events and external boundaries in UFO/OntoUML](https://github.com/ArazSaieArasi3/OntoSPK/issues/28) | #13 |

## Deferred follow-ups

| Work item | Depends on |
| --- | --- |
| [#29: Register a persistent identifier after a public release exists](https://github.com/ArazSaieArasi3/OntoSPK/issues/29) | #7 |
| [#30: Verify the publication-facing citation and evidence handoff](https://github.com/ArazSaieArasi3/OntoSPK/issues/30) | #7 |
| [#31: Pilot verification of the first-order formal specification](https://github.com/ArazSaieArasi3/OntoSPK/issues/31) | #13 |
| [#32: Verify diagram provenance and domain relationship views](https://github.com/ArazSaieArasi3/OntoSPK/issues/32) | #7 |
| [#37: Plan a sourced concept page for each OntoSPK concept](https://github.com/ArazSaieArasi3/OntoSPK/issues/37) | Deferred design discussion with the repository owner |

## Publication boundaries

The public core excludes industrial or personal datasets, manuscript binaries, private correspondence, physical database releases and an operational Explorer application. Public examples are explicitly synthetic. Separately governed source references are evidence locators with disclosed accessibility and alignment limits; they are not imports or accepted equivalence assertions.

## Continuing work

Use the linked issues to resume work and record results. Do not mark an item complete solely because source files, a plan or a historical report exist. Attach the accepted public commit, execution/readback evidence and remaining limitations. Cross-repository closeout is recorded by the respective maintainers without copying restricted source discussions into this repository.
