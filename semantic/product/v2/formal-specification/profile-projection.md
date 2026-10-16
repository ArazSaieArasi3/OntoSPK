# Explicit logical-profile projection

This generated reference translates the logical constructs present in the pinned Turtle profile. It is separate from the native structural theory. It does not supply a complete OWL 2 datatype theory, a UFO modal theory, or operational history policies.

The corresponding [TPTP file](profile-projection.p) contains expanded FOL. [Source bindings](source-bindings.json) identify the exact input; [symbols](symbols.json) map every predicate to its original IRI.

RDF annotations and class/property declarations do not assert that instances exist. XSD range IRIs are represented as abstract unary datatype predicates. Their value spaces, lexical normalization and the OWL object/data-domain separation are not axiomatized here.

## Expanded axioms

The `owl:AllDisjointClasses` declaration expands pairwise in the TPTP file. Its class list is shown once here; it does not imply that all ontology classes are disjoint.

```text
urn:productium:specification-profile:AssessmentClaim
urn:productium:specification-profile:BundleSpecification
urn:productium:specification-profile:CapabilitySpecification
urn:productium:specification-profile:ChangeProposalSpecification
urn:productium:specification-profile:ChangeRecord
urn:productium:specification-profile:CommitmentLevelDefinition
urn:productium:specification-profile:CompetitiveNarrative
urn:productium:specification-profile:ConditionSpecification
urn:productium:specification-profile:ConfidenceAssessment
urn:productium:specification-profile:DecisionCriterionSpecification
urn:productium:specification-profile:DecisionRecord
urn:productium:specification-profile:DeliveryStatusRecord
urn:productium:specification-profile:DeliveryWorkItem
urn:productium:specification-profile:DependencySpecification
urn:productium:specification-profile:EnablerSpecification
urn:productium:specification-profile:EvidenceAttributionRecord
urn:productium:specification-profile:ExternalReferenceRecord
urn:productium:specification-profile:FeatureFlagSpecification
urn:productium:specification-profile:FeatureSpecification
urn:productium:specification-profile:FindingRecord
urn:productium:specification-profile:GoToMarketSpecification
urn:productium:specification-profile:HypothesisSpecification
urn:productium:specification-profile:InformationArchitectureSpecification
urn:productium:specification-profile:InitiativeSpecification
urn:productium:specification-profile:InteractionStepSpecification
urn:productium:specification-profile:JourneySpecification
urn:productium:specification-profile:JourneyStageSpecification
urn:productium:specification-profile:LaunchSpecification
urn:productium:specification-profile:LifecycleSpecification
urn:productium:specification-profile:LifecycleStageSpecification
urn:productium:specification-profile:MessagingSpecification
urn:productium:specification-profile:MilestoneSpecification
urn:productium:specification-profile:OfferingSpecification
urn:productium:specification-profile:OpportunityStatement
urn:productium:specification-profile:PersonaSpecification
urn:productium:specification-profile:PlanningHorizonDefinition
urn:productium:specification-profile:PortfolioEntry
urn:productium:specification-profile:PositioningStatement
urn:productium:specification-profile:PriorityAssessment
urn:productium:specification-profile:ProblemSolutionFitAssessment
urn:productium:specification-profile:ProblemStatement
urn:productium:specification-profile:Product
urn:productium:specification-profile:ProductCapability
urn:productium:specification-profile:ProductMarketFitAssessment
urn:productium:specification-profile:ProductPortfolio
urn:productium:specification-profile:ProductRealization
urn:productium:specification-profile:ProductStatusRecord
urn:productium:specification-profile:ProductVersion
urn:productium:specification-profile:ReleaseSpecification
urn:productium:specification-profile:RequirementRationaleStatement
urn:productium:specification-profile:Roadmap
urn:productium:specification-profile:RoadmapEntry
urn:productium:specification-profile:ScenarioSpecification
urn:productium:specification-profile:ScopeSpecification
urn:productium:specification-profile:ScreenSpecification
urn:productium:specification-profile:SolutionSpecification
urn:productium:specification-profile:TargetWindowAssignment
urn:productium:specification-profile:TestExecution
urn:productium:specification-profile:TestResult
urn:productium:specification-profile:TestSuiteSpecification
urn:productium:specification-profile:TouchpointSpecification
urn:productium:specification-profile:UIStateSpecification
urn:productium:specification-profile:UserFlowSpecification
urn:productium:specification-profile:UserRoleSpecification
urn:productium:specification-profile:UserStorySpecification
urn:productium:specification-profile:VerticalSliceSpecification
urn:productium:specification-profile:VisionStatement
```

### profile_0001 — asymmetric

Source: `urn:productium:specification-profile:r8_supersedes`

```text
(! [X,Y] : (o_r8_supersedes_a59a0a58(X,Y) => ~(o_r8_supersedes_a59a0a58(Y,X))))
```

### profile_0002 — asymmetric

Source: `urn:product-ontology:delivery-profile:0.5:referenceSupersedes`

```text
(! [X,Y] : (o_referencesupersedes_67ba3120(X,Y) => ~(o_referencesupersedes_67ba3120(Y,X))))
```

### profile_0003 — asymmetric

Source: `urn:product-ontology:assessment-profile:0.4:scopeSupersedes`

```text
(! [X,Y] : (o_scopesupersedes_4c533220(X,Y) => ~(o_scopesupersedes_4c533220(Y,X))))
```

### profile_0004 — asymmetric

Source: `urn:product-ontology:trace-profile:0.6:stepPrecedes`

```text
(! [X,Y] : (o_stepprecedes_f878e3d5(X,Y) => ~(o_stepprecedes_f878e3d5(Y,X))))
```

### profile_0005 — chain

Source: `urn:productium:specification-profile:recordedAttributionTo`

```text
(! [X,Y,Z] : ((o_iscarrierinrecord_6fcdca61(X,Y) & o_recordsclaim_3d0873c5(Y,Z)) => o_recordedattributionto_3e20c24d(X,Z)))
```

### profile_0072 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_assessmentclaim_4878d612(X))))
```

### profile_0073 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_conditionspecification_bd3c5c1d(X))))
```

### profile_0074 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_evidenceartifact_6317ec1f(X))))
```

### profile_0075 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_evidenceattributionrecord_1c89f498(X))))
```

### profile_0076 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_productcapability_5801242c(X))))
```

### profile_0077 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_productrealization_b516a087(X))))
```

### profile_0078 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_productversion_e1d59901(X))))
```

### profile_0079 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_scenariospecification_131385c1(X))))
```

### profile_0080 — disjoint

Source: `urn:product-ontology:assessment-profile:0.4:AssessmentContextSpecification`

```text
(! [X] : ~((o_assessmentcontextspecification_9a5060b5(X) & o_scopespecification_beb9b28d(X))))
```

### profile_0795 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_deliverystatusrecord_e59c51e2(X))))
```

### profile_0796 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_deliveryworkitem_f98a3f27(X))))
```

### profile_0797 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_productcapability_5801242c(X))))
```

### profile_0798 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_productrealization_b516a087(X))))
```

### profile_0799 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_productversion_e1d59901(X))))
```

### profile_0800 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_releasespecification_37d609b4(X))))
```

### profile_0801 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_testexecution_483822c9(X))))
```

### profile_0802 — disjoint

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : ~((o_deliveryworkitemstatusrecord_17e65d34(X) & o_testresult_26ca0bda(X))))
```

### profile_0908 — disjoint

Source: `urn:productium:specification-profile:EvidenceArtifact`

```text
(! [X] : ~((o_evidenceartifact_6317ec1f(X) & o_assessmentclaim_4878d612(X))))
```

### profile_2235 — domain

Source: `urn:product-ontology:trace-profile:0.6:acquisitionCitesEvidence`

```text
(! [X,Y] : (o_acquisitioncitesevidence_f26cf4c5(X,Y) => o_acquisitionhypothesisspecification_6e118852(X)))
```

### profile_2236 — domain

Source: `urn:product-ontology:trace-profile:0.6:acquisitionCitesInsight`

```text
(! [X,Y] : (o_acquisitioncitesinsight_ce0a4a23(X,Y) => o_acquisitionhypothesisspecification_6e118852(X)))
```

### profile_2237 — domain

Source: `urn:product-ontology:trace-profile:0.6:adoptionCitesEvidence`

```text
(! [X,Y] : (o_adoptioncitesevidence_428719c3(X,Y) => o_adoptionhypothesisspecification_de10da7b(X)))
```

### profile_2238 — domain

Source: `urn:product-ontology:trace-profile:0.6:adoptionCitesInsight`

```text
(! [X,Y] : (o_adoptioncitesinsight_ca8a908f(X,Y) => o_adoptionhypothesisspecification_de10da7b(X)))
```

### profile_2239 — domain

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedRealizedByComponent`

```text
(! [X,Y] : (o_architecture_intendedrealizedbycomponent_e7a020a9(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2240 — domain

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedRealizedByService`

```text
(! [X,Y] : (o_architecture_intendedrealizedbyservice_ccc7d57c(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2241 — domain

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedSatisfiedByArchitectureElement`

```text
(! [X,Y] : (o_architecture_intendedsatisfiedbyarchitectureelement_5d473d90(X,Y) => o_requirementspecification_067f8073(X)))
```

### profile_2242 — domain

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedSatisfiedByInterface`

```text
(! [X,Y] : (o_architecture_intendedsatisfiedbyinterface_7a29350c(X,Y) => o_requirementspecification_067f8073(X)))
```

### profile_2243 — domain

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedSupportedByArchitectureElement`

```text
(! [X,Y] : (o_architecture_intendedsupportedbyarchitectureelement_7cafe8bc(X,Y) => o_capabilityspecification_73a1b978(X)))
```

### profile_2244 — domain

Source: `urn:productium:specification-profile:assessesProblem`

```text
(! [X,Y] : (o_assessesproblem_338b0d44(X,Y) => o_problemsolutionfitassessment_1c59291a(X)))
```

### profile_2245 — domain

Source: `urn:productium:specification-profile:assessesProduct`

```text
(! [X,Y] : (o_assessesproduct_26a7167f(X,Y) => o_productmarketfitassessment_c7e309d6(X)))
```

### profile_2246 — domain

Source: `urn:productium:specification-profile:assessesSolution`

```text
(! [X,Y] : (o_assessessolution_17cfc916(X,Y) => o_problemsolutionfitassessment_1c59291a(X)))
```

### profile_2247 — domain

Source: `urn:productium:specification-profile:assessesSpecification`

```text
(! [X,Y] : (o_assessesspecification_38115d6b(X,Y) => o_testexecution_483822c9(X)))
```

### profile_2248 — domain

Source: `urn:product-ontology:assessment-profile:0.4:attributionAgent`

```text
(! [X,Y] : (o_attributionagent_3e95a876(X,Y) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_2249 — domain

Source: `urn:product-ontology:assessment-profile:0.4:attributionSource`

```text
(! [X,Y] : (o_attributionsource_9f703f28(X,Y) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_2250 — domain

Source: `urn:product-ontology:assessment-profile:0.4:attributionStance`

```text
(! [X,Y] : (o_attributionstance_86be106a(X,Y) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_2251 — domain

Source: `urn:product-ontology:assessment-profile:0.4:attributionTimestamp`

```text
(! [X,Y] : (o_attributiontimestamp_edefea94(X,Y) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_2252 — domain

Source: `urn:productium:specification-profile:bearsCapability`

```text
(! [X,Y] : (o_bearscapability_2b724b5f(X,Y) => o_productrealization_b516a087(X)))
```

### profile_2253 — domain

Source: `urn:productium:specification-profile:canonicalOwner`

```text
(! [X,Y] : (o_canonicalowner_e9c00d88(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2254 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeDecision`

```text
(! [X,Y] : (o_changedecision_f64fbe05(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2255 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeFeature`

```text
(! [X,Y] : (o_changefeature_d145a21d(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2256 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeOccurrenceReference`

```text
(! [X,Y] : (o_changeoccurrencereference_851a5877(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2257 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeRecordedAt`

```text
(! [X,Y] : (o_changerecordedat_b51849a2(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2258 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeScope`

```text
(! [X,Y] : (o_changescope_3f8a92ef(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2259 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeSource`

```text
(! [X,Y] : (o_changesource_52403cd5(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2260 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeStatement`

```text
(! [X,Y] : (o_changestatement_0c3cf3b3(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2261 — domain

Source: `urn:product-ontology:trace-profile:0.6:changeTask`

```text
(! [X,Y] : (o_changetask_0b4d77dc(X,Y) => o_changerecord_f3de1b87(X)))
```

### profile_2262 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimActualCapability`

```text
(! [X,Y] : (o_claimactualcapability_27fec47c(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2263 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimContext`

```text
(! [X,Y] : (o_claimcontext_7950f82f(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2264 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimCriterion`

```text
(! [X,Y] : (o_claimcriterion_6a063ec1(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2265 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimIntendedCapability`

```text
(! [X,Y] : (o_claimintendedcapability_56a5a011(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2266 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimProduct`

```text
(! [X,Y] : (o_claimproduct_a8f421e4(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2267 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimRealization`

```text
(! [X,Y] : (o_claimrealization_2e93c51b(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2268 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimRequirement`

```text
(! [X,Y] : (o_claimrequirement_19e961d9(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2269 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimStatement`

```text
(! [X,Y] : (o_claimstatement_30ad9287(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2270 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimSubject`

```text
(! [X,Y] : (o_claimsubject_8dc7dd3c(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2271 — domain

Source: `urn:product-ontology:assessment-profile:0.4:claimVersion`

```text
(! [X,Y] : (o_claimversion_32b75c75(X,Y) => o_assessmentclaim_4878d612(X)))
```

### profile_2272 — domain

Source: `urn:productium:specification-profile:concernsRequirement`

```text
(! [X,Y] : (o_concernsrequirement_aa894472(X,Y) => o_validationfindingrecord_e628162e(X)))
```

### profile_2273 — domain

Source: `urn:productium:specification-profile:conditionContext`

```text
(! [X,Y] : (o_conditioncontext_0b036eac(X,Y) => o_conditionspecification_bd3c5c1d(X)))
```

### profile_2274 — domain

Source: `urn:productium:specification-profile:conditionStatement`

```text
(! [X,Y] : (o_conditionstatement_d35dee07(X,Y) => o_conditionspecification_bd3c5c1d(X)))
```

### profile_2275 — domain

Source: `urn:productium:specification-profile:constrainsRequirement`

```text
(! [X,Y] : (o_constrainsrequirement_a32faf49(X,Y) => o_constraintspecification_8fe3dc03(X)))
```

### profile_2276 — domain

Source: `urn:productium:specification-profile:containsCase`

```text
(! [X,Y] : (o_containscase_30232243(X,Y) => o_testsuitespecification_97bde355(X)))
```

### profile_2277 — domain

Source: `urn:productium:specification-profile:containsProduct`

```text
(! [X,Y] : (o_containsproduct_ecaaf85f(X,Y) => o_productportfolio_7289b5d8(X)))
```

### profile_2278 — domain

Source: `urn:productium:specification-profile:containsStage`

```text
(! [X,Y] : (o_containsstage_2deab665(X,Y) => o_journeyspecification_6c58f66d(X)))
```

### profile_2279 — domain

Source: `urn:product-ontology:assessment-profile:0.4:contextDescription`

```text
(! [X,Y] : (o_contextdescription_a35336af(X,Y) => o_assessmentcontextspecification_9a5060b5(X)))
```

### profile_2280 — domain

Source: `urn:product-ontology:assessment-profile:0.4:contextScenario`

```text
(! [X,Y] : (o_contextscenario_74327530(X,Y) => o_assessmentcontextspecification_9a5060b5(X)))
```

### profile_2281 — domain

Source: `urn:product-ontology:assessment-profile:0.4:contextSource`

```text
(! [X,Y] : (o_contextsource_10343fb1(X,Y) => o_assessmentcontextspecification_9a5060b5(X)))
```

### profile_2282 — domain

Source: `urn:product-ontology:assessment-profile:0.4:contextVersion`

```text
(! [X,Y] : (o_contextversion_b62a88f2(X,Y) => o_assessmentcontextspecification_9a5060b5(X)))
```

### profile_2283 — domain

Source: `urn:product-ontology:trace-profile:0.6:decisionConsidersSolution`

```text
(! [X,Y] : (o_decisionconsiderssolution_6ba3a05f(X,Y) => o_decisionrecord_d6051b08(X)))
```

### profile_2284 — domain

Source: `urn:product-ontology:trace-profile:0.6:decisionEvidence`

```text
(! [X,Y] : (o_decisionevidence_98d8b65a(X,Y) => o_decisionrecord_d6051b08(X)))
```

### profile_2285 — domain

Source: `urn:product-ontology:trace-profile:0.6:decisionRationale`

```text
(! [X,Y] : (o_decisionrationale_a17588c8(X,Y) => o_decisionrecord_d6051b08(X)))
```

### profile_2286 — domain

Source: `urn:product-ontology:trace-profile:0.6:decisionSelectsSolution`

```text
(! [X,Y] : (o_decisionselectssolution_595fe441(X,Y) => o_decisionrecord_d6051b08(X)))
```

### profile_2287 — domain

Source: `urn:product-ontology:trace-profile:0.6:decisionSource`

```text
(! [X,Y] : (o_decisionsource_5e2bafbc(X,Y) => o_decisionrecord_d6051b08(X)))
```

### profile_2288 — domain

Source: `urn:product-ontology:assessment-profile:0.4:deferredStatement`

```text
(! [X,Y] : (o_deferredstatement_cb96fd07(X,Y) => o_scopespecification_beb9b28d(X)))
```

### profile_2289 — domain

Source: `urn:productium:specification-profile:definesLifecycleStage`

```text
(! [X,Y] : (o_defineslifecyclestage_9a9dcdbb(X,Y) => o_lifecyclespecification_8ccb5ce0(X)))
```

### profile_2290 — domain

Source: `urn:product-ontology:trace-profile:0.6:dependencyActualCapabilityTarget`

```text
(! [X,Y] : (o_dependencyactualcapabilitytarget_5f4e89b9(X,Y) => o_dependencyspecification_9401a9e8(X)))
```

### profile_2291 — domain

Source: `urn:product-ontology:trace-profile:0.6:dependencyCapabilitySpecificationTarget`

```text
(! [X,Y] : (o_dependencycapabilityspecificationtarget_cfd20400(X,Y) => o_dependencyspecification_9401a9e8(X)))
```

### profile_2292 — domain

Source: `urn:product-ontology:trace-profile:0.6:dependencyCondition`

```text
(! [X,Y] : (o_dependencycondition_cc5a91c9(X,Y) => o_dependencyspecification_9401a9e8(X)))
```

### profile_2293 — domain

Source: `urn:product-ontology:trace-profile:0.6:dependencyExternalTarget`

```text
(! [X,Y] : (o_dependencyexternaltarget_24a02018(X,Y) => o_dependencyspecification_9401a9e8(X)))
```

### profile_2294 — domain

Source: `urn:product-ontology:trace-profile:0.6:dependencyProductTarget`

```text
(! [X,Y] : (o_dependencyproducttarget_c8cb5b8c(X,Y) => o_dependencyspecification_9401a9e8(X)))
```

### profile_2295 — domain

Source: `urn:product-ontology:trace-profile:0.6:dependencySource`

```text
(! [X,Y] : (o_dependencysource_84023279(X,Y) => o_dependencyspecification_9401a9e8(X)))
```

### profile_2296 — domain

Source: `urn:productium:specification-profile:dependsOnEnablerSpecification`

```text
(! [X,Y] : (o_dependsonenablerspecification_e09124c8(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2297 — domain

Source: `urn:productium:specification-profile:evaluatedAgainst`

```text
(! [X,Y] : (o_evaluatedagainst_b6d44896(X,Y) => o_productcapability_5801242c(X)))
```

### profile_2298 — domain

Source: `urn:product-ontology:assessment-profile:0.4:excludedStatement`

```text
(! [X,Y] : (o_excludedstatement_bd86f1d3(X,Y) => o_scopespecification_beb9b28d(X)))
```

### profile_2299 — domain

Source: `urn:productium:specification-profile:executes`

```text
(! [X,Y] : (o_executes_ed879ee9(X,Y) => o_testexecution_483822c9(X)))
```

### profile_2300 — domain

Source: `urn:product-ontology:delivery-profile:0.5:executionContext`

```text
(! [X,Y] : (o_executioncontext_02a29f55(X,Y) => o_testexecution_483822c9(X)))
```

### profile_2301 — domain

Source: `urn:product-ontology:delivery-profile:0.5:executionCriterion`

```text
(! [X,Y] : (o_executioncriterion_db30b082(X,Y) => o_testexecution_483822c9(X)))
```

### profile_2302 — domain

Source: `urn:product-ontology:delivery-profile:0.5:executionEndedAt`

```text
(! [X,Y] : (o_executionendedat_2fa28738(X,Y) => o_testexecution_483822c9(X)))
```

### profile_2303 — domain

Source: `urn:productium:specification-profile:exemplifiedByScenario`

```text
(! [X,Y] : (o_exemplifiedbyscenario_2222458f(X,Y) => o_acceptancecriterionspecification_0299ae3e(X)))
```

### profile_2304 — domain

Source: `urn:productium:specification-profile:expectedEnabledBy`

```text
(! [X,Y] : (o_expectedenabledby_66626032(X,Y) => o_outcomespecification_05ee7bc3(X)))
```

### profile_2305 — domain

Source: `urn:product-ontology:assessment-profile:0.4:findingSource`

```text
(! [X,Y] : (o_findingsource_666e303f(X,Y) => o_findingrecord_6c235440(X)))
```

### profile_2306 — domain

Source: `urn:product-ontology:assessment-profile:0.4:findingStatement`

```text
(! [X,Y] : (o_findingstatement_ba684cd2(X,Y) => o_findingrecord_6c235440(X)))
```

### profile_2307 — domain

Source: `urn:productium:specification-profile:hasDependencySpecification`

```text
(! [X,Y] : (o_hasdependencyspecification_b4f40c53(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2308 — domain

Source: `urn:productium:specification-profile:hasFeatureCriterion`

```text
(! [X,Y] : (o_hasfeaturecriterion_3b1e170f(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2309 — domain

Source: `urn:productium:specification-profile:hasProductStatusRecord`

```text
(! [X,Y] : (o_hasproductstatusrecord_d1c2c559(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2310 — domain

Source: `urn:productium:specification-profile:hasProposedSolution`

```text
(! [X,Y] : (o_hasproposedsolution_f48d80c8(X,Y) => o_opportunitystatement_b89a8713(X)))
```

### profile_2311 — domain

Source: `urn:productium:specification-profile:hasScopeSpecification`

```text
(! [X,Y] : (o_hasscopespecification_15ac67e9(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2312 — domain

Source: `urn:productium:specification-profile:hasStoryCriterion`

```text
(! [X,Y] : (o_hasstorycriterion_324c6d65(X,Y) => o_userstoryspecification_680a42c6(X)))
```

### profile_2313 — domain

Source: `urn:productium:specification-profile:hasStorySpecification`

```text
(! [X,Y] : (o_hasstoryspecification_d8dd9c41(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2314 — domain

Source: `urn:productium:specification-profile:hasVersion`

```text
(! [X,Y] : (o_hasversion_4f56b7f5(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2315 — domain

Source: `urn:productium:specification-profile:hasVisionStatement`

```text
(! [X,Y] : (o_hasvisionstatement_4d04c805(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2316 — domain

Source: `urn:productium:specification-profile:hypothesizesAboutProblem`

```text
(! [X,Y] : (o_hypothesizesaboutproblem_ab4d9ffa(X,Y) => o_hypothesisspecification_9a33f1c8(X)))
```

### profile_2317 — domain

Source: `urn:productium:specification-profile:implementsFeature`

```text
(! [X,Y] : (o_implementsfeature_60c7b80d(X,Y) => o_productrealization_b516a087(X)))
```

### profile_2318 — domain

Source: `urn:product-ontology:assessment-profile:0.4:includedStatement`

```text
(! [X,Y] : (o_includedstatement_01f21b71(X,Y) => o_scopespecification_beb9b28d(X)))
```

### profile_2319 — domain

Source: `urn:productium:specification-profile:informsInitiative`

```text
(! [X,Y] : (o_informsinitiative_91e95196(X,Y) => o_solutionhypothesisspecification_724e7cc7(X)))
```

### profile_2320 — domain

Source: `urn:productium:specification-profile:intendedToEnableFeature`

```text
(! [X,Y] : (o_intendedtoenablefeature_d4c185e5(X,Y) => o_enablerspecification_4a676984(X)))
```

### profile_2321 — domain

Source: `urn:productium:specification-profile:intendsCapability`

```text
(! [X,Y] : (o_intendscapability_32debd07(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2322 — domain

Source: `urn:productium:specification-profile:intendsToAddressProblem`

```text
(! [X,Y] : (o_intendstoaddressproblem_b7999f7d(X,Y) => o_solutionspecification_ca854bd1(X)))
```

### profile_2323 — domain

Source: `urn:productium:specification-profile:intendsToContributeToOutcome`

```text
(! [X,Y] : (o_intendstocontributetooutcome_26f1e26d(X,Y) => o_solutionspecification_ca854bd1(X)))
```

### profile_2324 — domain

Source: `urn:productium:specification-profile:intendsToSupportGoal`

```text
(! [X,Y] : (o_intendstosupportgoal_ca793e16(X,Y) => o_initiativespecification_5404588f(X)))
```

### profile_2325 — domain

Source: `urn:product-ontology:delivery-profile:0.5:itemStatus`

```text
(! [X,Y] : (o_itemstatus_370b117a(X,Y) => o_deliveryworkitem_f98a3f27(X)))
```

### profile_2326 — domain

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusChange`

```text
(! [X,Y] : (o_itemstatuschange_1f124dff(X,Y) => o_deliveryworkitemstatusrecord_17e65d34(X)))
```

### profile_2327 — domain

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusCode`

```text
(! [X,Y] : (o_itemstatuscode_a08e2882(X,Y) => o_deliveryworkitemstatusrecord_17e65d34(X)))
```

### profile_2328 — domain

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusReportedAt`

```text
(! [X,Y] : (o_itemstatusreportedat_5cd2a459(X,Y) => o_deliveryworkitemstatusrecord_17e65d34(X)))
```

### profile_2329 — domain

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusScheme`

```text
(! [X,Y] : (o_itemstatusscheme_abd64624(X,Y) => o_deliveryworkitemstatusrecord_17e65d34(X)))
```

### profile_2330 — domain

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusSource`

```text
(! [X,Y] : (o_itemstatussource_abbfc60e(X,Y) => o_deliveryworkitemstatusrecord_17e65d34(X)))
```

### profile_2331 — domain

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusVersion`

```text
(! [X,Y] : (o_itemstatusversion_83352ce1(X,Y) => o_deliveryworkitemstatusrecord_17e65d34(X)))
```

### profile_2332 — domain

Source: `urn:productium:specification-profile:justifiesRequirement`

```text
(! [X,Y] : (o_justifiesrequirement_19321de4(X,Y) => o_requirementrationalestatement_dc35d28b(X)))
```

### profile_2333 — domain

Source: `urn:productium:specification-profile:motivatesGoal`

```text
(! [X,Y] : (o_motivatesgoal_1f820745(X,Y) => o_visionstatement_cc6f8a1e(X)))
```

### profile_2334 — domain

Source: `urn:productium:specification-profile:motivatesHypothesis`

```text
(! [X,Y] : (o_motivateshypothesis_17ba4d64(X,Y) => o_opportunitystatement_b89a8713(X)))
```

### profile_2335 — domain

Source: `urn:productium:specification-profile:motivatesSolutionHypothesis`

```text
(! [X,Y] : (o_motivatessolutionhypothesis_906ea5a3(X,Y) => o_hypothesisspecification_9a33f1c8(X)))
```

### profile_2336 — domain

Source: `urn:product-ontology:trace-profile:0.6:narrativeCitesEvidence`

```text
(! [X,Y] : (o_narrativecitesevidence_4c4cfa6a(X,Y) => o_competitivenarrative_88476b59(X)))
```

### profile_2337 — domain

Source: `urn:product-ontology:trace-profile:0.6:narrativeCitesInsight`

```text
(! [X,Y] : (o_narrativecitesinsight_effdb379(X,Y) => o_competitivenarrative_88476b59(X)))
```

### profile_2338 — domain

Source: `urn:product-ontology:delivery-profile:0.5:observedAuthority`

```text
(! [X,Y] : (o_observedauthority_0599d34b(X,Y) => o_findingrecord_6c235440(X)))
```

### profile_2339 — domain

Source: `urn:product-ontology:delivery-profile:0.5:observedTarget`

```text
(! [X,Y] : (o_observedtarget_32dd708a(X,Y) => o_findingrecord_6c235440(X)))
```

### profile_2340 — domain

Source: `urn:productium:specification-profile:offeringOf`

```text
(! [X,Y] : (o_offeringof_38930d39(X,Y) => o_offeringspecification_fd5297ce(X)))
```

### profile_2341 — domain

Source: `urn:productium:specification-profile:operationalizedByCriterion`

```text
(! [X,Y] : (o_operationalizedbycriterion_dab109a6(X,Y) => o_requirementspecification_067f8073(X)))
```

### profile_2342 — domain

Source: `urn:productium:specification-profile:organizesEntry`

```text
(! [X,Y] : (o_organizesentry_8770c5a7(X,Y) => o_productportfolio_7289b5d8(X)))
```

### profile_2343 — domain

Source: `urn:productium:specification-profile:personaContext`

```text
(! [X,Y] : (o_personacontext_dfcf9689(X,Y) => o_personaspecification_81fd0066(X)))
```

### profile_2344 — domain

Source: `urn:productium:specification-profile:personaDescription`

```text
(! [X,Y] : (o_personadescription_d3f39048(X,Y) => o_personaspecification_81fd0066(X)))
```

### profile_2345 — domain

Source: `urn:productium:specification-profile:predictsOutcome`

```text
(! [X,Y] : (o_predictsoutcome_89abbedd(X,Y) => o_hypothesisspecification_9a33f1c8(X)))
```

### profile_2346 — domain

Source: `urn:product-ontology:trace-profile:0.6:proposalFeature`

```text
(! [X,Y] : (o_proposalfeature_019a6892(X,Y) => o_changeproposalspecification_970520af(X)))
```

### profile_2347 — domain

Source: `urn:product-ontology:trace-profile:0.6:proposalScope`

```text
(! [X,Y] : (o_proposalscope_0facbcb1(X,Y) => o_changeproposalspecification_970520af(X)))
```

### profile_2348 — domain

Source: `urn:product-ontology:trace-profile:0.6:proposalSource`

```text
(! [X,Y] : (o_proposalsource_dea17c01(X,Y) => o_changeproposalspecification_970520af(X)))
```

### profile_2349 — domain

Source: `urn:product-ontology:trace-profile:0.6:proposalStatement`

```text
(! [X,Y] : (o_proposalstatement_9485e7f4(X,Y) => o_changeproposalspecification_970520af(X)))
```

### profile_2350 — domain

Source: `urn:productium:specification-profile:proposesCapability`

```text
(! [X,Y] : (o_proposescapability_c6854e04(X,Y) => o_solutionspecification_ca854bd1(X)))
```

### profile_2351 — domain

Source: `urn:productium:specification-profile:proposesFeature`

```text
(! [X,Y] : (o_proposesfeature_d77fdc30(X,Y) => o_solutionspecification_ca854bd1(X)))
```

### profile_2352 — domain

Source: `urn:productium:specification-profile:r100_usesPositioningStatement`

```text
(! [X,Y] : (o_r100_usespositioningstatement_7d9e1c8f(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2353 — domain

Source: `urn:productium:specification-profile:r101_plansLaunch`

```text
(! [X,Y] : (o_r101_planslaunch_3f463a58(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2354 — domain

Source: `urn:productium:specification-profile:r102_targetsMarketingGoal`

```text
(! [X,Y] : (o_r102_targetsmarketinggoal_24bd6c0f(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2355 — domain

Source: `urn:productium:specification-profile:r103_informsPositioningStatement`

```text
(! [X,Y] : (o_r103_informspositioningstatement_120b1242(X,Y) => o_marketinginsightreference_ecbebe36(X)))
```

### profile_2356 — domain

Source: `urn:productium:specification-profile:r104_informsGoToMarketSpecification`

```text
(! [X,Y] : (o_r104_informsgotomarketspecification_02341859(X,Y) => o_marketinginsightreference_ecbebe36(X)))
```

### profile_2357 — domain

Source: `urn:productium:specification-profile:r105_informsGoToMarketFromAcquisition`

```text
(! [X,Y] : (o_r105_informsgotomarketfromacquisition_feb8a2fc(X,Y) => o_acquisitionhypothesisspecification_6e118852(X)))
```

### profile_2358 — domain

Source: `urn:productium:specification-profile:r106_informsGoToMarketFromAdoption`

```text
(! [X,Y] : (o_r106_informsgotomarketfromadoption_b0f8bd14(X,Y) => o_adoptionhypothesisspecification_de10da7b(X)))
```

### profile_2359 — domain

Source: `urn:product-ontology:relation-profile:0.7:r107_intendedToSupport`

```text
(! [X,Y] : (o_r107_intendedtosupport_a55e674b(X,Y) => o_capabilityspecification_73a1b978(X)))
```

### profile_2360 — domain

Source: `urn:product-ontology:relation-profile:0.7:r116_references`

```text
(! [X,Y] : (o_r116_references_63e63e34(X,Y) => o_positioningstatement_23009b5a(X)))
```

### profile_2361 — domain

Source: `urn:productium:specification-profile:r117_tracksInitiative`

```text
(! [X,Y] : (o_r117_tracksinitiative_681adc26(X,Y) => o_productportfolio_7289b5d8(X)))
```

### profile_2362 — domain

Source: `urn:productium:specification-profile:r118_tracksReleaseSpecification`

```text
(! [X,Y] : (o_r118_tracksreleasespecification_df925b75(X,Y) => o_productportfolio_7289b5d8(X)))
```

### profile_2363 — domain

Source: `urn:productium:specification-profile:r119_tracksMilestoneSpecification`

```text
(! [X,Y] : (o_r119_tracksmilestonespecification_daacb60c(X,Y) => o_productportfolio_7289b5d8(X)))
```

### profile_2364 — domain

Source: `urn:productium:specification-profile:r120_referencesProductLine`

```text
(! [X,Y] : (o_r120_referencesproductline_8119739b(X,Y) => o_productportfolio_7289b5d8(X)))
```

### profile_2365 — domain

Source: `urn:productium:specification-profile:r121_hasPortfolioConfidenceAssessment`

```text
(! [X,Y] : (o_r121_hasportfolioconfidenceassessment_8c1fdc29(X,Y) => o_productportfolio_7289b5d8(X)))
```

### profile_2366 — domain

Source: `urn:productium:specification-profile:r122_targetsPersona`

```text
(! [X,Y] : (o_r122_targetspersona_ae33ca6e(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2367 — domain

Source: `urn:productium:specification-profile:r123_framesJourney`

```text
(! [X,Y] : (o_r123_framesjourney_c1aae71e(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2368 — domain

Source: `urn:productium:specification-profile:r125_framesFeature`

```text
(! [X,Y] : (o_r125_framesfeature_be65a400(X,Y) => o_visionstatement_cc6f8a1e(X)))
```

### profile_2369 — domain

Source: `urn:productium:specification-profile:r127_tracksInitiativeReleaseSpecification`

```text
(! [X,Y] : (o_r127_tracksinitiativereleasespecification_bfe3d8f2(X,Y) => o_initiativespecification_5404588f(X)))
```

### profile_2370 — domain

Source: `urn:productium:specification-profile:r133_supportedBy`

```text
(! [X,Y] : (o_r133_supportedby_3ea116b3(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2371 — domain

Source: `urn:productium:specification-profile:r135_recordsResolutionChange`

```text
(! [X,Y] : (o_r135_recordsresolutionchange_c4c748e4(X,Y) => o_validationfindingrecord_e628162e(X)))
```

### profile_2372 — domain

Source: `urn:productium:specification-profile:r136_includes`

```text
(! [X,Y] : (o_r136_includes_f27d15f3(X,Y) => o_journeyspecification_6c58f66d(X)))
```

### profile_2373 — domain

Source: `urn:productium:specification-profile:r137_includesScreen`

```text
(! [X,Y] : (o_r137_includesscreen_b67b76df(X,Y) => o_userflowspecification_fb730f56(X)))
```

### profile_2374 — domain

Source: `urn:productium:specification-profile:r138_precededBy`

```text
(! [X,Y] : (o_r138_precededby_4bd62bab(X,Y) => o_screenspecification_cad2e1fc(X)))
```

### profile_2375 — domain

Source: `urn:productium:specification-profile:r139_intendsToSupportGoal`

```text
(! [X,Y] : (o_r139_intendstosupportgoal_99240761(X,Y) => o_roadmap_381d20e5(X)))
```

### profile_2376 — domain

Source: `urn:productium:specification-profile:r140_plansEntryRelease`

```text
(! [X,Y] : (o_r140_plansentryrelease_6edbf91c(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2377 — domain

Source: `urn:productium:specification-profile:r141_milestoneForReleaseSpecification`

```text
(! [X,Y] : (o_r141_milestoneforreleasespecification_436e77e6(X,Y) => o_milestonespecification_585f68a5(X)))
```

### profile_2378 — domain

Source: `urn:productium:specification-profile:r142_groupsPlannedInitiative`

```text
(! [X,Y] : (o_r142_groupsplannedinitiative_5df56fc8(X,Y) => o_planninghorizondefinition_b6519652(X)))
```

### profile_2379 — domain

Source: `urn:productium:specification-profile:r143_usesWindowHorizonDefinition`

```text
(! [X,Y] : (o_r143_useswindowhorizondefinition_61719e93(X,Y) => o_targetwindowassignment_f8688c9e(X)))
```

### profile_2380 — domain

Source: `urn:productium:specification-profile:r144_targetsReleaseGoal`

```text
(! [X,Y] : (o_r144_targetsreleasegoal_95fe86ff(X,Y) => o_releasespecification_37d609b4(X)))
```

### profile_2381 — domain

Source: `urn:productium:specification-profile:r145_concernsDeliveryWorkItem`

```text
(! [X,Y] : (o_r145_concernsdeliveryworkitem_4adaf68c(X,Y) => o_releaseevidencerecord_0b26c3e8(X)))
```

### profile_2382 — domain

Source: `urn:productium:specification-profile:r146_specifiesRequirementVerification`

```text
(! [X,Y] : (o_r146_specifiesrequirementverification_23b89ac8(X,Y) => o_testcase_d5ce3254(X)))
```

### profile_2383 — domain

Source: `urn:productium:specification-profile:r147_hasRecordedExecution`

```text
(! [X,Y] : (o_r147_hasrecordedexecution_b149d286(X,Y) => o_testsuitespecification_97bde355(X)))
```

### profile_2384 — domain

Source: `urn:productium:specification-profile:r148_referencesJourneyStage`

```text
(! [X,Y] : (o_r148_referencesjourneystage_f1b07c84(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2385 — domain

Source: `urn:productium:specification-profile:r149_targetsLaunchPersona`

```text
(! [X,Y] : (o_r149_targetslaunchpersona_b7340d99(X,Y) => o_launchspecification_19376d8c(X)))
```

### profile_2386 — domain

Source: `urn:productium:specification-profile:r150_usesLaunchPositioning`

```text
(! [X,Y] : (o_r150_useslaunchpositioning_df725e36(X,Y) => o_launchspecification_19376d8c(X)))
```

### profile_2387 — domain

Source: `urn:productium:specification-profile:r151_usesLaunchMessaging`

```text
(! [X,Y] : (o_r151_useslaunchmessaging_fc78021d(X,Y) => o_launchspecification_19376d8c(X)))
```

### profile_2388 — domain

Source: `urn:productium:specification-profile:r154_referencesMetric`

```text
(! [X,Y] : (o_r154_referencesmetric_5e8c4c07(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2389 — domain

Source: `urn:productium:specification-profile:r155_addresses`

```text
(! [X,Y] : (o_r155_addresses_03ac5ee1(X,Y) => o_visionstatement_cc6f8a1e(X)))
```

### profile_2390 — domain

Source: `urn:productium:specification-profile:r156_referencesMetric`

```text
(! [X,Y] : (o_r156_referencesmetric_e08298d2(X,Y) => o_goalspecification_9ac1cc8d(X)))
```

### profile_2391 — domain

Source: `urn:product-ontology:relation-profile:0.7:r157_evidencedBy`

```text
(! [X,Y] : (o_r157_evidencedby_0c148076(X,Y) => o_problemstatement_fe6d79b3(X)))
```

### profile_2392 — domain

Source: `urn:productium:specification-profile:r158_referencesMetric`

```text
(! [X,Y] : (o_r158_referencesmetric_faff69ea(X,Y) => o_opportunitystatement_b89a8713(X)))
```

### profile_2393 — domain

Source: `urn:product-ontology:relation-profile:0.7:r160_evidencedBy`

```text
(! [X,Y] : (o_r160_evidencedby_f78dca6e(X,Y) => o_hypothesisspecification_9a33f1c8(X)))
```

### profile_2394 — domain

Source: `urn:product-ontology:relation-profile:0.7:r162_evidencedBy`

```text
(! [X,Y] : (o_r162_evidencedby_a21fefbd(X,Y) => o_productmarketfitassessment_c7e309d6(X)))
```

### profile_2395 — domain

Source: `urn:productium:specification-profile:r164_intendsToAddressProblem`

```text
(! [X,Y] : (o_r164_intendstoaddressproblem_1652c40a(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2396 — domain

Source: `urn:productium:specification-profile:r165_specifiesBeneficiaryPersona`

```text
(! [X,Y] : (o_r165_specifiesbeneficiarypersona_54ff8b06(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2397 — domain

Source: `urn:productium:specification-profile:r166_referencesMetric`

```text
(! [X,Y] : (o_r166_referencesmetric_bb043a79(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2398 — domain

Source: `urn:product-ontology:relation-profile:0.7:r167_supports`

```text
(! [X,Y] : (o_r167_supports_ac5c3998(X,Y) => o_qualityrequirementspecification_538881c0(X)))
```

### profile_2399 — domain

Source: `urn:productium:specification-profile:r168_identifiesOpportunity`

```text
(! [X,Y] : (o_r168_identifiesopportunity_67e1eb38(X,Y) => o_journeyspecification_6c58f66d(X)))
```

### profile_2400 — domain

Source: `urn:productium:specification-profile:r169_referencesMetric`

```text
(! [X,Y] : (o_r169_referencesmetric_8b89a396(X,Y) => o_journeyspecification_6c58f66d(X)))
```

### profile_2401 — domain

Source: `urn:productium:specification-profile:r170_identifiesOpportunity`

```text
(! [X,Y] : (o_r170_identifiesopportunity_1891e592(X,Y) => o_journeystagespecification_4d216026(X)))
```

### profile_2402 — domain

Source: `urn:productium:specification-profile:r171_referencesMetric`

```text
(! [X,Y] : (o_r171_referencesmetric_60f96202(X,Y) => o_journeystagespecification_4d216026(X)))
```

### profile_2403 — domain

Source: `urn:productium:specification-profile:r172_addressesProblemStatement`

```text
(! [X,Y] : (o_r172_addressesproblemstatement_c107d468(X,Y) => o_positioningstatement_23009b5a(X)))
```

### profile_2404 — domain

Source: `urn:productium:specification-profile:r173_claimsDifferentiationThrough`

```text
(! [X,Y] : (o_r173_claimsdifferentiationthrough_32299f8b(X,Y) => o_positioningstatement_23009b5a(X)))
```

### profile_2405 — domain

Source: `urn:productium:specification-profile:r174_targetsMessagePersona`

```text
(! [X,Y] : (o_r174_targetsmessagepersona_4f03fd4a(X,Y) => o_messagingspecification_24de7362(X)))
```

### profile_2406 — domain

Source: `urn:productium:specification-profile:r175_referencesMessageFeature`

```text
(! [X,Y] : (o_r175_referencesmessagefeature_8652872f(X,Y) => o_messagingspecification_24de7362(X)))
```

### profile_2407 — domain

Source: `urn:productium:specification-profile:r176_referencesMetric`

```text
(! [X,Y] : (o_r176_referencesmetric_7f5339f1(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2408 — domain

Source: `urn:productium:specification-profile:r177_referencesMetric`

```text
(! [X,Y] : (o_r177_referencesmetric_585bd336(X,Y) => o_launchspecification_19376d8c(X)))
```

### profile_2409 — domain

Source: `urn:productium:specification-profile:r178_referencesMetric`

```text
(! [X,Y] : (o_r178_referencesmetric_16b8c658(X,Y) => o_marketinggoalspecification_19f0f0dc(X)))
```

### profile_2410 — domain

Source: `urn:productium:specification-profile:r179_addressesNarrativeProblem`

```text
(! [X,Y] : (o_r179_addressesnarrativeproblem_34764f2c(X,Y) => o_competitivenarrative_88476b59(X)))
```

### profile_2411 — domain

Source: `urn:productium:specification-profile:r180_claimsDifferentiationThrough`

```text
(! [X,Y] : (o_r180_claimsdifferentiationthrough_ad8a3f6b(X,Y) => o_competitivenarrative_88476b59(X)))
```

### profile_2412 — domain

Source: `urn:productium:specification-profile:r181_hypothesizesAcquisitionForProblem`

```text
(! [X,Y] : (o_r181_hypothesizesacquisitionforproblem_3b87a7c1(X,Y) => o_acquisitionhypothesisspecification_6e118852(X)))
```

### profile_2413 — domain

Source: `urn:productium:specification-profile:r182_referencesMetric`

```text
(! [X,Y] : (o_r182_referencesmetric_a7139da4(X,Y) => o_acquisitionhypothesisspecification_6e118852(X)))
```

### profile_2414 — domain

Source: `urn:productium:specification-profile:r183_hypothesizesAdoptionForProblem`

```text
(! [X,Y] : (o_r183_hypothesizesadoptionforproblem_b930ea90(X,Y) => o_adoptionhypothesisspecification_de10da7b(X)))
```

### profile_2415 — domain

Source: `urn:productium:specification-profile:r184_referencesMetric`

```text
(! [X,Y] : (o_r184_referencesmetric_73452d4c(X,Y) => o_adoptionhypothesisspecification_de10da7b(X)))
```

### profile_2416 — domain

Source: `urn:product-ontology:relation-profile:0.7:r185_referencesValueProposition`

```text
(! [X,Y] : (o_r185_referencesvalueproposition_ffb84690(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2417 — domain

Source: `urn:product-ontology:relation-profile:0.7:r186_targets`

```text
(! [X,Y] : (o_r186_targets_2cb09f38(X,Y) => o_offeringspecification_fd5297ce(X)))
```

### profile_2418 — domain

Source: `urn:product-ontology:relation-profile:0.7:r187_includesService`

```text
(! [X,Y] : (o_r187_includesservice_8dab3bd6(X,Y) => o_offeringspecification_fd5297ce(X)))
```

### profile_2419 — domain

Source: `urn:product-ontology:relation-profile:0.7:r188_referencesVariantConfiguration`

```text
(! [X,Y] : (o_r188_referencesvariantconfiguration_763729c8(X,Y) => o_productvariantreference_0a8d9825(X)))
```

### profile_2420 — domain

Source: `urn:product-ontology:relation-profile:0.7:r189_targets`

```text
(! [X,Y] : (o_r189_targets_f54bba9b(X,Y) => o_visionstatement_cc6f8a1e(X)))
```

### profile_2421 — domain

Source: `urn:product-ontology:relation-profile:0.7:r190_referencesValueProposition`

```text
(! [X,Y] : (o_r190_referencesvalueproposition_e34183b3(X,Y) => o_visionstatement_cc6f8a1e(X)))
```

### profile_2422 — domain

Source: `urn:product-ontology:relation-profile:0.7:r192_references`

```text
(! [X,Y] : (o_r192_references_797ec57b(X,Y) => o_problemsolutionfitassessment_1c59291a(X)))
```

### profile_2423 — domain

Source: `urn:product-ontology:relation-profile:0.7:r194_referencesMentalModel`

```text
(! [X,Y] : (o_r194_referencesmentalmodel_4329630f(X,Y) => o_informationarchitecturespecification_0a84724e(X)))
```

### profile_2424 — domain

Source: `urn:product-ontology:relation-profile:0.7:r195_usesScript`

```text
(! [X,Y] : (o_r195_usesscript_5e74131c(X,Y) => o_testcase_d5ce3254(X)))
```

### profile_2425 — domain

Source: `urn:product-ontology:relation-profile:0.7:r196_reportedUnderTestPlan`

```text
(! [X,Y] : (o_r196_reportedundertestplan_d76ea0ce(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2426 — domain

Source: `urn:product-ontology:relation-profile:0.7:r197_citesExecutionScript`

```text
(! [X,Y] : (o_r197_citesexecutionscript_27d9b423(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2427 — domain

Source: `urn:product-ontology:relation-profile:0.7:r198_citesSupportingEvidence`

```text
(! [X,Y] : (o_r198_citessupportingevidence_b12e8015(X,Y) => o_validationevidencerecord_89bff0ca(X)))
```

### profile_2428 — domain

Source: `urn:product-ontology:relation-profile:0.7:r199_referencesDatasetConfiguration`

```text
(! [X,Y] : (o_r199_referencesdatasetconfiguration_3452091a(X,Y) => o_testdatareference_6063ba4c(X)))
```

### profile_2429 — domain

Source: `urn:product-ontology:relation-profile:0.7:r200_targets`

```text
(! [X,Y] : (o_r200_targets_6af6d65d(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2430 — domain

Source: `urn:product-ontology:relation-profile:0.7:r201_targets`

```text
(! [X,Y] : (o_r201_targets_bcdee8f4(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2431 — domain

Source: `urn:product-ontology:relation-profile:0.7:r202_referencesValueProposition`

```text
(! [X,Y] : (o_r202_referencesvalueproposition_3e308d90(X,Y) => o_gotomarketspecification_e383dc02(X)))
```

### profile_2432 — domain

Source: `urn:product-ontology:relation-profile:0.7:r203_targets`

```text
(! [X,Y] : (o_r203_targets_4b1b7f63(X,Y) => o_launchspecification_19376d8c(X)))
```

### profile_2433 — domain

Source: `urn:product-ontology:relation-profile:0.7:r204_targets`

```text
(! [X,Y] : (o_r204_targets_cce4b6f0(X,Y) => o_marketinggoalspecification_19f0f0dc(X)))
```

### profile_2434 — domain

Source: `urn:product-ontology:relation-profile:0.7:r207_citesInsightEvidence`

```text
(! [X,Y] : (o_r207_citesinsightevidence_6c67b850(X,Y) => o_marketinginsightreference_ecbebe36(X)))
```

### profile_2435 — domain

Source: `urn:product-ontology:relation-profile:0.7:r208_addressesNeed`

```text
(! [X,Y] : (o_r208_addressesneed_7e9f91f2(X,Y) => o_offeringspecification_fd5297ce(X)))
```

### profile_2436 — domain

Source: `urn:product-ontology:relation-profile:0.7:r209_informedBy`

```text
(! [X,Y] : (o_r209_informedby_359974a5(X,Y) => o_visionstatement_cc6f8a1e(X)))
```

### profile_2437 — domain

Source: `urn:product-ontology:relation-profile:0.7:r210_assessesNeed`

```text
(! [X,Y] : (o_r210_assessesneed_6c9cbff0(X,Y) => o_productmarketfitassessment_c7e309d6(X)))
```

### profile_2438 — domain

Source: `urn:product-ontology:relation-profile:0.7:r211_assessesPain`

```text
(! [X,Y] : (o_r211_assessespain_4bb93078(X,Y) => o_productmarketfitassessment_c7e309d6(X)))
```

### profile_2439 — domain

Source: `urn:product-ontology:relation-profile:0.7:r212_intendsToAddressNeed`

```text
(! [X,Y] : (o_r212_intendstoaddressneed_c432a5ce(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2440 — domain

Source: `urn:product-ontology:relation-profile:0.7:r213_addressesPain`

```text
(! [X,Y] : (o_r213_addressespain_f5a8340d(X,Y) => o_userstoryspecification_680a42c6(X)))
```

### profile_2441 — domain

Source: `urn:product-ontology:relation-profile:0.7:r214_describesPain`

```text
(! [X,Y] : (o_r214_describespain_41cb74d0(X,Y) => o_journeyspecification_6c58f66d(X)))
```

### profile_2442 — domain

Source: `urn:product-ontology:relation-profile:0.7:r215_describesPain`

```text
(! [X,Y] : (o_r215_describespain_45679c75(X,Y) => o_journeystagespecification_4d216026(X)))
```

### profile_2443 — domain

Source: `urn:product-ontology:relation-profile:0.7:r216_intendsToAddressNeed`

```text
(! [X,Y] : (o_r216_intendstoaddressneed_b44769cc(X,Y) => o_touchpointspecification_88904c65(X)))
```

### profile_2444 — domain

Source: `urn:product-ontology:relation-profile:0.7:r217_describesPain`

```text
(! [X,Y] : (o_r217_describespain_88f12b79(X,Y) => o_touchpointspecification_88904c65(X)))
```

### profile_2445 — domain

Source: `urn:product-ontology:relation-profile:0.7:r218_citesSupportingEvidence`

```text
(! [X,Y] : (o_r218_citessupportingevidence_b66ffe2c(X,Y) => o_releaseevidencerecord_0b26c3e8(X)))
```

### profile_2446 — domain

Source: `urn:product-ontology:relation-profile:0.7:r219_addressesPain`

```text
(! [X,Y] : (o_r219_addressespain_19e58eb3(X,Y) => o_positioningstatement_23009b5a(X)))
```

### profile_2447 — domain

Source: `urn:product-ontology:relation-profile:0.7:r220_addressesPain`

```text
(! [X,Y] : (o_r220_addressespain_44c648a6(X,Y) => o_messagingspecification_24de7362(X)))
```

### profile_2448 — domain

Source: `urn:product-ontology:relation-profile:0.7:r221_supportedBy`

```text
(! [X,Y] : (o_r221_supportedby_f95d0f4b(X,Y) => o_messagingspecification_24de7362(X)))
```

### profile_2449 — domain

Source: `urn:product-ontology:relation-profile:0.7:r222_differentiatesFrom`

```text
(! [X,Y] : (o_r222_differentiatesfrom_15e5abc1(X,Y) => o_competitivenarrative_88476b59(X)))
```

### profile_2450 — domain

Source: `urn:product-ontology:relation-profile:0.7:r223_supportedBy`

```text
(! [X,Y] : (o_r223_supportedby_0fc110d1(X,Y) => o_competitivenarrative_88476b59(X)))
```

### profile_2451 — domain

Source: `urn:product-ontology:relation-profile:0.7:r224_evidencedBy`

```text
(! [X,Y] : (o_r224_evidencedby_733ce5a5(X,Y) => o_acquisitionhypothesisspecification_6e118852(X)))
```

### profile_2452 — domain

Source: `urn:product-ontology:relation-profile:0.7:r225_addressesPain`

```text
(! [X,Y] : (o_r225_addressespain_c6e2ffe1(X,Y) => o_adoptionhypothesisspecification_de10da7b(X)))
```

### profile_2453 — domain

Source: `urn:product-ontology:relation-profile:0.7:r226_evidencedBy`

```text
(! [X,Y] : (o_r226_evidencedby_83e51087(X,Y) => o_adoptionhypothesisspecification_de10da7b(X)))
```

### profile_2454 — domain

Source: `urn:productium:specification-profile:r22_motivatesOpportunity`

```text
(! [X,Y] : (o_r22_motivatesopportunity_6479604f(X,Y) => o_problemstatement_fe6d79b3(X)))
```

### profile_2455 — domain

Source: `urn:productium:specification-profile:r51_describesUserRole`

```text
(! [X,Y] : (o_r51_describesuserrole_3185165a(X,Y) => o_personaspecification_81fd0066(X)))
```

### profile_2456 — domain

Source: `urn:productium:specification-profile:r52_representedInJourney`

```text
(! [X,Y] : (o_r52_representedinjourney_b2264545(X,Y) => o_personaspecification_81fd0066(X)))
```

### profile_2457 — domain

Source: `urn:productium:specification-profile:r54_includes`

```text
(! [X,Y] : (o_r54_includes_e85c425d(X,Y) => o_journeystagespecification_4d216026(X)))
```

### profile_2458 — domain

Source: `urn:productium:specification-profile:r55_describedByFlow`

```text
(! [X,Y] : (o_r55_describedbyflow_1d3fe4a0(X,Y) => o_journeystagespecification_4d216026(X)))
```

### profile_2459 — domain

Source: `urn:productium:specification-profile:r56_specifiesStep`

```text
(! [X,Y] : (o_r56_specifiesstep_4fbba994(X,Y) => o_userflowspecification_fb730f56(X)))
```

### profile_2460 — domain

Source: `urn:productium:specification-profile:r57_referencesScreen`

```text
(! [X,Y] : (o_r57_referencesscreen_af9c2b51(X,Y) => o_interactionstepspecification_44c8af3e(X)))
```

### profile_2461 — domain

Source: `urn:productium:specification-profile:r58_organizesScreenSpecification`

```text
(! [X,Y] : (o_r58_organizesscreenspecification_55a3985a(X,Y) => o_informationarchitecturespecification_0a84724e(X)))
```

### profile_2462 — domain

Source: `urn:productium:specification-profile:r59_definesUIState`

```text
(! [X,Y] : (o_r59_definesuistate_1240d902(X,Y) => o_screenspecification_cad2e1fc(X)))
```

### profile_2463 — domain

Source: `urn:productium:specification-profile:r60_reportsOnFlow`

```text
(! [X,Y] : (o_r60_reportsonflow_1078c4ad(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2464 — domain

Source: `urn:productium:specification-profile:r61_reportsOnScreen`

```text
(! [X,Y] : (o_r61_reportsonscreen_dbff3398(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2465 — domain

Source: `urn:productium:specification-profile:r63_supportedBy`

```text
(! [X,Y] : (o_r63_supportedby_1fdde5fb(X,Y) => o_userstoryspecification_680a42c6(X)))
```

### profile_2466 — domain

Source: `urn:productium:specification-profile:r64_organizesRoadmapEntry`

```text
(! [X,Y] : (o_r64_organizesroadmapentry_e6adfceb(X,Y) => o_roadmap_381d20e5(X)))
```

### profile_2467 — domain

Source: `urn:productium:specification-profile:r65_plansInitiative`

```text
(! [X,Y] : (o_r65_plansinitiative_ea87adc7(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2468 — domain

Source: `urn:productium:specification-profile:r66_plansFeatureDelivery`

```text
(! [X,Y] : (o_r66_plansfeaturedelivery_82d8279a(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2469 — domain

Source: `urn:productium:specification-profile:r67_targetsMilestone`

```text
(! [X,Y] : (o_r67_targetsmilestone_7d34f2ca(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2470 — domain

Source: `urn:productium:specification-profile:r68_hasPriorityAssessment`

```text
(! [X,Y] : (o_r68_haspriorityassessment_32fcf4c1(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2471 — domain

Source: `urn:productium:specification-profile:r69_usesRankingCriterion`

```text
(! [X,Y] : (o_r69_usesrankingcriterion_4fe537ae(X,Y) => o_priorityassessment_ac21f6f9(X)))
```

### profile_2472 — domain

Source: `urn:productium:specification-profile:r70_usesHorizonDefinition`

```text
(! [X,Y] : (o_r70_useshorizondefinition_fd4ddeb9(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2473 — domain

Source: `urn:productium:specification-profile:r71_hasTargetWindowAssignment`

```text
(! [X,Y] : (o_r71_hastargetwindowassignment_192f03b5(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2474 — domain

Source: `urn:productium:specification-profile:r72_hasEntryConfidenceAssessment`

```text
(! [X,Y] : (o_r72_hasentryconfidenceassessment_e5951f91(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2475 — domain

Source: `urn:productium:specification-profile:r73_usesCommitmentLevelDefinition`

```text
(! [X,Y] : (o_r73_usescommitmentleveldefinition_f065646b(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2476 — domain

Source: `urn:productium:specification-profile:r74_hasPlanningDependency`

```text
(! [X,Y] : (o_r74_hasplanningdependency_64392581(X,Y) => o_roadmapentry_c1c3186e(X)))
```

### profile_2477 — domain

Source: `urn:productium:specification-profile:r75_plansDeliveryItem`

```text
(! [X,Y] : (o_r75_plansdeliveryitem_0335f73f(X,Y) => o_releasespecification_37d609b4(X)))
```

### profile_2478 — domain

Source: `urn:productium:specification-profile:r76_referencesChangeRecord`

```text
(! [X,Y] : (o_r76_referenceschangerecord_e6102cca(X,Y) => o_releasespecification_37d609b4(X)))
```

### profile_2479 — domain

Source: `urn:productium:specification-profile:r78_hasReleaseEvidenceRecord`

```text
(! [X,Y] : (o_r78_hasreleaseevidencerecord_349ce5f1(X,Y) => o_releasespecification_37d609b4(X)))
```

### profile_2480 — domain

Source: `urn:productium:specification-profile:r79_proposesRecordedChange`

```text
(! [X,Y] : (o_r79_proposesrecordedchange_17c0be66(X,Y) => o_changeproposalspecification_970520af(X)))
```

### profile_2481 — domain

Source: `urn:productium:specification-profile:r80_plansFeature`

```text
(! [X,Y] : (o_r80_plansfeature_7dac01de(X,Y) => o_deliveryworkitem_f98a3f27(X)))
```

### profile_2482 — domain

Source: `urn:productium:specification-profile:r81_intendedToContributeToWork`

```text
(! [X,Y] : (o_r81_intendedtocontributetowork_25bd0e17(X,Y) => o_taskreference_51d691cd(X)))
```

### profile_2483 — domain

Source: `urn:productium:specification-profile:r82_specifiesFeatureActivationControl`

```text
(! [X,Y] : (o_r82_specifiesfeatureactivationcontrol_6337914a(X,Y) => o_featureflagspecification_91eb227b(X)))
```

### profile_2484 — domain

Source: `urn:productium:specification-profile:r83_plannedForRelease`

```text
(! [X,Y] : (o_r83_plannedforrelease_2e49ff30(X,Y) => o_productversion_e1d59901(X)))
```

### profile_2485 — domain

Source: `urn:productium:specification-profile:r84_covers`

```text
(! [X,Y] : (o_r84_covers_274b6383(X,Y) => o_testscenario_1c3da1d3(X)))
```

### profile_2486 — domain

Source: `urn:productium:specification-profile:r85_specifiesRequirementVerification`

```text
(! [X,Y] : (o_r85_specifiesrequirementverification_60458645(X,Y) => o_testscenario_1c3da1d3(X)))
```

### profile_2487 — domain

Source: `urn:productium:specification-profile:r86_specifiesCriterionVerification`

```text
(! [X,Y] : (o_r86_specifiescriterionverification_fc5c455e(X,Y) => o_testscenario_1c3da1d3(X)))
```

### profile_2488 — domain

Source: `urn:productium:specification-profile:r87_refinesTestScenario`

```text
(! [X,Y] : (o_r87_refinestestscenario_2f86dad0(X,Y) => o_testcase_d5ce3254(X)))
```

### profile_2489 — domain

Source: `urn:productium:specification-profile:r89_referencesTestData`

```text
(! [X,Y] : (o_r89_referencestestdata_23eb835a(X,Y) => o_testcase_d5ce3254(X)))
```

### profile_2490 — domain

Source: `urn:productium:specification-profile:r8_supersedes`

```text
(! [X,Y] : (o_r8_supersedes_a59a0a58(X,Y) => o_productversion_e1d59901(X)))
```

### profile_2491 — domain

Source: `urn:productium:specification-profile:r92_hasVerificationEvidenceRecord`

```text
(! [X,Y] : (o_r92_hasverificationevidencerecord_387f2a4e(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2492 — domain

Source: `urn:productium:specification-profile:r93_hasValidationEvidenceRecord`

```text
(! [X,Y] : (o_r93_hasvalidationevidencerecord_8467c0d9(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2493 — domain

Source: `urn:productium:specification-profile:r94_hasPositioningStatement`

```text
(! [X,Y] : (o_r94_haspositioningstatement_6fdb00a7(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2494 — domain

Source: `urn:productium:specification-profile:r95_positionedByStatement`

```text
(! [X,Y] : (o_r95_positionedbystatement_6f7e5470(X,Y) => o_offeringspecification_fd5297ce(X)))
```

### profile_2495 — domain

Source: `urn:productium:specification-profile:r96_referencesTargetMarket`

```text
(! [X,Y] : (o_r96_referencestargetmarket_27d66c85(X,Y) => o_positioningstatement_23009b5a(X)))
```

### profile_2496 — domain

Source: `urn:productium:specification-profile:r97_referencesTargetSegment`

```text
(! [X,Y] : (o_r97_referencestargetsegment_26c84e83(X,Y) => o_positioningstatement_23009b5a(X)))
```

### profile_2497 — domain

Source: `urn:productium:specification-profile:r98_referencesCompetitiveNarrative`

```text
(! [X,Y] : (o_r98_referencescompetitivenarrative_217aed66(X,Y) => o_positioningstatement_23009b5a(X)))
```

### profile_2498 — domain

Source: `urn:productium:specification-profile:r99_expressesPositioning`

```text
(! [X,Y] : (o_r99_expressespositioning_628c10f4(X,Y) => o_messagingspecification_24de7362(X)))
```

### profile_2499 — domain

Source: `urn:productium:specification-profile:realizesVersion`

```text
(! [X,Y] : (o_realizesversion_8ca00efc(X,Y) => o_productrealization_b516a087(X)))
```

### profile_2500 — domain

Source: `urn:productium:specification-profile:recordedAttributionTo`

```text
(! [X,Y] : (o_recordedattributionto_3e20c24d(X,Y) => o_evidenceartifact_6317ec1f(X)))
```

### profile_2501 — domain

Source: `urn:productium:specification-profile:recordsAffectedInitiative`

```text
(! [X,Y] : (o_recordsaffectedinitiative_2fad9b0e(X,Y) => o_decisionrecord_d6051b08(X)))
```

### profile_2502 — domain

Source: `urn:productium:specification-profile:recordsCarrier`

```text
(! [X,Y] : (o_recordscarrier_68e09c12(X,Y) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_2503 — domain

Source: `urn:productium:specification-profile:recordsClaim`

```text
(! [X,Y] : (o_recordsclaim_3d0873c5(X,Y) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_2504 — domain

Source: `urn:productium:specification-profile:recordsCriterion`

```text
(! [X,Y] : (o_recordscriterion_00fcf0e8(X,Y) => o_decisionrecord_d6051b08(X)))
```

### profile_2505 — domain

Source: `urn:productium:specification-profile:recordsExecution`

```text
(! [X,Y] : (o_recordsexecution_bdd9ccef(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2506 — domain

Source: `urn:productium:specification-profile:referenceContext`

```text
(! [X,Y] : (o_referencecontext_58c96c8a(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2507 — domain

Source: `urn:productium:specification-profile:referenceProvenance`

```text
(! [X,Y] : (o_referenceprovenance_8d44e213(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2508 — domain

Source: `urn:productium:specification-profile:referencePurpose`

```text
(! [X,Y] : (o_referencepurpose_536ac956(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2509 — domain

Source: `urn:product-ontology:delivery-profile:0.5:referenceRecordedAt`

```text
(! [X,Y] : (o_referencerecordedat_d583c6bc(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2510 — domain

Source: `urn:product-ontology:delivery-profile:0.5:referenceReviewFinding`

```text
(! [X,Y] : (o_referencereviewfinding_3b780567(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2511 — domain

Source: `urn:product-ontology:delivery-profile:0.5:referenceRevisionLabel`

```text
(! [X,Y] : (o_referencerevisionlabel_8b082866(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2512 — domain

Source: `urn:productium:specification-profile:referencesOffering`

```text
(! [X,Y] : (o_referencesoffering_bfc38ac5(X,Y) => o_bundlespecification_f7007010(X)))
```

### profile_2513 — domain

Source: `urn:productium:specification-profile:referencesProduct`

```text
(! [X,Y] : (o_referencesproduct_8b03c51e(X,Y) => o_portfolioentry_e83956e9(X)))
```

### profile_2514 — domain

Source: `urn:productium:specification-profile:referencesProductFamily`

```text
(! [X,Y] : (o_referencesproductfamily_7de942a9(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2515 — domain

Source: `urn:productium:specification-profile:referencesProductLine`

```text
(! [X,Y] : (o_referencesproductline_556acfa2(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2516 — domain

Source: `urn:productium:specification-profile:referencesProductVariant`

```text
(! [X,Y] : (o_referencesproductvariant_63ea45c4(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2517 — domain

Source: `urn:productium:specification-profile:referencesRuleForRequirement`

```text
(! [X,Y] : (o_referencesruleforrequirement_82b4b463(X,Y) => o_businessrulereference_54a4db46(X)))
```

### profile_2518 — domain

Source: `urn:product-ontology:delivery-profile:0.5:referenceSupersedes`

```text
(! [X,Y] : (o_referencesupersedes_67ba3120(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2519 — domain

Source: `urn:productium:specification-profile:referenceTarget`

```text
(! [X,Y] : (o_referencetarget_c4ad5bee(X,Y) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2520 — domain

Source: `urn:productium:specification-profile:refinedByRequirement`

```text
(! [X,Y] : (o_refinedbyrequirement_96eabe04(X,Y) => o_userstoryspecification_680a42c6(X)))
```

### profile_2521 — domain

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusChange`

```text
(! [X,Y] : (o_releasestatuschange_a735bfeb(X,Y) => o_deliverystatusrecord_e59c51e2(X)))
```

### profile_2522 — domain

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusCode`

```text
(! [X,Y] : (o_releasestatuscode_34ff965d(X,Y) => o_deliverystatusrecord_e59c51e2(X)))
```

### profile_2523 — domain

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusReportedAt`

```text
(! [X,Y] : (o_releasestatusreportedat_2259b9bf(X,Y) => o_deliverystatusrecord_e59c51e2(X)))
```

### profile_2524 — domain

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusScheme`

```text
(! [X,Y] : (o_releasestatusscheme_834a126d(X,Y) => o_deliverystatusrecord_e59c51e2(X)))
```

### profile_2525 — domain

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusSource`

```text
(! [X,Y] : (o_releasestatussource_9174f3c6(X,Y) => o_deliverystatusrecord_e59c51e2(X)))
```

### profile_2526 — domain

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusVersion`

```text
(! [X,Y] : (o_releasestatusversion_4d1e1ab0(X,Y) => o_deliverystatusrecord_e59c51e2(X)))
```

### profile_2527 — domain

Source: `urn:productium:specification-profile:reportsStatus`

```text
(! [X,Y] : (o_reportsstatus_e9d948fc(X,Y) => o_releasespecification_37d609b4(X)))
```

### profile_2528 — domain

Source: `urn:productium:specification-profile:representedByStory`

```text
(! [X,Y] : (o_representedbystory_25664527(X,Y) => o_verticalslicespecification_25b6ba78(X)))
```

### profile_2529 — domain

Source: `urn:product-ontology:delivery-profile:0.5:resultOutcome`

```text
(! [X,Y] : (o_resultoutcome_3eb31a2b(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2530 — domain

Source: `urn:product-ontology:delivery-profile:0.5:resultRecordedAt`

```text
(! [X,Y] : (o_resultrecordedat_cc5c9d15(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2531 — domain

Source: `urn:product-ontology:delivery-profile:0.5:resultSource`

```text
(! [X,Y] : (o_resultsource_d7f3bdb0(X,Y) => o_testresult_26ca0bda(X)))
```

### profile_2532 — domain

Source: `urn:product-ontology:delivery-profile:0.5:reviewReason`

```text
(! [X,Y] : (o_reviewreason_619760cf(X,Y) => o_findingrecord_6c235440(X)))
```

### profile_2533 — domain

Source: `urn:product-ontology:delivery-profile:0.5:reviewRecordedAt`

```text
(! [X,Y] : (o_reviewrecordedat_0012d0fd(X,Y) => o_findingrecord_6c235440(X)))
```

### profile_2534 — domain

Source: `urn:productium:specification-profile:scenarioActions`

```text
(! [X,Y] : (o_scenarioactions_6c887f89(X,Y) => o_scenariospecification_131385c1(X)))
```

### profile_2535 — domain

Source: `urn:productium:specification-profile:scenarioContext`

```text
(! [X,Y] : (o_scenariocontext_2ee069f1(X,Y) => o_scenariospecification_131385c1(X)))
```

### profile_2536 — domain

Source: `urn:productium:specification-profile:scenarioPrecondition`

```text
(! [X,Y] : (o_scenarioprecondition_4776ce8c(X,Y) => o_scenariospecification_131385c1(X)))
```

### profile_2537 — domain

Source: `urn:product-ontology:assessment-profile:0.4:scopeChangeRecord`

```text
(! [X,Y] : (o_scopechangerecord_89135be8(X,Y) => o_scopespecification_beb9b28d(X)))
```

### profile_2538 — domain

Source: `urn:product-ontology:assessment-profile:0.4:scopeSource`

```text
(! [X,Y] : (o_scopesource_4d209733(X,Y) => o_scopespecification_beb9b28d(X)))
```

### profile_2539 — domain

Source: `urn:product-ontology:assessment-profile:0.4:scopeSupersedes`

```text
(! [X,Y] : (o_scopesupersedes_4c533220(X,Y) => o_scopespecification_beb9b28d(X)))
```

### profile_2540 — domain

Source: `urn:productium:specification-profile:solutionHypothesizesAboutProblem`

```text
(! [X,Y] : (o_solutionhypothesizesaboutproblem_32929111(X,Y) => o_solutionhypothesisspecification_724e7cc7(X)))
```

### profile_2541 — domain

Source: `urn:productium:specification-profile:solutionPredictsOutcome`

```text
(! [X,Y] : (o_solutionpredictsoutcome_50736bc8(X,Y) => o_solutionhypothesisspecification_724e7cc7(X)))
```

### profile_2542 — domain

Source: `urn:productium:specification-profile:sourcesRequirement`

```text
(! [X,Y] : (o_sourcesrequirement_787c0bfa(X,Y) => o_requirementsourcereference_372235ba(X)))
```

### profile_2543 — domain

Source: `urn:productium:specification-profile:specifiedByRequirement`

```text
(! [X,Y] : (o_specifiedbyrequirement_4195410f(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2544 — domain

Source: `urn:productium:specification-profile:specifiedThroughFeature`

```text
(! [X,Y] : (o_specifiedthroughfeature_c8fc40a2(X,Y) => o_capabilityspecification_73a1b978(X)))
```

### profile_2545 — domain

Source: `urn:productium:specification-profile:specifiesCapability`

```text
(! [X,Y] : (o_specifiescapability_1c1747fb(X,Y) => o_productversion_e1d59901(X)))
```

### profile_2546 — domain

Source: `urn:productium:specification-profile:specifiesExpectedCondition`

```text
(! [X,Y] : (o_specifiesexpectedcondition_d555ae1c(X,Y) => o_scenariospecification_131385c1(X)))
```

### profile_2547 — domain

Source: `urn:productium:specification-profile:specifiesOutcomeMetric`

```text
(! [X,Y] : (o_specifiesoutcomemetric_c22cec66(X,Y) => o_outcomespecification_05ee7bc3(X)))
```

### profile_2548 — domain

Source: `urn:productium:specification-profile:specifiesPersonaContext`

```text
(! [X,Y] : (o_specifiespersonacontext_213f7eb5(X,Y) => o_userstoryspecification_680a42c6(X)))
```

### profile_2549 — domain

Source: `urn:productium:specification-profile:specifiesSlice`

```text
(! [X,Y] : (o_specifiesslice_dc3a4749(X,Y) => o_featurespecification_2de6dfb0(X)))
```

### profile_2550 — domain

Source: `urn:product-ontology:trace-profile:0.6:stepPrecedes`

```text
(! [X,Y] : (o_stepprecedes_f878e3d5(X,Y) => o_interactionstepspecification_44c8af3e(X)))
```

### profile_2551 — domain

Source: `urn:productium:specification-profile:targetsOutcome`

```text
(! [X,Y] : (o_targetsoutcome_e53fd35a(X,Y) => o_initiativespecification_5404588f(X)))
```

### profile_2552 — domain

Source: `urn:productium:specification-profile:targetsOutcomeSpecification`

```text
(! [X,Y] : (o_targetsoutcomespecification_a78e4886(X,Y) => o_goalspecification_9ac1cc8d(X)))
```

### profile_2553 — domain

Source: `urn:productium:specification-profile:testsRealization`

```text
(! [X,Y] : (o_testsrealization_70c84c2c(X,Y) => o_testexecution_483822c9(X)))
```

### profile_2554 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityInformationArchitecture`

```text
(! [X,Y] : (o_usabilityinformationarchitecture_da396e22(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2555 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityJourney`

```text
(! [X,Y] : (o_usabilityjourney_af09679d(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2556 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityJourneyStage`

```text
(! [X,Y] : (o_usabilityjourneystage_5caef2c8(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2557 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityPersona`

```text
(! [X,Y] : (o_usabilitypersona_063b1c06(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2558 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityRecommendation`

```text
(! [X,Y] : (o_usabilityrecommendation_54765e4f(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2559 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityStep`

```text
(! [X,Y] : (o_usabilitystep_6665fcbf(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2560 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityTouchpoint`

```text
(! [X,Y] : (o_usabilitytouchpoint_331ca302(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2561 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityUIState`

```text
(! [X,Y] : (o_usabilityuistate_f4195a87(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2562 — domain

Source: `urn:product-ontology:trace-profile:0.6:usabilityUserRole`

```text
(! [X,Y] : (o_usabilityuserrole_c0e67ae6(X,Y) => o_usabilityfindingrecord_1be07103(X)))
```

### profile_2563 — domain

Source: `urn:productium:specification-profile:usesLifecycleSpecification`

```text
(! [X,Y] : (o_useslifecyclespecification_82197b12(X,Y) => o_product_5e2e77d6(X)))
```

### profile_2564 — domain

Source: `urn:product-ontology:assessment-profile:0.4:versionScope`

```text
(! [X,Y] : (o_versionscope_f2807a84(X,Y) => o_productversion_e1d59901(X)))
```

### profile_2565 — functional

Source: `urn:product-ontology:assessment-profile:0.4:attributionAgent`

```text
(! [X,Y,Z] : ((o_attributionagent_3e95a876(X,Y) & o_attributionagent_3e95a876(X,Z)) => (Y = Z)))
```

### profile_2566 — functional

Source: `urn:product-ontology:assessment-profile:0.4:attributionStance`

```text
(! [X,Y,Z] : ((o_attributionstance_86be106a(X,Y) & o_attributionstance_86be106a(X,Z)) => (Y = Z)))
```

### profile_2567 — functional

Source: `urn:product-ontology:assessment-profile:0.4:attributionTimestamp`

```text
(! [X,Y,Z] : ((o_attributiontimestamp_edefea94(X,Y) & o_attributiontimestamp_edefea94(X,Z)) => (Y = Z)))
```

### profile_2568 — functional

Source: `urn:product-ontology:trace-profile:0.6:changeFeature`

```text
(! [X,Y,Z] : ((o_changefeature_d145a21d(X,Y) & o_changefeature_d145a21d(X,Z)) => (Y = Z)))
```

### profile_2569 — functional

Source: `urn:product-ontology:trace-profile:0.6:changeOccurrenceReference`

```text
(! [X,Y,Z] : ((o_changeoccurrencereference_851a5877(X,Y) & o_changeoccurrencereference_851a5877(X,Z)) => (Y = Z)))
```

### profile_2570 — functional

Source: `urn:product-ontology:trace-profile:0.6:changeRecordedAt`

```text
(! [X,Y,Z] : ((o_changerecordedat_b51849a2(X,Y) & o_changerecordedat_b51849a2(X,Z)) => (Y = Z)))
```

### profile_2571 — functional

Source: `urn:product-ontology:trace-profile:0.6:changeScope`

```text
(! [X,Y,Z] : ((o_changescope_3f8a92ef(X,Y) & o_changescope_3f8a92ef(X,Z)) => (Y = Z)))
```

### profile_2572 — functional

Source: `urn:product-ontology:trace-profile:0.6:changeStatement`

```text
(! [X,Y,Z] : ((o_changestatement_0c3cf3b3(X,Y) & o_changestatement_0c3cf3b3(X,Z)) => (Y = Z)))
```

### profile_2573 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimActualCapability`

```text
(! [X,Y,Z] : ((o_claimactualcapability_27fec47c(X,Y) & o_claimactualcapability_27fec47c(X,Z)) => (Y = Z)))
```

### profile_2574 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimContext`

```text
(! [X,Y,Z] : ((o_claimcontext_7950f82f(X,Y) & o_claimcontext_7950f82f(X,Z)) => (Y = Z)))
```

### profile_2575 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimCriterion`

```text
(! [X,Y,Z] : ((o_claimcriterion_6a063ec1(X,Y) & o_claimcriterion_6a063ec1(X,Z)) => (Y = Z)))
```

### profile_2576 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimIntendedCapability`

```text
(! [X,Y,Z] : ((o_claimintendedcapability_56a5a011(X,Y) & o_claimintendedcapability_56a5a011(X,Z)) => (Y = Z)))
```

### profile_2577 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimProduct`

```text
(! [X,Y,Z] : ((o_claimproduct_a8f421e4(X,Y) & o_claimproduct_a8f421e4(X,Z)) => (Y = Z)))
```

### profile_2578 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimRealization`

```text
(! [X,Y,Z] : ((o_claimrealization_2e93c51b(X,Y) & o_claimrealization_2e93c51b(X,Z)) => (Y = Z)))
```

### profile_2579 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimRequirement`

```text
(! [X,Y,Z] : ((o_claimrequirement_19e961d9(X,Y) & o_claimrequirement_19e961d9(X,Z)) => (Y = Z)))
```

### profile_2580 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimStatement`

```text
(! [X,Y,Z] : ((o_claimstatement_30ad9287(X,Y) & o_claimstatement_30ad9287(X,Z)) => (Y = Z)))
```

### profile_2581 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimSubject`

```text
(! [X,Y,Z] : ((o_claimsubject_8dc7dd3c(X,Y) & o_claimsubject_8dc7dd3c(X,Z)) => (Y = Z)))
```

### profile_2582 — functional

Source: `urn:product-ontology:assessment-profile:0.4:claimVersion`

```text
(! [X,Y,Z] : ((o_claimversion_32b75c75(X,Y) & o_claimversion_32b75c75(X,Z)) => (Y = Z)))
```

### profile_2583 — functional

Source: `urn:product-ontology:assessment-profile:0.4:contextDescription`

```text
(! [X,Y,Z] : ((o_contextdescription_a35336af(X,Y) & o_contextdescription_a35336af(X,Z)) => (Y = Z)))
```

### profile_2584 — functional

Source: `urn:product-ontology:assessment-profile:0.4:contextVersion`

```text
(! [X,Y,Z] : ((o_contextversion_b62a88f2(X,Y) & o_contextversion_b62a88f2(X,Z)) => (Y = Z)))
```

### profile_2585 — functional

Source: `urn:product-ontology:trace-profile:0.6:decisionRationale`

```text
(! [X,Y,Z] : ((o_decisionrationale_a17588c8(X,Y) & o_decisionrationale_a17588c8(X,Z)) => (Y = Z)))
```

### profile_2586 — functional

Source: `urn:product-ontology:trace-profile:0.6:dependencyActualCapabilityTarget`

```text
(! [X,Y,Z] : ((o_dependencyactualcapabilitytarget_5f4e89b9(X,Y) & o_dependencyactualcapabilitytarget_5f4e89b9(X,Z)) => (Y = Z)))
```

### profile_2587 — functional

Source: `urn:product-ontology:trace-profile:0.6:dependencyCapabilitySpecificationTarget`

```text
(! [X,Y,Z] : ((o_dependencycapabilityspecificationtarget_cfd20400(X,Y) & o_dependencycapabilityspecificationtarget_cfd20400(X,Z)) => (Y = Z)))
```

### profile_2588 — functional

Source: `urn:product-ontology:trace-profile:0.6:dependencyCondition`

```text
(! [X,Y,Z] : ((o_dependencycondition_cc5a91c9(X,Y) & o_dependencycondition_cc5a91c9(X,Z)) => (Y = Z)))
```

### profile_2589 — functional

Source: `urn:product-ontology:trace-profile:0.6:dependencyExternalTarget`

```text
(! [X,Y,Z] : ((o_dependencyexternaltarget_24a02018(X,Y) & o_dependencyexternaltarget_24a02018(X,Z)) => (Y = Z)))
```

### profile_2590 — functional

Source: `urn:product-ontology:trace-profile:0.6:dependencyProductTarget`

```text
(! [X,Y,Z] : ((o_dependencyproducttarget_c8cb5b8c(X,Y) & o_dependencyproducttarget_c8cb5b8c(X,Z)) => (Y = Z)))
```

### profile_2591 — functional

Source: `urn:product-ontology:delivery-profile:0.5:executionContext`

```text
(! [X,Y,Z] : ((o_executioncontext_02a29f55(X,Y) & o_executioncontext_02a29f55(X,Z)) => (Y = Z)))
```

### profile_2592 — functional

Source: `urn:product-ontology:delivery-profile:0.5:executionEndedAt`

```text
(! [X,Y,Z] : ((o_executionendedat_2fa28738(X,Y) & o_executionendedat_2fa28738(X,Z)) => (Y = Z)))
```

### profile_2593 — functional

Source: `urn:product-ontology:assessment-profile:0.4:findingStatement`

```text
(! [X,Y,Z] : ((o_findingstatement_ba684cd2(X,Y) & o_findingstatement_ba684cd2(X,Z)) => (Y = Z)))
```

### profile_2594 — functional

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusCode`

```text
(! [X,Y,Z] : ((o_itemstatuscode_a08e2882(X,Y) & o_itemstatuscode_a08e2882(X,Z)) => (Y = Z)))
```

### profile_2595 — functional

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusReportedAt`

```text
(! [X,Y,Z] : ((o_itemstatusreportedat_5cd2a459(X,Y) & o_itemstatusreportedat_5cd2a459(X,Z)) => (Y = Z)))
```

### profile_2596 — functional

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusScheme`

```text
(! [X,Y,Z] : ((o_itemstatusscheme_abd64624(X,Y) & o_itemstatusscheme_abd64624(X,Z)) => (Y = Z)))
```

### profile_2597 — functional

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusVersion`

```text
(! [X,Y,Z] : ((o_itemstatusversion_83352ce1(X,Y) & o_itemstatusversion_83352ce1(X,Z)) => (Y = Z)))
```

### profile_2598 — functional

Source: `urn:product-ontology:delivery-profile:0.5:observedAuthority`

```text
(! [X,Y,Z] : ((o_observedauthority_0599d34b(X,Y) & o_observedauthority_0599d34b(X,Z)) => (Y = Z)))
```

### profile_2599 — functional

Source: `urn:product-ontology:delivery-profile:0.5:observedTarget`

```text
(! [X,Y,Z] : ((o_observedtarget_32dd708a(X,Y) & o_observedtarget_32dd708a(X,Z)) => (Y = Z)))
```

### profile_2600 — functional

Source: `urn:product-ontology:trace-profile:0.6:proposalFeature`

```text
(! [X,Y,Z] : ((o_proposalfeature_019a6892(X,Y) & o_proposalfeature_019a6892(X,Z)) => (Y = Z)))
```

### profile_2601 — functional

Source: `urn:product-ontology:trace-profile:0.6:proposalScope`

```text
(! [X,Y,Z] : ((o_proposalscope_0facbcb1(X,Y) & o_proposalscope_0facbcb1(X,Z)) => (Y = Z)))
```

### profile_2602 — functional

Source: `urn:product-ontology:trace-profile:0.6:proposalStatement`

```text
(! [X,Y,Z] : ((o_proposalstatement_9485e7f4(X,Y) & o_proposalstatement_9485e7f4(X,Z)) => (Y = Z)))
```

### profile_2603 — functional

Source: `urn:productium:specification-profile:r143_usesWindowHorizonDefinition`

```text
(! [X,Y,Z] : ((o_r143_useswindowhorizondefinition_61719e93(X,Y) & o_r143_useswindowhorizondefinition_61719e93(X,Z)) => (Y = Z)))
```

### profile_2604 — functional

Source: `urn:product-ontology:delivery-profile:0.5:referenceRecordedAt`

```text
(! [X,Y,Z] : ((o_referencerecordedat_d583c6bc(X,Y) & o_referencerecordedat_d583c6bc(X,Z)) => (Y = Z)))
```

### profile_2605 — functional

Source: `urn:product-ontology:delivery-profile:0.5:referenceRevisionLabel`

```text
(! [X,Y,Z] : ((o_referencerevisionlabel_8b082866(X,Y) & o_referencerevisionlabel_8b082866(X,Z)) => (Y = Z)))
```

### profile_2606 — functional

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusCode`

```text
(! [X,Y,Z] : ((o_releasestatuscode_34ff965d(X,Y) & o_releasestatuscode_34ff965d(X,Z)) => (Y = Z)))
```

### profile_2607 — functional

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusReportedAt`

```text
(! [X,Y,Z] : ((o_releasestatusreportedat_2259b9bf(X,Y) & o_releasestatusreportedat_2259b9bf(X,Z)) => (Y = Z)))
```

### profile_2608 — functional

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusScheme`

```text
(! [X,Y,Z] : ((o_releasestatusscheme_834a126d(X,Y) & o_releasestatusscheme_834a126d(X,Z)) => (Y = Z)))
```

### profile_2609 — functional

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusVersion`

```text
(! [X,Y,Z] : ((o_releasestatusversion_4d1e1ab0(X,Y) & o_releasestatusversion_4d1e1ab0(X,Z)) => (Y = Z)))
```

### profile_2610 — functional

Source: `urn:product-ontology:delivery-profile:0.5:resultOutcome`

```text
(! [X,Y,Z] : ((o_resultoutcome_3eb31a2b(X,Y) & o_resultoutcome_3eb31a2b(X,Z)) => (Y = Z)))
```

### profile_2611 — functional

Source: `urn:product-ontology:delivery-profile:0.5:resultRecordedAt`

```text
(! [X,Y,Z] : ((o_resultrecordedat_cc5c9d15(X,Y) & o_resultrecordedat_cc5c9d15(X,Z)) => (Y = Z)))
```

### profile_2612 — functional

Source: `urn:product-ontology:delivery-profile:0.5:reviewReason`

```text
(! [X,Y,Z] : ((o_reviewreason_619760cf(X,Y) & o_reviewreason_619760cf(X,Z)) => (Y = Z)))
```

### profile_2613 — functional

Source: `urn:product-ontology:delivery-profile:0.5:reviewRecordedAt`

```text
(! [X,Y,Z] : ((o_reviewrecordedat_0012d0fd(X,Y) & o_reviewrecordedat_0012d0fd(X,Z)) => (Y = Z)))
```

### profile_2614 — functional

Source: `urn:product-ontology:assessment-profile:0.4:versionScope`

```text
(! [X,Y,Z] : ((o_versionscope_f2807a84(X,Y) & o_versionscope_f2807a84(X,Z)) => (Y = Z)))
```

### profile_2615 — inverse

Source: `urn:productium:specification-profile:isCarrierInRecord`

```text
(! [X,Y] : (o_iscarrierinrecord_6fcdca61(X,Y) <=> o_recordscarrier_68e09c12(Y,X)))
```

### profile_2616 — inverse_functional

Source: `urn:product-ontology:delivery-profile:0.5:itemStatus`

```text
(! [X,Y,Z] : ((o_itemstatus_370b117a(Y,X) & o_itemstatus_370b117a(Z,X)) => (Y = Z)))
```

### profile_2617 — inverse_functional

Source: `urn:product-ontology:delivery-profile:0.5:referenceReviewFinding`

```text
(! [X,Y,Z] : ((o_referencereviewfinding_3b780567(Y,X) & o_referencereviewfinding_3b780567(Z,X)) => (Y = Z)))
```

### profile_2618 — irreflexive

Source: `urn:productium:specification-profile:dependsOnEnablerSpecification`

```text
(! [X] : ~(o_dependsonenablerspecification_e09124c8(X,X)))
```

### profile_2619 — irreflexive

Source: `urn:productium:specification-profile:motivatesSolutionHypothesis`

```text
(! [X] : ~(o_motivatessolutionhypothesis_906ea5a3(X,X)))
```

### profile_2620 — irreflexive

Source: `urn:productium:specification-profile:r74_hasPlanningDependency`

```text
(! [X] : ~(o_r74_hasplanningdependency_64392581(X,X)))
```

### profile_2621 — irreflexive

Source: `urn:productium:specification-profile:r87_refinesTestScenario`

```text
(! [X] : ~(o_r87_refinestestscenario_2f86dad0(X,X)))
```

### profile_2622 — irreflexive

Source: `urn:productium:specification-profile:r8_supersedes`

```text
(! [X] : ~(o_r8_supersedes_a59a0a58(X,X)))
```

### profile_2623 — irreflexive

Source: `urn:product-ontology:delivery-profile:0.5:referenceSupersedes`

```text
(! [X] : ~(o_referencesupersedes_67ba3120(X,X)))
```

### profile_2624 — irreflexive

Source: `urn:productium:specification-profile:referenceTarget`

```text
(! [X] : ~(o_referencetarget_c4ad5bee(X,X)))
```

### profile_2625 — irreflexive

Source: `urn:product-ontology:assessment-profile:0.4:scopeSupersedes`

```text
(! [X] : ~(o_scopesupersedes_4c533220(X,X)))
```

### profile_2626 — irreflexive

Source: `urn:product-ontology:trace-profile:0.6:stepPrecedes`

```text
(! [X] : ~(o_stepprecedes_f878e3d5(X,X)))
```

### profile_2627 — range

Source: `urn:product-ontology:trace-profile:0.6:acquisitionCitesEvidence`

```text
(! [X,Y] : (o_acquisitioncitesevidence_f26cf4c5(X,Y) => o_evidenceattributionrecord_1c89f498(Y)))
```

### profile_2628 — range

Source: `urn:product-ontology:trace-profile:0.6:acquisitionCitesInsight`

```text
(! [X,Y] : (o_acquisitioncitesinsight_ce0a4a23(X,Y) => o_marketinginsightreference_ecbebe36(Y)))
```

### profile_2629 — range

Source: `urn:product-ontology:trace-profile:0.6:adoptionCitesEvidence`

```text
(! [X,Y] : (o_adoptioncitesevidence_428719c3(X,Y) => o_evidenceattributionrecord_1c89f498(Y)))
```

### profile_2630 — range

Source: `urn:product-ontology:trace-profile:0.6:adoptionCitesInsight`

```text
(! [X,Y] : (o_adoptioncitesinsight_ca8a908f(X,Y) => o_marketinginsightreference_ecbebe36(Y)))
```

### profile_2631 — range

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedRealizedByComponent`

```text
(! [X,Y] : (o_architecture_intendedrealizedbycomponent_e7a020a9(X,Y) => o_architecture_3acomponent_fee3a4db(Y)))
```

### profile_2632 — range

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedRealizedByService`

```text
(! [X,Y] : (o_architecture_intendedrealizedbyservice_ccc7d57c(X,Y) => o_architecture_3aservice_dcbfdfed(Y)))
```

### profile_2633 — range

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedSatisfiedByArchitectureElement`

```text
(! [X,Y] : (o_architecture_intendedsatisfiedbyarchitectureelement_5d473d90(X,Y) => o_architecture_3aarchitectureelement_aeb7c90c(Y)))
```

### profile_2634 — range

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedSatisfiedByInterface`

```text
(! [X,Y] : (o_architecture_intendedsatisfiedbyinterface_7a29350c(X,Y) => o_architecture_3ainterface_164e7515(Y)))
```

### profile_2635 — range

Source: `urn:product-ontology:relation-profile:0.7:architecture_intendedSupportedByArchitectureElement`

```text
(! [X,Y] : (o_architecture_intendedsupportedbyarchitectureelement_7cafe8bc(X,Y) => o_architecture_3aarchitectureelement_aeb7c90c(Y)))
```

### profile_2636 — range

Source: `urn:productium:specification-profile:assessesProblem`

```text
(! [X,Y] : (o_assessesproblem_338b0d44(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2637 — range

Source: `urn:productium:specification-profile:assessesProduct`

```text
(! [X,Y] : (o_assessesproduct_26a7167f(X,Y) => o_product_5e2e77d6(Y)))
```

### profile_2638 — range

Source: `urn:productium:specification-profile:assessesSolution`

```text
(! [X,Y] : (o_assessessolution_17cfc916(X,Y) => o_solutionspecification_ca854bd1(Y)))
```

### profile_2639 — range

Source: `urn:productium:specification-profile:assessesSpecification`

```text
(! [X,Y] : (o_assessesspecification_38115d6b(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2640 — range

Source: `urn:product-ontology:assessment-profile:0.4:attributionAgent`

```text
(! [X,Y] : (o_attributionagent_3e95a876(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2641 — range

Source: `urn:product-ontology:assessment-profile:0.4:attributionSource`

```text
(! [X,Y] : (o_attributionsource_9f703f28(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2642 — range

Source: `urn:product-ontology:assessment-profile:0.4:attributionStance`

```text
(! [X,Y] : (o_attributionstance_86be106a(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2643 — range

Source: `urn:product-ontology:assessment-profile:0.4:attributionTimestamp`

```text
(! [X,Y] : (o_attributiontimestamp_edefea94(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2644 — range

Source: `urn:productium:specification-profile:bearsCapability`

```text
(! [X,Y] : (o_bearscapability_2b724b5f(X,Y) => o_productcapability_5801242c(Y)))
```

### profile_2645 — range

Source: `urn:product-ontology:trace-profile:0.6:changeDecision`

```text
(! [X,Y] : (o_changedecision_f64fbe05(X,Y) => o_decisionrecord_d6051b08(Y)))
```

### profile_2646 — range

Source: `urn:product-ontology:trace-profile:0.6:changeFeature`

```text
(! [X,Y] : (o_changefeature_d145a21d(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2647 — range

Source: `urn:product-ontology:trace-profile:0.6:changeOccurrenceReference`

```text
(! [X,Y] : (o_changeoccurrencereference_851a5877(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2648 — range

Source: `urn:product-ontology:trace-profile:0.6:changeRecordedAt`

```text
(! [X,Y] : (o_changerecordedat_b51849a2(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2649 — range

Source: `urn:product-ontology:trace-profile:0.6:changeScope`

```text
(! [X,Y] : (o_changescope_3f8a92ef(X,Y) => o_scopespecification_beb9b28d(Y)))
```

### profile_2650 — range

Source: `urn:product-ontology:trace-profile:0.6:changeSource`

```text
(! [X,Y] : (o_changesource_52403cd5(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2651 — range

Source: `urn:product-ontology:trace-profile:0.6:changeStatement`

```text
(! [X,Y] : (o_changestatement_0c3cf3b3(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2652 — range

Source: `urn:product-ontology:trace-profile:0.6:changeTask`

```text
(! [X,Y] : (o_changetask_0b4d77dc(X,Y) => o_taskreference_51d691cd(Y)))
```

### profile_2653 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimActualCapability`

```text
(! [X,Y] : (o_claimactualcapability_27fec47c(X,Y) => o_productcapability_5801242c(Y)))
```

### profile_2654 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimContext`

```text
(! [X,Y] : (o_claimcontext_7950f82f(X,Y) => o_assessmentcontextspecification_9a5060b5(Y)))
```

### profile_2655 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimCriterion`

```text
(! [X,Y] : (o_claimcriterion_6a063ec1(X,Y) => o_conditionspecification_bd3c5c1d(Y)))
```

### profile_2656 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimIntendedCapability`

```text
(! [X,Y] : (o_claimintendedcapability_56a5a011(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2657 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimProduct`

```text
(! [X,Y] : (o_claimproduct_a8f421e4(X,Y) => o_product_5e2e77d6(Y)))
```

### profile_2658 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimRealization`

```text
(! [X,Y] : (o_claimrealization_2e93c51b(X,Y) => o_productrealization_b516a087(Y)))
```

### profile_2659 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimRequirement`

```text
(! [X,Y] : (o_claimrequirement_19e961d9(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2660 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimStatement`

```text
(! [X,Y] : (o_claimstatement_30ad9287(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2661 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimSubject`

```text
(! [X,Y] : (o_claimsubject_8dc7dd3c(X,Y) => (((o_product_5e2e77d6(Y) | o_productversion_e1d59901(Y)) | o_productrealization_b516a087(Y)) | o_requirementspecification_067f8073(Y))))
```

### profile_2662 — range

Source: `urn:product-ontology:assessment-profile:0.4:claimVersion`

```text
(! [X,Y] : (o_claimversion_32b75c75(X,Y) => o_productversion_e1d59901(Y)))
```

### profile_2663 — range

Source: `urn:productium:specification-profile:concernsRequirement`

```text
(! [X,Y] : (o_concernsrequirement_aa894472(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2664 — range

Source: `urn:productium:specification-profile:conditionStatement`

```text
(! [X,Y] : (o_conditionstatement_d35dee07(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2665 — range

Source: `urn:productium:specification-profile:constrainsRequirement`

```text
(! [X,Y] : (o_constrainsrequirement_a32faf49(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2666 — range

Source: `urn:productium:specification-profile:containsCase`

```text
(! [X,Y] : (o_containscase_30232243(X,Y) => o_testcase_d5ce3254(Y)))
```

### profile_2667 — range

Source: `urn:productium:specification-profile:containsProduct`

```text
(! [X,Y] : (o_containsproduct_ecaaf85f(X,Y) => o_product_5e2e77d6(Y)))
```

### profile_2668 — range

Source: `urn:productium:specification-profile:containsStage`

```text
(! [X,Y] : (o_containsstage_2deab665(X,Y) => o_journeystagespecification_4d216026(Y)))
```

### profile_2669 — range

Source: `urn:product-ontology:assessment-profile:0.4:contextDescription`

```text
(! [X,Y] : (o_contextdescription_a35336af(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2670 — range

Source: `urn:product-ontology:assessment-profile:0.4:contextScenario`

```text
(! [X,Y] : (o_contextscenario_74327530(X,Y) => o_scenariospecification_131385c1(Y)))
```

### profile_2671 — range

Source: `urn:product-ontology:assessment-profile:0.4:contextSource`

```text
(! [X,Y] : (o_contextsource_10343fb1(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2672 — range

Source: `urn:product-ontology:assessment-profile:0.4:contextVersion`

```text
(! [X,Y] : (o_contextversion_b62a88f2(X,Y) => o_productversion_e1d59901(Y)))
```

### profile_2673 — range

Source: `urn:product-ontology:trace-profile:0.6:decisionConsidersSolution`

```text
(! [X,Y] : (o_decisionconsiderssolution_6ba3a05f(X,Y) => o_solutionspecification_ca854bd1(Y)))
```

### profile_2674 — range

Source: `urn:product-ontology:trace-profile:0.6:decisionEvidence`

```text
(! [X,Y] : (o_decisionevidence_98d8b65a(X,Y) => o_evidenceattributionrecord_1c89f498(Y)))
```

### profile_2675 — range

Source: `urn:product-ontology:trace-profile:0.6:decisionRationale`

```text
(! [X,Y] : (o_decisionrationale_a17588c8(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2676 — range

Source: `urn:product-ontology:trace-profile:0.6:decisionSelectsSolution`

```text
(! [X,Y] : (o_decisionselectssolution_595fe441(X,Y) => o_solutionspecification_ca854bd1(Y)))
```

### profile_2677 — range

Source: `urn:product-ontology:trace-profile:0.6:decisionSource`

```text
(! [X,Y] : (o_decisionsource_5e2bafbc(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2678 — range

Source: `urn:product-ontology:assessment-profile:0.4:deferredStatement`

```text
(! [X,Y] : (o_deferredstatement_cb96fd07(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2679 — range

Source: `urn:productium:specification-profile:definesLifecycleStage`

```text
(! [X,Y] : (o_defineslifecyclestage_9a9dcdbb(X,Y) => o_lifecyclestagespecification_9e5a8393(Y)))
```

### profile_2680 — range

Source: `urn:product-ontology:trace-profile:0.6:dependencyActualCapabilityTarget`

```text
(! [X,Y] : (o_dependencyactualcapabilitytarget_5f4e89b9(X,Y) => o_productcapability_5801242c(Y)))
```

### profile_2681 — range

Source: `urn:product-ontology:trace-profile:0.6:dependencyCapabilitySpecificationTarget`

```text
(! [X,Y] : (o_dependencycapabilityspecificationtarget_cfd20400(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2682 — range

Source: `urn:product-ontology:trace-profile:0.6:dependencyCondition`

```text
(! [X,Y] : (o_dependencycondition_cc5a91c9(X,Y) => o_conditionspecification_bd3c5c1d(Y)))
```

### profile_2683 — range

Source: `urn:product-ontology:trace-profile:0.6:dependencyExternalTarget`

```text
(! [X,Y] : (o_dependencyexternaltarget_24a02018(X,Y) => o_externalreferencerecord_c2bf0dcc(Y)))
```

### profile_2684 — range

Source: `urn:product-ontology:trace-profile:0.6:dependencyProductTarget`

```text
(! [X,Y] : (o_dependencyproducttarget_c8cb5b8c(X,Y) => o_product_5e2e77d6(Y)))
```

### profile_2685 — range

Source: `urn:product-ontology:trace-profile:0.6:dependencySource`

```text
(! [X,Y] : (o_dependencysource_84023279(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2686 — range

Source: `urn:productium:specification-profile:dependsOnEnablerSpecification`

```text
(! [X,Y] : (o_dependsonenablerspecification_e09124c8(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2687 — range

Source: `urn:productium:specification-profile:evaluatedAgainst`

```text
(! [X,Y] : (o_evaluatedagainst_b6d44896(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2688 — range

Source: `urn:product-ontology:assessment-profile:0.4:excludedStatement`

```text
(! [X,Y] : (o_excludedstatement_bd86f1d3(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2689 — range

Source: `urn:productium:specification-profile:executes`

```text
(! [X,Y] : (o_executes_ed879ee9(X,Y) => o_testcase_d5ce3254(Y)))
```

### profile_2690 — range

Source: `urn:product-ontology:delivery-profile:0.5:executionContext`

```text
(! [X,Y] : (o_executioncontext_02a29f55(X,Y) => o_assessmentcontextspecification_9a5060b5(Y)))
```

### profile_2691 — range

Source: `urn:product-ontology:delivery-profile:0.5:executionCriterion`

```text
(! [X,Y] : (o_executioncriterion_db30b082(X,Y) => o_conditionspecification_bd3c5c1d(Y)))
```

### profile_2692 — range

Source: `urn:product-ontology:delivery-profile:0.5:executionEndedAt`

```text
(! [X,Y] : (o_executionendedat_2fa28738(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2693 — range

Source: `urn:productium:specification-profile:exemplifiedByScenario`

```text
(! [X,Y] : (o_exemplifiedbyscenario_2222458f(X,Y) => o_requirementscenariospecification_1c228a11(Y)))
```

### profile_2694 — range

Source: `urn:productium:specification-profile:expectedEnabledBy`

```text
(! [X,Y] : (o_expectedenabledby_66626032(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2695 — range

Source: `urn:product-ontology:assessment-profile:0.4:findingSource`

```text
(! [X,Y] : (o_findingsource_666e303f(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2696 — range

Source: `urn:product-ontology:assessment-profile:0.4:findingStatement`

```text
(! [X,Y] : (o_findingstatement_ba684cd2(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2697 — range

Source: `urn:productium:specification-profile:hasDependencySpecification`

```text
(! [X,Y] : (o_hasdependencyspecification_b4f40c53(X,Y) => o_dependencyspecification_9401a9e8(Y)))
```

### profile_2698 — range

Source: `urn:productium:specification-profile:hasFeatureCriterion`

```text
(! [X,Y] : (o_hasfeaturecriterion_3b1e170f(X,Y) => o_acceptancecriterionspecification_0299ae3e(Y)))
```

### profile_2699 — range

Source: `urn:productium:specification-profile:hasProductStatusRecord`

```text
(! [X,Y] : (o_hasproductstatusrecord_d1c2c559(X,Y) => o_productstatusrecord_15a4cd21(Y)))
```

### profile_2700 — range

Source: `urn:productium:specification-profile:hasProposedSolution`

```text
(! [X,Y] : (o_hasproposedsolution_f48d80c8(X,Y) => o_solutionspecification_ca854bd1(Y)))
```

### profile_2701 — range

Source: `urn:productium:specification-profile:hasScopeSpecification`

```text
(! [X,Y] : (o_hasscopespecification_15ac67e9(X,Y) => o_scopespecification_beb9b28d(Y)))
```

### profile_2702 — range

Source: `urn:productium:specification-profile:hasStoryCriterion`

```text
(! [X,Y] : (o_hasstorycriterion_324c6d65(X,Y) => o_acceptancecriterionspecification_0299ae3e(Y)))
```

### profile_2703 — range

Source: `urn:productium:specification-profile:hasStorySpecification`

```text
(! [X,Y] : (o_hasstoryspecification_d8dd9c41(X,Y) => o_userstoryspecification_680a42c6(Y)))
```

### profile_2704 — range

Source: `urn:productium:specification-profile:hasVersion`

```text
(! [X,Y] : (o_hasversion_4f56b7f5(X,Y) => o_productversion_e1d59901(Y)))
```

### profile_2705 — range

Source: `urn:productium:specification-profile:hasVisionStatement`

```text
(! [X,Y] : (o_hasvisionstatement_4d04c805(X,Y) => o_visionstatement_cc6f8a1e(Y)))
```

### profile_2706 — range

Source: `urn:productium:specification-profile:hypothesizesAboutProblem`

```text
(! [X,Y] : (o_hypothesizesaboutproblem_ab4d9ffa(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2707 — range

Source: `urn:productium:specification-profile:implementsFeature`

```text
(! [X,Y] : (o_implementsfeature_60c7b80d(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2708 — range

Source: `urn:product-ontology:assessment-profile:0.4:includedStatement`

```text
(! [X,Y] : (o_includedstatement_01f21b71(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2709 — range

Source: `urn:productium:specification-profile:informsInitiative`

```text
(! [X,Y] : (o_informsinitiative_91e95196(X,Y) => o_initiativespecification_5404588f(Y)))
```

### profile_2710 — range

Source: `urn:productium:specification-profile:intendedToEnableFeature`

```text
(! [X,Y] : (o_intendedtoenablefeature_d4c185e5(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2711 — range

Source: `urn:productium:specification-profile:intendsCapability`

```text
(! [X,Y] : (o_intendscapability_32debd07(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2712 — range

Source: `urn:productium:specification-profile:intendsToAddressProblem`

```text
(! [X,Y] : (o_intendstoaddressproblem_b7999f7d(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2713 — range

Source: `urn:productium:specification-profile:intendsToContributeToOutcome`

```text
(! [X,Y] : (o_intendstocontributetooutcome_26f1e26d(X,Y) => o_outcomespecification_05ee7bc3(Y)))
```

### profile_2714 — range

Source: `urn:productium:specification-profile:intendsToSupportGoal`

```text
(! [X,Y] : (o_intendstosupportgoal_ca793e16(X,Y) => o_goalspecification_9ac1cc8d(Y)))
```

### profile_2715 — range

Source: `urn:product-ontology:delivery-profile:0.5:itemStatus`

```text
(! [X,Y] : (o_itemstatus_370b117a(X,Y) => o_deliveryworkitemstatusrecord_17e65d34(Y)))
```

### profile_2716 — range

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusChange`

```text
(! [X,Y] : (o_itemstatuschange_1f124dff(X,Y) => o_changerecord_f3de1b87(Y)))
```

### profile_2717 — range

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusCode`

```text
(! [X,Y] : (o_itemstatuscode_a08e2882(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2718 — range

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusReportedAt`

```text
(! [X,Y] : (o_itemstatusreportedat_5cd2a459(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2719 — range

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusScheme`

```text
(! [X,Y] : (o_itemstatusscheme_abd64624(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2720 — range

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusSource`

```text
(! [X,Y] : (o_itemstatussource_abbfc60e(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2721 — range

Source: `urn:product-ontology:delivery-profile:0.5:itemStatusVersion`

```text
(! [X,Y] : (o_itemstatusversion_83352ce1(X,Y) => o_productversion_e1d59901(Y)))
```

### profile_2722 — range

Source: `urn:productium:specification-profile:justifiesRequirement`

```text
(! [X,Y] : (o_justifiesrequirement_19321de4(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2723 — range

Source: `urn:productium:specification-profile:motivatesGoal`

```text
(! [X,Y] : (o_motivatesgoal_1f820745(X,Y) => o_goalspecification_9ac1cc8d(Y)))
```

### profile_2724 — range

Source: `urn:productium:specification-profile:motivatesHypothesis`

```text
(! [X,Y] : (o_motivateshypothesis_17ba4d64(X,Y) => o_hypothesisspecification_9a33f1c8(Y)))
```

### profile_2725 — range

Source: `urn:productium:specification-profile:motivatesSolutionHypothesis`

```text
(! [X,Y] : (o_motivatessolutionhypothesis_906ea5a3(X,Y) => o_solutionhypothesisspecification_724e7cc7(Y)))
```

### profile_2726 — range

Source: `urn:product-ontology:trace-profile:0.6:narrativeCitesEvidence`

```text
(! [X,Y] : (o_narrativecitesevidence_4c4cfa6a(X,Y) => o_evidenceattributionrecord_1c89f498(Y)))
```

### profile_2727 — range

Source: `urn:product-ontology:trace-profile:0.6:narrativeCitesInsight`

```text
(! [X,Y] : (o_narrativecitesinsight_effdb379(X,Y) => o_marketinginsightreference_ecbebe36(Y)))
```

### profile_2728 — range

Source: `urn:product-ontology:delivery-profile:0.5:observedAuthority`

```text
(! [X,Y] : (o_observedauthority_0599d34b(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2729 — range

Source: `urn:product-ontology:delivery-profile:0.5:observedTarget`

```text
(! [X,Y] : (o_observedtarget_32dd708a(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2730 — range

Source: `urn:productium:specification-profile:offeringOf`

```text
(! [X,Y] : (o_offeringof_38930d39(X,Y) => o_product_5e2e77d6(Y)))
```

### profile_2731 — range

Source: `urn:productium:specification-profile:operationalizedByCriterion`

```text
(! [X,Y] : (o_operationalizedbycriterion_dab109a6(X,Y) => o_acceptancecriterionspecification_0299ae3e(Y)))
```

### profile_2732 — range

Source: `urn:productium:specification-profile:organizesEntry`

```text
(! [X,Y] : (o_organizesentry_8770c5a7(X,Y) => o_portfolioentry_e83956e9(Y)))
```

### profile_2733 — range

Source: `urn:productium:specification-profile:personaDescription`

```text
(! [X,Y] : (o_personadescription_d3f39048(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2734 — range

Source: `urn:productium:specification-profile:predictsOutcome`

```text
(! [X,Y] : (o_predictsoutcome_89abbedd(X,Y) => o_outcomespecification_05ee7bc3(Y)))
```

### profile_2735 — range

Source: `urn:product-ontology:trace-profile:0.6:proposalFeature`

```text
(! [X,Y] : (o_proposalfeature_019a6892(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2736 — range

Source: `urn:product-ontology:trace-profile:0.6:proposalScope`

```text
(! [X,Y] : (o_proposalscope_0facbcb1(X,Y) => o_scopespecification_beb9b28d(Y)))
```

### profile_2737 — range

Source: `urn:product-ontology:trace-profile:0.6:proposalSource`

```text
(! [X,Y] : (o_proposalsource_dea17c01(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2738 — range

Source: `urn:product-ontology:trace-profile:0.6:proposalStatement`

```text
(! [X,Y] : (o_proposalstatement_9485e7f4(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2739 — range

Source: `urn:productium:specification-profile:proposesCapability`

```text
(! [X,Y] : (o_proposescapability_c6854e04(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2740 — range

Source: `urn:productium:specification-profile:proposesFeature`

```text
(! [X,Y] : (o_proposesfeature_d77fdc30(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2741 — range

Source: `urn:productium:specification-profile:r100_usesPositioningStatement`

```text
(! [X,Y] : (o_r100_usespositioningstatement_7d9e1c8f(X,Y) => o_positioningstatement_23009b5a(Y)))
```

### profile_2742 — range

Source: `urn:productium:specification-profile:r101_plansLaunch`

```text
(! [X,Y] : (o_r101_planslaunch_3f463a58(X,Y) => o_launchspecification_19376d8c(Y)))
```

### profile_2743 — range

Source: `urn:productium:specification-profile:r102_targetsMarketingGoal`

```text
(! [X,Y] : (o_r102_targetsmarketinggoal_24bd6c0f(X,Y) => o_marketinggoalspecification_19f0f0dc(Y)))
```

### profile_2744 — range

Source: `urn:productium:specification-profile:r103_informsPositioningStatement`

```text
(! [X,Y] : (o_r103_informspositioningstatement_120b1242(X,Y) => o_positioningstatement_23009b5a(Y)))
```

### profile_2745 — range

Source: `urn:productium:specification-profile:r104_informsGoToMarketSpecification`

```text
(! [X,Y] : (o_r104_informsgotomarketspecification_02341859(X,Y) => o_gotomarketspecification_e383dc02(Y)))
```

### profile_2746 — range

Source: `urn:productium:specification-profile:r105_informsGoToMarketFromAcquisition`

```text
(! [X,Y] : (o_r105_informsgotomarketfromacquisition_feb8a2fc(X,Y) => o_gotomarketspecification_e383dc02(Y)))
```

### profile_2747 — range

Source: `urn:productium:specification-profile:r106_informsGoToMarketFromAdoption`

```text
(! [X,Y] : (o_r106_informsgotomarketfromadoption_b0f8bd14(X,Y) => o_gotomarketspecification_e383dc02(Y)))
```

### profile_2748 — range

Source: `urn:product-ontology:relation-profile:0.7:r107_intendedToSupport`

```text
(! [X,Y] : (o_r107_intendedtosupport_a55e674b(X,Y) => o_business_3abusinesscapability_f89e9560(Y)))
```

### profile_2749 — range

Source: `urn:product-ontology:relation-profile:0.7:r116_references`

```text
(! [X,Y] : (o_r116_references_63e63e34(X,Y) => o_business_3avalueproposition_0e38f937(Y)))
```

### profile_2750 — range

Source: `urn:productium:specification-profile:r117_tracksInitiative`

```text
(! [X,Y] : (o_r117_tracksinitiative_681adc26(X,Y) => o_initiativespecification_5404588f(Y)))
```

### profile_2751 — range

Source: `urn:productium:specification-profile:r118_tracksReleaseSpecification`

```text
(! [X,Y] : (o_r118_tracksreleasespecification_df925b75(X,Y) => o_releasespecification_37d609b4(Y)))
```

### profile_2752 — range

Source: `urn:productium:specification-profile:r119_tracksMilestoneSpecification`

```text
(! [X,Y] : (o_r119_tracksmilestonespecification_daacb60c(X,Y) => o_milestonespecification_585f68a5(Y)))
```

### profile_2753 — range

Source: `urn:productium:specification-profile:r120_referencesProductLine`

```text
(! [X,Y] : (o_r120_referencesproductline_8119739b(X,Y) => o_productlinereference_b18ff0aa(Y)))
```

### profile_2754 — range

Source: `urn:productium:specification-profile:r121_hasPortfolioConfidenceAssessment`

```text
(! [X,Y] : (o_r121_hasportfolioconfidenceassessment_8c1fdc29(X,Y) => o_confidenceassessment_e93b5ff6(Y)))
```

### profile_2755 — range

Source: `urn:productium:specification-profile:r122_targetsPersona`

```text
(! [X,Y] : (o_r122_targetspersona_ae33ca6e(X,Y) => o_personaspecification_81fd0066(Y)))
```

### profile_2756 — range

Source: `urn:productium:specification-profile:r123_framesJourney`

```text
(! [X,Y] : (o_r123_framesjourney_c1aae71e(X,Y) => o_journeyspecification_6c58f66d(Y)))
```

### profile_2757 — range

Source: `urn:productium:specification-profile:r125_framesFeature`

```text
(! [X,Y] : (o_r125_framesfeature_be65a400(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2758 — range

Source: `urn:productium:specification-profile:r127_tracksInitiativeReleaseSpecification`

```text
(! [X,Y] : (o_r127_tracksinitiativereleasespecification_bfe3d8f2(X,Y) => o_releasespecification_37d609b4(Y)))
```

### profile_2759 — range

Source: `urn:productium:specification-profile:r133_supportedBy`

```text
(! [X,Y] : (o_r133_supportedby_3ea116b3(X,Y) => o_userflowspecification_fb730f56(Y)))
```

### profile_2760 — range

Source: `urn:productium:specification-profile:r135_recordsResolutionChange`

```text
(! [X,Y] : (o_r135_recordsresolutionchange_c4c748e4(X,Y) => o_changerecord_f3de1b87(Y)))
```

### profile_2761 — range

Source: `urn:productium:specification-profile:r136_includes`

```text
(! [X,Y] : (o_r136_includes_f27d15f3(X,Y) => o_touchpointspecification_88904c65(Y)))
```

### profile_2762 — range

Source: `urn:productium:specification-profile:r137_includesScreen`

```text
(! [X,Y] : (o_r137_includesscreen_b67b76df(X,Y) => o_screenspecification_cad2e1fc(Y)))
```

### profile_2763 — range

Source: `urn:productium:specification-profile:r138_precededBy`

```text
(! [X,Y] : (o_r138_precededby_4bd62bab(X,Y) => o_screenspecification_cad2e1fc(Y)))
```

### profile_2764 — range

Source: `urn:productium:specification-profile:r139_intendsToSupportGoal`

```text
(! [X,Y] : (o_r139_intendstosupportgoal_99240761(X,Y) => o_goalspecification_9ac1cc8d(Y)))
```

### profile_2765 — range

Source: `urn:productium:specification-profile:r140_plansEntryRelease`

```text
(! [X,Y] : (o_r140_plansentryrelease_6edbf91c(X,Y) => o_releasespecification_37d609b4(Y)))
```

### profile_2766 — range

Source: `urn:productium:specification-profile:r141_milestoneForReleaseSpecification`

```text
(! [X,Y] : (o_r141_milestoneforreleasespecification_436e77e6(X,Y) => o_releasespecification_37d609b4(Y)))
```

### profile_2767 — range

Source: `urn:productium:specification-profile:r142_groupsPlannedInitiative`

```text
(! [X,Y] : (o_r142_groupsplannedinitiative_5df56fc8(X,Y) => o_initiativespecification_5404588f(Y)))
```

### profile_2768 — range

Source: `urn:productium:specification-profile:r143_usesWindowHorizonDefinition`

```text
(! [X,Y] : (o_r143_useswindowhorizondefinition_61719e93(X,Y) => o_planninghorizondefinition_b6519652(Y)))
```

### profile_2769 — range

Source: `urn:productium:specification-profile:r144_targetsReleaseGoal`

```text
(! [X,Y] : (o_r144_targetsreleasegoal_95fe86ff(X,Y) => o_goalspecification_9ac1cc8d(Y)))
```

### profile_2770 — range

Source: `urn:productium:specification-profile:r145_concernsDeliveryWorkItem`

```text
(! [X,Y] : (o_r145_concernsdeliveryworkitem_4adaf68c(X,Y) => o_deliveryworkitem_f98a3f27(Y)))
```

### profile_2771 — range

Source: `urn:productium:specification-profile:r146_specifiesRequirementVerification`

```text
(! [X,Y] : (o_r146_specifiesrequirementverification_23b89ac8(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2772 — range

Source: `urn:productium:specification-profile:r147_hasRecordedExecution`

```text
(! [X,Y] : (o_r147_hasrecordedexecution_b149d286(X,Y) => o_testexecution_483822c9(Y)))
```

### profile_2773 — range

Source: `urn:productium:specification-profile:r148_referencesJourneyStage`

```text
(! [X,Y] : (o_r148_referencesjourneystage_f1b07c84(X,Y) => o_journeystagespecification_4d216026(Y)))
```

### profile_2774 — range

Source: `urn:productium:specification-profile:r149_targetsLaunchPersona`

```text
(! [X,Y] : (o_r149_targetslaunchpersona_b7340d99(X,Y) => o_personaspecification_81fd0066(Y)))
```

### profile_2775 — range

Source: `urn:productium:specification-profile:r150_usesLaunchPositioning`

```text
(! [X,Y] : (o_r150_useslaunchpositioning_df725e36(X,Y) => o_positioningstatement_23009b5a(Y)))
```

### profile_2776 — range

Source: `urn:productium:specification-profile:r151_usesLaunchMessaging`

```text
(! [X,Y] : (o_r151_useslaunchmessaging_fc78021d(X,Y) => o_messagingspecification_24de7362(Y)))
```

### profile_2777 — range

Source: `urn:productium:specification-profile:r154_referencesMetric`

```text
(! [X,Y] : (o_r154_referencesmetric_5e8c4c07(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2778 — range

Source: `urn:productium:specification-profile:r155_addresses`

```text
(! [X,Y] : (o_r155_addresses_03ac5ee1(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2779 — range

Source: `urn:productium:specification-profile:r156_referencesMetric`

```text
(! [X,Y] : (o_r156_referencesmetric_e08298d2(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2780 — range

Source: `urn:product-ontology:relation-profile:0.7:r157_evidencedBy`

```text
(! [X,Y] : (o_r157_evidencedby_0c148076(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2781 — range

Source: `urn:productium:specification-profile:r158_referencesMetric`

```text
(! [X,Y] : (o_r158_referencesmetric_faff69ea(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2782 — range

Source: `urn:product-ontology:relation-profile:0.7:r160_evidencedBy`

```text
(! [X,Y] : (o_r160_evidencedby_f78dca6e(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2783 — range

Source: `urn:product-ontology:relation-profile:0.7:r162_evidencedBy`

```text
(! [X,Y] : (o_r162_evidencedby_a21fefbd(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2784 — range

Source: `urn:productium:specification-profile:r164_intendsToAddressProblem`

```text
(! [X,Y] : (o_r164_intendstoaddressproblem_1652c40a(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2785 — range

Source: `urn:productium:specification-profile:r165_specifiesBeneficiaryPersona`

```text
(! [X,Y] : (o_r165_specifiesbeneficiarypersona_54ff8b06(X,Y) => o_personaspecification_81fd0066(Y)))
```

### profile_2786 — range

Source: `urn:productium:specification-profile:r166_referencesMetric`

```text
(! [X,Y] : (o_r166_referencesmetric_bb043a79(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2787 — range

Source: `urn:product-ontology:relation-profile:0.7:r167_supports`

```text
(! [X,Y] : (o_r167_supports_ac5c3998(X,Y) => o_business_3abusinessgoal_c090e4a7(Y)))
```

### profile_2788 — range

Source: `urn:productium:specification-profile:r168_identifiesOpportunity`

```text
(! [X,Y] : (o_r168_identifiesopportunity_67e1eb38(X,Y) => o_opportunitystatement_b89a8713(Y)))
```

### profile_2789 — range

Source: `urn:productium:specification-profile:r169_referencesMetric`

```text
(! [X,Y] : (o_r169_referencesmetric_8b89a396(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2790 — range

Source: `urn:productium:specification-profile:r170_identifiesOpportunity`

```text
(! [X,Y] : (o_r170_identifiesopportunity_1891e592(X,Y) => o_opportunitystatement_b89a8713(Y)))
```

### profile_2791 — range

Source: `urn:productium:specification-profile:r171_referencesMetric`

```text
(! [X,Y] : (o_r171_referencesmetric_60f96202(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2792 — range

Source: `urn:productium:specification-profile:r172_addressesProblemStatement`

```text
(! [X,Y] : (o_r172_addressesproblemstatement_c107d468(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2793 — range

Source: `urn:productium:specification-profile:r173_claimsDifferentiationThrough`

```text
(! [X,Y] : (o_r173_claimsdifferentiationthrough_32299f8b(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2794 — range

Source: `urn:productium:specification-profile:r174_targetsMessagePersona`

```text
(! [X,Y] : (o_r174_targetsmessagepersona_4f03fd4a(X,Y) => o_personaspecification_81fd0066(Y)))
```

### profile_2795 — range

Source: `urn:productium:specification-profile:r175_referencesMessageFeature`

```text
(! [X,Y] : (o_r175_referencesmessagefeature_8652872f(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2796 — range

Source: `urn:productium:specification-profile:r176_referencesMetric`

```text
(! [X,Y] : (o_r176_referencesmetric_7f5339f1(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2797 — range

Source: `urn:productium:specification-profile:r177_referencesMetric`

```text
(! [X,Y] : (o_r177_referencesmetric_585bd336(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2798 — range

Source: `urn:productium:specification-profile:r178_referencesMetric`

```text
(! [X,Y] : (o_r178_referencesmetric_16b8c658(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2799 — range

Source: `urn:productium:specification-profile:r179_addressesNarrativeProblem`

```text
(! [X,Y] : (o_r179_addressesnarrativeproblem_34764f2c(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2800 — range

Source: `urn:productium:specification-profile:r180_claimsDifferentiationThrough`

```text
(! [X,Y] : (o_r180_claimsdifferentiationthrough_ad8a3f6b(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2801 — range

Source: `urn:productium:specification-profile:r181_hypothesizesAcquisitionForProblem`

```text
(! [X,Y] : (o_r181_hypothesizesacquisitionforproblem_3b87a7c1(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2802 — range

Source: `urn:productium:specification-profile:r182_referencesMetric`

```text
(! [X,Y] : (o_r182_referencesmetric_a7139da4(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2803 — range

Source: `urn:productium:specification-profile:r183_hypothesizesAdoptionForProblem`

```text
(! [X,Y] : (o_r183_hypothesizesadoptionforproblem_b930ea90(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2804 — range

Source: `urn:productium:specification-profile:r184_referencesMetric`

```text
(! [X,Y] : (o_r184_referencesmetric_73452d4c(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2805 — range

Source: `urn:product-ontology:relation-profile:0.7:r185_referencesValueProposition`

```text
(! [X,Y] : (o_r185_referencesvalueproposition_ffb84690(X,Y) => o_business_3avalueproposition_0e38f937(Y)))
```

### profile_2806 — range

Source: `urn:product-ontology:relation-profile:0.7:r186_targets`

```text
(! [X,Y] : (o_r186_targets_2cb09f38(X,Y) => o_market_3acustomersegment_66d92554(Y)))
```

### profile_2807 — range

Source: `urn:product-ontology:relation-profile:0.7:r187_includesService`

```text
(! [X,Y] : (o_r187_includesservice_8dab3bd6(X,Y) => o_business_3aservice_f1320a41(Y)))
```

### profile_2808 — range

Source: `urn:product-ontology:relation-profile:0.7:r188_referencesVariantConfiguration`

```text
(! [X,Y] : (o_r188_referencesvariantconfiguration_763729c8(X,Y) => o_productline_3aproductconfiguration_1aa4dbad(Y)))
```

### profile_2809 — range

Source: `urn:product-ontology:relation-profile:0.7:r189_targets`

```text
(! [X,Y] : (o_r189_targets_f54bba9b(X,Y) => o_market_3acustomersegment_66d92554(Y)))
```

### profile_2810 — range

Source: `urn:product-ontology:relation-profile:0.7:r190_referencesValueProposition`

```text
(! [X,Y] : (o_r190_referencesvalueproposition_e34183b3(X,Y) => o_business_3avalueproposition_0e38f937(Y)))
```

### profile_2811 — range

Source: `urn:product-ontology:relation-profile:0.7:r192_references`

```text
(! [X,Y] : (o_r192_references_797ec57b(X,Y) => o_externalunresolved_3aevidence_f652b3e0(Y)))
```

### profile_2812 — range

Source: `urn:product-ontology:relation-profile:0.7:r194_referencesMentalModel`

```text
(! [X,Y] : (o_r194_referencesmentalmodel_4329630f(X,Y) => o_uxresearch_3auser_mental_model_8ac43723(Y)))
```

### profile_2813 — range

Source: `urn:product-ontology:relation-profile:0.7:r195_usesScript`

```text
(! [X,Y] : (o_r195_usesscript_5e74131c(X,Y) => o_externalunresolved_3atest_script_3061cf78(Y)))
```

### profile_2814 — range

Source: `urn:product-ontology:relation-profile:0.7:r196_reportedUnderTestPlan`

```text
(! [X,Y] : (o_r196_reportedundertestplan_d76ea0ce(X,Y) => o_externalunresolved_3atest_plan_77f789bb(Y)))
```

### profile_2815 — range

Source: `urn:product-ontology:relation-profile:0.7:r197_citesExecutionScript`

```text
(! [X,Y] : (o_r197_citesexecutionscript_27d9b423(X,Y) => o_externalunresolved_3atest_script_3061cf78(Y)))
```

### profile_2816 — range

Source: `urn:product-ontology:relation-profile:0.7:r198_citesSupportingEvidence`

```text
(! [X,Y] : (o_r198_citessupportingevidence_b12e8015(X,Y) => o_externalunresolved_3aevidence_f652b3e0(Y)))
```

### profile_2817 — range

Source: `urn:product-ontology:relation-profile:0.7:r199_referencesDatasetConfiguration`

```text
(! [X,Y] : (o_r199_referencesdatasetconfiguration_3452091a(X,Y) => o_externalunresolved_3aconfiguration_89aedc2c(Y)))
```

### profile_2818 — range

Source: `urn:product-ontology:relation-profile:0.7:r200_targets`

```text
(! [X,Y] : (o_r200_targets_6af6d65d(X,Y) => o_market_3acustomersegment_66d92554(Y)))
```

### profile_2819 — range

Source: `urn:product-ontology:relation-profile:0.7:r201_targets`

```text
(! [X,Y] : (o_r201_targets_bcdee8f4(X,Y) => o_market_3amarket_caacdc2c(Y)))
```

### profile_2820 — range

Source: `urn:product-ontology:relation-profile:0.7:r202_referencesValueProposition`

```text
(! [X,Y] : (o_r202_referencesvalueproposition_3e308d90(X,Y) => o_business_3avalueproposition_0e38f937(Y)))
```

### profile_2821 — range

Source: `urn:product-ontology:relation-profile:0.7:r203_targets`

```text
(! [X,Y] : (o_r203_targets_4b1b7f63(X,Y) => o_market_3acustomersegment_66d92554(Y)))
```

### profile_2822 — range

Source: `urn:product-ontology:relation-profile:0.7:r204_targets`

```text
(! [X,Y] : (o_r204_targets_cce4b6f0(X,Y) => o_market_3acustomersegment_66d92554(Y)))
```

### profile_2823 — range

Source: `urn:product-ontology:relation-profile:0.7:r207_citesInsightEvidence`

```text
(! [X,Y] : (o_r207_citesinsightevidence_6c67b850(X,Y) => o_externalunresolved_3aevidence_f652b3e0(Y)))
```

### profile_2824 — range

Source: `urn:product-ontology:relation-profile:0.7:r208_addressesNeed`

```text
(! [X,Y] : (o_r208_addressesneed_7e9f91f2(X,Y) => o_market_3aneed_3f8a1679(Y)))
```

### profile_2825 — range

Source: `urn:product-ontology:relation-profile:0.7:r209_informedBy`

```text
(! [X,Y] : (o_r209_informedby_359974a5(X,Y) => o_market_3aneed_3f8a1679(Y)))
```

### profile_2826 — range

Source: `urn:product-ontology:relation-profile:0.7:r210_assessesNeed`

```text
(! [X,Y] : (o_r210_assessesneed_6c9cbff0(X,Y) => o_market_3aneed_3f8a1679(Y)))
```

### profile_2827 — range

Source: `urn:product-ontology:relation-profile:0.7:r211_assessesPain`

```text
(! [X,Y] : (o_r211_assessespain_4bb93078(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2828 — range

Source: `urn:product-ontology:relation-profile:0.7:r212_intendsToAddressNeed`

```text
(! [X,Y] : (o_r212_intendstoaddressneed_c432a5ce(X,Y) => o_market_3aneed_3f8a1679(Y)))
```

### profile_2829 — range

Source: `urn:product-ontology:relation-profile:0.7:r213_addressesPain`

```text
(! [X,Y] : (o_r213_addressespain_f5a8340d(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2830 — range

Source: `urn:product-ontology:relation-profile:0.7:r214_describesPain`

```text
(! [X,Y] : (o_r214_describespain_41cb74d0(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2831 — range

Source: `urn:product-ontology:relation-profile:0.7:r215_describesPain`

```text
(! [X,Y] : (o_r215_describespain_45679c75(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2832 — range

Source: `urn:product-ontology:relation-profile:0.7:r216_intendsToAddressNeed`

```text
(! [X,Y] : (o_r216_intendstoaddressneed_b44769cc(X,Y) => o_market_3aneed_3f8a1679(Y)))
```

### profile_2833 — range

Source: `urn:product-ontology:relation-profile:0.7:r217_describesPain`

```text
(! [X,Y] : (o_r217_describespain_88f12b79(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2834 — range

Source: `urn:product-ontology:relation-profile:0.7:r218_citesSupportingEvidence`

```text
(! [X,Y] : (o_r218_citessupportingevidence_b66ffe2c(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2835 — range

Source: `urn:product-ontology:relation-profile:0.7:r219_addressesPain`

```text
(! [X,Y] : (o_r219_addressespain_19e58eb3(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2836 — range

Source: `urn:product-ontology:relation-profile:0.7:r220_addressesPain`

```text
(! [X,Y] : (o_r220_addressespain_44c648a6(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2837 — range

Source: `urn:product-ontology:relation-profile:0.7:r221_supportedBy`

```text
(! [X,Y] : (o_r221_supportedby_f95d0f4b(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2838 — range

Source: `urn:product-ontology:relation-profile:0.7:r222_differentiatesFrom`

```text
(! [X,Y] : (o_r222_differentiatesfrom_15e5abc1(X,Y) => o_market_3acompetitor_alternative_1d938a32(Y)))
```

### profile_2839 — range

Source: `urn:product-ontology:relation-profile:0.7:r223_supportedBy`

```text
(! [X,Y] : (o_r223_supportedby_0fc110d1(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2840 — range

Source: `urn:product-ontology:relation-profile:0.7:r224_evidencedBy`

```text
(! [X,Y] : (o_r224_evidencedby_733ce5a5(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2841 — range

Source: `urn:product-ontology:relation-profile:0.7:r225_addressesPain`

```text
(! [X,Y] : (o_r225_addressespain_c6e2ffe1(X,Y) => o_market_3apain_2b652a79(Y)))
```

### profile_2842 — range

Source: `urn:product-ontology:relation-profile:0.7:r226_evidencedBy`

```text
(! [X,Y] : (o_r226_evidencedby_83e51087(X,Y) => o_evidencelayer_3aevidence_c26fe8bd(Y)))
```

### profile_2843 — range

Source: `urn:productium:specification-profile:r22_motivatesOpportunity`

```text
(! [X,Y] : (o_r22_motivatesopportunity_6479604f(X,Y) => o_opportunitystatement_b89a8713(Y)))
```

### profile_2844 — range

Source: `urn:productium:specification-profile:r51_describesUserRole`

```text
(! [X,Y] : (o_r51_describesuserrole_3185165a(X,Y) => o_userrolespecification_cccebf00(Y)))
```

### profile_2845 — range

Source: `urn:productium:specification-profile:r52_representedInJourney`

```text
(! [X,Y] : (o_r52_representedinjourney_b2264545(X,Y) => o_journeyspecification_6c58f66d(Y)))
```

### profile_2846 — range

Source: `urn:productium:specification-profile:r54_includes`

```text
(! [X,Y] : (o_r54_includes_e85c425d(X,Y) => o_touchpointspecification_88904c65(Y)))
```

### profile_2847 — range

Source: `urn:productium:specification-profile:r55_describedByFlow`

```text
(! [X,Y] : (o_r55_describedbyflow_1d3fe4a0(X,Y) => o_userflowspecification_fb730f56(Y)))
```

### profile_2848 — range

Source: `urn:productium:specification-profile:r56_specifiesStep`

```text
(! [X,Y] : (o_r56_specifiesstep_4fbba994(X,Y) => o_interactionstepspecification_44c8af3e(Y)))
```

### profile_2849 — range

Source: `urn:productium:specification-profile:r57_referencesScreen`

```text
(! [X,Y] : (o_r57_referencesscreen_af9c2b51(X,Y) => o_screenspecification_cad2e1fc(Y)))
```

### profile_2850 — range

Source: `urn:productium:specification-profile:r58_organizesScreenSpecification`

```text
(! [X,Y] : (o_r58_organizesscreenspecification_55a3985a(X,Y) => o_screenspecification_cad2e1fc(Y)))
```

### profile_2851 — range

Source: `urn:productium:specification-profile:r59_definesUIState`

```text
(! [X,Y] : (o_r59_definesuistate_1240d902(X,Y) => o_uistatespecification_64de4585(Y)))
```

### profile_2852 — range

Source: `urn:productium:specification-profile:r60_reportsOnFlow`

```text
(! [X,Y] : (o_r60_reportsonflow_1078c4ad(X,Y) => o_userflowspecification_fb730f56(Y)))
```

### profile_2853 — range

Source: `urn:productium:specification-profile:r61_reportsOnScreen`

```text
(! [X,Y] : (o_r61_reportsonscreen_dbff3398(X,Y) => o_screenspecification_cad2e1fc(Y)))
```

### profile_2854 — range

Source: `urn:productium:specification-profile:r63_supportedBy`

```text
(! [X,Y] : (o_r63_supportedby_1fdde5fb(X,Y) => o_userflowspecification_fb730f56(Y)))
```

### profile_2855 — range

Source: `urn:productium:specification-profile:r64_organizesRoadmapEntry`

```text
(! [X,Y] : (o_r64_organizesroadmapentry_e6adfceb(X,Y) => o_roadmapentry_c1c3186e(Y)))
```

### profile_2856 — range

Source: `urn:productium:specification-profile:r65_plansInitiative`

```text
(! [X,Y] : (o_r65_plansinitiative_ea87adc7(X,Y) => o_initiativespecification_5404588f(Y)))
```

### profile_2857 — range

Source: `urn:productium:specification-profile:r66_plansFeatureDelivery`

```text
(! [X,Y] : (o_r66_plansfeaturedelivery_82d8279a(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2858 — range

Source: `urn:productium:specification-profile:r67_targetsMilestone`

```text
(! [X,Y] : (o_r67_targetsmilestone_7d34f2ca(X,Y) => o_milestonespecification_585f68a5(Y)))
```

### profile_2859 — range

Source: `urn:productium:specification-profile:r68_hasPriorityAssessment`

```text
(! [X,Y] : (o_r68_haspriorityassessment_32fcf4c1(X,Y) => o_priorityassessment_ac21f6f9(Y)))
```

### profile_2860 — range

Source: `urn:productium:specification-profile:r69_usesRankingCriterion`

```text
(! [X,Y] : (o_r69_usesrankingcriterion_4fe537ae(X,Y) => o_prioritizationcriterionspecification_5d537952(Y)))
```

### profile_2861 — range

Source: `urn:productium:specification-profile:r70_usesHorizonDefinition`

```text
(! [X,Y] : (o_r70_useshorizondefinition_fd4ddeb9(X,Y) => o_planninghorizondefinition_b6519652(Y)))
```

### profile_2862 — range

Source: `urn:productium:specification-profile:r71_hasTargetWindowAssignment`

```text
(! [X,Y] : (o_r71_hastargetwindowassignment_192f03b5(X,Y) => o_targetwindowassignment_f8688c9e(Y)))
```

### profile_2863 — range

Source: `urn:productium:specification-profile:r72_hasEntryConfidenceAssessment`

```text
(! [X,Y] : (o_r72_hasentryconfidenceassessment_e5951f91(X,Y) => o_confidenceassessment_e93b5ff6(Y)))
```

### profile_2864 — range

Source: `urn:productium:specification-profile:r73_usesCommitmentLevelDefinition`

```text
(! [X,Y] : (o_r73_usescommitmentleveldefinition_f065646b(X,Y) => o_commitmentleveldefinition_ff01d228(Y)))
```

### profile_2865 — range

Source: `urn:productium:specification-profile:r74_hasPlanningDependency`

```text
(! [X,Y] : (o_r74_hasplanningdependency_64392581(X,Y) => o_roadmapentry_c1c3186e(Y)))
```

### profile_2866 — range

Source: `urn:productium:specification-profile:r75_plansDeliveryItem`

```text
(! [X,Y] : (o_r75_plansdeliveryitem_0335f73f(X,Y) => o_deliveryworkitem_f98a3f27(Y)))
```

### profile_2867 — range

Source: `urn:productium:specification-profile:r76_referencesChangeRecord`

```text
(! [X,Y] : (o_r76_referenceschangerecord_e6102cca(X,Y) => o_changerecord_f3de1b87(Y)))
```

### profile_2868 — range

Source: `urn:productium:specification-profile:r78_hasReleaseEvidenceRecord`

```text
(! [X,Y] : (o_r78_hasreleaseevidencerecord_349ce5f1(X,Y) => o_releaseevidencerecord_0b26c3e8(Y)))
```

### profile_2869 — range

Source: `urn:productium:specification-profile:r79_proposesRecordedChange`

```text
(! [X,Y] : (o_r79_proposesrecordedchange_17c0be66(X,Y) => o_changerecord_f3de1b87(Y)))
```

### profile_2870 — range

Source: `urn:productium:specification-profile:r80_plansFeature`

```text
(! [X,Y] : (o_r80_plansfeature_7dac01de(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2871 — range

Source: `urn:productium:specification-profile:r81_intendedToContributeToWork`

```text
(! [X,Y] : (o_r81_intendedtocontributetowork_25bd0e17(X,Y) => o_deliveryworkitem_f98a3f27(Y)))
```

### profile_2872 — range

Source: `urn:productium:specification-profile:r82_specifiesFeatureActivationControl`

```text
(! [X,Y] : (o_r82_specifiesfeatureactivationcontrol_6337914a(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2873 — range

Source: `urn:productium:specification-profile:r83_plannedForRelease`

```text
(! [X,Y] : (o_r83_plannedforrelease_2e49ff30(X,Y) => o_releasespecification_37d609b4(Y)))
```

### profile_2874 — range

Source: `urn:productium:specification-profile:r84_covers`

```text
(! [X,Y] : (o_r84_covers_274b6383(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2875 — range

Source: `urn:productium:specification-profile:r85_specifiesRequirementVerification`

```text
(! [X,Y] : (o_r85_specifiesrequirementverification_60458645(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2876 — range

Source: `urn:productium:specification-profile:r86_specifiesCriterionVerification`

```text
(! [X,Y] : (o_r86_specifiescriterionverification_fc5c455e(X,Y) => o_acceptancecriterionspecification_0299ae3e(Y)))
```

### profile_2877 — range

Source: `urn:productium:specification-profile:r87_refinesTestScenario`

```text
(! [X,Y] : (o_r87_refinestestscenario_2f86dad0(X,Y) => o_testscenario_1c3da1d3(Y)))
```

### profile_2878 — range

Source: `urn:productium:specification-profile:r89_referencesTestData`

```text
(! [X,Y] : (o_r89_referencestestdata_23eb835a(X,Y) => o_testdatareference_6063ba4c(Y)))
```

### profile_2879 — range

Source: `urn:productium:specification-profile:r8_supersedes`

```text
(! [X,Y] : (o_r8_supersedes_a59a0a58(X,Y) => o_productversion_e1d59901(Y)))
```

### profile_2880 — range

Source: `urn:productium:specification-profile:r92_hasVerificationEvidenceRecord`

```text
(! [X,Y] : (o_r92_hasverificationevidencerecord_387f2a4e(X,Y) => o_verificationevidencerecord_16c2d7e8(Y)))
```

### profile_2881 — range

Source: `urn:productium:specification-profile:r93_hasValidationEvidenceRecord`

```text
(! [X,Y] : (o_r93_hasvalidationevidencerecord_8467c0d9(X,Y) => o_validationevidencerecord_89bff0ca(Y)))
```

### profile_2882 — range

Source: `urn:productium:specification-profile:r94_hasPositioningStatement`

```text
(! [X,Y] : (o_r94_haspositioningstatement_6fdb00a7(X,Y) => o_positioningstatement_23009b5a(Y)))
```

### profile_2883 — range

Source: `urn:productium:specification-profile:r95_positionedByStatement`

```text
(! [X,Y] : (o_r95_positionedbystatement_6f7e5470(X,Y) => o_positioningstatement_23009b5a(Y)))
```

### profile_2884 — range

Source: `urn:productium:specification-profile:r96_referencesTargetMarket`

```text
(! [X,Y] : (o_r96_referencestargetmarket_27d66c85(X,Y) => o_targetmarketreference_07684f2b(Y)))
```

### profile_2885 — range

Source: `urn:productium:specification-profile:r97_referencesTargetSegment`

```text
(! [X,Y] : (o_r97_referencestargetsegment_26c84e83(X,Y) => o_targetsegmentreference_776e2c90(Y)))
```

### profile_2886 — range

Source: `urn:productium:specification-profile:r98_referencesCompetitiveNarrative`

```text
(! [X,Y] : (o_r98_referencescompetitivenarrative_217aed66(X,Y) => o_competitivenarrative_88476b59(Y)))
```

### profile_2887 — range

Source: `urn:productium:specification-profile:r99_expressesPositioning`

```text
(! [X,Y] : (o_r99_expressespositioning_628c10f4(X,Y) => o_positioningstatement_23009b5a(Y)))
```

### profile_2888 — range

Source: `urn:productium:specification-profile:realizesVersion`

```text
(! [X,Y] : (o_realizesversion_8ca00efc(X,Y) => o_productversion_e1d59901(Y)))
```

### profile_2889 — range

Source: `urn:productium:specification-profile:recordedAttributionTo`

```text
(! [X,Y] : (o_recordedattributionto_3e20c24d(X,Y) => o_assessmentclaim_4878d612(Y)))
```

### profile_2890 — range

Source: `urn:productium:specification-profile:recordsAffectedInitiative`

```text
(! [X,Y] : (o_recordsaffectedinitiative_2fad9b0e(X,Y) => o_initiativespecification_5404588f(Y)))
```

### profile_2891 — range

Source: `urn:productium:specification-profile:recordsCarrier`

```text
(! [X,Y] : (o_recordscarrier_68e09c12(X,Y) => o_evidenceartifact_6317ec1f(Y)))
```

### profile_2892 — range

Source: `urn:productium:specification-profile:recordsClaim`

```text
(! [X,Y] : (o_recordsclaim_3d0873c5(X,Y) => o_assessmentclaim_4878d612(Y)))
```

### profile_2893 — range

Source: `urn:productium:specification-profile:recordsCriterion`

```text
(! [X,Y] : (o_recordscriterion_00fcf0e8(X,Y) => o_decisioncriterionspecification_2f0e2825(Y)))
```

### profile_2894 — range

Source: `urn:productium:specification-profile:recordsExecution`

```text
(! [X,Y] : (o_recordsexecution_bdd9ccef(X,Y) => o_testexecution_483822c9(Y)))
```

### profile_2895 — range

Source: `urn:productium:specification-profile:referencePurpose`

```text
(! [X,Y] : (o_referencepurpose_536ac956(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2896 — range

Source: `urn:product-ontology:delivery-profile:0.5:referenceRecordedAt`

```text
(! [X,Y] : (o_referencerecordedat_d583c6bc(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2897 — range

Source: `urn:product-ontology:delivery-profile:0.5:referenceReviewFinding`

```text
(! [X,Y] : (o_referencereviewfinding_3b780567(X,Y) => o_findingrecord_6c235440(Y)))
```

### profile_2898 — range

Source: `urn:product-ontology:delivery-profile:0.5:referenceRevisionLabel`

```text
(! [X,Y] : (o_referencerevisionlabel_8b082866(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2899 — range

Source: `urn:productium:specification-profile:referencesOffering`

```text
(! [X,Y] : (o_referencesoffering_bfc38ac5(X,Y) => o_offeringspecification_fd5297ce(Y)))
```

### profile_2900 — range

Source: `urn:productium:specification-profile:referencesProduct`

```text
(! [X,Y] : (o_referencesproduct_8b03c51e(X,Y) => o_product_5e2e77d6(Y)))
```

### profile_2901 — range

Source: `urn:productium:specification-profile:referencesProductFamily`

```text
(! [X,Y] : (o_referencesproductfamily_7de942a9(X,Y) => o_productfamilyreference_b7144cb8(Y)))
```

### profile_2902 — range

Source: `urn:productium:specification-profile:referencesProductLine`

```text
(! [X,Y] : (o_referencesproductline_556acfa2(X,Y) => o_productlinereference_b18ff0aa(Y)))
```

### profile_2903 — range

Source: `urn:productium:specification-profile:referencesProductVariant`

```text
(! [X,Y] : (o_referencesproductvariant_63ea45c4(X,Y) => o_productvariantreference_0a8d9825(Y)))
```

### profile_2904 — range

Source: `urn:productium:specification-profile:referencesRuleForRequirement`

```text
(! [X,Y] : (o_referencesruleforrequirement_82b4b463(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2905 — range

Source: `urn:product-ontology:delivery-profile:0.5:referenceSupersedes`

```text
(! [X,Y] : (o_referencesupersedes_67ba3120(X,Y) => o_externalreferencerecord_c2bf0dcc(Y)))
```

### profile_2906 — range

Source: `urn:productium:specification-profile:refinedByRequirement`

```text
(! [X,Y] : (o_refinedbyrequirement_96eabe04(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2907 — range

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusChange`

```text
(! [X,Y] : (o_releasestatuschange_a735bfeb(X,Y) => o_changerecord_f3de1b87(Y)))
```

### profile_2908 — range

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusCode`

```text
(! [X,Y] : (o_releasestatuscode_34ff965d(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2909 — range

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusReportedAt`

```text
(! [X,Y] : (o_releasestatusreportedat_2259b9bf(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2910 — range

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusScheme`

```text
(! [X,Y] : (o_releasestatusscheme_834a126d(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2911 — range

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusSource`

```text
(! [X,Y] : (o_releasestatussource_9174f3c6(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2912 — range

Source: `urn:product-ontology:delivery-profile:0.5:releaseStatusVersion`

```text
(! [X,Y] : (o_releasestatusversion_4d1e1ab0(X,Y) => o_productversion_e1d59901(Y)))
```

### profile_2913 — range

Source: `urn:productium:specification-profile:reportsStatus`

```text
(! [X,Y] : (o_reportsstatus_e9d948fc(X,Y) => o_deliverystatusrecord_e59c51e2(Y)))
```

### profile_2914 — range

Source: `urn:productium:specification-profile:representedByStory`

```text
(! [X,Y] : (o_representedbystory_25664527(X,Y) => o_userstoryspecification_680a42c6(Y)))
```

### profile_2915 — range

Source: `urn:product-ontology:delivery-profile:0.5:resultOutcome`

```text
(! [X,Y] : (o_resultoutcome_3eb31a2b(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2916 — range

Source: `urn:product-ontology:delivery-profile:0.5:resultRecordedAt`

```text
(! [X,Y] : (o_resultrecordedat_cc5c9d15(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2917 — range

Source: `urn:product-ontology:delivery-profile:0.5:resultSource`

```text
(! [X,Y] : (o_resultsource_d7f3bdb0(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2918 — range

Source: `urn:product-ontology:delivery-profile:0.5:reviewReason`

```text
(! [X,Y] : (o_reviewreason_619760cf(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2919 — range

Source: `urn:product-ontology:delivery-profile:0.5:reviewRecordedAt`

```text
(! [X,Y] : (o_reviewrecordedat_0012d0fd(X,Y) => o_datetime_db3d52ac(Y)))
```

### profile_2920 — range

Source: `urn:productium:specification-profile:scenarioActions`

```text
(! [X,Y] : (o_scenarioactions_6c887f89(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2921 — range

Source: `urn:productium:specification-profile:scenarioPrecondition`

```text
(! [X,Y] : (o_scenarioprecondition_4776ce8c(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2922 — range

Source: `urn:product-ontology:assessment-profile:0.4:scopeChangeRecord`

```text
(! [X,Y] : (o_scopechangerecord_89135be8(X,Y) => o_changerecord_f3de1b87(Y)))
```

### profile_2923 — range

Source: `urn:product-ontology:assessment-profile:0.4:scopeSource`

```text
(! [X,Y] : (o_scopesource_4d209733(X,Y) => o_anyuri_be9501df(Y)))
```

### profile_2924 — range

Source: `urn:product-ontology:assessment-profile:0.4:scopeSupersedes`

```text
(! [X,Y] : (o_scopesupersedes_4c533220(X,Y) => o_scopespecification_beb9b28d(Y)))
```

### profile_2925 — range

Source: `urn:productium:specification-profile:solutionHypothesizesAboutProblem`

```text
(! [X,Y] : (o_solutionhypothesizesaboutproblem_32929111(X,Y) => o_problemstatement_fe6d79b3(Y)))
```

### profile_2926 — range

Source: `urn:productium:specification-profile:solutionPredictsOutcome`

```text
(! [X,Y] : (o_solutionpredictsoutcome_50736bc8(X,Y) => o_outcomespecification_05ee7bc3(Y)))
```

### profile_2927 — range

Source: `urn:productium:specification-profile:sourcesRequirement`

```text
(! [X,Y] : (o_sourcesrequirement_787c0bfa(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2928 — range

Source: `urn:productium:specification-profile:specifiedByRequirement`

```text
(! [X,Y] : (o_specifiedbyrequirement_4195410f(X,Y) => o_requirementspecification_067f8073(Y)))
```

### profile_2929 — range

Source: `urn:productium:specification-profile:specifiedThroughFeature`

```text
(! [X,Y] : (o_specifiedthroughfeature_c8fc40a2(X,Y) => o_featurespecification_2de6dfb0(Y)))
```

### profile_2930 — range

Source: `urn:productium:specification-profile:specifiesCapability`

```text
(! [X,Y] : (o_specifiescapability_1c1747fb(X,Y) => o_capabilityspecification_73a1b978(Y)))
```

### profile_2931 — range

Source: `urn:productium:specification-profile:specifiesExpectedCondition`

```text
(! [X,Y] : (o_specifiesexpectedcondition_d555ae1c(X,Y) => o_conditionspecification_bd3c5c1d(Y)))
```

### profile_2932 — range

Source: `urn:productium:specification-profile:specifiesOutcomeMetric`

```text
(! [X,Y] : (o_specifiesoutcomemetric_c22cec66(X,Y) => o_productmetricreference_50f07de6(Y)))
```

### profile_2933 — range

Source: `urn:productium:specification-profile:specifiesPersonaContext`

```text
(! [X,Y] : (o_specifiespersonacontext_213f7eb5(X,Y) => o_personaspecification_81fd0066(Y)))
```

### profile_2934 — range

Source: `urn:productium:specification-profile:specifiesSlice`

```text
(! [X,Y] : (o_specifiesslice_dc3a4749(X,Y) => o_verticalslicespecification_25b6ba78(Y)))
```

### profile_2935 — range

Source: `urn:product-ontology:trace-profile:0.6:stepPrecedes`

```text
(! [X,Y] : (o_stepprecedes_f878e3d5(X,Y) => o_interactionstepspecification_44c8af3e(Y)))
```

### profile_2936 — range

Source: `urn:productium:specification-profile:targetsOutcome`

```text
(! [X,Y] : (o_targetsoutcome_e53fd35a(X,Y) => o_outcomespecification_05ee7bc3(Y)))
```

### profile_2937 — range

Source: `urn:productium:specification-profile:targetsOutcomeSpecification`

```text
(! [X,Y] : (o_targetsoutcomespecification_a78e4886(X,Y) => o_outcomespecification_05ee7bc3(Y)))
```

### profile_2938 — range

Source: `urn:productium:specification-profile:testsRealization`

```text
(! [X,Y] : (o_testsrealization_70c84c2c(X,Y) => o_productrealization_b516a087(Y)))
```

### profile_2939 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityInformationArchitecture`

```text
(! [X,Y] : (o_usabilityinformationarchitecture_da396e22(X,Y) => o_informationarchitecturespecification_0a84724e(Y)))
```

### profile_2940 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityJourney`

```text
(! [X,Y] : (o_usabilityjourney_af09679d(X,Y) => o_journeyspecification_6c58f66d(Y)))
```

### profile_2941 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityJourneyStage`

```text
(! [X,Y] : (o_usabilityjourneystage_5caef2c8(X,Y) => o_journeystagespecification_4d216026(Y)))
```

### profile_2942 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityPersona`

```text
(! [X,Y] : (o_usabilitypersona_063b1c06(X,Y) => o_personaspecification_81fd0066(Y)))
```

### profile_2943 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityRecommendation`

```text
(! [X,Y] : (o_usabilityrecommendation_54765e4f(X,Y) => o_string_24ea0d6e(Y)))
```

### profile_2944 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityStep`

```text
(! [X,Y] : (o_usabilitystep_6665fcbf(X,Y) => o_interactionstepspecification_44c8af3e(Y)))
```

### profile_2945 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityTouchpoint`

```text
(! [X,Y] : (o_usabilitytouchpoint_331ca302(X,Y) => o_touchpointspecification_88904c65(Y)))
```

### profile_2946 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityUIState`

```text
(! [X,Y] : (o_usabilityuistate_f4195a87(X,Y) => o_uistatespecification_64de4585(Y)))
```

### profile_2947 — range

Source: `urn:product-ontology:trace-profile:0.6:usabilityUserRole`

```text
(! [X,Y] : (o_usabilityuserrole_c0e67ae6(X,Y) => o_userrolespecification_cccebf00(Y)))
```

### profile_2948 — range

Source: `urn:productium:specification-profile:usesLifecycleSpecification`

```text
(! [X,Y] : (o_useslifecyclespecification_82197b12(X,Y) => o_lifecyclespecification_8ccb5ce0(Y)))
```

### profile_2949 — range

Source: `urn:product-ontology:assessment-profile:0.4:versionScope`

```text
(! [X,Y] : (o_versionscope_f2807a84(X,Y) => o_scopespecification_beb9b28d(Y)))
```

### profile_2950 — subclass

Source: `urn:productium:specification-profile:AcceptanceCriterionSpecification`

```text
(! [X] : (o_acceptancecriterionspecification_0299ae3e(X) => o_conditionspecification_bd3c5c1d(X)))
```

### profile_2951 — subclass

Source: `urn:productium:specification-profile:AcquisitionHypothesisSpecification`

```text
(! [X] : (o_acquisitionhypothesisspecification_6e118852(X) => o_hypothesisspecification_9a33f1c8(X)))
```

### profile_2952 — subclass

Source: `urn:productium:specification-profile:AdoptionHypothesisSpecification`

```text
(! [X] : (o_adoptionhypothesisspecification_de10da7b(X) => o_hypothesisspecification_9a33f1c8(X)))
```

### profile_2953 — subclass

Source: `urn:productium:specification-profile:AssessmentClaim`

```text
(! [X] : (o_assessmentclaim_4878d612(X) => (? [Y] : (o_claimcontext_7950f82f(X,Y) & (! [Z] : (o_claimcontext_7950f82f(X,Z) => (Z = Y)))))))
```

### profile_2954 — subclass

Source: `urn:productium:specification-profile:AssessmentClaim`

```text
(! [X] : (o_assessmentclaim_4878d612(X) => (? [Y] : (o_claimcriterion_6a063ec1(X,Y) & (! [Z] : (o_claimcriterion_6a063ec1(X,Z) => (Z = Y)))))))
```

### profile_2955 — subclass

Source: `urn:productium:specification-profile:AssessmentClaim`

```text
(! [X] : (o_assessmentclaim_4878d612(X) => (? [Y] : (o_claimsubject_8dc7dd3c(X,Y) & (! [Z] : (o_claimsubject_8dc7dd3c(X,Z) => (Z = Y)))))))
```

### profile_2956 — subclass

Source: `urn:productium:specification-profile:BusinessRuleReference`

```text
(! [X] : (o_businessrulereference_54a4db46(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2957 — subclass

Source: `urn:productium:specification-profile:CapabilitySpecification`

```text
(! [X] : (o_capabilityspecification_73a1b978(X) => $true))
```

### profile_2958 — subclass

Source: `urn:productium:specification-profile:CapabilitySpecification`

```text
(! [X] : (o_capabilityspecification_73a1b978(X) => $true))
```

### profile_2959 — subclass

Source: `urn:productium:specification-profile:CapabilitySpecification`

```text
(! [X] : (o_capabilityspecification_73a1b978(X) => (? [Y] : (o_specifiescapability_1c1747fb(Y,X) & (! [Z] : (o_specifiescapability_1c1747fb(Z,X) => (Z = Y)))))))
```

### profile_2960 — subclass

Source: `urn:productium:specification-profile:ChangeRecord`

```text
(! [X] : (o_changerecord_f3de1b87(X) => o_evidenceartifact_6317ec1f(X)))
```

### profile_2961 — subclass

Source: `urn:productium:specification-profile:ConditionSpecification`

```text
(! [X] : (o_conditionspecification_bd3c5c1d(X) => (? [Y] : (o_conditioncontext_0b036eac(X,Y) & (! [Z] : (o_conditioncontext_0b036eac(X,Z) => (Z = Y)))))))
```

### profile_2962 — subclass

Source: `urn:productium:specification-profile:ConditionSpecification`

```text
(! [X] : (o_conditionspecification_bd3c5c1d(X) => (? [Y] : (o_conditionstatement_d35dee07(X,Y) & (! [Z] : (o_conditionstatement_d35dee07(X,Z) => (Z = Y)))))))
```

### profile_2963 — subclass

Source: `urn:productium:specification-profile:ConditionSpecification`

```text
(! [X] : (o_conditionspecification_bd3c5c1d(X) => (? [Y] : (o_specificationprovenance_3872dc46(X,Y) & (! [Z] : (o_specificationprovenance_3872dc46(X,Z) => (Z = Y)))))))
```

### profile_2964 — subclass

Source: `urn:productium:specification-profile:ConstraintSpecification`

```text
(! [X] : (o_constraintspecification_8fe3dc03(X) => o_conditionspecification_bd3c5c1d(X)))
```

### profile_2965 — subclass

Source: `urn:product-ontology:delivery-profile:0.5:DeliveryWorkItemStatusRecord`

```text
(! [X] : (o_deliveryworkitemstatusrecord_17e65d34(X) => (? [Y] : (o_itemstatus_370b117a(Y,X) & (! [Z] : (o_itemstatus_370b117a(Z,X) => (Z = Y)))))))
```

### profile_2966 — subclass

Source: `urn:productium:specification-profile:DependencySpecification`

```text
(! [X] : (o_dependencyspecification_9401a9e8(X) => (? [Y] : (o_dependencycondition_cc5a91c9(X,Y) & (! [Z] : (o_dependencycondition_cc5a91c9(X,Z) => (Z = Y)))))))
```

### profile_2967 — subclass

Source: `urn:productium:specification-profile:EvidenceAttributionRecord`

```text
(! [X] : (o_evidenceattributionrecord_1c89f498(X) => (? [Y] : ((o_recordscarrier_68e09c12(X,Y) & o_evidenceartifact_6317ec1f(Y)) & (! [Z] : ((o_recordscarrier_68e09c12(X,Z) & o_evidenceartifact_6317ec1f(Z)) => (Z = Y)))))))
```

### profile_2968 — subclass

Source: `urn:productium:specification-profile:EvidenceAttributionRecord`

```text
(! [X] : (o_evidenceattributionrecord_1c89f498(X) => (? [Y] : ((o_recordsclaim_3d0873c5(X,Y) & o_assessmentclaim_4878d612(Y)) & (! [Z] : ((o_recordsclaim_3d0873c5(X,Z) & o_assessmentclaim_4878d612(Z)) => (Z = Y)))))))
```

### profile_2969 — subclass

Source: `urn:productium:specification-profile:ExternalReferenceRecord`

```text
(! [X] : (o_externalreferencerecord_c2bf0dcc(X) => (? [Y] : (o_canonicalowner_e9c00d88(X,Y) & (! [Z] : (o_canonicalowner_e9c00d88(X,Z) => (Z = Y)))))))
```

### profile_2970 — subclass

Source: `urn:productium:specification-profile:ExternalReferenceRecord`

```text
(! [X] : (o_externalreferencerecord_c2bf0dcc(X) => (? [Y] : (o_referenceprovenance_8d44e213(X,Y) & (! [Z] : (o_referenceprovenance_8d44e213(X,Z) => (Z = Y)))))))
```

### profile_2971 — subclass

Source: `urn:productium:specification-profile:ExternalReferenceRecord`

```text
(! [X] : (o_externalreferencerecord_c2bf0dcc(X) => (? [Y] : (o_referencetarget_c4ad5bee(X,Y) & (! [Z] : (o_referencetarget_c4ad5bee(X,Z) => (Z = Y)))))))
```

### profile_2972 — subclass

Source: `urn:productium:specification-profile:FindingRecord`

```text
(! [X] : (o_findingrecord_6c235440(X) => o_evidenceartifact_6317ec1f(X)))
```

### profile_2973 — subclass

Source: `urn:productium:specification-profile:FunctionalRequirementSpecification`

```text
(! [X] : (o_functionalrequirementspecification_1732b959(X) => o_requirementspecification_067f8073(X)))
```

### profile_2974 — subclass

Source: `urn:productium:specification-profile:GoalSpecification`

```text
(! [X] : (o_goalspecification_9ac1cc8d(X) => o_conditionspecification_bd3c5c1d(X)))
```

### profile_2975 — subclass

Source: `urn:productium:specification-profile:MarketingGoalSpecification`

```text
(! [X] : (o_marketinggoalspecification_19f0f0dc(X) => o_goalspecification_9ac1cc8d(X)))
```

### profile_2976 — subclass

Source: `urn:productium:specification-profile:MarketingInsightReference`

```text
(! [X] : (o_marketinginsightreference_ecbebe36(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2977 — subclass

Source: `urn:productium:specification-profile:OutcomeSpecification`

```text
(! [X] : (o_outcomespecification_05ee7bc3(X) => o_conditionspecification_bd3c5c1d(X)))
```

### profile_2978 — subclass

Source: `urn:productium:specification-profile:PersonaSpecification`

```text
(! [X] : (o_personaspecification_81fd0066(X) => (? [Y] : (o_personacontext_dfcf9689(X,Y) & (! [Z] : (o_personacontext_dfcf9689(X,Z) => (Z = Y)))))))
```

### profile_2979 — subclass

Source: `urn:productium:specification-profile:PersonaSpecification`

```text
(! [X] : (o_personaspecification_81fd0066(X) => (? [Y] : (o_personadescription_d3f39048(X,Y) & (! [Z] : (o_personadescription_d3f39048(X,Z) => (Z = Y)))))))
```

### profile_2980 — subclass

Source: `urn:productium:specification-profile:PersonaSpecification`

```text
(! [X] : (o_personaspecification_81fd0066(X) => (? [Y] : (o_specificationprovenance_3872dc46(X,Y) & (! [Z] : (o_specificationprovenance_3872dc46(X,Z) => (Z = Y)))))))
```

### profile_2981 — subclass

Source: `urn:productium:specification-profile:PrioritizationCriterionSpecification`

```text
(! [X] : (o_prioritizationcriterionspecification_5d537952(X) => o_decisioncriterionspecification_2f0e2825(X)))
```

### profile_2982 — subclass

Source: `urn:productium:specification-profile:Product`

```text
(! [X] : (o_product_5e2e77d6(X) => $true))
```

### profile_2983 — subclass

Source: `urn:productium:specification-profile:ProductCapability`

```text
(! [X] : (o_productcapability_5801242c(X) => $true))
```

### profile_2984 — subclass

Source: `urn:productium:specification-profile:ProductCapability`

```text
(! [X] : (o_productcapability_5801242c(X) => (? [Y] : (o_bearscapability_2b724b5f(Y,X) & (! [Z] : (o_bearscapability_2b724b5f(Z,X) => (Z = Y)))))))
```

### profile_2985 — subclass

Source: `urn:productium:specification-profile:ProductFamilyReference`

```text
(! [X] : (o_productfamilyreference_b7144cb8(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2986 — subclass

Source: `urn:productium:specification-profile:ProductLineReference`

```text
(! [X] : (o_productlinereference_b18ff0aa(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2987 — subclass

Source: `urn:productium:specification-profile:ProductMetricReference`

```text
(! [X] : (o_productmetricreference_50f07de6(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2988 — subclass

Source: `urn:productium:specification-profile:ProductRealization`

```text
(! [X] : (o_productrealization_b516a087(X) => $true))
```

### profile_2989 — subclass

Source: `urn:productium:specification-profile:ProductRealization`

```text
(! [X] : (o_productrealization_b516a087(X) => (? [Y] : (o_realizesversion_8ca00efc(X,Y) & (! [Z] : (o_realizesversion_8ca00efc(X,Z) => (Z = Y)))))))
```

### profile_2990 — subclass

Source: `urn:productium:specification-profile:ProductRealization`

```text
(! [X] : (o_productrealization_b516a087(X) => (? [Y] : o_bearscapability_2b724b5f(X,Y))))
```

### profile_2991 — subclass

Source: `urn:productium:specification-profile:ProductVariantReference`

```text
(! [X] : (o_productvariantreference_0a8d9825(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2992 — subclass

Source: `urn:productium:specification-profile:ProductVersion`

```text
(! [X] : (o_productversion_e1d59901(X) => $true))
```

### profile_2993 — subclass

Source: `urn:productium:specification-profile:ProductVersion`

```text
(! [X] : (o_productversion_e1d59901(X) => $true))
```

### profile_2994 — subclass

Source: `urn:productium:specification-profile:ProductVersion`

```text
(! [X] : (o_productversion_e1d59901(X) => (? [Y] : (o_hasversion_4f56b7f5(Y,X) & (! [Z] : (o_hasversion_4f56b7f5(Z,X) => (Z = Y)))))))
```

### profile_2995 — subclass

Source: `urn:productium:specification-profile:QualityRequirementSpecification`

```text
(! [X] : (o_qualityrequirementspecification_538881c0(X) => o_requirementspecification_067f8073(X)))
```

### profile_2996 — subclass

Source: `urn:productium:specification-profile:ReleaseEvidenceRecord`

```text
(! [X] : (o_releaseevidencerecord_0b26c3e8(X) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_2997 — subclass

Source: `urn:productium:specification-profile:RequirementScenarioSpecification`

```text
(! [X] : (o_requirementscenariospecification_1c228a11(X) => o_scenariospecification_131385c1(X)))
```

### profile_2998 — subclass

Source: `urn:productium:specification-profile:RequirementSourceReference`

```text
(! [X] : (o_requirementsourcereference_372235ba(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_2999 — subclass

Source: `urn:productium:specification-profile:RequirementSpecification`

```text
(! [X] : (o_requirementspecification_067f8073(X) => o_conditionspecification_bd3c5c1d(X)))
```

### profile_3000 — subclass

Source: `urn:productium:specification-profile:ScenarioSpecification`

```text
(! [X] : (o_scenariospecification_131385c1(X) => (? [Y] : (o_scenarioactions_6c887f89(X,Y) & (! [Z] : (o_scenarioactions_6c887f89(X,Z) => (Z = Y)))))))
```

### profile_3001 — subclass

Source: `urn:productium:specification-profile:ScenarioSpecification`

```text
(! [X] : (o_scenariospecification_131385c1(X) => (? [Y] : (o_scenariocontext_2ee069f1(X,Y) & (! [Z] : (o_scenariocontext_2ee069f1(X,Z) => (Z = Y)))))))
```

### profile_3002 — subclass

Source: `urn:productium:specification-profile:ScenarioSpecification`

```text
(! [X] : (o_scenariospecification_131385c1(X) => (? [Y] : (o_scenarioprecondition_4776ce8c(X,Y) & (! [Z] : (o_scenarioprecondition_4776ce8c(X,Z) => (Z = Y)))))))
```

### profile_3003 — subclass

Source: `urn:productium:specification-profile:ScenarioSpecification`

```text
(! [X] : (o_scenariospecification_131385c1(X) => (? [Y] : (o_specificationprovenance_3872dc46(X,Y) & (! [Z] : (o_specificationprovenance_3872dc46(X,Z) => (Z = Y)))))))
```

### profile_3004 — subclass

Source: `urn:productium:specification-profile:ScenarioSpecification`

```text
(! [X] : (o_scenariospecification_131385c1(X) => (? [Y] : (o_specifiesexpectedcondition_d555ae1c(X,Y) & o_conditionspecification_bd3c5c1d(Y)))))
```

### profile_3005 — subclass

Source: `urn:productium:specification-profile:SolutionHypothesisSpecification`

```text
(! [X] : (o_solutionhypothesisspecification_724e7cc7(X) => o_hypothesisspecification_9a33f1c8(X)))
```

### profile_3006 — subclass

Source: `urn:productium:specification-profile:TargetMarketReference`

```text
(! [X] : (o_targetmarketreference_07684f2b(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_3007 — subclass

Source: `urn:productium:specification-profile:TargetSegmentReference`

```text
(! [X] : (o_targetsegmentreference_776e2c90(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_3008 — subclass

Source: `urn:productium:specification-profile:TaskReference`

```text
(! [X] : (o_taskreference_51d691cd(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_3009 — subclass

Source: `urn:productium:specification-profile:TestCase`

```text
(! [X] : (o_testcase_d5ce3254(X) => $true))
```

### profile_3010 — subclass

Source: `urn:productium:specification-profile:TestCase`

```text
(! [X] : (o_testcase_d5ce3254(X) => o_scenariospecification_131385c1(X)))
```

### profile_3011 — subclass

Source: `urn:productium:specification-profile:TestDataReference`

```text
(! [X] : (o_testdatareference_6063ba4c(X) => o_externalreferencerecord_c2bf0dcc(X)))
```

### profile_3012 — subclass

Source: `urn:productium:specification-profile:TestExecution`

```text
(! [X] : (o_testexecution_483822c9(X) => (? [Y] : (o_executes_ed879ee9(X,Y) & (! [Z] : (o_executes_ed879ee9(X,Z) => (Z = Y)))))))
```

### profile_3013 — subclass

Source: `urn:productium:specification-profile:TestExecution`

```text
(! [X] : (o_testexecution_483822c9(X) => (? [Y] : (o_executioncontext_02a29f55(X,Y) & (! [Z] : (o_executioncontext_02a29f55(X,Z) => (Z = Y)))))))
```

### profile_3014 — subclass

Source: `urn:productium:specification-profile:TestExecution`

```text
(! [X] : (o_testexecution_483822c9(X) => (? [Y] : (o_recordsexecution_bdd9ccef(Y,X) & (! [Z] : (o_recordsexecution_bdd9ccef(Z,X) => (Z = Y)))))))
```

### profile_3015 — subclass

Source: `urn:productium:specification-profile:TestExecution`

```text
(! [X] : (o_testexecution_483822c9(X) => (? [Y] : (o_testsrealization_70c84c2c(X,Y) & (! [Z] : (o_testsrealization_70c84c2c(X,Z) => (Z = Y)))))))
```

### profile_3016 — subclass

Source: `urn:productium:specification-profile:TestExecution`

```text
(! [X] : (o_testexecution_483822c9(X) => (? [Y] : o_assessesspecification_38115d6b(X,Y))))
```

### profile_3017 — subclass

Source: `urn:productium:specification-profile:TestExecution`

```text
(! [X] : (o_testexecution_483822c9(X) => (? [Y] : o_executioncriterion_db30b082(X,Y))))
```

### profile_3018 — subclass

Source: `urn:productium:specification-profile:TestResult`

```text
(! [X] : (o_testresult_26ca0bda(X) => (? [Y] : (o_recordsexecution_bdd9ccef(X,Y) & (! [Z] : (o_recordsexecution_bdd9ccef(X,Z) => (Z = Y)))))))
```

### profile_3019 — subclass

Source: `urn:productium:specification-profile:TestResult`

```text
(! [X] : (o_testresult_26ca0bda(X) => o_evidenceartifact_6317ec1f(X)))
```

### profile_3020 — subclass

Source: `urn:productium:specification-profile:TestScenario`

```text
(! [X] : (o_testscenario_1c3da1d3(X) => o_scenariospecification_131385c1(X)))
```

### profile_3021 — subclass

Source: `urn:productium:specification-profile:UsabilityFindingRecord`

```text
(! [X] : (o_usabilityfindingrecord_1be07103(X) => o_findingrecord_6c235440(X)))
```

### profile_3022 — subclass

Source: `urn:productium:specification-profile:ValidationEvidenceRecord`

```text
(! [X] : (o_validationevidencerecord_89bff0ca(X) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_3023 — subclass

Source: `urn:productium:specification-profile:ValidationFindingRecord`

```text
(! [X] : (o_validationfindingrecord_e628162e(X) => o_findingrecord_6c235440(X)))
```

### profile_3024 — subclass

Source: `urn:productium:specification-profile:VerificationEvidenceRecord`

```text
(! [X] : (o_verificationevidencerecord_16c2d7e8(X) => o_evidenceattributionrecord_1c89f498(X)))
```

### profile_3025 — subproperty

Source: `urn:product-ontology:assessment-profile:0.4:claimProduct`

```text
(! [X,Y] : (o_claimproduct_a8f421e4(X,Y) => o_claimsubject_8dc7dd3c(X,Y)))
```

### profile_3026 — subproperty

Source: `urn:product-ontology:assessment-profile:0.4:claimRealization`

```text
(! [X,Y] : (o_claimrealization_2e93c51b(X,Y) => o_claimsubject_8dc7dd3c(X,Y)))
```

### profile_3027 — subproperty

Source: `urn:product-ontology:assessment-profile:0.4:claimRequirement`

```text
(! [X,Y] : (o_claimrequirement_19e961d9(X,Y) => o_claimsubject_8dc7dd3c(X,Y)))
```

### profile_3028 — subproperty

Source: `urn:product-ontology:assessment-profile:0.4:claimVersion`

```text
(! [X,Y] : (o_claimversion_32b75c75(X,Y) => o_claimsubject_8dc7dd3c(X,Y)))
```

### profile_3029 — subproperty

Source: `urn:product-ontology:trace-profile:0.6:decisionSelectsSolution`

```text
(! [X,Y] : (o_decisionselectssolution_595fe441(X,Y) => o_decisionconsiderssolution_6ba3a05f(X,Y)))
```

### profile_3030 — subproperty

Source: `urn:productium:specification-profile:r178_referencesMetric`

```text
(! [X,Y] : (o_r178_referencesmetric_16b8c658(X,Y) => o_r156_referencesmetric_e08298d2(X,Y)))
```

### profile_3031 — subproperty

Source: `urn:productium:specification-profile:r181_hypothesizesAcquisitionForProblem`

```text
(! [X,Y] : (o_r181_hypothesizesacquisitionforproblem_3b87a7c1(X,Y) => o_hypothesizesaboutproblem_ab4d9ffa(X,Y)))
```

### profile_3032 — subproperty

Source: `urn:productium:specification-profile:r183_hypothesizesAdoptionForProblem`

```text
(! [X,Y] : (o_r183_hypothesizesadoptionforproblem_b930ea90(X,Y) => o_hypothesizesaboutproblem_ab4d9ffa(X,Y)))
```

### profile_3033 — subproperty

Source: `urn:product-ontology:relation-profile:0.7:r224_evidencedBy`

```text
(! [X,Y] : (o_r224_evidencedby_733ce5a5(X,Y) => o_r160_evidencedby_f78dca6e(X,Y)))
```

### profile_3034 — subproperty

Source: `urn:product-ontology:relation-profile:0.7:r226_evidencedBy`

```text
(! [X,Y] : (o_r226_evidencedby_83e51087(X,Y) => o_r160_evidencedby_f78dca6e(X,Y)))
```

### profile_3035 — subproperty

Source: `urn:productium:specification-profile:r92_hasVerificationEvidenceRecord`

```text
(! [X,Y] : (o_r92_hasverificationevidencerecord_387f2a4e(X,Y) => o_iscarrierinrecord_6fcdca61(X,Y)))
```

### profile_3036 — subproperty

Source: `urn:productium:specification-profile:r93_hasValidationEvidenceRecord`

```text
(! [X,Y] : (o_r93_hasvalidationevidencerecord_8467c0d9(X,Y) => o_iscarrierinrecord_6fcdca61(X,Y)))
```

### profile_3037 — subproperty

Source: `urn:productium:specification-profile:solutionHypothesizesAboutProblem`

```text
(! [X,Y] : (o_solutionhypothesizesaboutproblem_32929111(X,Y) => o_hypothesizesaboutproblem_ab4d9ffa(X,Y)))
```

### profile_3038 — subproperty

Source: `urn:productium:specification-profile:solutionPredictsOutcome`

```text
(! [X,Y] : (o_solutionpredictsoutcome_50736bc8(X,Y) => o_predictsoutcome_89abbedd(X,Y)))
```
