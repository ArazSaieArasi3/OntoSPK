```json
{
  "native_id": "IC:Product",
  "editorial_status": "editorial-source-checked",
  "reviewed_on": "2026-10-26",
  "evidence": [
    {
      "id": "management",
      "source": "ebert2007",
      "claim": "Product-management competence and product outcomes are investigated empirically.",
      "support": "partial",
      "locator": "Abstract, study purpose and industry-project account",
      "limitation": "Context for product governance; does not establish the local identity criterion."
    },
    {
      "id": "business",
      "source": "kittlaus2022",
      "claim": "Software product management is situated in software as a business.",
      "support": "partial",
      "locator": "Chapter 2 abstract, opening and scope paragraphs",
      "limitation": "Only the original chapter abstract was inspected; no detailed book definition is asserted."
    }
  ],
  "related_ids": [
    "IC:ProductVersion",
    "IC:ProductRealization"
  ]
}
```

## Extended explanation

In OntoSPK, a Product is the continuing subject of product governance. Its purpose and stewardship connect plans, versions and evidence across change. A version fixes an approved specification baseline; a deployed realization enacts one such baseline. Keeping these subjects separate lets a reader ask whether a decision concerns the continuing product, a particular approved design, or one configured system. This paragraph explains the local model commitment; it is not a definition quoted from an external author.

The broader management literature supplies context rather than the complete identity rule. Ebert investigates product-management competence and product outcomes through an industry study [@management]. Kittlaus’s chapter positions software product management within software as a business [@business]. Those accounts motivate attention to managed products, but neither inspected abstract establishes OntoSPK’s precise purpose-and-lineage identity criterion. The local synthesis should therefore be evaluated on its explicit commitments rather than presented as a universally accepted definition of product.

## Distinctions

- **ProductVersion:** an immutable approved baseline of a Product, rather than its continuing identity.
- **ProductRealization:** one concrete configured functional whole; several realizations need not be several Products.
- **Database row:** a representation of the Product, not its constitutive identity.

## Illustrative example

An authored illustration: a team maintains an invoicing product through approved baselines 1 and 2. Two configured deployments enact baseline 2. The Product, its two versions, and the two realizations answer different identity questions. This is not an observation from Ebert’s study.

## Evidence gaps and lineage

The canonical definition is a project commitment, not an exact quotation or an independently validated cross-literature equivalence. Only the original abstracts of the management article and book chapter were available for this pass; detailed book definitions were not inspected. A full-text definition comparison remains open. The frozen catalogue records the commitment; it does not establish the historical sequence in which the concept was discovered.
