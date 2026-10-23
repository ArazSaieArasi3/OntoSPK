# Business boundary contract review

**Issue #23: the five local reference policies are decided.** Public authority is the existing OntoSPK v2.0.0 operational contract. The separately governed owner repository is private, so no public owner snapshot or owner-equivalent import is accepted. No private owner payload is copied.

| Stable handle | Public operational meaning in OntoSPK | Accepted local kind | Decision |
| --- | --- | --- | --- |
| `EXT:Business:BusinessCapability` | A business-owned ability that a product capability specification intends to support. | `business_capability` | Keep reference-only; no accepted owner equivalence. |
| `EXT:Business:BusinessGoal` | A business-owned desired outcome to which a product requirement contributes. | `business_goal` | Keep reference-only; no accepted owner equivalence. |
| `EXT:Business:BusinessRule` | A business-owned directive or constraint referenced by a product specification. | `business_rule` | Keep reference-only; no accepted owner equivalence. |
| `EXT:Business:Service` | A business-facing service included in an offering; distinct from a software architecture service. | `business_service` | Keep reference-only; no accepted owner equivalence. |
| `EXT:Business:ValueProposition` | A business-owned statement of value offered to intended recipients. | `value_proposition` | Keep reference-only; no accepted owner equivalence. |

The definitions above are reproduced from the already public native model, not from the private Business ontology. They explain OntoSPK usage without requiring a reader to fetch a private repository. The four same-name declarations are historical evidence, not definition-equivalence proofs.

## Service versus BusinessService

Keep the stable Business handle; display Business Service; reject treating architecture_service as its typed record kind. BusinessService remains an owner rename candidate, not an accepted equivalence or an IRI rewrite.

The native architecture service contract uses `architecture_service`: A technical service in a software architecture; distinct from a business-facing service. The business contract uses `business_service`: A business-facing service included in an offering; distinct from a software architecture service.

The existing stable native ID remains `EXT:Business:Service`, the native display is **Business Service**, and the owner `BusinessService` locator remains a rename candidate. Neither the Business handle nor the architecture handle is retargeted or merged. Different IRIs do not themselves establish disjoint classes or distinct individuals.

## All eight native uses and their existing logical projection

| Native relation | Source | Relation | Business target | Targets per source | Existing OWL predicate |
| --- | --- | --- | --- | --- | --- |
| `REL:W2:107` | `IC:CapabilitySpecification` | intendedToSupport | `EXT:Business:BusinessCapability` | `0..*` | `urn:product-ontology:relation-profile:0.7:r107_intendedToSupport` |
| `REL:W2:111` | `IC:BusinessRuleReference` | refersTo | `EXT:Business:BusinessRule` | `1` | `urn:productium:specification-profile:referenceTarget` |
| `REL:W2:116` | `IC:PositioningStatement` | references | `EXT:Business:ValueProposition` | `0..*` | `urn:product-ontology:relation-profile:0.7:r116_references` |
| `REL:W2:167` | `IC:QualityRequirementSpecification` | supports | `EXT:Business:BusinessGoal` | `0..*` | `urn:product-ontology:relation-profile:0.7:r167_supports` |
| `REL:W2:185` | `IC:Product` | referencesValueProposition | `EXT:Business:ValueProposition` | `0..*` | `urn:product-ontology:relation-profile:0.7:r185_referencesValueProposition` |
| `REL:W2:187` | `IC:OfferingSpecification` | includesService | `EXT:Business:Service` | `0..*` | `urn:product-ontology:relation-profile:0.7:r187_includesService` |
| `REL:W2:190` | `IC:VisionStatement` | referencesValueProposition | `EXT:Business:ValueProposition` | `0..*` | `urn:product-ontology:relation-profile:0.7:r190_referencesValueProposition` |
| `REL:W2:202` | `IC:GoToMarketSpecification` | referencesValueProposition | `EXT:Business:ValueProposition` | `0..*` | `urn:product-ontology:relation-profile:0.7:r202_referencesValueProposition` |

Four Business kinds have local OWL boundary placeholders used as ranges by seven relations. BusinessRule instead uses the local `BusinessRuleReference` record and generic `referenceTarget` predicate, with no asserted BusinessRule owner-class range. The native-to-OWL class projection register deliberately asserts no authoritative mapping for any of the five handles. A traced boundary range is not an accepted mapping to the owner ontology.

## Accepted, rejected and unresolved

- **Accepted:** five local operational reference contracts, their kinds and the eight released relation signatures. Preserve the core and record target/source/version provenance.
- **Rejected:** automatic equivalence from equal names, an unreviewed Service → BusinessService IRI rename, merging business/architecture service contracts, and adding an owner ontology as a runtime import.
- **Unresolved externally:** authoritative owner-definition compatibility, target membership and UFO typing. These are not needed to choose the current reference-only policy. A future locally owned concept or accepted owner mapping requires an explicit new semantic identity and review, not a change to frozen v2.0.0.

## Executable reference-record gate

The released legacy boundary gate returns REVIEW_REQUIRED for all five Business handles: it has no v0_41 typed Business contract. The new **separate adapter** at `tools/boundaries/business_reference.py` implements this reviewed local record policy. It requires a stable handle, an allowed kind, one target IRI, a source IRI and a nonempty version; it rejects equivalence/owner-acceptance flags and an inconsistent supplied class locator. Passing means local record conformance only. It neither proves target membership nor fetches an owner repository.

```bash
python tools/boundaries/business_reference.py --input reference.json
python tools/publication/test_business_boundary_contract.py
```

Native, OWL, SHACL, Wiki and existing frozen publication mappings are unchanged. This is a documented/executable reference policy; no new semantic release is claimed. A complete RDF population still needs its existing SHACL validation; a valid JSON reference record is not whole-population or independent scientific acceptance.

## Public sources and reproducibility

- [Frozen native contracts](../semantic/product/v2/source/formalization/Native_Model_v0_41_0.json)
- [Frozen logical profile](../semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl)
- [Published historical external register](external-boundary-status.json)
- [Exact source paths, hashes, decisions and eight relation signatures](business-boundary-review.json)
- [Executable contract test report](business-boundary-tests.md)

Run `python tools/publication/build_business_boundary_review.py` from the repository root to reproduce the public extraction. The private-visibility observation is a dated metadata readback, not a claim that this generator performs an online owner-definition review.
