# External references and ownership boundaries

The native model contains 27 reference-only external handles. They retain conceptual boundaries without importing an owner ontology or asserting class equivalence. This page explains preserved metadata; it does not repeat the historical owner-snapshot inspection as a new experiment.

## How to read the recorded evidence

Sixteen records contain `EXACT_NAME_CLASS_DECLARATION_VERIFIED`: the earlier review observed a same-name class declaration in a pinned owner snapshot. The field `verified_declaration_iri` records that historical declaration evidence. It does **not** mean that the IRI is publicly dereferenceable, that definitions are equivalent, that UFO types have been accepted, or that an external owner approved an alignment. All 27 records retain `target_iri_status: NOT_VERIFIED` and `semantic_equivalence: NOT_ASSERTED`.

Seventeen records have an `owner_class_locator`; one of these is only the Business `Service` to `BusinessService` rename candidate. All 17 use a namespace under a separately governed research repository. An authenticated repository-metadata readback on 22 October 2026 reports that namespace repository as private. These namespace strings are preserved as identifiers and evidence locators, not advertised as public file-download links. Public readers cannot be expected to reproduce the private owner-snapshot inspection from these locators.

## Decisions for the fixed core

- Preserve the native model and logical-profile identities in the public core.
- Disclose inaccessible or unresolved evidence instead of presenting a broken public link as accepted alignment.
- Keep private owner payloads outside the distribution; use explicitly synthetic boundary fixtures for the disclosed local revision tests.
- Resolve each owner contract through the linked follow-ups. If accepted work changes native metadata or semantics, publish a new version and explain the change; never replace the frozen release silently.

## Complete register

| Handle | Recorded declaration status | Recorded class locator |
| --- | --- | --- |
| `EXT:Architecture:ArchitectureElement` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/architecture#ArchitectureElement` |
| `EXT:Architecture:Component` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/architecture#Component` |
| `EXT:Architecture:Interface` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/architecture#Interface` |
| `EXT:Architecture:Service` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/architecture#Service` |
| `EXT:Business:BusinessCapability` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/business#BusinessCapability` |
| `EXT:Business:BusinessGoal` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/business#BusinessGoal` |
| `EXT:Business:BusinessRule` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/business#BusinessRule` |
| `EXT:Business:Service` | `RENAMED_TARGET_CANDIDATE` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/business#BusinessService` |
| `EXT:Business:ValueProposition` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/business#ValueProposition` |
| `EXT:EvidenceLayer:Evidence` | `OWNER_CONTRACT_UNRESOLVED` | No recorded exact locator |
| `EXT:ExternalUnresolved:Configuration` | `OWNER_CONTRACT_UNRESOLVED` | No recorded exact locator |
| `EXT:ExternalUnresolved:Evidence` | `OWNER_CONTRACT_UNRESOLVED` | No recorded exact locator |
| `EXT:ExternalUnresolved:Test_Plan` | `OWNER_CONTRACT_UNRESOLVED` | No recorded exact locator |
| `EXT:ExternalUnresolved:Test_Script` | `OWNER_CONTRACT_UNRESOLVED` | No recorded exact locator |
| `EXT:Market:Competitor_Alternative` | `COMPOSITE_TARGET_REQUIRES_SEPARATION` | No recorded exact locator |
| `EXT:Market:CustomerSegment` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/market#CustomerSegment` |
| `EXT:Market:Market` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/market#Market` |
| `EXT:Market:MarketInsight` | `CLASS_NOT_DECLARED_IN_PINNED_OWNER` | No recorded exact locator |
| `EXT:Market:MarketSegment` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/market#MarketSegment` |
| `EXT:Market:Need` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/market#Need` |
| `EXT:Market:Pain` | `CLASS_NOT_DECLARED_IN_PINNED_OWNER` | No recorded exact locator |
| `EXT:ProductLine:ProductConfiguration` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/product-line#ProductConfiguration` |
| `EXT:ProductLine:ProductFamily` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/product-line#ProductFamily` |
| `EXT:ProductLine:ProductLine` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/product-line#ProductLine` |
| `EXT:ProductLine:ProductVariant` | `EXACT_NAME_CLASS_DECLARATION_VERIFIED` | `https://github.com/ArazSaieArasi3/product-management-research/semantic/product-line#ProductVariant` |
| `EXT:ProductManagement:Metric` | `OWNER_CONTRACT_UNRESOLVED` | No recorded exact locator |
| `EXT:UXResearch:User_Mental_Model` | `OWNER_CONTRACT_UNRESOLVED` | No recorded exact locator |

## Follow-up decisions

Business: [#23](https://github.com/ArazSaieArasi3/OntoSPK/issues/23); Market: [#24](https://github.com/ArazSaieArasi3/OntoSPK/issues/24); ProductLine: [#25](https://github.com/ArazSaieArasi3/OntoSPK/issues/25); Architecture: [#26](https://github.com/ArazSaieArasi3/OntoSPK/issues/26); unresolved and composite targets: [#27](https://github.com/ArazSaieArasi3/OntoSPK/issues/27). None is relabeled as completed external-owner acceptance.

## Sources and reproduction

- [Frozen native model](https://github.com/ArazSaieArasi3/OntoSPK/blob/v2.0.0/semantic/product/v2/source/formalization/Native_Model_v0_41_0.json)
- [Machine-readable register with owner snapshot identifiers](https://github.com/ArazSaieArasi3/OntoSPK/blob/v2.0.0/evaluation/external-boundary-status.json)
- [Generator](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/tools/publication/build_external_boundary_report.py)
- [Quality evidence and limits](Quality)
- [Release plan](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/docs/development/release-plan.md)

Run `python tools/publication/build_external_boundary_report.py` from the repository root. The script checks the native digest and category totals and produces this page and its JSON companion. The visibility observation is a separately recorded metadata readback, not a network request performed by this generator.
