# ProductCapability / Mode profile decision — issue #48

**Decision PC-01 v1.0.0, adopted 24 October 2026: retain the concrete `ProductCapability` in an explicitly bounded project profile.** The maintainer delegated the best supported choice; this is a local project decision, not independent scientific acceptance. No semantic migration is made. The ontology core remains v2.0.0; the latest published evidence release at this decision is v2.0.7. This subsequent decision is identified by its own repository commit, not retroactively attributed to that release.

## Meaning in the model

`ProductCapability` denotes an actual intrinsic disposition of one configured `ProductRealization`. A search service's ability to retrieve results is an example of the intended reading; the example does not establish an actual capability empirically. A requirement to retrieve results belongs to the specification side. A successful execution is evidence about behavior. These remain distinct.

The retained class has stereotype `mode`, nature `intrinsic-mode` and `isAbstract=false`. Its characterization is `bearsCapability`. Every actual capability has exactly one realization bearer; the current project also requires each admitted realization to bear at least one capability. That latter minimum scopes the modeled systems and is not a universal assertion about every damaged installation. Capability identity requires the same bearer and continuity of the underlying disposition. Cardinality checks alone cannot establish that continuity or causal power.

## Exact profile and authoritative comparison

The intended profile for this decision is **OntoSPK concrete-capability project profile PC-01 v1.0.0**, precisely scoped by the [machine-readable decision](../tools/publication/capability-profile-decision.json), frozen native source and focused comparison below. This is a project restriction/deviation declaration, not an official OntoUML version or a complete foundational profile.

The official documentation source was checked at commit [`e48fde4fbb74d0df92419e056c85d794b85be02b`](https://github.com/OntoUML/OntoUML/tree/e48fde4fbb74d0df92419e056c85d794b85be02b). Five file digests are pinned in the decision; an optional reference-checkout command verifies those bytes. The [Mode metadata](https://github.com/OntoUML/OntoUML/blob/e48fde4fbb74d0df92419e056c85d794b85be02b/classes/aspects/mode/meta.yml) explicitly declares `abstract: true`. The [Mode constraints](https://github.com/OntoUML/OntoUML/blob/e48fde4fbb74d0df92419e056c85d794b85be02b/classes/aspects/mode/constraints.rst) separately require characterization and exactly one bearer, and restrict the inheritance structure. The [Subkind metadata](https://github.com/OntoUML/OntoUML/blob/e48fde4fbb74d0df92419e056c85d794b85be02b/classes/sortals/subkind/meta.yml) permits Mode as a supertype without imposing the same mandatory abstractness value on Subkind.

There is a documented abstractness mismatch. We do not call it a documentation typo, reinterpret it as mere stereotype-metaclass abstractness, or claim our concrete class conforms to it. The project profile permits concrete instantiation because this class intentionally records actual dispositions directly and currently has no justified concrete specialization hierarchy. That choice is defensible within the declared bounded project scope, while **strict conformance to the pinned reference is withheld**. General UFO adequacy and a whole-language review remain separate.

## Alternatives and migration assessment

| Option | Consequence | Decision |
| --- | --- | --- |
| A. Keep concrete `ProductCapability`, explicitly disclose reference deviation | Retains actual disposition instances, identity commitments and current mappings. Requires no data migration. Full reference-profile conformity cannot be claimed. | **Adopted.** Best supported by the present domain model and compatibility requirements. |
| B. Toggle `isAbstract=true` alone | Creates an abstract native leaf with no concrete specialization. Existing sampled fixture typing supplies no concrete descendant. A successful OWL consistency check would not encode or settle native direct instantiation. | Rejected as an unjustified repair. |
| C. Abstract `ProductCapability` plus meaningful concrete `subkind` specializations | Potential route toward the reference rule. Requires evidence for rigid domain distinctions, coverage/scope decisions, new class IDs and generalizations, population typing, mapping/constraint/diagram updates and migration tests. A synonym subclass adds no domain explanation. | Deferred until such evidence or a strict-conformity requirement exists. |

An abstract class can still have instances through a concrete subclass: inherited membership in `ProductCapability` would remain valid. Therefore the issue is **lack of a concrete specialization and its justified typing/migration**, not that every `rdf:type ProductCapability` assertion would necessarily become false. The present RDF profile does not encode native direct-versus-indirect instantiation. This distinction prevents a misleading migration or satisfiability argument.

## Source-bound executed evidence

The [deterministic report](capability-profile-review.json) binds native source, decision, mapping, eight affected native formulas and three positive synthetic populations by SHA-256. Reproduce it with `python tools/publication/build_capability_profile_review.py` and `python tools/publication/test_capability_profile_review.py`.

| Focused comparison | Executed result | Interpretation |
| --- | --- | --- |
| C1 characterization | `ICREL:CP:bearsCapability` found | Scoped structural check. |
| C2 bearer multiplicity | Opposite end is exactly `1` | Static cardinality; no temporal/modal proof. |
| C3–C6 ancestor/descendant restrictions | No ancestors or descendants of this class | Passes vacuously; no hierarchy-wide foundational proof. |
| Reference abstractness | Reference true; native false | Explicitly accepted project deviation, not a passing strict-reference check. |
| Three positive native-profile fixture populations | Each explicitly types `actual1` as ProductCapability; no concrete descendants exist | Synthetic compatibility evidence, not three distinct real capabilities or an inventory of deployed data. |
| Native-to-OWL mapping | Existing `urn:productium:specification-profile:ProductCapability` retained | No new equivalence, import or signature bridge. |
| Native formula inventory | Eight of 892 structural formulas mention this class | All retained; no new abstractness axiom is silently added. |
| Adverse controls | Eight injected structural faults detected; abstract-leaf and hypothetical-subkind contrasts exercised | Finite test sensitivity, not independent domain validation. |

The official-source check was executed against the pinned Git checkout using `python tools/publication/build_capability_profile_review.py --reference-root build/ontouml-reference`. Routine CI uses the recorded comparison and local source hashes; it does not silently access a changing `latest` page or claim a fresh external readback. To repeat the external check, obtain the official repository at the exact commit above and pass its path. Third-party source files are not redistributed in this report.

## Acceptance, boundaries and reopening

This resolves #48's project-profile choice and migration assessment by selecting A. No ontology axioms, native abstractness flags, identifiers, instance records, SHACL targets, diagrams, frozen releases or private sibling repositories change. Historical reports that said the choice was pending remain historical; this decision supersedes that pending status for current readers.

Reopen the decision if strict conformity becomes a project requirement, independently justified concrete capability specializations emerge, or authoritative profile requirements change. A later accepted semantic migration must receive a new semantic version, reviewed migration and affected native/OWL/SHACL/CQ/FOL checks. Independent scientific review, modal/causal adequacy and empirical disposition continuity are still unestablished. Closing this focused decision does not certify them.

The [current publication handoff](../docs/handbook/publication-handoff.md) and [formal verification method](../docs/handbook/formal-verification.md) explain how to read this decision with the rest of the evidence.
