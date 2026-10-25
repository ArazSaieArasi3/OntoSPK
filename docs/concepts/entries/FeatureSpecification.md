```json
{
  "native_id": "IC:FeatureSpecification",
  "editorial_status": "editorial-source-checked",
  "reviewed_on": "2026-10-26",
  "evidence": [
    {
      "id": "feature",
      "source": "classen2008",
      "claim": "Feature meanings depend on context; the proposed requirements-engineering account combines requirements, assumptions and specification.",
      "support": "adapted",
      "locator": "Section 1 and Table 1, pp. 16–18; Section 3.1, pp. 21–22",
      "limitation": "The paper’s feature is a triplet; the local class is an authored specification artifact."
    },
    {
      "id": "environment",
      "source": "zave1997",
      "claim": "Requirements engineering must describe the environment and clarify relationships among requirements, specifications and domain knowledge.",
      "support": "direct",
      "locator": "Section 1, conclusions (1)–(4), pp. 2–3",
      "limitation": "Supports the limited methodological claim, not the complete local class definition."
    }
  ],
  "related_ids": [
    "IC:CapabilitySpecification",
    "IC:ProductCapability",
    "IC:DeliveryWorkItem"
  ]
}
```

## Extended explanation

A FeatureSpecification gives an intended functional unit an authored identity before anyone can assume that a running system provides it. In the local model it connects proposed behavior, user value and acceptance criteria. It is useful when a team needs to discuss what is intended, why it matters and how it would be accepted while implementation remains open. A delivery work item can organize implementation effort without becoming identical to the specified feature.

Classen, Heymans and Schobbens show that feature definitions combine problem and solution concerns in different ways. Their requirements-engineering account relates requirements, domain assumptions and specifications [@feature]. This supports explaining a feature in context rather than treating its name as self-sufficient. OntoSPK’s authored specification artifact is a local adaptation, not the paper’s entire feature triplet. Zave and Jackson likewise make the environment and the relationships among descriptions central to requirements engineering [@environment]. A written feature does not establish that its behavior exists or that its proposed benefit has been observed.

## Distinctions

- **CapabilitySpecification:** states an intended ability without fixing its implementation.
- **ProductCapability:** an actual disposition of a realization, rather than the authored intention.
- **DeliveryWorkItem:** work coordination about intended scope; it need not have one-to-one identity with a feature.

## Illustrative example

An authored reminder-scheduling specification states intended behavior, the proposed reduction in manual follow-up, and acceptance conditions. The specification can exist before the scheduler is implemented. A later test result about reminder delivery is evidence concerning the implementation, not the specification itself.

## Evidence gaps and lineage

The literature supports the problem/specification distinction but not the exact native class identity, its full relation set or guaranteed customer value. No exact equivalence to a feature-diagram node or the paper’s triplet is claimed. This is a current explanatory comparison; no original concept-discovery chronology is available from these readings.
