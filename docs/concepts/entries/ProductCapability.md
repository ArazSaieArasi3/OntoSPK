```json
{
  "native_id": "IC:ProductCapability",
  "editorial_status": "editorial-source-checked",
  "reviewed_on": "2026-10-26",
  "evidence": [
    {
      "id": "disposition",
      "source": "azevedo2015",
      "claim": "A disposition can be present without manifestation and can manifest through an event.",
      "support": "direct",
      "locator": "Section 4, p. 241, paragraphs on intrinsic moments and dispositions",
      "limitation": "Supports that limited distinction; not the project-specific concrete Mode decision."
    },
    {
      "id": "types",
      "source": "azevedo2015",
      "claim": "The capability analysis distinguishes disposition universals and the individuals bearing dispositions.",
      "support": "adapted",
      "locator": "Sections 6.1–6.2, pp. 243–245",
      "limitation": "Enterprise-architecture types are comparative background, not an accepted import or proof of PC-01."
    }
  ],
  "related_ids": [
    "IC:ProductRealization",
    "IC:CapabilitySpecification",
    "IC:TestExecution"
  ]
}
```

## Extended explanation

A ProductCapability is the actual ability inhering in one configured ProductRealization. In the local model, a planned ability and an actual one have different subjects: the specification states what is intended; the capability concerns what the concrete functional whole is disposed to do. A successful execution can supply evidence about an ability without becoming identical to the ability or proving its availability in every context.

Azevedo and colleagues analyze capabilities through UFO’s dispositional account. Dispositions can exist without manifestation and manifest through events under suitable conditions [@disposition]. Their enterprise-architecture analysis also distinguishes disposition types from the individuals that bear dispositions [@types]. OntoSPK adapts this background to product realizations and retains a concrete project Mode under PC-01. The source supports the dispositional distinction; it does not settle every native identity commitment or remove the declared mismatch with the abstract Mode convention of the reference metamodel. Strict reference-profile conformity remains unclaimed.

## Distinctions

- **CapabilitySpecification:** an intended ability, not evidence that an actual bearer has it.
- **ProductRealization:** bears the capability; its machine name is not the ability.
- **Execution/result:** an event or its report, rather than the disposition itself.

## Illustrative example

An authored illustration: a configured invoicing realization can validate an invoice under its applicable input and environment conditions even when no validation request is currently running. A passing test documents one exercised case; it does not by itself establish unrestricted validation capability.

## Evidence gaps and lineage

PC-01 is a bounded project choice. The [capability profile review](../../evaluation/capability-profile-review.html) records the adopted choice and reference deviation. Independent adequacy, modal/causal completeness and equivalence to the enterprise-architecture construct remain open. The current comparison is not evidence of the original discovery sequence.
