# Formalization and logical semantics

The formal description separates static conceptual commitments from an executable OWL profile, finite graph validation and persistence policies. The structural register contains 892 expressions. A separate matrix describes 22 scoped commitments, their enforcing mechanisms, examples and limits.

## Identity and language

The current logical profile is the Turtle file `Current_Logical_Profile_v0_43_0.ttl`. Its ontology IRI is `urn:productium:specification-profile:`. The inherited `owl:versionInfo` annotation reads `IC-0.7 authored specification identity candidate`; that annotation is retained technical metadata, not the public distribution version. No new version IRI or namespace has been invented for the repository move.

The OWL profile is checked under OWL 2 DL/HermiT in the documented controls. It uses open-world semantics and does not assume different names always denote different individuals. The generated reference reports actual imports and axioms from the file.

## A representative commitment

One ProductRealization is associated with exactly one ProductVersion in the bounded commitment. The structural and logical interpretations are described separately in the complete matrix.

```text
forall r: ProductRealization(r) ->
  exists v: ProductVersion(v) and realizesVersion(r,v)

forall r,v1,v2:
  realizesVersion(r,v1) and realizesVersion(r,v2) -> v1=v2
```

The uniqueness statement does not prove temporal continuity or conformance of a realization to an intended baseline. Under OWL, two version names without a distinctness assertion need not produce the same result as two explicitly distinct versions. The finite data checks test their own asserted-record requirements.

## Complete reference

- [All structural formulas and association contracts](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/semantic/product/v2/reference/associations.md)
- [All scoped commitments and their limits](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/semantic/product/v2/reference/commitments.md)
- [Generalizations and generalization sets](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/semantic/product/v2/reference/generalizations.md)
- [Classes and native identity commitments](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/semantic/product/v2/reference/classes.md)
- [Native to OWL projection](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/semantic/product/v2/reference/native-class-projection.csv)
- [OWL, validation and database constraints](Constraints)
- [Reasoning and results](Quality)

Generated lookup pages complement this explanation. They do not establish complete UFO modal, counterfactual or causal semantics.

The generated [WIDOCO cross-reference](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/docs/widoco/index-en.html) complements the [logical declaration reference](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/docs/reference/owl/index.html). Both derive from the same logical source.
