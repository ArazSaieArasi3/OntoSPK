# Market boundary preservation — issue #24

**Current reference-only use is accepted and preserved by owner direction (23 October 2026).** The earlier proposal to reassess owner alignment, introduce locally owned replacement concepts or publish sibling repositories is deferred. This increment changes documentation and preservation checks only.

| Handle | Existing public operational meaning | Recorded kind | Disposition |
| --- | --- | --- | --- |
| `EXT:Market:CustomerSegment` | A grouping of customers by shared needs, behavior or context; not an individual customer. | `customer_segment` | Preserve unchanged |
| `EXT:Market:Market` | A bounded exchange context to which a product or go-to-market specification refers. | `market` | Preserve unchanged |
| `EXT:Market:MarketSegment` | A subset of a market selected using explicit segmentation criteria. | `market_segment` | Preserve unchanged |
| `EXT:Market:Need` | A required or desired condition associated with a customer or actor context. | `customer_need` | Preserve unchanged |

These meanings and locators already exist in the public native v2.0.0 model. No new definition, class, owner mapping, import, constraint or Market runtime adapter is introduced. No sibling/private repository is read or changed by this workflow.

## Existing native uses

| Relation | Source | Market target | Recorded target bounds | Existing logical predicate |
| --- | --- | --- | --- | --- |
| `REL:W2:113` refersTo | `IC:TargetMarketReference` | `EXT:Market:Market` | `1` | `urn:productium:specification-profile:referenceTarget` |
| `REL:W2:114` refersTo | `IC:TargetSegmentReference` | `EXT:Market:MarketSegment` | `1` | `urn:productium:specification-profile:referenceTarget` |
| `REL:W2:186` targets | `IC:OfferingSpecification` | `EXT:Market:CustomerSegment` | `0..*` | `urn:product-ontology:relation-profile:0.7:r186_targets` |
| `REL:W2:189` targets | `IC:VisionStatement` | `EXT:Market:CustomerSegment` | `0..*` | `urn:product-ontology:relation-profile:0.7:r189_targets` |
| `REL:W2:200` targets | `IC:GoToMarketSpecification` | `EXT:Market:CustomerSegment` | `0..*` | `urn:product-ontology:relation-profile:0.7:r200_targets` |
| `REL:W2:201` targets | `IC:GoToMarketSpecification` | `EXT:Market:Market` | `0..*` | `urn:product-ontology:relation-profile:0.7:r201_targets` |
| `REL:W2:203` targets | `IC:LaunchSpecification` | `EXT:Market:CustomerSegment` | `0..*` | `urn:product-ontology:relation-profile:0.7:r203_targets` |
| `REL:W2:204` targets | `IC:MarketingGoalSpecification` | `EXT:Market:CustomerSegment` | `0..*` | `urn:product-ontology:relation-profile:0.7:r204_targets` |
| `REL:W2:208` addressesNeed | `IC:OfferingSpecification` | `EXT:Market:Need` | `0..*` | `urn:product-ontology:relation-profile:0.7:r208_addressesNeed` |
| `REL:W2:209` informedBy | `IC:VisionStatement` | `EXT:Market:Need` | `0..*` | `urn:product-ontology:relation-profile:0.7:r209_informedBy` |
| `REL:W2:210` assessesNeed | `IC:ProductMarketFitAssessment` | `EXT:Market:Need` | `0..*` | `urn:product-ontology:relation-profile:0.7:r210_assessesNeed` |
| `REL:W2:212` intendsToAddressNeed | `IC:FeatureSpecification` | `EXT:Market:Need` | `0..*` | `urn:product-ontology:relation-profile:0.7:r212_intendsToAddressNeed` |
| `REL:W2:216` intendsToAddressNeed | `IC:TouchpointSpecification` | `EXT:Market:Need` | `0..*` | `urn:product-ontology:relation-profile:0.7:r216_intendsToAddressNeed` |

The table reproduces recorded bounds; their original candidate/review metadata is retained in the JSON receipt and is not promoted to a new scientific acceptance. Two reference-record relations use generic `referenceTarget`; the other eleven retain their existing logical range projections. None establishes an accepted mapping to an external owner class.

## Executed preservation evidence

- All 543 tracked semantic files are byte-identical to frozen v2.0.0; all 27 boundary elements and the 13 incident Market relations are preserved.
- All 90 memory-only adverse changes are rejected: definitions, labels, kinds, locators, equivalence flags, stereotypes, typed contracts, relation endpoints/cardinalities/removals, and changes to the other 23 boundaries.
- Four direct calls to the frozen boundary runtime retain `REVIEW_REQUIRED / NO_IMPLEMENTED_TYPED_BOUNDARY_CONTRACT`. This result is disclosed unchanged; present reference use is accepted by policy and does not imply a newly implemented typed validator.

## Release and deferred scope

v2.0.3 is a documentation/evidence patch over ontology core v2.0.0. Existing Business evidence from #23 is retained. No semantic migration is required. The frozen v2.0.1 documentation and v2.0.2 evaluation release remain unchanged. The future v2.1.0 semantic work remains conditional; private-repository publication is not a prerequisite for this patch.

The original external alignment/localization objectives of #24 are superseded for this increment by the owner preservation decision. The acceptance is explicitly limited to current reference-only use. ProductLine, Architecture and unresolved/composite external reviews (#25–#27) are deferred; they are not silently reported implemented. Later cross-ontology rewiring requires a new owner-directed review.

[Exact source identities, all file blobs, relation metadata, runtime observations and adverse controls](market-boundary-preservation.json) · [Frozen native source](../semantic/product/v2/source/formalization/Native_Model_v0_41_0.json)

Reproduce with `python tools/publication/review_market_preservation.py` from the repository root with the frozen v2.0.0 commit available. No network request is made by this runner.
