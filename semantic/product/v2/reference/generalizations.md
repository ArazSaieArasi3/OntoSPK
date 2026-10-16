# Generalizations and sets

## `GEN:W2:152`

`IC:FunctionalRequirementSpecification` specializes `IC:RequirementSpecification`.

```text
forall x: C["IC:FunctionalRequirementSpecification"](x) => C["IC:RequirementSpecification"](x)
```

## `GEN:W2:153`

`IC:QualityRequirementSpecification` specializes `IC:RequirementSpecification`.

```text
forall x: C["IC:QualityRequirementSpecification"](x) => C["IC:RequirementSpecification"](x)
```

## `GEN:PROPOSED:SolutionHypothesis`

`IC:SolutionHypothesisSpecification` specializes `IC:HypothesisSpecification`.

```text
forall x: C["IC:SolutionHypothesisSpecification"](x) => C["IC:HypothesisSpecification"](x)
```

## `GEN:PROPOSED:AcquisitionHypothesis`

`IC:AcquisitionHypothesisSpecification` specializes `IC:HypothesisSpecification`.

```text
forall x: C["IC:AcquisitionHypothesisSpecification"](x) => C["IC:HypothesisSpecification"](x)
```

## `GEN:PROPOSED:AdoptionHypothesis`

`IC:AdoptionHypothesisSpecification` specializes `IC:HypothesisSpecification`.

```text
forall x: C["IC:AdoptionHypothesisSpecification"](x) => C["IC:HypothesisSpecification"](x)
```

## `GEN:IC04:PrioritizationCriterionSpecification:DecisionCriterionSpecification`

`IC:PrioritizationCriterionSpecification` specializes `IC:DecisionCriterionSpecification`.

```text
forall x: C["IC:PrioritizationCriterionSpecification"](x) => C["IC:DecisionCriterionSpecification"](x)
```

## `GEN:IC04:MarketingGoalSpecification:GoalSpecification`

`IC:MarketingGoalSpecification` specializes `IC:GoalSpecification`.

```text
forall x: C["IC:MarketingGoalSpecification"](x) => C["IC:GoalSpecification"](x)
```

## `GEN:IC04:TestResult:EvidenceArtifact`

`IC:TestResult` specializes `IC:EvidenceArtifact`.

```text
forall x: C["IC:TestResult"](x) => C["IC:EvidenceArtifact"](x)
```

## `GEN:IC04:ChangeRecord:EvidenceArtifact`

`IC:ChangeRecord` specializes `IC:EvidenceArtifact`.

```text
forall x: C["IC:ChangeRecord"](x) => C["IC:EvidenceArtifact"](x)
```

## `GEN:IC04:VerificationEvidence:EvidenceArtifact`

`IC:VerificationEvidenceRecord` specializes `IC:EvidenceAttributionRecord`.

```text
forall x: C["IC:VerificationEvidenceRecord"](x) => C["IC:EvidenceAttributionRecord"](x)
```

## `GEN:IC04:ValidationEvidence:EvidenceArtifact`

`IC:ValidationEvidenceRecord` specializes `IC:EvidenceAttributionRecord`.

```text
forall x: C["IC:ValidationEvidenceRecord"](x) => C["IC:EvidenceAttributionRecord"](x)
```

## `GEN:IC04:ReleaseEvidence:EvidenceArtifact`

`IC:ReleaseEvidenceRecord` specializes `IC:EvidenceAttributionRecord`.

```text
forall x: C["IC:ReleaseEvidenceRecord"](x) => C["IC:EvidenceAttributionRecord"](x)
```

## `GEN:IC05:FindingRecord:EvidenceArtifact`

`IC:FindingRecord` specializes `IC:EvidenceArtifact`.

```text
forall x: C["IC:FindingRecord"](x) => C["IC:EvidenceArtifact"](x)
```

## `GEN:IC05:UsabilityFindingRecord:FindingRecord`

`IC:UsabilityFindingRecord` specializes `IC:FindingRecord`.

```text
forall x: C["IC:UsabilityFindingRecord"](x) => C["IC:FindingRecord"](x)
```

## `GEN:IC05:ValidationFindingRecord:FindingRecord`

`IC:ValidationFindingRecord` specializes `IC:FindingRecord`.

```text
forall x: C["IC:ValidationFindingRecord"](x) => C["IC:FindingRecord"](x)
```

## `GEN:IC06:ProductFamilyReference`

`IC:ProductFamilyReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:ProductFamilyReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:ProductLineReference`

`IC:ProductLineReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:ProductLineReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:ProductVariantReference`

`IC:ProductVariantReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:ProductVariantReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:ProductMetricReference`

`IC:ProductMetricReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:ProductMetricReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:BusinessRuleReference`

`IC:BusinessRuleReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:BusinessRuleReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:RequirementSourceReference`

`IC:RequirementSourceReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:RequirementSourceReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:TaskReference`

`IC:TaskReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:TaskReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:TestDataReference`

`IC:TestDataReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:TestDataReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:TargetMarketReference`

`IC:TargetMarketReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:TargetMarketReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:TargetSegmentReference`

`IC:TargetSegmentReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:TargetSegmentReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC06:MarketingInsightReference`

`IC:MarketingInsightReference` specializes `IC:ExternalReferenceRecord`.

```text
forall x: C["IC:MarketingInsightReference"](x) => C["IC:ExternalReferenceRecord"](x)
```

## `GEN:IC07:GoalSpecification`

`IC:GoalSpecification` specializes `IC:ConditionSpecification`.

```text
forall x: C["IC:GoalSpecification"](x) => C["IC:ConditionSpecification"](x)
```

## `GEN:IC07:OutcomeSpecification`

`IC:OutcomeSpecification` specializes `IC:ConditionSpecification`.

```text
forall x: C["IC:OutcomeSpecification"](x) => C["IC:ConditionSpecification"](x)
```

## `GEN:IC07:RequirementSpecification`

`IC:RequirementSpecification` specializes `IC:ConditionSpecification`.

```text
forall x: C["IC:RequirementSpecification"](x) => C["IC:ConditionSpecification"](x)
```

## `GEN:IC07:AcceptanceCriterionSpecification`

`IC:AcceptanceCriterionSpecification` specializes `IC:ConditionSpecification`.

```text
forall x: C["IC:AcceptanceCriterionSpecification"](x) => C["IC:ConditionSpecification"](x)
```

## `GEN:IC07:ConstraintSpecification`

`IC:ConstraintSpecification` specializes `IC:ConditionSpecification`.

```text
forall x: C["IC:ConstraintSpecification"](x) => C["IC:ConditionSpecification"](x)
```

## `GEN:IC07:RequirementScenarioSpecification`

`IC:RequirementScenarioSpecification` specializes `IC:ScenarioSpecification`.

```text
forall x: C["IC:RequirementScenarioSpecification"](x) => C["IC:ScenarioSpecification"](x)
```

## `GEN:IC07:TestScenario`

`IC:TestScenario` specializes `IC:ScenarioSpecification`.

```text
forall x: C["IC:TestScenario"](x) => C["IC:ScenarioSpecification"](x)
```

## `GEN:IC07:TestCase`

`IC:TestCase` specializes `IC:ScenarioSpecification`.

```text
forall x: C["IC:TestCase"](x) => C["IC:ScenarioSpecification"](x)
```

```json
{
  "id": "GS:Requirement:ContentTypes",
  "type": "GeneralizationSet",
  "created": "2026-10-09",
  "modified": "2026-10-09",
  "name": {
    "en": "Requirement content categories"
  },
  "alternativeNames": [],
  "description": null,
  "editorialNotes": [],
  "creators": [],
  "contributors": [],
  "customProperties": {
    "status": "IC03_OVERLAP_PERMITTED_OPEN_CLASSIFICATION"
  },
  "isDisjoint": false,
  "isComplete": false,
  "generalizations": [
    "GEN:W2:152",
    "GEN:W2:153"
  ],
  "categorizer": null
}
```
