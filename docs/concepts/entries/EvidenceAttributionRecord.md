```json
{
  "native_id": "IC:EvidenceAttributionRecord",
  "editorial_status": "editorial-source-checked",
  "reviewed_on": "2026-10-26",
  "evidence": [
    {
      "id": "support",
      "source": "menon2009",
      "claim": "Claims, arguments and evidence are distinct; evidential support must be judged with scope and coverage in view.",
      "support": "adapted",
      "locator": "Section 2, definitions 1–4, author manuscript PDF p. 3; Sections 3.4–3.5",
      "limitation": "A safety-case account is adapted to product assessment; it does not define this exact record class."
    },
    {
      "id": "provenance",
      "source": "prov2013",
      "claim": "PROV attribution ascribes an entity to an agent and is different from a carrier-to-assessment attribution.",
      "support": "contrast",
      "locator": "Section 5.3.2, Attribution; Section 1, Introduction",
      "limitation": "Terminological comparison only; no PROV equivalence, import or automated mapping."
    }
  ],
  "related_ids": [
    "IC:EvidenceArtifact",
    "IC:AssessmentClaim",
    "IC:FindingRecord",
    "EXT:EvidenceLayer:Evidence"
  ]
}
```

## Extended explanation

An EvidenceAttributionRecord records an assessor’s decision to use a particular carrier for a particular assessment claim. Its local purpose is to make that evidential use inspectable: readers can distinguish the carrier, the claim and the attribution rather than assuming that a file is universally evidential. The record documents an assessment relationship; its existence does not establish that the claim is true.

Safety-case research distinguishes claims from the arguments and evidence offered for them. Menon, Hawkins and McDermid further discuss scope and coverage when judging support [@support]. OntoSPK adapts this discipline to product assessments without treating all product evidence as safety certification. Provenance is also relevant, but W3C PROV’s attribution concerns an entity’s ascription to an agent [@provenance]. The similarly named PROV relation is therefore not the local carrier-to-assessment attribution. Keeping this distinction visible prevents a provenance link from being mistaken for a justification of a product claim.

## Distinctions

- **EvidenceArtifact:** an eligible information carrier; eligibility is not an assessment conclusion.
- **AssessmentClaim:** the proposition and assessment subject under consideration.
- **FindingRecord:** a fixed finding statement with subject bindings and provenance.
- **PROV attribution:** responsibility of an agent for an entity, not this class’s entire evidential-use contract [@provenance].

## Illustrative example

An authored illustration: an assessor cites test report T for claim C about one configured realization and scenario. Another assessor can use T for a narrower claim without making the two attribution records identical. The report, each claim and each assessor’s attribution remain distinguishable.

## Evidence gaps and lineage

The exact native class is an authored synthesis; the cited works do not introduce it under this name. No safety certificate, accepted PROV mapping or complete evidence-quality judgment is implied. The source model and recorded editorial comparison establish current traceability, not the original discovery history.
