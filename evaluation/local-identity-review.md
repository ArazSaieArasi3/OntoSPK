# Local identity, bearer and event review — issue #28

**The bounded local review is complete; scientific limits are retained.** All 37 existing local grounding questions have an explicit assessment. Two updated realization/capability commitments bring the review to 39 entries in ten decision groups. This is a review of existing authored choices, not independent domain acceptance or a full UFO conformance proof.

## Decisions and rationale

| Group | Existing interpretation retained | Limit |
| --- | --- | --- |
| LINEAGE — Product lineage and version baseline | Keep authored mandate/product lineage and an immutable approved version baseline as three distinct referents. Rename, ownership transfer and version succession do not by themselves create another Product. Version equality is a declared/canonical-identifier assumption in the transition policy; no content-based or OWL-key identity proof is inferred. | Semantic identity needs provenance and human/domain evidence; equality of record IDs is insufficient. |
| ARTIFACT — Authored specifications and records | Retain the current authored-artifact reading and each published constitutive purpose/baseline criterion. Plans, offerings and decision records are distinct from realized behavior, publication acts and physical file copies. Bundle and portfolio references alone do not prove real-world parthood. | These are existing scoped design choices, not independently validated universal identity criteria. |
| STAGE — Stage definitions and status assertions | Retain stage-definition artifacts and dated status-assertion records. Neither current class is a Product phase or an intrinsic quality merely because its label concerns a stage/status. | A real phase partition or quality model would require a separate versioned conceptual decision. |
| CONTEXT — Dependency and user-role specifications | Retain specifications of a dependency condition or participation purpose; do not turn their current instances into actual relators or anti-rigid user roles. | Actual participants, truthmakers and necessary dependence need evidence before a different ontological reading. |
| ABILITY — Intended ability, concrete realization and actual mode | Preserve the intended-ability specification, concrete configured realization and actual intrinsic disposition as distinct. A realization has one version and at least one actual capability; an actual capability has exactly one bearer. Continuity evidence governs reuse of realization/capability identifiers in the separate bounded policy. | Causal continuity and disposition persistence remain supplied evidence. The concrete Mode abstractness/profile discrepancy is tracked in #48; no strict profile conformance is claimed. |
| CONDITION — Constitutive condition facets | Retain rigid, authored facets under the published ConditionSpecification/RequirementSpecification identity providers. Desired, expected, required and acceptance content belongs to that authored baseline. A requirement statement is distinct from the actual behavior or the agent intention. | Content essentiality is a model assumption; the review does not impose new disjointness, coverage or modal axioms. |
| SCENARIO — Scenario and test-procedure artifacts | Retain authored scenario/procedure facets inheriting ScenarioSpecification identity. Repeating a TestCase is another TestExecution; a scenario description is distinct from an obtaining situation. | No identity inference from equal procedure text or from equal execution inputs is introduced. |
| REFERENCE — Identity of local reference records | Retain ExternalReferenceRecord inheritance and the constitutive local reference purpose. Distinguish reference-record identity from externally governed target identity. | Owner semantics, replacement concepts and new mappings remain deferred; existing boundary treatment is unchanged. |
| EVIDENCE — Outcome records and evidence attributions | Retain one consolidated result record for one concluded attempt and distinct evidence-attribution records. Later reporting time does not imply creation during the attempt. A physical carrier and its verification/validation assertions are distinct referents. | Record identity, real outcome truth and independent evidential acceptance are different questions. |
| EVENT — Attempt occurrence, participation and reporting | Retain the concluded real-attempt profile, including setup-only aborted attempts. Binding a target is not proof of actual participation; a code-exercised correspondence flag remains a qualified candidate. Equal inputs/timestamps do not identify events, and graph replay is not a newly observed occurrence. | Unknown end/planned runs are outside this admission profile, not absent from reality. No full UFO-B causality or new ROoST equivalence is asserted. |

## Question-by-question trace

| Native concept | Existing review question | Decision |
| --- | --- | --- |
| `IC:ProductPortfolio` | Does portfolio identity survive member changes, and do all Products participate uniformly? If heterogeneous PortfolioItems are parts, define their roles. | LINEAGE |
| `IC:Product` | Specify sameness across versions, offerings, ownership and deployment; separate product referent from Product Knowledge record if both occur. | LINEAGE |
| `IC:ProductVersion` | Choose independent version-record identity versus same Product changing intrinsic condition; define succession. | LINEAGE |
| `IC:OfferingSpecification` | Choose offer identity across audience/price/channel changes and show dependence on Product and market context. | ARTIFACT |
| `IC:BundleSpecification` | Identify homogeneous members or different functional roles; test whether same bundle survives member replacement. | ARTIFACT |
| `IC:LifecycleSpecification` | Identify whether instances are reusable models or actual histories of one Product. | ARTIFACT |
| `IC:VisionStatement` | Specify statement identity/version, author and product bearer; distinguish description from a future situation. | ARTIFACT |
| `IC:FeatureSpecification` | Clarify implemented functionality vs specification, independent identity, and real parthood in a Product. | ARTIFACT |
| `IC:VerticalSliceSpecification` | Specify slice identity and whether decomposedInto denotes product parthood, planned work or specification refinement. | ARTIFACT |
| `IC:UserStorySpecification` | Specify ID and version; preserve distinction from actual user action and Requirement. | ARTIFACT |
| `IC:PersonaSpecification` | Specify archetype artifact identity/evidence; actual human users would need a different type. | ARTIFACT |
| `IC:RoadmapEntry` | Define entry ID across target/schedule changes and distinguish from the actual target item. | ARTIFACT |
| `IC:ReleaseSpecification` | Choose package/snapshot, act of publishing, or record; specify release ID, temporal boundary and version relation. | ARTIFACT |
| `IC:LaunchSpecification` | Distinguish actual activity, campaign/plan and record; provide temporal identity and participants. | ARTIFACT |
| `IC:DecisionRecord` | Distinguish decision act from record; define record identity and change/version policy. | ARTIFACT |
| `IC:LifecycleStageSpecification` | For «Phase», identify the Product identity provider, intrinsic criterion and complete disjoint partition; otherwise model a stage category. | STAGE |
| `IC:ProductStatusRecord` | Specify bearer, value, changes and identity of status assignment; «Quality» requires characterization, «Phase» requires intrinsic partition. | STAGE |
| `IC:DependencySpecification` | Name all participants, truthmaker and existential dependence; «Relator» requires mediations to at least two individuals. | CONTEXT |
| `IC:UserRoleSpecification` | If «Role», model Person/user identity provider and necessary relational context; if definition, give artifact identity. | CONTEXT |
| `IC:CapabilitySpecification` | Identify concrete Product bearer and necessary dependence for «Mode»; if merely planned, model capability specification separately. | ABILITY |
| `IC:ProductRealization` | Updated concrete realization/mode identity commitment (ID03/ID04). | ABILITY |
| `IC:ProductCapability` | Updated concrete realization/mode identity commitment (ID03/ID04). | ABILITY |
| `IC:GoalSpecification` | Decide whether instance is a governed statement with its own ID or an intention borne by an agent; trace targets to Outcome. | CONDITION |
| `IC:OutcomeSpecification` | Separate expected target from actual observation/event and specify outcome identity across measures. | CONDITION |
| `IC:RequirementSpecification` | Ground persistent requirement identity across edits and copies; distinguish normative statement from required behavior. | CONDITION |
| `IC:FunctionalRequirementSpecification` | First establish Requirement's identity provider; justify that functional classification is rigid; decide overlap with QualityRequirement. | CONDITION |
| `IC:QualityRequirementSpecification` | First establish same identity provider and rigid classification; decide overlap/completeness of the two categories. | CONDITION |
| `IC:AcceptanceCriterionSpecification` | Specify criterion ID, owner and scope; separate statement from observed satisfaction. | CONDITION |
| `IC:RequirementScenarioSpecification` | Identify scenario across changes and distinguish from TestScenario and enacted behavior. | SCENARIO |
| `IC:TestScenario` | Define scenario ID and ensure it is a specification rather than an occurring situation. | SCENARIO |
| `IC:TestCase` | Define test-case identity and revision semantics; separate its executions. | SCENARIO |
| `IC:ProductFamilyReference` | Define reference identity, external target IRI, source/version and whether reference can change target. | REFERENCE |
| `IC:ProductLineReference` | Define local reference identity and external ProductLine target/source/version. | REFERENCE |
| `IC:ProductVariantReference` | Define local reference identity and ProductVariant target/configuration version. | REFERENCE |
| `IC:ProductMetricReference` | Define local reference identity and external Metric ownership; distinguish metric definition from measured value. | REFERENCE |
| `IC:TestResult` | Set result-record identity/provenance and distinguish observed outcome/value from the recording artifact. | EVIDENCE |
| `IC:VerificationEvidenceRecord` | Determine evidence identity and whether verification is essential or a contextual use; if «Role», add identity provider and dependency. | EVIDENCE |
| `IC:ValidationEvidenceRecord` | Determine evidence identity and whether the same record may support both validation and verification. | EVIDENCE |
| `IC:TestExecution` | Represent occurrence, participants, time and TestCase specification using an event-capable native model; determine tooling coverage. | EVENT |

## One concrete native-profile discrepancy

The frozen ProductCapability is a concrete `mode` (`isAbstract=false`). The inspected OntoUML Mode page displays `Abstract=True`. Its characterization and one-bearer requirements are compatible with the current native relation, but that does not remove the abstractness discrepancy. Preserve the released instances/profile and withhold a strict full-reference-profile conformance claim. [Issue #48](https://github.com/ArazSaieArasi3/OntoSPK/issues/48) tracks the exact profile choice and migration assessment. A blind flag toggle is not a justified semantic repair.

## Executed evidence and scope

The [focused executable tests](local-identity-tests.md) record the finite identity-transition grid, replay of retained cases, bounded native taxonomy/bearer checks, legacy ledger controls and occurrence/history contrasts. They test supplied declarations and finite data. The existing HermiT/SHACL/CQ suite is rerun separately by CI; no theorem about arbitrary worlds, empirical continuity, or full causal adequacy is inferred.

The transition policy remains separate from combined occurrence admission. An IRI used as evidence is not evidence truth. A documented direct-DML limit of the retained legacy ledger is kept visible, not repaired in the frozen source. These limits are not hidden inside pass percentages.

All 543 semantic files and all 27 boundaries remain frozen, verified by the [preservation gate](market-boundary-preservation.md). Private repositories, external rewiring and new ROoST alignment remain deferred. This review introduces no axioms, identifiers, stereotypes or model migration. It can be published as documentation/evidence patch v2.0.4; v2.1.0 remains conditional on a later accepted semantic change.

## Primary comparison sources

- [S1] [https://ontouml.readthedocs.io/en/latest/classes/sortals/kind/index.html](https://ontouml.readthedocs.io/en/latest/classes/sortals/kind/index.html) — observed 2026-10-24; Identity-provider and rigid-type structural comparison; not an imported ontology.
- [S2] [https://ontouml.readthedocs.io/en/latest/classes/aspects/mode/index.html](https://ontouml.readthedocs.io/en/latest/classes/aspects/mode/index.html) — observed 2026-10-24; Bearer dependence/characterization and the displayed Abstract=True profile discrepancy.
- [S3] [https://ontouml.readthedocs.io/en/latest/relationships/characterization/index.html](https://ontouml.readthedocs.io/en/latest/relationships/characterization/index.html) — observed 2026-10-24; Bearer/feature direction and multiplicity comparison.
- [S4] [https://nemo-ufes.github.io/gufo/](https://nemo-ufes.github.io/gufo/) — observed 2026-10-24; Conceptual comparison of objects, intrinsic modes, events and participation. No gUFO import or full UFO-B claim.

These sources support conceptual/structural comparison only. gUFO distinguishes endurants, intrinsic modes and events and provides explicit participation relations with bounded UFO-B support. No gUFO import, exact equivalentClass mapping or new foundational profile is asserted.

[Exact source hashes and all 39 assessments](local-identity-review.json) · [Executable tests](local-identity-tests.md)

Reproduce: `python tools/publication/build_local_identity_review.py` followed by `python tools/publication/test_local_identity_review.py`.
