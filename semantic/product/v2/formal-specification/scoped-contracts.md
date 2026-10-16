# Mappings and scoped contracts

These formulas retain explicit mappings and scoped test contracts from the current companion sources. They are separated from the native structural theory and the OWL projection so that a mapping or an operational admission condition is not silently promoted to an axiom of every representation.

## Inverse mappings

The [association crosswalk](../source/validation_v041/inputs/Relation_OWL_SQL_Crosswalk_v0_16_0.csv) gives the following orientations. Subscripts below identify distinct native associations even when their display labels coincide.

```text
forall E,P:
  entryOfPortfolio_W004(E,P) <-> organizesEntry_W003(P,E)

forall D,P:
  dependencyOfProduct_W013(D,P) <-> hasDependencySpecification_W012(P,D)

forall E,R:
  hasResult_W091(E,R) <-> recordsExecution_profile(R,E)
```

The first two connect explicitly mapped native associations. The third relates a native association to the retained profile predicate; it does not introduce a new `owl:inverseOf` declaration into the source file.

The profile already declares:

```text
forall A,U:
  isCarrierInRecord(A,U) <-> recordsCarrier(U,A)

forall A,U,C:
  (isCarrierInRecord(A,U) and recordsClaim(U,C)) ->
    recordedAttributionTo(A,C)
```

The consequence is an attribution link, not truth of the claim.

## Test-profile joins

The source is the [scoped commitment matrix](../source/t52_formalization_v043/Commitment_Matrix_22_v0_43_0.json), commitments EV10 and EV11. These joins are documented graph/admission contracts; they are not claimed to be axioms encoded in the retained OWL file.

```text
forall E,R,S:
  (testsRealization(E,R) and assessesSpecification(E,S)) ->
    exists V:
      realizesVersion(R,V) and specifiesCapability(V,S)

forall Q,E,T:
  (hasRecordedExecution(Q,E) and executes(E,T)) ->
    containsCase(Q,T)
```

`containsCase` is the profile name mapped to native association `REL:W2:088`. No other relation named `contains` is merged with it.

The typed unique-version condition follows from the native endpoint type and exact-one realization/version bound:

```text
forall E,R:
  testsRealization(E,R) ->
    exists V:
      ProductVersion(V) and realizesVersion(R,V) and
      forall W: realizesVersion(R,W) -> W=V
```

These statements align a declared test target and assessment scope. They do not establish actual participation, successful execution, or satisfaction of the specified capability.

## Additional boundaries

- The native requirement generalization set is neither disjoint nor complete.
- The profile disjointness list applies only to its listed classes. In particular, TestResult remains a subclass of EvidenceArtifact.
- Asymmetry and irreflexivity alone do not exclude every longer directed cycle. No transitive-closure claim is added.
- Functional properties mean at most one value; existence requires a separate minimum or exact-cardinality axiom.
- Missing explicit data is not automatically false in the first-order theory. Finite admission checks have separately stated completeness requirements.
- A repeated identifier or timestamp is not a proof of continuing real-world identity.
- The immutable-record, replay and persistence commitments in the matrix remain operational contracts. They are not folded into a static object theory.
