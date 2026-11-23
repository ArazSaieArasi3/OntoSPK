# Conceptual distinctions in OntoSPK

Suppose a team asks, “Did the version we shipped meet this requirement?” The requirement gives the team a criterion. The version identifies an approved baseline. To interpret a test result, the team still needs to know which configured system was examined, what attempt took place and what the result records. OntoSPK keeps these links explicit. A reader can then follow a claim back to its evidence and see where the information runs out.

## Finding the right concept

Each row starts with a choice a modeler might face. The examples illustrate how to read the model. The linked catalogue entries give the definitions and identity criteria for the terms used.

| Domain | Modeling question | How to represent it |
| --- | --- | --- |
| Product Portfolio | A product appears in two portfolios. Are there two products? | Each portfolio can have its own [entry](../../semantic/product/v2/reference/classes.md#portfolioentry) referring to the same [product](../../semantic/product/v2/reference/classes.md#product). Moving an entry changes the portfolio description. |
| Product Strategy | A team adopts a goal of reducing search time. Has search become faster? | A [goal specification](../../semantic/product/v2/reference/classes.md#goalspecification) records the desired condition. An assessment of change needs observations and a basis for comparison. |
| Product Definition | The specification says that the product can filter results. Which build can actually do this? | Record the intended ability in a [capability specification](../../semantic/product/v2/reference/classes.md#capabilityspecification). Attribute an actual capability to the configured realization that bears it. |
| Product Requirement | “Display the source identifier” appears in a requirements document. What would count as satisfying it? | Use a [functional requirement](../../semantic/product/v2/reference/classes.md#functionalrequirementspecification) for the required behavior and an [acceptance criterion](../../semantic/product/v2/reference/classes.md#acceptancecriterionspecification) for the condition used to judge it. A result records what happened on a particular attempt. |
| Product Experience | A journey shows a user opening a detail view. Did anyone follow that path? | A [journey specification](../../semantic/product/v2/reference/classes.md#journeyspecification) describes the intended experience. A [usability finding](../../semantic/product/v2/reference/classes.md#usabilityfindingrecord) can record a finding from an assessment. |
| Product Roadmap | A feature has a target window. Was it delivered in that window? | Keep the [roadmap entry](../../semantic/product/v2/reference/classes.md#roadmapentry) and [target window assignment](../../semantic/product/v2/reference/classes.md#targetwindowassignment) as planning information. Look for delivery records to answer the historical question. |
| Product Delivery | A release specification lists a change. When was its delivery status reported? | A [release specification](../../semantic/product/v2/reference/classes.md#releasespecification) states the intended release. A [delivery status record](../../semantic/product/v2/reference/classes.md#deliverystatusrecord) gives the dated status assertion. |
| Product Test | The same case is run twice against the same installation. How many attempts took place? | Keep one [test case](../../semantic/product/v2/reference/classes.md#testcase) and two [executions](../../semantic/product/v2/reference/classes.md#testexecution). In this profile each concluded attempt has its own consolidated result. |
| Product Marketing | A launch plan names a segment. Does that establish adoption by that segment? | A [launch specification](../../semantic/product/v2/reference/classes.md#launchspecification) describes the plan. An [adoption hypothesis](../../semantic/product/v2/reference/classes.md#adoptionhypothesisspecification) expresses an expectation whose assessment needs evidence. |
| Product Evidence | A report is cited in support of a verification claim. What does the link establish? | A [verification evidence record](../../semantic/product/v2/reference/classes.md#verificationevidencerecord) records the attribution and its purpose. The adequacy of the cited material remains a matter for assessment. |
| Product Realization | Two installations use the same version. Which one had the tested ability? | Identify the [realization](../../semantic/product/v2/reference/classes.md#productrealization) that was examined. Each actual [capability](../../semantic/product/v2/reference/classes.md#productcapability) has a particular bearer. |
| Product Reference | An application displays an identifier assigned by an external source. Who defines its meaning? | An [external reference record](../../semantic/product/v2/reference/classes.md#externalreferencerecord) preserves the binding, purpose and provenance. The external authority governs the referent. |

## Reading a trace in the Pharmaceutical Ecosystem Explorer

The Explorer case in the OntoSPK paper (Section V.E and Table VI) reports two connected requirements: to display pharmaceutical product information and to retain a reference to its source. A retained openFDA extract supplied the historical source records. A source identifier in the display refers to the externally described item. The software build identifies the implementation presenting that information. Those identifiers answer different questions, even when they appear in the same screen or report.

The paper reports that SQL and SPARQL returned matching tuples for the implemented mappings. A reader can use that result to assess agreement between those two representations for the tested data. Establishing a manufacturer's role would require evidence of the relevant activity. A manufacturer name in a source row supplies a source observation.

For an **illustrative extension**, suppose a tester opens the same detail view on two installations of one version. Record which installation each attempt examined, including an attempt that stopped during setup. Associate each consolidated result with its own attempt. A later reader can now ask which installation was exercised and whether the source identifier appeared. These two installation runs are an example of how to extend the trace, separate from the observations reported for the Explorer.

## Following a realization across a change

A product can continue through several versions. In the native model a realization is a concrete configured whole bound to one version. A transition record supplies the operation, before/after identifiers, version bindings, branching status and declarations about system and capability continuity. The executable check asks whether these entries agree. An evidence reference identifies the declaration being used. Assessing the truth of its account requires evidence from the deployment itself.

For a restart on an unchanged version without branching, let *b* and *a* be the recorded realization identifiers before and after the restart. When the supplied system-continuity assessment is **preserved**, the record must satisfy **b = a**. When it is **broken**, the record must satisfy **b ≠ a**. When it is **unknown**, the realization decision goes to review. Capability continuity is a further question for a continuing realization.

| Recorded transition | Expected reading in this profile |
| --- | --- |
| Restart or migration, same version, no branch, system and disposition both declared preserved | Reuse both identifiers. A different realization identifier contradicts the supplied account. |
| Same restart, but the disposition was recreated | Reuse the realization identifier and assign a distinct capability identifier. |
| Migration with a branch or a break in system continuity | Use a distinct realization and capability. |
| Upgrade or rollback with a change of version | Record a successor realization. The governed product can continue. A restart record that also changes the version is rejected as an inconsistent operation description. |
| Independent clone or reconstruction | Use distinct realization and capability identifiers, even when the version is shared. |
| Same version, no branch, system continuity unknown on restart | Refer for review. An identical identifier alone cannot settle the question. |

The [decision function](../../semantic/product/v2/source/validation_v041/inputs/identity_policy.py) and [worked inputs](../../semantic/product/v2/source/validation_v041/inputs/identity_transition_cases.json) show the accepted, rejected and review outcomes. The [test report](../../evaluation/local-identity-tests.md) covers **864 combinations across six operations**, plus 25 retained cases. These are checks on supplied declarations. The transition check runs separately from combined occurrence admission.

## When two records concern an event

A test case can be used repeatedly. A concluded attempt has a target, a case, a context and a consolidated result. Two distinct attempts can use the same case and target and even have the same recorded timestamp. Conversely, submitting the same accepted record twice adds no evidence of a second attempt. A report may be written after the attempt ends.

The occurrence profile requires one observed end. If the start is known, one start is recorded and it must be at or before the end. If the start is unknown, the start field is left empty and its status is recorded. A setup-only aborted attempt can have a result even though the code under test was never exercised. A later observation can supplement the history while preserving the accepted snapshot. These checks concern concluded test attempts. The profile leaves the general UFO question of causal continuity and the identity of arbitrary events open. See the [event and history commitments](../../semantic/product/v2/reference/commitments.md) and [occurrence controls](../../evaluation/local-identity-tests.md).

## Reading “exactly one bearer”

Every actual product capability has exactly one product realization as its bearer. Logical consistency and explicit documentation answer different questions. For a graph containing an identified product capability, the examples below assume the applicable shape is run on the supplied graph without merging names.

| Supplied bearer data for one capability | OWL interpretation of this constraint | Explicit SHACL check |
| --- | --- | --- |
| No bearer name | Consistent with the existence of an unnamed bearer. | Fails the minimum count. |
| Two bearer names, with no assertion or inference that they differ | Both names may denote one individual. | Two distinct RDF terms fail the maximum count. |
| Two bearers asserted or inferred to be different | Inconsistent with exactly one bearer. | The two explicit values also fail the maximum count. |

The [formal results](../../evaluation/results/formal.json) include the HermiT cases and the finite-graph contrasts. The SQL projection checks the bindings available to its declared admission routines. Its historical application ledger has a documented limitation for direct deletion and reinsertion. A reader assessing a particular guarantee should consult the [matrix of commitments](../../semantic/product/v2/reference/commitments.md) for the enforcing mechanism and the [identity review](../../evaluation/local-identity-review.md) for the assumptions behind it.
