```json
{
  "native_id": "IC:ProductRealization",
  "editorial_status": "editorial-source-checked",
  "reviewed_on": "2026-10-26",
  "evidence": [
    {
      "id": "research",
      "source": "duarte2018",
      "claim": "The research separates ontologies of software, requirements and requirements at runtime.",
      "support": "partial",
      "locator": "Abstract, presentation of SwO, RSRO and RRO",
      "limitation": "The inspected abstract establishes scope only; it does not validate the local concrete-whole definition."
    },
    {
      "id": "execution",
      "source": "rro",
      "claim": "RRO distinguishes a program, its loaded dispositional copy and its execution event.",
      "support": "contrast",
      "locator": "Section 3.1, Program Execution; concept definitions Loaded Program Copy and Program Copy Execution",
      "limitation": "The local realization is a concrete whole; RRO’s loaded copy is a disposition. No class equivalence."
    }
  ],
  "related_ids": [
    "IC:Product",
    "IC:ProductVersion",
    "IC:ProductCapability",
    "IC:TestExecution"
  ]
}
```

## Extended explanation

OntoSPK uses ProductRealization to identify the concrete configured computing-system whole that enacts a fixed product-version baseline. The local identity question concerns that functional whole, rather than its inventory record, one host machine or a particular execution. This permits evidence and actual capabilities to refer to the system being assessed while keeping its approved intended baseline separately identifiable.

Related software-ontology work distinguishes the nature of software from execution: Duarte and colleagues introduce linked ontologies for software, requirements and requirements at runtime [@research]. The published RRO documentation distinguishes a program, its loaded copy and the event of executing that copy [@execution]. That separation is useful comparative context, but its loaded copy is a disposition inhering in a machine. OntoSPK’s realization is instead the concrete functional whole. This is a contrast between ontological categories, not a renamed import or a claim that the two classes are equivalent.

## Distinctions

- **Product:** continuing governed product identity across baselines.
- **ProductVersion:** the immutable approved specification baseline enacted by the realization.
- **TestExecution:** a concluded attempt involving a realization; an occurrence is not its participant.
- **Loaded Program Copy in RRO:** a dispositional materialization, not the local concrete whole [@execution].

## Illustrative example

An authored illustration: a configured invoicing service with its integrated runtime components enacts approved baseline 2. Its asset-management record describes it. A concluded test against it is an event. Neither the descriptive record nor the test event is that realization.

## Evidence gaps and lineage

The system-whole identity criterion is local and needs independent domain assessment. The article’s abstract was inspected; detailed article claims here are not inferred from it. The explicit category comparison uses the original ontology documentation. No causal adequacy, complete mapping, import or historic discovery claim follows from this comparison.
