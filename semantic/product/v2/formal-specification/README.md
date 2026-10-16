# OntoSPK first-order specification

This specification makes the declared static structure and explicit logical-profile commitments inspectable in first-order logic with equality. It is bound to native model **0.41.0** and logical profile **0.43.0**, within distribution **2.0.0-rc.1**. It does not change either source model.

## Read the specification

| Component | Human-readable reference | Expanded formulas |
| --- | --- | --- |
| Every native class, association, endpoint multiplicity and generalization | [Native structure](native-structure.md) | [Native FOL](native-structure.p) |
| Explicit logical constructs in the retained OWL profile | [Profile projection](profile-projection.md) | [Profile FOL](profile-projection.p) |
| Inverse mappings, test-profile joins and inference boundaries | [Mappings and scoped contracts](scoped-contracts.md) | Formulas are given explicitly in that document. |
| Identifier and version traceability | [Predicate dictionary](symbols.json) and [source bindings](source-bindings.json) | [Association signatures](relation-signatures.json) |
| Transcription checks | [Review findings](review.md) | [Machine-readable report](transcription-review.json) |

The native theory and profile projection have **separate signatures**. Their files must not simply be concatenated as a claim of semantic equivalence. Native classes, external handles, implementation properties and datatype predicates have distinct roles. The existing [native-class projection](../reference/native-class-projection.csv) and [association crosswalk](../source/validation_v041/inputs/Relation_OWL_SQL_Crosswalk_v0_16_0.csv) retain the declared mappings and their limits.

## Language

Classes are unary predicates and associations are binary predicates. Identity is ordinary equality. Quantifiers range over individuals, not predicates. The readable cardinality tables are finite axiom schemas; all macros are expanded in the `.p` files using TPTP FOF syntax.

For example, the actual-capability commitment is:

```text
forall C:
  ProductCapability(C) ->
    exists R:
      ProductRealization(R) and bearsCapability(R,C) and
      forall S: bearsCapability(S,C) -> S=R
```

Existence and uniqueness are both required. Two different names do not automatically denote two different individuals. Classes may be empty unless another axiom requires an instance. A `0..*` bound contributes no substantive restriction; those tautological entries are retained to preserve one-to-one correspondence with the existing structural register. Expression counts are not measures of semantic strength.

## Scope

The native reference covers 128 class symbols, including 27 external handles, 286 associations and 34 generalizations. Its 892 expressions preserve the source register's three entries per association and one per generalization. The profile projection translates the explicit logical constructs separately, including pairwise expansion of the declared disjointness list.

The profile projection is an **object-level FOL abstraction**, not a full axiomatization of OWL 2 direct semantics. XSD ranges appear as unary datatype predicates. Datatype value spaces, lexical normalization and object/data-domain separation are not supplied. It also does not encode the full modal meaning of UFO stereotypes, temporal identity, causal participation, or operational persistence and admission policies.

A recorded specification does not itself establish an implemented capability. An evidence attribution does not establish claim truth. A test result does not automatically imply success. These are limits on inference, not assertions that implementation, truth or success are absent.

## Reproduce the transcription checks

From the repository root, using the dependencies in `tools/ontospk/requirements.txt`:

```bash
python tools/ontospk/build_fol.py
python tools/ontospk/check_fol.py
```

The checks parse the emitted formulas, inspect variable closure and predicate arity, reconcile source inventories and evaluate native relation translations over all two-object interpretations. They check the transcription; they are not a proof of whole-ontology consistency, independent domain validation, or full equivalence among the native model, OWL, SHACL and SQL.

No manuscript change or new ontology-wide reasoner result is part of this addition.
