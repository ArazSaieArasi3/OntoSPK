# Native first-order specification

This reference is generated directly from the pinned native model. Every row instantiates the formulas below. Full expansions are in [native-structure.p](native-structure.p); identifiers and arities are in [symbols.json](symbols.json).

## Notation

For each row `(A,R,B,m,n)`, assert:

```text
forall X,Y: R(X,Y) -> (A(X) and B(Y))
forall X: A(X) -> bound(m, Y: R(X,Y))
forall X: B(X) -> bound(n, Y: R(Y,X))
```

Here `m` counts targets per source and `n` counts sources per target. The bound macros expand to ordinary FOL with equality:

```text
bound(0..*, Y: P(Y)) := true
bound(1..*, Y: P(Y)) := exists Y: P(Y)
bound(0..1, Y: P(Y)) := forall Y,Z: (P(Y) and P(Z)) -> Y=Z
bound(1, Y: P(Y)) := exists Y: P(Y) and forall Z: P(Z) -> Z=Y
```

The JSON and TPTP expansions fix parentheses and scope explicitly. This is a finite axiom schema, not quantification over predicates. A class may be empty. The theory has no unique-name assumption and adds no global existence axiom. Unbounded multiplicities add no finite upper bound.

## Class signature

| Native identifier | Name | Domain | Stereotype | Predicate |
|---|---|---|---|---|
| EXT:Architecture:ArchitectureElement | ArchitectureElement | External boundary | not assigned | n_architectureelement_e6c278b3 |
| EXT:Architecture:Component | Component | External boundary | not assigned | n_component_ffb2c8c2 |
| EXT:Architecture:Interface | Interface | External boundary | not assigned | n_interface_9cd68719 |
| EXT:Architecture:Service | Service | External boundary | not assigned | n_service_40a44f0f |
| EXT:Business:BusinessCapability | BusinessCapability | External boundary | not assigned | n_businesscapability_0e01daa7 |
| EXT:Business:BusinessGoal | BusinessGoal | External boundary | not assigned | n_businessgoal_fd321d79 |
| EXT:Business:BusinessRule | BusinessRule | External boundary | not assigned | n_businessrule_66a93a3e |
| EXT:Business:Service | Business Service | External boundary | not assigned | n_service_14dc588b |
| EXT:Business:ValueProposition | ValueProposition | External boundary | not assigned | n_valueproposition_dd391b92 |
| EXT:EvidenceLayer:Evidence | Evidence | External boundary | not assigned | n_evidence_d9b64bff |
| EXT:ExternalUnresolved:Configuration | Configuration | External boundary | not assigned | n_configuration_6940ac17 |
| EXT:ExternalUnresolved:Evidence | Evidence | External boundary | not assigned | n_evidence_28f83376 |
| EXT:ExternalUnresolved:Test_Plan | Test Plan | External boundary | not assigned | n_test_plan_248db48a |
| EXT:ExternalUnresolved:Test_Script | Test Script | External boundary | not assigned | n_test_script_493721b6 |
| EXT:Market:Competitor_Alternative | Competitive Referent | External boundary | not assigned | n_competitor_alternative_bd6168ff |
| EXT:Market:CustomerSegment | CustomerSegment | External boundary | not assigned | n_customersegment_e1604cb2 |
| EXT:Market:Market | Market | External boundary | not assigned | n_market_88e504ed |
| EXT:Market:MarketInsight | MarketInsight | External boundary | not assigned | n_marketinsight_f2895c73 |
| EXT:Market:MarketSegment | MarketSegment | External boundary | not assigned | n_marketsegment_a587efab |
| EXT:Market:Need | Need | External boundary | not assigned | n_need_1c876b64 |
| EXT:Market:Pain | Pain | External boundary | not assigned | n_pain_e65105e8 |
| EXT:ProductLine:ProductConfiguration | ProductConfiguration | External boundary | not assigned | n_productconfiguration_4ca6b5f5 |
| EXT:ProductLine:ProductFamily | ProductFamily | External boundary | not assigned | n_productfamily_88b0b1dc |
| EXT:ProductLine:ProductLine | ProductLine | External boundary | not assigned | n_productline_3dc98e6a |
| EXT:ProductLine:ProductVariant | ProductVariant | External boundary | not assigned | n_productvariant_bf90ec75 |
| EXT:ProductManagement:Metric | Metric | External boundary | not assigned | n_metric_72cad409 |
| EXT:UXResearch:User_Mental_Model | User Mental Model | External boundary | not assigned | n_user_mental_model_fd96909e |
| IC:AcceptanceCriterionSpecification | AcceptanceCriterionSpecification | Product Requirement | subkind | n_acceptancecriterionspecification_b210a672 |
| IC:AcquisitionHypothesisSpecification | AcquisitionHypothesisSpecification | Product Marketing | subkind | n_acquisitionhypothesisspecification_f53c189f |
| IC:AdoptionHypothesisSpecification | AdoptionHypothesisSpecification | Product Marketing | subkind | n_adoptionhypothesisspecification_2af3a479 |
| IC:AssessmentClaim | AssessmentClaim | Product Evidence | kind | n_assessmentclaim_845fd7a6 |
| IC:AssessmentContextSpecification | AssessmentContextSpecification | Product Evidence | kind | n_assessmentcontextspecification_1eaefd26 |
| IC:BundleSpecification | BundleSpecification | Product Portfolio | kind | n_bundlespecification_43ab05f6 |
| IC:BusinessRuleReference | BusinessRuleReference | Product Reference | subkind | n_businessrulereference_86a0a817 |
| IC:CapabilitySpecification | CapabilitySpecification | Product Definition | kind | n_capabilityspecification_9a2df711 |
| IC:ChangeProposalSpecification | ChangeProposalSpecification | Product Delivery | kind | n_changeproposalspecification_78844f4a |
| IC:ChangeRecord | ChangeRecord | Product Delivery | kind | n_changerecord_fd7f0722 |
| IC:CommitmentLevelDefinition | CommitmentLevelDefinition | Product Roadmap | kind | n_commitmentleveldefinition_07b14cfa |
| IC:CompetitiveNarrative | CompetitiveNarrative | Product Marketing | kind | n_competitivenarrative_346d99d1 |
| IC:ConditionSpecification | ConditionSpecification | Product Definition | kind | n_conditionspecification_bd1404c1 |
| IC:ConfidenceAssessment | ConfidenceAssessment | Product Roadmap | kind | n_confidenceassessment_6e5843ec |
| IC:ConstraintSpecification | ConstraintSpecification | Product Requirement | subkind | n_constraintspecification_b3f38000 |
| IC:DecisionCriterionSpecification | DecisionCriterionSpecification | Product Strategy | kind | n_decisioncriterionspecification_94e603d1 |
| IC:DecisionRecord | DecisionRecord | Product Strategy | kind | n_decisionrecord_1339be47 |
| IC:DeliveryStatusRecord | DeliveryStatusRecord | Product Delivery | kind | n_deliverystatusrecord_9e00ef2d |
| IC:DeliveryWorkItem | DeliveryWorkItem | Product Delivery | kind | n_deliveryworkitem_aa69924e |
| IC:DeliveryWorkItemStatusRecord | DeliveryWorkItemStatusRecord | Product Delivery | kind | n_deliveryworkitemstatusrecord_24efd200 |
| IC:DependencySpecification | DependencySpecification | Product Portfolio | kind | n_dependencyspecification_c46325d1 |
| IC:EnablerSpecification | EnablerSpecification | Product Definition | kind | n_enablerspecification_b1d8c9be |
| IC:EvidenceArtifact | EvidenceArtifact | Product Evidence | category | n_evidenceartifact_9faef742 |
| IC:EvidenceAttributionRecord | EvidenceAttributionRecord | Product Evidence | kind | n_evidenceattributionrecord_1374deb5 |
| IC:ExternalReferenceRecord | ExternalReferenceRecord | Product Reference | kind | n_externalreferencerecord_eecf8de0 |
| IC:FeatureFlagSpecification | FeatureFlagSpecification | Product Delivery | kind | n_featureflagspecification_b1f1ade5 |
| IC:FeatureSpecification | FeatureSpecification | Product Definition | kind | n_featurespecification_3608cfde |
| IC:FindingRecord | FindingRecord | Product Evidence | kind | n_findingrecord_0a2f27a2 |
| IC:FunctionalRequirementSpecification | FunctionalRequirementSpecification | Product Requirement | subkind | n_functionalrequirementspecification_6d142951 |
| IC:GoToMarketSpecification | GoToMarketSpecification | Product Marketing | kind | n_gotomarketspecification_0dec7af9 |
| IC:GoalSpecification | GoalSpecification | Product Strategy | subkind | n_goalspecification_e8a45aca |
| IC:HypothesisSpecification | HypothesisSpecification | Product Strategy | kind | n_hypothesisspecification_793ebb63 |
| IC:InformationArchitectureSpecification | InformationArchitectureSpecification | Product Experience | kind | n_informationarchitecturespecification_7a7b972c |
| IC:InitiativeSpecification | InitiativeSpecification | Product Strategy | kind | n_initiativespecification_7e07a685 |
| IC:InteractionStepSpecification | InteractionStepSpecification | Product Experience | kind | n_interactionstepspecification_cd93f059 |
| IC:JourneySpecification | JourneySpecification | Product Experience | kind | n_journeyspecification_13c4d1f4 |
| IC:JourneyStageSpecification | JourneyStageSpecification | Product Experience | kind | n_journeystagespecification_4bd4d01c |
| IC:LaunchSpecification | LaunchSpecification | Product Marketing | kind | n_launchspecification_e28ba61e |
| IC:LifecycleSpecification | LifecycleSpecification | Product Portfolio | kind | n_lifecyclespecification_864030b5 |
| IC:LifecycleStageSpecification | LifecycleStageSpecification | Product Portfolio | kind | n_lifecyclestagespecification_1bb099c0 |
| IC:MarketingGoalSpecification | MarketingGoalSpecification | Product Marketing | subkind | n_marketinggoalspecification_a5099fed |
| IC:MarketingInsightReference | MarketingInsightReference | Product Reference | subkind | n_marketinginsightreference_3b862346 |
| IC:MessagingSpecification | MessagingSpecification | Product Marketing | kind | n_messagingspecification_5c538bb8 |
| IC:MilestoneSpecification | MilestoneSpecification | Product Roadmap | kind | n_milestonespecification_cde09a20 |
| IC:OfferingSpecification | OfferingSpecification | Product Portfolio | kind | n_offeringspecification_5446ebd8 |
| IC:OpportunityStatement | OpportunityStatement | Product Strategy | kind | n_opportunitystatement_23a09cd2 |
| IC:OutcomeSpecification | OutcomeSpecification | Product Strategy | subkind | n_outcomespecification_518f3db1 |
| IC:PersonaSpecification | PersonaSpecification | Product Experience | kind | n_personaspecification_f594b1db |
| IC:PlanningHorizonDefinition | PlanningHorizonDefinition | Product Roadmap | kind | n_planninghorizondefinition_a0b203d3 |
| IC:PortfolioEntry | PortfolioEntry | Product Portfolio | kind | n_portfolioentry_33d7e05a |
| IC:PositioningStatement | PositioningStatement | Product Marketing | kind | n_positioningstatement_4cf10a65 |
| IC:PrioritizationCriterionSpecification | PrioritizationCriterionSpecification | Product Roadmap | subkind | n_prioritizationcriterionspecification_93c7d7ac |
| IC:PriorityAssessment | PriorityAssessment | Product Roadmap | kind | n_priorityassessment_8ded0489 |
| IC:ProblemSolutionFitAssessment | ProblemSolutionFitAssessment | Product Strategy | kind | n_problemsolutionfitassessment_c805b8da |
| IC:ProblemStatement | ProblemStatement | Product Strategy | kind | n_problemstatement_bbeab790 |
| IC:Product | Product | Product Portfolio | kind | n_product_1113063f |
| IC:ProductCapability | ProductCapability | Product Realization | mode | n_productcapability_daacc368 |
| IC:ProductFamilyReference | ProductFamilyReference | Product Reference | subkind | n_productfamilyreference_690c8ed8 |
| IC:ProductLineReference | ProductLineReference | Product Reference | subkind | n_productlinereference_ca709c26 |
| IC:ProductMarketFitAssessment | ProductMarketFitAssessment | Product Strategy | kind | n_productmarketfitassessment_edc39b79 |
| IC:ProductMetricReference | ProductMetricReference | Product Reference | subkind | n_productmetricreference_e601b04f |
| IC:ProductPortfolio | ProductPortfolio | Product Portfolio | kind | n_productportfolio_d7eb3fb1 |
| IC:ProductRealization | ProductRealization | Product Realization | kind | n_productrealization_3f34561e |
| IC:ProductStatusRecord | ProductStatusRecord | Product Portfolio | kind | n_productstatusrecord_8dee8029 |
| IC:ProductVariantReference | ProductVariantReference | Product Reference | subkind | n_productvariantreference_632bdd4c |
| IC:ProductVersion | ProductVersion | Product Portfolio | kind | n_productversion_6f96b4e1 |
| IC:QualityRequirementSpecification | QualityRequirementSpecification | Product Requirement | subkind | n_qualityrequirementspecification_917fbe6e |
| IC:ReleaseEvidenceRecord | ReleaseEvidenceRecord | Product Evidence | subkind | n_releaseevidencerecord_7818c30f |
| IC:ReleaseSpecification | ReleaseSpecification | Product Delivery | kind | n_releasespecification_6af5122c |
| IC:RequirementRationaleStatement | RequirementRationaleStatement | Product Requirement | kind | n_requirementrationalestatement_01810884 |
| IC:RequirementScenarioSpecification | RequirementScenarioSpecification | Product Requirement | subkind | n_requirementscenariospecification_c1770070 |
| IC:RequirementSourceReference | RequirementSourceReference | Product Reference | subkind | n_requirementsourcereference_54b980ed |
| IC:RequirementSpecification | RequirementSpecification | Product Requirement | subkind | n_requirementspecification_65341313 |
| IC:Roadmap | Roadmap | Product Roadmap | kind | n_roadmap_995689f7 |
| IC:RoadmapEntry | RoadmapEntry | Product Roadmap | kind | n_roadmapentry_357ac916 |
| IC:ScenarioSpecification | ScenarioSpecification | Product Definition | kind | n_scenariospecification_0e62e381 |
| IC:ScopeSpecification | ScopeSpecification | Product Definition | kind | n_scopespecification_08dd6413 |
| IC:ScreenSpecification | ScreenSpecification | Product Experience | kind | n_screenspecification_01d48843 |
| IC:SolutionHypothesisSpecification | SolutionHypothesisSpecification | Product Strategy | subkind | n_solutionhypothesisspecification_f5d71b12 |
| IC:SolutionSpecification | SolutionSpecification | Product Definition | kind | n_solutionspecification_1f2d66e4 |
| IC:TargetMarketReference | TargetMarketReference | Product Reference | subkind | n_targetmarketreference_05622292 |
| IC:TargetSegmentReference | TargetSegmentReference | Product Reference | subkind | n_targetsegmentreference_e8fed746 |
| IC:TargetWindowAssignment | TargetWindowAssignment | Product Roadmap | kind | n_targetwindowassignment_b9fff514 |
| IC:TaskReference | TaskReference | Product Reference | subkind | n_taskreference_55fe919a |
| IC:TestCase | TestCase | Product Test | subkind | n_testcase_4838ac55 |
| IC:TestDataReference | TestDataReference | Product Reference | subkind | n_testdatareference_2f5031b7 |
| IC:TestExecution | TestExecution | Product Test | event | n_testexecution_de7d3951 |
| IC:TestResult | TestResult | Product Test | kind | n_testresult_1b08937a |
| IC:TestScenario | TestScenario | Product Test | subkind | n_testscenario_48e750a7 |
| IC:TestSuiteSpecification | TestSuiteSpecification | Product Test | kind | n_testsuitespecification_9c5427f3 |
| IC:TouchpointSpecification | TouchpointSpecification | Product Experience | kind | n_touchpointspecification_354c96e7 |
| IC:UIStateSpecification | UIStateSpecification | Product Experience | kind | n_uistatespecification_dcbb7363 |
| IC:UsabilityFindingRecord | UsabilityFindingRecord | Product Experience | subkind | n_usabilityfindingrecord_dcd80cdd |
| IC:UserFlowSpecification | UserFlowSpecification | Product Experience | kind | n_userflowspecification_cf108467 |
| IC:UserRoleSpecification | UserRoleSpecification | Product Experience | kind | n_userrolespecification_22705cf4 |
| IC:UserStorySpecification | UserStorySpecification | Product Requirement | kind | n_userstoryspecification_ba3bd5ce |
| IC:ValidationEvidenceRecord | ValidationEvidenceRecord | Product Evidence | subkind | n_validationevidencerecord_456f518a |
| IC:ValidationFindingRecord | ValidationFindingRecord | Product Requirement | subkind | n_validationfindingrecord_02b02536 |
| IC:VerificationEvidenceRecord | VerificationEvidenceRecord | Product Evidence | subkind | n_verificationevidencerecord_bd42ce8b |
| IC:VerticalSliceSpecification | VerticalSliceSpecification | Product Definition | kind | n_verticalslicespecification_5fd0b0b8 |
| IC:VisionStatement | VisionStatement | Product Strategy | kind | n_visionstatement_cb1717ed |

## Product Definition

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| ICREL:ARCH:realizedByComponent | IC:FeatureSpecification | intendedRealizedByComponent | EXT:Architecture:Component | 0..* | 0..* |
| ICREL:ARCH:realizedByService | IC:FeatureSpecification | intendedRealizedByService | EXT:Architecture:Service | 0..* | 0..* |
| ICREL:ARCH:supportedByArchitectureElement | IC:CapabilitySpecification | intendedSupportedByArchitectureElement | EXT:Architecture:ArchitectureElement | 0..* | 0..* |
| ICREL:SP:expectedCondition | IC:ScenarioSpecification | specifiesExpectedCondition | IC:ConditionSpecification | 1..* | 0..* |
| REL:ORSD04:scopeChangeRecord | IC:ScopeSpecification | scopeChangeRecord | IC:ChangeRecord | 0..* | 0..* |
| REL:ORSD04:scopeSupersedes | IC:ScopeSpecification | scopeSupersedes | IC:ScopeSpecification | 0..* | 0..* |
| REL:W2:034 | IC:CapabilitySpecification | specifiedThroughFeature | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:036 | IC:SolutionSpecification | proposesCapability | IC:CapabilitySpecification | 0..* | 0..* |
| REL:W2:037 | IC:SolutionSpecification | proposesFeature | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:038 | IC:FeatureSpecification | specifiesSlice | IC:VerticalSliceSpecification | 0..* | 0..* |
| REL:W2:039 | IC:EnablerSpecification | intendedToEnableFeature | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:040 | IC:FeatureSpecification | dependsOnFeatureSpecification | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:041 | IC:VerticalSliceSpecification | representedByStory | IC:UserStorySpecification | 0..* | 0..* |
| REL:W2:042 | IC:FeatureSpecification | hasStorySpecification | IC:UserStorySpecification | 0..* | 0..* |
| REL:W2:107 | IC:CapabilitySpecification | intendedToSupport | EXT:Business:BusinessCapability | 0..* | 0..* |
| REL:W2:130 | IC:SolutionSpecification | intendsToAddressProblem | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:131 | IC:FeatureSpecification | specifiedByRequirement | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:132 | IC:FeatureSpecification | hasFeatureCriterion | IC:AcceptanceCriterionSpecification | 0..* | 0..* |
| REL:W2:133 | IC:FeatureSpecification | supportedBy | IC:UserFlowSpecification | 0..* | 0..* |
| REL:W2:163 | IC:SolutionSpecification | intendsToContributeToOutcome | IC:OutcomeSpecification | 0..* | 0..* |
| REL:W2:164 | IC:FeatureSpecification | intendsToAddressProblem | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:165 | IC:FeatureSpecification | specifiesBeneficiaryPersona | IC:PersonaSpecification | 0..* | 0..* |
| REL:W2:166 | IC:FeatureSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:212 | IC:FeatureSpecification | intendsToAddressNeed | EXT:Market:Need | 0..* | 0..* |

## Product Delivery

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| REL:ORSD05:itemStatus | IC:DeliveryWorkItem | itemStatus | IC:DeliveryWorkItemStatusRecord | 0..* | 1 |
| REL:ORSD05:itemStatusChange | IC:DeliveryWorkItemStatusRecord | itemStatusChange | IC:ChangeRecord | 0..* | 0..* |
| REL:ORSD05:itemStatusVersion | IC:DeliveryWorkItemStatusRecord | itemStatusVersion | IC:ProductVersion | 0..1 | 0..* |
| REL:ORSD05:releaseStatusChange | IC:DeliveryStatusRecord | releaseStatusChange | IC:ChangeRecord | 0..* | 0..* |
| REL:ORSD05:releaseStatusVersion | IC:DeliveryStatusRecord | releaseStatusVersion | IC:ProductVersion | 0..1 | 0..* |
| REL:ORSD06:changeDecision | IC:ChangeRecord | changeDecision | IC:DecisionRecord | 0..* | 0..* |
| REL:ORSD06:changeFeature | IC:ChangeRecord | changeFeature | IC:FeatureSpecification | 0..1 | 0..* |
| REL:ORSD06:changeScope | IC:ChangeRecord | changeScope | IC:ScopeSpecification | 0..1 | 0..* |
| REL:ORSD06:changeTask | IC:ChangeRecord | changeTask | IC:TaskReference | 0..* | 0..* |
| REL:ORSD06:proposalFeature | IC:ChangeProposalSpecification | proposalFeature | IC:FeatureSpecification | 0..1 | 0..* |
| REL:ORSD06:proposalScope | IC:ChangeProposalSpecification | proposalScope | IC:ScopeSpecification | 0..1 | 0..* |
| REL:W2:075 | IC:ReleaseSpecification | plansDeliveryItem | IC:DeliveryWorkItem | 0..* | 0..* |
| REL:W2:076 | IC:ReleaseSpecification | referencesChangeRecord | IC:ChangeRecord | 0..* | 0..* |
| REL:W2:077 | IC:ReleaseSpecification | hasStatus | IC:DeliveryStatusRecord | 0..* | 1 |
| REL:W2:078 | IC:ReleaseSpecification | hasReleaseEvidenceRecord | IC:ReleaseEvidenceRecord | 0..* | 0..* |
| REL:W2:079 | IC:ChangeProposalSpecification | proposesRecordedChange | IC:ChangeRecord | 0..* | 0..* |
| REL:W2:080 | IC:DeliveryWorkItem | plansFeature | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:082 | IC:FeatureFlagSpecification | specifiesFeatureActivationControl | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:144 | IC:ReleaseSpecification | targetsReleaseGoal | IC:GoalSpecification | 0..* | 0..* |

## Product Evidence

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| ICREL:EU:assertsClaim | IC:EvidenceAttributionRecord | recordsClaim | IC:AssessmentClaim | 1 | 0..* |
| ICREL:EU:attributedTo | IC:EvidenceArtifact | recordedAttributionTo | IC:AssessmentClaim | 0..* | 0..* |
| ICREL:EU:usesEvidence | IC:EvidenceAttributionRecord | recordsCarrier | IC:EvidenceArtifact | 1 | 0..* |
| REL:ORSD04:claimActualCapability | IC:AssessmentClaim | claimActualCapability | IC:ProductCapability | 0..1 | 0..* |
| REL:ORSD04:claimContext | IC:AssessmentClaim | claimContext | IC:AssessmentContextSpecification | 1 | 0..* |
| REL:ORSD04:claimCriterion | IC:AssessmentClaim | claimCriterion | IC:ConditionSpecification | 1 | 0..* |
| REL:ORSD04:claimIntendedCapability | IC:AssessmentClaim | claimIntendedCapability | IC:CapabilitySpecification | 0..1 | 0..* |
| REL:ORSD04:claimProduct | IC:AssessmentClaim | claimProduct | IC:Product | 0..1 | 0..* |
| REL:ORSD04:claimRealization | IC:AssessmentClaim | claimRealization | IC:ProductRealization | 0..1 | 0..* |
| REL:ORSD04:claimRequirement | IC:AssessmentClaim | claimRequirement | IC:RequirementSpecification | 0..1 | 0..* |
| REL:ORSD04:claimVersion | IC:AssessmentClaim | claimVersion | IC:ProductVersion | 0..1 | 0..* |
| REL:ORSD04:contextScenario | IC:AssessmentContextSpecification | contextScenario | IC:ScenarioSpecification | 0..* | 0..* |
| REL:ORSD04:contextVersion | IC:AssessmentContextSpecification | contextVersion | IC:ProductVersion | 0..1 | 0..* |
| REL:W2:145 | IC:ReleaseEvidenceRecord | concernsDeliveryWorkItem | IC:DeliveryWorkItem | 0..* | 0..* |
| REL:W2:198 | IC:ValidationEvidenceRecord | citesSupportingEvidence | EXT:ExternalUnresolved:Evidence | 0..* | 0..* |
| REL:W2:218 | IC:ReleaseEvidenceRecord | citesSupportingEvidence | EXT:EvidenceLayer:Evidence | 0..* | 0..* |

## Product Experience

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| REL:ORSD06:stepPrecedes | IC:InteractionStepSpecification | stepPrecedes | IC:InteractionStepSpecification | 0..* | 0..* |
| REL:ORSD06:usabilityInformationArchitecture | IC:UsabilityFindingRecord | usabilityInformationArchitecture | IC:InformationArchitectureSpecification | 0..* | 0..* |
| REL:ORSD06:usabilityJourney | IC:UsabilityFindingRecord | usabilityJourney | IC:JourneySpecification | 0..* | 0..* |
| REL:ORSD06:usabilityJourneyStage | IC:UsabilityFindingRecord | usabilityJourneyStage | IC:JourneyStageSpecification | 0..* | 0..* |
| REL:ORSD06:usabilityPersona | IC:UsabilityFindingRecord | usabilityPersona | IC:PersonaSpecification | 0..* | 0..* |
| REL:ORSD06:usabilityStep | IC:UsabilityFindingRecord | usabilityStep | IC:InteractionStepSpecification | 0..* | 0..* |
| REL:ORSD06:usabilityTouchpoint | IC:UsabilityFindingRecord | usabilityTouchpoint | IC:TouchpointSpecification | 0..* | 0..* |
| REL:ORSD06:usabilityUIState | IC:UsabilityFindingRecord | usabilityUIState | IC:UIStateSpecification | 0..* | 0..* |
| REL:ORSD06:usabilityUserRole | IC:UsabilityFindingRecord | usabilityUserRole | IC:UserRoleSpecification | 0..* | 0..* |
| REL:W2:051 | IC:PersonaSpecification | describesUserRole | IC:UserRoleSpecification | 0..* | 0..* |
| REL:W2:052 | IC:PersonaSpecification | representedInJourney | IC:JourneySpecification | 0..* | 0..* |
| REL:W2:053 | IC:JourneySpecification | contains | IC:JourneyStageSpecification | 0..* | 1 |
| REL:W2:054 | IC:JourneyStageSpecification | includes | IC:TouchpointSpecification | 0..* | 0..* |
| REL:W2:055 | IC:JourneyStageSpecification | describedByFlow | IC:UserFlowSpecification | 0..* | 0..* |
| REL:W2:056 | IC:UserFlowSpecification | specifiesStep | IC:InteractionStepSpecification | 0..* | 1 |
| REL:W2:057 | IC:InteractionStepSpecification | referencesScreen | IC:ScreenSpecification | 0..* | 0..* |
| REL:W2:058 | IC:InformationArchitectureSpecification | organizesScreenSpecification | IC:ScreenSpecification | 0..* | 0..* |
| REL:W2:059 | IC:ScreenSpecification | definesUIState | IC:UIStateSpecification | 0..* | 1 |
| REL:W2:060 | IC:UsabilityFindingRecord | reportsOnFlow | IC:UserFlowSpecification | 0..* | 0..* |
| REL:W2:061 | IC:UsabilityFindingRecord | reportsOnScreen | IC:ScreenSpecification | 0..* | 0..* |
| REL:W2:136 | IC:JourneySpecification | includes | IC:TouchpointSpecification | 0..* | 0..* |
| REL:W2:137 | IC:UserFlowSpecification | includesScreen | IC:ScreenSpecification | 0..* | 0..* |
| REL:W2:138 | IC:ScreenSpecification | allowsPrecedingScreen | IC:ScreenSpecification | 0..* | 0..* |
| REL:W2:168 | IC:JourneySpecification | identifiesOpportunity | IC:OpportunityStatement | 0..* | 0..* |
| REL:W2:169 | IC:JourneySpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:170 | IC:JourneyStageSpecification | identifiesOpportunity | IC:OpportunityStatement | 0..* | 0..* |
| REL:W2:171 | IC:JourneyStageSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:194 | IC:InformationArchitectureSpecification | referencesMentalModel | EXT:UXResearch:User_Mental_Model | 0..* | 0..* |
| REL:W2:214 | IC:JourneySpecification | describesPain | EXT:Market:Pain | 0..* | 0..* |
| REL:W2:215 | IC:JourneyStageSpecification | describesPain | EXT:Market:Pain | 0..* | 0..* |
| REL:W2:216 | IC:TouchpointSpecification | intendsToAddressNeed | EXT:Market:Need | 0..* | 0..* |
| REL:W2:217 | IC:TouchpointSpecification | describesPain | EXT:Market:Pain | 0..* | 0..* |

## Product Marketing

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| REL:ORSD06:acquisitionCitesEvidence | IC:AcquisitionHypothesisSpecification | acquisitionCitesEvidence | IC:EvidenceAttributionRecord | 0..* | 0..* |
| REL:ORSD06:acquisitionCitesInsight | IC:AcquisitionHypothesisSpecification | acquisitionCitesInsight | IC:MarketingInsightReference | 0..* | 0..* |
| REL:ORSD06:adoptionCitesEvidence | IC:AdoptionHypothesisSpecification | adoptionCitesEvidence | IC:EvidenceAttributionRecord | 0..* | 0..* |
| REL:ORSD06:adoptionCitesInsight | IC:AdoptionHypothesisSpecification | adoptionCitesInsight | IC:MarketingInsightReference | 0..* | 0..* |
| REL:ORSD06:narrativeCitesEvidence | IC:CompetitiveNarrative | narrativeCitesEvidence | IC:EvidenceAttributionRecord | 0..* | 0..* |
| REL:ORSD06:narrativeCitesInsight | IC:CompetitiveNarrative | narrativeCitesInsight | IC:MarketingInsightReference | 0..* | 0..* |
| REL:W2:096 | IC:PositioningStatement | referencesTargetMarket | IC:TargetMarketReference | 0..* | 0..* |
| REL:W2:097 | IC:PositioningStatement | referencesTargetSegment | IC:TargetSegmentReference | 0..* | 0..* |
| REL:W2:098 | IC:PositioningStatement | referencesCompetitiveNarrative | IC:CompetitiveNarrative | 0..* | 0..* |
| REL:W2:099 | IC:MessagingSpecification | expressesPositioning | IC:PositioningStatement | 0..* | 0..* |
| REL:W2:100 | IC:GoToMarketSpecification | usesPositioningStatement | IC:PositioningStatement | 0..* | 0..* |
| REL:W2:101 | IC:GoToMarketSpecification | plansLaunch | IC:LaunchSpecification | 0..* | 0..* |
| REL:W2:102 | IC:GoToMarketSpecification | targetsMarketingGoal | IC:MarketingGoalSpecification | 0..* | 0..* |
| REL:W2:105 | IC:AcquisitionHypothesisSpecification | informsGoToMarketFromAcquisition | IC:GoToMarketSpecification | 0..* | 0..* |
| REL:W2:106 | IC:AdoptionHypothesisSpecification | informsGoToMarketFromAdoption | IC:GoToMarketSpecification | 0..* | 0..* |
| REL:W2:116 | IC:PositioningStatement | references | EXT:Business:ValueProposition | 0..* | 0..* |
| REL:W2:148 | IC:GoToMarketSpecification | referencesJourneyStage | IC:JourneyStageSpecification | 0..* | 0..* |
| REL:W2:149 | IC:LaunchSpecification | targetsLaunchPersona | IC:PersonaSpecification | 0..* | 0..* |
| REL:W2:150 | IC:LaunchSpecification | usesLaunchPositioning | IC:PositioningStatement | 0..* | 0..* |
| REL:W2:151 | IC:LaunchSpecification | usesLaunchMessaging | IC:MessagingSpecification | 0..* | 0..* |
| REL:W2:172 | IC:PositioningStatement | addressesProblemStatement | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:173 | IC:PositioningStatement | claimsDifferentiationThrough | IC:CapabilitySpecification | 0..* | 0..* |
| REL:W2:174 | IC:MessagingSpecification | targetsMessagePersona | IC:PersonaSpecification | 0..* | 0..* |
| REL:W2:175 | IC:MessagingSpecification | referencesMessageFeature | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:176 | IC:GoToMarketSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:177 | IC:LaunchSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:178 | IC:MarketingGoalSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:179 | IC:CompetitiveNarrative | addressesNarrativeProblem | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:180 | IC:CompetitiveNarrative | claimsDifferentiationThrough | IC:CapabilitySpecification | 0..* | 0..* |
| REL:W2:181 | IC:AcquisitionHypothesisSpecification | hypothesizesAcquisitionForProblem | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:182 | IC:AcquisitionHypothesisSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:183 | IC:AdoptionHypothesisSpecification | hypothesizesAdoptionForProblem | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:184 | IC:AdoptionHypothesisSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:200 | IC:GoToMarketSpecification | targets | EXT:Market:CustomerSegment | 0..* | 0..* |
| REL:W2:201 | IC:GoToMarketSpecification | targets | EXT:Market:Market | 0..* | 0..* |
| REL:W2:202 | IC:GoToMarketSpecification | referencesValueProposition | EXT:Business:ValueProposition | 0..* | 0..* |
| REL:W2:203 | IC:LaunchSpecification | targets | EXT:Market:CustomerSegment | 0..* | 0..* |
| REL:W2:204 | IC:MarketingGoalSpecification | targets | EXT:Market:CustomerSegment | 0..* | 0..* |
| REL:W2:219 | IC:PositioningStatement | addressesPain | EXT:Market:Pain | 0..* | 0..* |
| REL:W2:220 | IC:MessagingSpecification | addressesPain | EXT:Market:Pain | 0..* | 0..* |
| REL:W2:221 | IC:MessagingSpecification | supportedBy | EXT:EvidenceLayer:Evidence | 0..* | 0..* |
| REL:W2:222 | IC:CompetitiveNarrative | differentiatesFrom | EXT:Market:Competitor_Alternative | 0..* | 0..* |
| REL:W2:223 | IC:CompetitiveNarrative | supportedBy | EXT:EvidenceLayer:Evidence | 0..* | 0..* |
| REL:W2:224 | IC:AcquisitionHypothesisSpecification | evidencedBy | EXT:EvidenceLayer:Evidence | 0..* | 0..* |
| REL:W2:225 | IC:AdoptionHypothesisSpecification | addressesPain | EXT:Market:Pain | 0..* | 0..* |
| REL:W2:226 | IC:AdoptionHypothesisSpecification | evidencedBy | EXT:EvidenceLayer:Evidence | 0..* | 0..* |

## Product Portfolio

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| ICREL:CP:specifiesCapability | IC:ProductVersion | specifiesCapability | IC:CapabilitySpecification | 0..* | 1 |
| REL:ORSD04:versionScope | IC:ProductVersion | versionScope | IC:ScopeSpecification | 0..1 | 0..* |
| REL:ORSD06:dependencyActualCapabilityTarget | IC:DependencySpecification | dependencyActualCapabilityTarget | IC:ProductCapability | 0..1 | 0..* |
| REL:ORSD06:dependencyCapabilitySpecificationTarget | IC:DependencySpecification | dependencyCapabilitySpecificationTarget | IC:CapabilitySpecification | 0..1 | 0..* |
| REL:ORSD06:dependencyCondition | IC:DependencySpecification | dependencyCondition | IC:ConditionSpecification | 1 | 0..* |
| REL:ORSD06:dependencyExternalTarget | IC:DependencySpecification | dependencyExternalTarget | IC:ExternalReferenceRecord | 0..1 | 0..* |
| REL:ORSD06:dependencyProductTarget | IC:DependencySpecification | dependencyProductTarget | IC:Product | 0..1 | 0..* |
| REL:W2:002 | IC:ProductPortfolio | containsProduct | IC:Product | 0..* | 0..* |
| REL:W2:003 | IC:ProductPortfolio | organizesEntry | IC:PortfolioEntry | 0..* | 1 |
| REL:W2:004 | IC:PortfolioEntry | entryOfPortfolio | IC:ProductPortfolio | 1 | 0..* |
| REL:W2:005 | IC:OfferingSpecification | offeringOf | IC:Product | 1 | 0..* |
| REL:W2:006 | IC:BundleSpecification | referencesOffering | IC:OfferingSpecification | 0..* | 0..* |
| REL:W2:007 | IC:Product | hasVersion | IC:ProductVersion | 0..* | 1 |
| REL:W2:008 | IC:ProductVersion | supersedes | IC:ProductVersion | 0..* | 0..* |
| REL:W2:009 | IC:Product | usesLifecycleSpecification | IC:LifecycleSpecification | 0..* | 0..* |
| REL:W2:010 | IC:LifecycleSpecification | definesLifecycleStage | IC:LifecycleStageSpecification | 0..* | 1 |
| REL:W2:011 | IC:Product | hasProductStatusRecord | IC:ProductStatusRecord | 0..* | 1 |
| REL:W2:012 | IC:Product | hasDependencySpecification | IC:DependencySpecification | 0..* | 1 |
| REL:W2:013 | IC:DependencySpecification | dependencyOfProduct | IC:Product | 1 | 0..* |
| REL:W2:014 | IC:Product | referencesProductFamily | IC:ProductFamilyReference | 0..* | 0..* |
| REL:W2:015 | IC:Product | referencesProductLine | IC:ProductLineReference | 0..* | 0..* |
| REL:W2:016 | IC:Product | referencesProductVariant | IC:ProductVariantReference | 0..* | 0..* |
| REL:W2:017 | IC:Product | hasVisionStatement | IC:VisionStatement | 0..* | 0..* |
| REL:W2:031 | IC:Product | hasScopeSpecification | IC:ScopeSpecification | 0..* | 0..* |
| REL:W2:032 | IC:Product | intendsCapability | IC:CapabilitySpecification | 0..* | 0..* |
| REL:W2:083 | IC:ProductVersion | plannedForRelease | IC:ReleaseSpecification | 0..* | 0..* |
| REL:W2:094 | IC:Product | hasPositioningStatement | IC:PositioningStatement | 0..* | 0..* |
| REL:W2:095 | IC:OfferingSpecification | positionedByStatement | IC:PositioningStatement | 0..* | 0..* |
| REL:W2:117 | IC:ProductPortfolio | tracksInitiative | IC:InitiativeSpecification | 0..* | 0..* |
| REL:W2:118 | IC:ProductPortfolio | tracksReleaseSpecification | IC:ReleaseSpecification | 0..* | 0..* |
| REL:W2:119 | IC:ProductPortfolio | tracksMilestoneSpecification | IC:MilestoneSpecification | 0..* | 0..* |
| REL:W2:120 | IC:ProductPortfolio | referencesProductLine | IC:ProductLineReference | 0..* | 0..* |
| REL:W2:121 | IC:ProductPortfolio | hasPortfolioConfidenceAssessment | IC:ConfidenceAssessment | 0..* | 0..* |
| REL:W2:122 | IC:Product | targetsPersona | IC:PersonaSpecification | 0..* | 0..* |
| REL:W2:123 | IC:Product | framesJourney | IC:JourneySpecification | 0..* | 0..* |
| REL:W2:124 | IC:PortfolioEntry | referencesProduct | IC:Product | 0..1 | 0..* |
| REL:W2:154 | IC:Product | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:185 | IC:Product | referencesValueProposition | EXT:Business:ValueProposition | 0..* | 0..* |
| REL:W2:186 | IC:OfferingSpecification | targets | EXT:Market:CustomerSegment | 0..* | 0..* |
| REL:W2:187 | IC:OfferingSpecification | includesService | EXT:Business:Service | 0..* | 0..* |
| REL:W2:208 | IC:OfferingSpecification | addressesNeed | EXT:Market:Need | 0..* | 0..* |

## Product Realization

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| ICREL:CP:bearsCapability | IC:ProductRealization | bearsCapability | IC:ProductCapability | 1..* | 1 |
| ICREL:CP:evaluatedAgainst | IC:ProductCapability | evaluatedAgainst | IC:CapabilitySpecification | 0..* | 0..* |
| ICREL:CP:realizesVersion | IC:ProductRealization | realizesVersion | IC:ProductVersion | 1 | 0..* |
| ICREL:implementsFeature | IC:ProductRealization | implementsFeature | IC:FeatureSpecification | 0..* | 0..* |

## Product Reference

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| REL:ORSD05:referenceReviewFinding | IC:ExternalReferenceRecord | referenceReviewFinding | IC:FindingRecord | 0..* | 0..1 |
| REL:ORSD05:referenceSupersedes | IC:ExternalReferenceRecord | referenceSupersedes | IC:ExternalReferenceRecord | 0..* | 0..* |
| REL:W2:047 | IC:BusinessRuleReference | referencesRuleForRequirement | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:048 | IC:RequirementSourceReference | sourcesRequirement | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:081 | IC:TaskReference | intendedToContributeToWork | IC:DeliveryWorkItem | 0..* | 0..* |
| REL:W2:103 | IC:MarketingInsightReference | informsPositioningStatement | IC:PositioningStatement | 0..* | 0..* |
| REL:W2:104 | IC:MarketingInsightReference | informsGoToMarketSpecification | IC:GoToMarketSpecification | 0..* | 0..* |
| REL:W2:108 | IC:ProductFamilyReference | refersTo | EXT:ProductLine:ProductFamily | 1 | 0..* |
| REL:W2:109 | IC:ProductLineReference | refersTo | EXT:ProductLine:ProductLine | 1 | 0..* |
| REL:W2:110 | IC:ProductVariantReference | refersTo | EXT:ProductLine:ProductVariant | 1 | 0..* |
| REL:W2:111 | IC:BusinessRuleReference | refersTo | EXT:Business:BusinessRule | 1 | 0..* |
| REL:W2:112 | IC:ProductMetricReference | refersTo | EXT:ProductManagement:Metric | 1 | 0..* |
| REL:W2:113 | IC:TargetMarketReference | refersTo | EXT:Market:Market | 1 | 0..* |
| REL:W2:114 | IC:TargetSegmentReference | refersTo | EXT:Market:MarketSegment | 1 | 0..* |
| REL:W2:115 | IC:MarketingInsightReference | refersTo | EXT:Market:MarketInsight | 1 | 0..* |
| REL:W2:188 | IC:ProductVariantReference | referencesVariantConfiguration | EXT:ProductLine:ProductConfiguration | 0..* | 0..* |
| REL:W2:199 | IC:TestDataReference | referencesDatasetConfiguration | EXT:ExternalUnresolved:Configuration | 0..* | 0..* |
| REL:W2:207 | IC:MarketingInsightReference | citesInsightEvidence | EXT:ExternalUnresolved:Evidence | 0..* | 0..* |

## Product Requirement

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| ICREL:ARCH:satisfiedByArchitectureElement | IC:RequirementSpecification | intendedSatisfiedByArchitectureElement | EXT:Architecture:ArchitectureElement | 0..* | 0..* |
| ICREL:ARCH:satisfiedByInterface | IC:RequirementSpecification | intendedSatisfiedByInterface | EXT:Architecture:Interface | 0..* | 0..* |
| REL:W2:043 | IC:UserStorySpecification | refinedByRequirement | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:044 | IC:RequirementSpecification | operationalizedByCriterion | IC:AcceptanceCriterionSpecification | 0..* | 0..* |
| REL:W2:045 | IC:AcceptanceCriterionSpecification | exemplifiedByScenario | IC:RequirementScenarioSpecification | 0..* | 0..* |
| REL:W2:046 | IC:ConstraintSpecification | constrainsRequirement | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:049 | IC:RequirementRationaleStatement | justifiesRequirement | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:050 | IC:ValidationFindingRecord | concernsRequirement | IC:RequirementSpecification | 1 | 0..* |
| REL:W2:062 | IC:UserStorySpecification | specifiesPersonaContext | IC:PersonaSpecification | 0..* | 0..* |
| REL:W2:063 | IC:UserStorySpecification | supportedBy | IC:UserFlowSpecification | 0..* | 0..* |
| REL:W2:134 | IC:UserStorySpecification | hasStoryCriterion | IC:AcceptanceCriterionSpecification | 0..* | 0..* |
| REL:W2:135 | IC:ValidationFindingRecord | recordsResolutionChange | IC:ChangeRecord | 0..* | 0..* |
| REL:W2:167 | IC:QualityRequirementSpecification | supports | EXT:Business:BusinessGoal | 0..* | 0..* |
| REL:W2:213 | IC:UserStorySpecification | addressesPain | EXT:Market:Pain | 0..* | 0..* |

## Product Roadmap

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| REL:W2:064 | IC:Roadmap | organizesRoadmapEntry | IC:RoadmapEntry | 0..* | 1 |
| REL:W2:065 | IC:RoadmapEntry | plansInitiative | IC:InitiativeSpecification | 0..* | 0..* |
| REL:W2:066 | IC:RoadmapEntry | plansFeatureDelivery | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:067 | IC:RoadmapEntry | targetsMilestone | IC:MilestoneSpecification | 0..* | 0..* |
| REL:W2:068 | IC:RoadmapEntry | hasPriorityAssessment | IC:PriorityAssessment | 0..* | 1 |
| REL:W2:069 | IC:PriorityAssessment | usesRankingCriterion | IC:PrioritizationCriterionSpecification | 0..* | 0..* |
| REL:W2:070 | IC:RoadmapEntry | usesHorizonDefinition | IC:PlanningHorizonDefinition | 0..* | 0..* |
| REL:W2:071 | IC:RoadmapEntry | hasTargetWindowAssignment | IC:TargetWindowAssignment | 0..* | 1 |
| REL:W2:072 | IC:RoadmapEntry | hasEntryConfidenceAssessment | IC:ConfidenceAssessment | 0..* | 0..* |
| REL:W2:073 | IC:RoadmapEntry | usesCommitmentLevelDefinition | IC:CommitmentLevelDefinition | 0..* | 0..* |
| REL:W2:074 | IC:RoadmapEntry | hasPlanningDependency | IC:RoadmapEntry | 0..* | 0..* |
| REL:W2:139 | IC:Roadmap | intendsToSupportGoal | IC:GoalSpecification | 0..* | 0..* |
| REL:W2:140 | IC:RoadmapEntry | plansEntryRelease | IC:ReleaseSpecification | 0..* | 0..* |
| REL:W2:141 | IC:MilestoneSpecification | milestoneForReleaseSpecification | IC:ReleaseSpecification | 0..* | 0..* |
| REL:W2:142 | IC:PlanningHorizonDefinition | groupsPlannedInitiative | IC:InitiativeSpecification | 0..* | 0..* |
| REL:W2:143 | IC:TargetWindowAssignment | usesWindowHorizonDefinition | IC:PlanningHorizonDefinition | 0..1 | 0..* |

## Product Strategy

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| REL:ORSD06:decisionConsidersSolution | IC:DecisionRecord | decisionConsidersSolution | IC:SolutionSpecification | 0..* | 0..* |
| REL:ORSD06:decisionEvidence | IC:DecisionRecord | decisionEvidence | IC:EvidenceAttributionRecord | 0..* | 0..* |
| REL:ORSD06:decisionSelectsSolution | IC:DecisionRecord | decisionSelectsSolution | IC:SolutionSpecification | 0..* | 0..* |
| REL:W2:018 | IC:VisionStatement | motivatesGoal | IC:GoalSpecification | 0..* | 0..* |
| REL:W2:019 | IC:GoalSpecification | targetsOutcomeSpecification | IC:OutcomeSpecification | 0..* | 0..* |
| REL:W2:020 | IC:OutcomeSpecification | specifiesOutcomeMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:021 | IC:InitiativeSpecification | targetsOutcome | IC:OutcomeSpecification | 0..* | 0..* |
| REL:W2:022 | IC:ProblemStatement | motivatesOpportunity | IC:OpportunityStatement | 0..* | 0..* |
| REL:W2:023 | IC:OpportunityStatement | motivatesHypothesis | IC:HypothesisSpecification | 0..* | 0..* |
| REL:W2:024 | IC:HypothesisSpecification | motivatesSolutionHypothesis | IC:SolutionHypothesisSpecification | 0..* | 0..* |
| REL:W2:025 | IC:SolutionHypothesisSpecification | informsInitiative | IC:InitiativeSpecification | 0..* | 0..* |
| REL:W2:026 | IC:DecisionRecord | recordsCriterion | IC:DecisionCriterionSpecification | 0..* | 0..* |
| REL:W2:027 | IC:DecisionRecord | recordsAffectedInitiative | IC:InitiativeSpecification | 0..* | 0..* |
| REL:W2:028 | IC:ProblemSolutionFitAssessment | assessesProblem | IC:ProblemStatement | 1 | 0..* |
| REL:W2:029 | IC:ProblemSolutionFitAssessment | assessesSolution | IC:SolutionSpecification | 1 | 0..* |
| REL:W2:030 | IC:ProductMarketFitAssessment | assessesProduct | IC:Product | 1 | 0..* |
| REL:W2:033 | IC:OutcomeSpecification | expectedEnabledBy | IC:CapabilitySpecification | 0..* | 0..* |
| REL:W2:035 | IC:OpportunityStatement | hasProposedSolution | IC:SolutionSpecification | 0..* | 0..* |
| REL:W2:125 | IC:VisionStatement | framesFeature | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:126 | IC:InitiativeSpecification | intendsToSupportGoal | IC:GoalSpecification | 0..* | 0..* |
| REL:W2:127 | IC:InitiativeSpecification | tracksInitiativeReleaseSpecification | IC:ReleaseSpecification | 0..* | 0..* |
| REL:W2:128 | IC:HypothesisSpecification | hypothesizesAboutProblem | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:129 | IC:SolutionHypothesisSpecification | solutionHypothesizesAboutProblem | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:155 | IC:VisionStatement | addresses | IC:ProblemStatement | 0..* | 0..* |
| REL:W2:156 | IC:GoalSpecification | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:157 | IC:ProblemStatement | evidencedBy | EXT:EvidenceLayer:Evidence | 0..* | 0..* |
| REL:W2:158 | IC:OpportunityStatement | referencesMetric | IC:ProductMetricReference | 0..* | 0..* |
| REL:W2:159 | IC:HypothesisSpecification | predictsOutcome | IC:OutcomeSpecification | 0..* | 0..* |
| REL:W2:160 | IC:HypothesisSpecification | evidencedBy | EXT:EvidenceLayer:Evidence | 0..* | 0..* |
| REL:W2:161 | IC:SolutionHypothesisSpecification | solutionPredictsOutcome | IC:OutcomeSpecification | 0..* | 0..* |
| REL:W2:162 | IC:ProductMarketFitAssessment | evidencedBy | EXT:EvidenceLayer:Evidence | 0..* | 0..* |
| REL:W2:189 | IC:VisionStatement | targets | EXT:Market:CustomerSegment | 0..* | 0..* |
| REL:W2:190 | IC:VisionStatement | referencesValueProposition | EXT:Business:ValueProposition | 0..* | 0..* |
| REL:W2:192 | IC:ProblemSolutionFitAssessment | references | EXT:ExternalUnresolved:Evidence | 0..* | 0..* |
| REL:W2:209 | IC:VisionStatement | informedBy | EXT:Market:Need | 0..* | 0..* |
| REL:W2:210 | IC:ProductMarketFitAssessment | assessesNeed | EXT:Market:Need | 0..* | 0..* |
| REL:W2:211 | IC:ProductMarketFitAssessment | assessesPain | EXT:Market:Pain | 0..* | 0..* |

## Product Test

| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |
|---|---|---|---|---|---|
| ICREL:CP:assessesSpecification | IC:TestExecution | assessesSpecification | IC:CapabilitySpecification | 1..* | 0..* |
| ICREL:CP:testsRealization | IC:TestExecution | testsRealization | IC:ProductRealization | 1 | 0..* |
| REL:ORSD05:executionContext | IC:TestExecution | executionContext | IC:AssessmentContextSpecification | 1 | 0..* |
| REL:ORSD05:executionCriterion | IC:TestExecution | executionCriterion | IC:ConditionSpecification | 1..* | 0..* |
| REL:W2:084 | IC:TestScenario | covers | IC:FeatureSpecification | 0..* | 0..* |
| REL:W2:085 | IC:TestScenario | specifiesRequirementVerification | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:086 | IC:TestScenario | specifiesCriterionVerification | IC:AcceptanceCriterionSpecification | 0..* | 0..* |
| REL:W2:087 | IC:TestCase | refinesTestScenario | IC:TestScenario | 0..* | 0..* |
| REL:W2:088 | IC:TestSuiteSpecification | contains | IC:TestCase | 0..* | 0..* |
| REL:W2:089 | IC:TestCase | referencesTestData | IC:TestDataReference | 0..* | 0..* |
| REL:W2:090 | IC:TestExecution | executes | IC:TestCase | 1 | 0..* |
| REL:W2:091 | IC:TestExecution | hasResult | IC:TestResult | 1 | 1 |
| REL:W2:092 | IC:TestResult | hasVerificationEvidenceRecord | IC:VerificationEvidenceRecord | 0..* | 0..1 |
| REL:W2:093 | IC:TestResult | hasValidationEvidenceRecord | IC:ValidationEvidenceRecord | 0..* | 0..1 |
| REL:W2:146 | IC:TestCase | specifiesRequirementVerification | IC:RequirementSpecification | 0..* | 0..* |
| REL:W2:147 | IC:TestSuiteSpecification | hasRecordedExecution | IC:TestExecution | 0..* | 0..* |
| REL:W2:195 | IC:TestCase | usesScript | EXT:ExternalUnresolved:Test_Script | 0..* | 0..* |
| REL:W2:196 | IC:TestResult | reportedUnderTestPlan | EXT:ExternalUnresolved:Test_Plan | 0..* | 0..* |
| REL:W2:197 | IC:TestResult | citesExecutionScript | EXT:ExternalUnresolved:Test_Script | 0..* | 0..* |

## Generalizations

Each row asserts `forall X: specific(X) -> general(X)`.

| Identifier | Specific | General |
|---|---|---|
| GEN:IC04:ChangeRecord:EvidenceArtifact | IC:ChangeRecord | IC:EvidenceArtifact |
| GEN:IC04:MarketingGoalSpecification:GoalSpecification | IC:MarketingGoalSpecification | IC:GoalSpecification |
| GEN:IC04:PrioritizationCriterionSpecification:DecisionCriterionSpecification | IC:PrioritizationCriterionSpecification | IC:DecisionCriterionSpecification |
| GEN:IC04:ReleaseEvidence:EvidenceArtifact | IC:ReleaseEvidenceRecord | IC:EvidenceAttributionRecord |
| GEN:IC04:TestResult:EvidenceArtifact | IC:TestResult | IC:EvidenceArtifact |
| GEN:IC04:ValidationEvidence:EvidenceArtifact | IC:ValidationEvidenceRecord | IC:EvidenceAttributionRecord |
| GEN:IC04:VerificationEvidence:EvidenceArtifact | IC:VerificationEvidenceRecord | IC:EvidenceAttributionRecord |
| GEN:IC05:FindingRecord:EvidenceArtifact | IC:FindingRecord | IC:EvidenceArtifact |
| GEN:IC05:UsabilityFindingRecord:FindingRecord | IC:UsabilityFindingRecord | IC:FindingRecord |
| GEN:IC05:ValidationFindingRecord:FindingRecord | IC:ValidationFindingRecord | IC:FindingRecord |
| GEN:IC06:BusinessRuleReference | IC:BusinessRuleReference | IC:ExternalReferenceRecord |
| GEN:IC06:MarketingInsightReference | IC:MarketingInsightReference | IC:ExternalReferenceRecord |
| GEN:IC06:ProductFamilyReference | IC:ProductFamilyReference | IC:ExternalReferenceRecord |
| GEN:IC06:ProductLineReference | IC:ProductLineReference | IC:ExternalReferenceRecord |
| GEN:IC06:ProductMetricReference | IC:ProductMetricReference | IC:ExternalReferenceRecord |
| GEN:IC06:ProductVariantReference | IC:ProductVariantReference | IC:ExternalReferenceRecord |
| GEN:IC06:RequirementSourceReference | IC:RequirementSourceReference | IC:ExternalReferenceRecord |
| GEN:IC06:TargetMarketReference | IC:TargetMarketReference | IC:ExternalReferenceRecord |
| GEN:IC06:TargetSegmentReference | IC:TargetSegmentReference | IC:ExternalReferenceRecord |
| GEN:IC06:TaskReference | IC:TaskReference | IC:ExternalReferenceRecord |
| GEN:IC06:TestDataReference | IC:TestDataReference | IC:ExternalReferenceRecord |
| GEN:IC07:AcceptanceCriterionSpecification | IC:AcceptanceCriterionSpecification | IC:ConditionSpecification |
| GEN:IC07:ConstraintSpecification | IC:ConstraintSpecification | IC:ConditionSpecification |
| GEN:IC07:GoalSpecification | IC:GoalSpecification | IC:ConditionSpecification |
| GEN:IC07:OutcomeSpecification | IC:OutcomeSpecification | IC:ConditionSpecification |
| GEN:IC07:RequirementScenarioSpecification | IC:RequirementScenarioSpecification | IC:ScenarioSpecification |
| GEN:IC07:RequirementSpecification | IC:RequirementSpecification | IC:ConditionSpecification |
| GEN:IC07:TestCase | IC:TestCase | IC:ScenarioSpecification |
| GEN:IC07:TestScenario | IC:TestScenario | IC:ScenarioSpecification |
| GEN:PROPOSED:AcquisitionHypothesis | IC:AcquisitionHypothesisSpecification | IC:HypothesisSpecification |
| GEN:PROPOSED:AdoptionHypothesis | IC:AdoptionHypothesisSpecification | IC:HypothesisSpecification |
| GEN:PROPOSED:SolutionHypothesis | IC:SolutionHypothesisSpecification | IC:HypothesisSpecification |
| GEN:W2:152 | IC:FunctionalRequirementSpecification | IC:RequirementSpecification |
| GEN:W2:153 | IC:QualityRequirementSpecification | IC:RequirementSpecification |

The requirement content generalization set is neither disjoint nor complete. Neither condition is added. Stereotype labels remain annotations in this static theory; their full UFO modal semantics is not encoded.
