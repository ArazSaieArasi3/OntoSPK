```json
{
  "native_id": "EXT:EvidenceLayer:Evidence",
  "editorial_status": "editorial-source-checked",
  "reviewed_on": "2026-10-26",
  "evidence": [
    {
      "id": "context",
      "source": "menon2009",
      "claim": "Evidence is assessed relative to a claim’s scope and coverage.",
      "support": "partial",
      "locator": "Sections 3.4–3.5, Scope and Coverage",
      "limitation": "General evidence context only; cannot define or validate the owner-specific EvidenceLayer concept."
    }
  ],
  "related_ids": [
    "EXT:ExternalUnresolved:Evidence",
    "IC:EvidenceArtifact",
    "IC:EvidenceAttributionRecord"
  ]
}
```

## Extended explanation

This page documents OntoSPK’s local reference-only handle for the EvidenceLayer owner. It is intentionally separate from both the locally authored evidence-attribution records and the unresolved external handle also labelled Evidence. The stable native ID identifies which boundary is meant. A shared label is insufficient to identify an external ontology class or its permitted uses.

Literature helps explain why evidence needs context: Menon and colleagues assess support relative to the claim’s scope and the evidence’s coverage [@context]. That is background for reading the boundary, not a definition of EvidenceLayer’s owned concept. No inspected public owner contract in this increment establishes the external concept’s complete definition or equivalence to a local carrier, claim or record. The local catalogue’s short boundary description is therefore retained verbatim rather than replaced with a scholarly definition borrowed from another domain.

## Distinctions

- **EXT:ExternalUnresolved:Evidence:** a different native handle, with a different owner/status, despite its duplicate label.
- **EvidenceArtifact:** a local category of eligible information carriers.
- **EvidenceAttributionRecord:** a local authored attribution record, not this external target.

## Illustrative example

An authored illustration: a reader sees two entries named Evidence in the native reference. Selecting EXT:EvidenceLayer:Evidence must reach this boundary and its own exact native section; selecting EXT:ExternalUnresolved:Evidence reaches the other section. Neither navigation operation establishes external semantic identity.

## Evidence gaps and lineage

The owner-specific definition, full external IRI/import acceptance and discovery provenance are not established here. Existing held-boundary policy remains in force; no private sibling repository was consulted and no new wiring is introduced. This page is an editorial boundary explanation with contextual literature, not a completed sourced definition of the external target.
