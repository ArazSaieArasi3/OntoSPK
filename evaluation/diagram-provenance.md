# Diagram provenance and verification

**Result: PASS_BOUNDED_VIEW_REVIEW.** The complete native source contains 128 classes, 286 associations and 34 generalizations. The approved public selected view contains 40 classes, 48 associations and 11 generalizations. All visible names, stereotypes, endpoint cardinalities and arrow target geometry match the declared selected-view profile and current native inputs. This is a bounded source/notation review, not independent scientific acceptance.

## Historical discrepancies and disposition

Six isReadOnly fields in the historical manifest are null although current native endpoints and SVG metadata say true. The accepted inputs are preserved; this report supplies complete current endpoint records for the 59 displayed relationships. The old SVG description also claims embedded draw.io data, which its XML does not contain. The reviewed presentation copy removes that unsupported claim while preserving visible geometry. No editable source is claimed recovered.

## Reading the notation

Association heads are open and declare target navigability only in this selected-view convention. They do not establish native navigability or causal/dependency relations. Generalization heads are hollow triangles pointing to the general class; generalizations carry no multiplicities. All 59 head tips meet the intended class boundary within three SVG coordinate units. Explicitly abstract classes are marked; unspecified native abstractness is not promoted to a scientific decision. Relation-family stereotypes are not invented for plain associations. The physical SVG is 178 by 222.5 mm with a portrait viewBox, rather than a full A4 page.

## Two domain views

The complete matrix accounts for all 286 association declarations, including within-domain cells and a separate external boundary bucket. Its row/column direction follows native endpoint order. The rectangle/arrow view uses a deterministic maximum spanning tree over local cross-domain association counts: twelve domains and eleven representative associations. Native ID breaks representative ties. The machine-readable report lists every omitted relation and every representative endpoint/cardinality; this is a navigation subset, not a new domain ontology, dependency architecture or assertion that the omitted links are absent. All twelve domain colors are taken directly from the selected figure. The 34 generalizations are not counted as associations.

## Scope and omissions

The selected view omits 88 class symbols, 238 associations and 23 generalizations. Exact omitted identifiers and all current displayed endpoint properties are recorded in `diagram-provenance.json`. The complete native model and exhaustive reference remain the full ontology source; no full-model image or independent UFO conformance certificate is claimed. PNGs are presentation exports tied to their SVG source hash; CI regenerates SVGs and verifies PNG source binding, not cross-platform byte-identical font rasterization.

| Display | Native relation | Type | Source | Target | Head distance |
| --- | --- | --- | --- | --- | ---: |
| R01 | `REL:W2:007` | BinaryRelation | `IC:Product` | `IC:ProductVersion` | 2.26 |
| R02 | `ICREL:CP:specifiesCapability` | BinaryRelation | `IC:ProductVersion` | `IC:CapabilitySpecification` | 2.26 |
| R03 | `ICREL:CP:realizesVersion` | BinaryRelation | `IC:ProductRealization` | `IC:ProductVersion` | 2.25 |
| R04 | `ICREL:CP:bearsCapability` | BinaryRelation | `IC:ProductRealization` | `IC:ProductCapability` | 2.26 |
| R05 | `ICREL:CP:evaluatedAgainst` | BinaryRelation | `IC:ProductCapability` | `IC:CapabilitySpecification` | 2.26 |
| R06 | `REL:W2:034` | BinaryRelation | `IC:CapabilitySpecification` | `IC:FeatureSpecification` | 2.25 |
| R07 | `REL:W2:131` | BinaryRelation | `IC:FeatureSpecification` | `IC:RequirementSpecification` | 2.26 |
| R08 | `ICREL:CP:testsRealization` | BinaryRelation | `IC:TestExecution` | `IC:ProductRealization` | 2.26 |
| R09 | `ICREL:CP:assessesSpecification` | BinaryRelation | `IC:TestExecution` | `IC:CapabilitySpecification` | 2.25 |
| R10 | `REL:W2:090` | BinaryRelation | `IC:TestExecution` | `IC:TestCase` | 2.26 |
| R11 | `REL:W2:091` | BinaryRelation | `IC:TestExecution` | `IC:TestResult` | 2.26 |
| R12 | `REL:ORSD05:executionContext` | BinaryRelation | `IC:TestExecution` | `IC:AssessmentContextSpecification` | 2.26 |
| R13 | `ICREL:EU:usesEvidence` | BinaryRelation | `IC:EvidenceAttributionRecord` | `IC:EvidenceArtifact` | 2.26 |
| R14 | `ICREL:EU:assertsClaim` | BinaryRelation | `IC:EvidenceAttributionRecord` | `IC:AssessmentClaim` | 2.26 |
| R15 | `REL:ORSD04:claimRealization` | BinaryRelation | `IC:AssessmentClaim` | `IC:ProductRealization` | 2.26 |
| R16 | `REL:W2:002` | BinaryRelation | `IC:ProductPortfolio` | `IC:Product` | 2.26 |
| R17 | `REL:W2:017` | BinaryRelation | `IC:Product` | `IC:VisionStatement` | 2.26 |
| R18 | `REL:W2:018` | BinaryRelation | `IC:VisionStatement` | `IC:GoalSpecification` | 2.26 |
| R19 | `REL:W2:155` | BinaryRelation | `IC:VisionStatement` | `IC:ProblemStatement` | 2.25 |
| R20 | `REL:W2:019` | BinaryRelation | `IC:GoalSpecification` | `IC:OutcomeSpecification` | 2.25 |
| R21 | `REL:W2:033` | BinaryRelation | `IC:OutcomeSpecification` | `IC:CapabilitySpecification` | 2.25 |
| R22 | `REL:W2:020` | BinaryRelation | `IC:OutcomeSpecification` | `IC:ProductMetricReference` | 2.26 |
| R23 | `REL:W2:042` | BinaryRelation | `IC:FeatureSpecification` | `IC:UserStorySpecification` | 2.26 |
| R24 | `REL:W2:043` | BinaryRelation | `IC:UserStorySpecification` | `IC:RequirementSpecification` | 2.26 |
| R25 | `REL:W2:044` | BinaryRelation | `IC:RequirementSpecification` | `IC:AcceptanceCriterionSpecification` | 2.26 |
| R26 | `REL:W2:048` | BinaryRelation | `IC:RequirementSourceReference` | `IC:RequirementSpecification` | 2.25 |
| R27 | `REL:W2:062` | BinaryRelation | `IC:UserStorySpecification` | `IC:PersonaSpecification` | 2.26 |
| R28 | `REL:W2:063` | BinaryRelation | `IC:UserStorySpecification` | `IC:UserFlowSpecification` | 2.26 |
| R29 | `REL:W2:064` | BinaryRelation | `IC:Roadmap` | `IC:RoadmapEntry` | 2.25 |
| R30 | `REL:W2:066` | BinaryRelation | `IC:RoadmapEntry` | `IC:FeatureSpecification` | 2.26 |
| R31 | `REL:W2:068` | BinaryRelation | `IC:RoadmapEntry` | `IC:PriorityAssessment` | 2.26 |
| R32 | `REL:W2:139` | BinaryRelation | `IC:Roadmap` | `IC:GoalSpecification` | 2.26 |
| R33 | `REL:W2:140` | BinaryRelation | `IC:RoadmapEntry` | `IC:ReleaseSpecification` | 2.26 |
| R34 | `REL:W2:083` | BinaryRelation | `IC:ProductVersion` | `IC:ReleaseSpecification` | 2.25 |
| R35 | `REL:W2:075` | BinaryRelation | `IC:ReleaseSpecification` | `IC:DeliveryWorkItem` | 2.26 |
| R36 | `REL:W2:080` | BinaryRelation | `IC:DeliveryWorkItem` | `IC:FeatureSpecification` | 2.26 |
| R37 | `REL:W2:077` | BinaryRelation | `IC:ReleaseSpecification` | `IC:DeliveryStatusRecord` | 2.26 |
| R38 | `REL:W2:094` | BinaryRelation | `IC:Product` | `IC:PositioningStatement` | 2.26 |
| R39 | `REL:W2:100` | BinaryRelation | `IC:GoToMarketSpecification` | `IC:PositioningStatement` | 2.26 |
| R40 | `REL:W2:173` | BinaryRelation | `IC:PositioningStatement` | `IC:CapabilitySpecification` | 2.26 |
| R41 | `REL:W2:146` | BinaryRelation | `IC:TestCase` | `IC:RequirementSpecification` | 2.26 |
| R42 | `REL:W2:092` | BinaryRelation | `IC:TestResult` | `IC:VerificationEvidenceRecord` | 2.26 |
| R43 | `REL:ORSD05:releaseStatusVersion` | BinaryRelation | `IC:DeliveryStatusRecord` | `IC:ProductVersion` | 2.25 |
| R44 | `ICREL:SP:expectedCondition` | BinaryRelation | `IC:ScenarioSpecification` | `IC:ConditionSpecification` | 2.26 |
| R45 | `REL:ORSD04:claimCriterion` | BinaryRelation | `IC:AssessmentClaim` | `IC:ConditionSpecification` | 2.26 |
| R46 | `REL:ORSD04:claimContext` | BinaryRelation | `IC:AssessmentClaim` | `IC:AssessmentContextSpecification` | 2.26 |
| R47 | `REL:ORSD06:decisionEvidence` | BinaryRelation | `IC:DecisionRecord` | `IC:EvidenceAttributionRecord` | 2.25 |
| R48 | `ICREL:implementsFeature` | BinaryRelation | `IC:ProductRealization` | `IC:FeatureSpecification` | 2.25 |
| G01 | `GEN:W2:152` | Generalization | `IC:FunctionalRequirementSpecification` | `IC:RequirementSpecification` | 2.26 |
| G02 | `GEN:W2:153` | Generalization | `IC:QualityRequirementSpecification` | `IC:RequirementSpecification` | 2.26 |
| G03 | `GEN:IC04:TestResult:EvidenceArtifact` | Generalization | `IC:TestResult` | `IC:EvidenceArtifact` | 2.25 |
| G04 | `GEN:IC04:VerificationEvidence:EvidenceArtifact` | Generalization | `IC:VerificationEvidenceRecord` | `IC:EvidenceAttributionRecord` | 2.25 |
| G05 | `GEN:IC06:ProductMetricReference` | Generalization | `IC:ProductMetricReference` | `IC:ExternalReferenceRecord` | 2.26 |
| G06 | `GEN:IC06:RequirementSourceReference` | Generalization | `IC:RequirementSourceReference` | `IC:ExternalReferenceRecord` | 2.26 |
| G07 | `GEN:IC07:GoalSpecification` | Generalization | `IC:GoalSpecification` | `IC:ConditionSpecification` | 2.26 |
| G08 | `GEN:IC07:OutcomeSpecification` | Generalization | `IC:OutcomeSpecification` | `IC:ConditionSpecification` | 2.26 |
| G09 | `GEN:IC07:RequirementSpecification` | Generalization | `IC:RequirementSpecification` | `IC:ConditionSpecification` | 2.25 |
| G10 | `GEN:IC07:AcceptanceCriterionSpecification` | Generalization | `IC:AcceptanceCriterionSpecification` | `IC:ConditionSpecification` | 2.25 |
| G11 | `GEN:IC07:TestCase` | Generalization | `IC:TestCase` | `IC:ScenarioSpecification` | 2.26 |

Reproduce with `python tools/publication/build_diagram_review.py`; use `--render-png` to explicitly refresh presentation exports.
