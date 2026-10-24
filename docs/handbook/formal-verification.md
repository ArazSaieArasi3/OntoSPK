# Formal specification and verification

OntoSPK's formal specification states selected commitments precisely; its verification reports what those commitments permit or exclude under declared assumptions. Read this page for the method, the [complete formal reference](../../semantic/product/v2/formal-specification/README.md) for the formulas, and the [executed FOL pilot](../../evaluation/fol-pilot.md) for individual results and certificates.

## Reading surfaces and source authority

Pages is the primary reading surface. It contains every accepted Wiki guide page, the conceptual and logical references, formal specification, evaluation explanations and downloads. The Wiki is a published projection of the repository's curated guide. The repository retains the governed source, code, exact formulas and machine-readable evidence for deeper inspection and reproduction. Reader explanations have one authored source; generated HTML and Wiki projections are not edited independently.

The fifteen accepted Wiki pages retain their historical core baseline. Current Pages adds explicit context and newer evidence without overwriting those published sources. A content audit compares their full normalized text, headings and link destinations with the Pages guide; equal page counts alone do not establish parity. This audit checks the accepted repository Wiki snapshot, not a fresh network read of a mutable live Wiki.

## Versions and citation

| Object | Identity and interpretation |
| --- | --- |
| Ontology core | [v2.0.0](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.0); native model 0.41.0 and logical profile 0.43.0. Their semantic files remain frozen. |
| Frozen documentation | [v2.0.1](https://arazsaiearasi3.github.io/OntoSPK/releases/v2.0.1/index.html), a historical documentation snapshot of that core. |
| Editorial annotation view | [v2.0.5](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.5), a separately identified annotation artifact with the same logical axioms. WIDOCO and the FOL pilot retain their declared frozen core inputs. |
| Executed FOL evidence | [v2.0.6](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.6), the accepted bounded verification pilot over the unchanged inputs. |
| Current reading route | The mutable `current/` site includes subsequent explanations. Its publication manifest identifies the exact deployed source; use an immutable release and its evidence for a reproducible citation. |

Historical labels such as `2.0.0-rc.1` inside the frozen formal reference record its preparation context. The v2.0.6 acceptance binds the exact source hashes and reproduces those same formulas; the old label does not identify a new or different current ontology. Neither a new documentation deployment nor the annotation view changes the pilot's semantic scope.

## Languages, notation and tools

| Layer | Language or tool | Role |
| --- | --- | --- |
| Conceptual model | OntoUML with a declared bounded project profile | Classes, relations, identity commitments and stereotypes; the adopted PC-01 local profile decision is disclosed separately and does not establish full reference conformity. |
| Formal statements | First-order logic with equality (FOL) | Unary class predicates, binary relation predicates, quantifiers and ordinary identity. |
| Expanded formula files | TPTP FOF syntax in `.p` files | Machine-readable serialization of the two static theories; all cardinality macros are expanded. |
| Logical implementation | OWL 2 DL, serialized in Turtle | The retained executable ontology profile, also checked with HermiT. Turtle is a serialization, not a reasoning method. |
| Data/admission validation | SHACL and separately declared operational contracts | Finite graph and admission requirements that are not automatically OWL or FOL consequences. |
| Bounded FOL solver | Pinned Z3 4.15.4 | Solves the fully grounded Boolean constraints. The retained custom parser reads the supported TPTP subset; Z3 does not directly parse the `.p` files. |

## A commitment in readable form

The actual-capability commitment says that every ProductCapability has exactly one ProductRealization bearer:

```text
forall C:
  ProductCapability(C) ->
    exists R:
      ProductRealization(R) and bearsCapability(R,C) and
      forall S: bearsCapability(S,C) -> S=R
```

The existential clause requires a bearer, and the equality clause requires uniqueness. If two explicitly distinct objects are both asserted to bear the same actual capability, they conflict with this requirement. Two different names alone need not denote distinct objects. This displayed example explains a retained commitment; the [expanded profile theory](../../semantic/product/v2/formal-specification/profile-projection.md) and the pilot's named scenarios determine exactly what is executed.

## Two theories, kept separate

The native structural theory contains 892 formulas derived from class/association structure, endpoint cardinalities and generalizations. The profile projection contains 3,038 formulas abstracted from explicit logical-profile constructs. Their signatures are separate; they are never concatenated as an assertion that the native model, OWL, SHACL and operational policies are equivalent.

The projection is an object-level abstraction. Datatype names become unary predicates; it does not implement OWL literal value spaces, lexical normalization or object/data-domain separation. The native structural theory does not supply the full modal or causal meaning of UFO stereotypes. These boundaries govern interpretation of every result.

## Verification procedure

1. **Bind and reproduce the inputs.** Check the frozen source hashes and regenerate the formal transcription in isolation. Its 71,872 two-object native relation interpretations and 544 generalization interpretations are replayed.
2. **Check the translation independently.** Compare the emitted native formulas against a separate encoder of native endpoint/cardinality records, and profile families against an encoder reading RDF constructs. At exact domain sizes two and three, Z3 runs 1,784 native and 22 profile-family disagreement searches. No disagreement is found within those bounds.
3. **State a finite scenario.** Choose an explicit nonempty universe, seed the relevant objects and facts, state any required distinctness or explicit absence, and include the entire selected theory. Quantifiers are expanded over that exact universe before solving.
4. **Search for a model or countermodel.** For consistency scenarios, ask whether the theory and seed have a model. For a proposed consequence, add its negation: a SAT witness is a counterexample; UNSAT excludes counterexamples only at that exact size.
5. **Check witnesses separately.** A Python FOL interpreter independently evaluates all formulas and scenario conditions in each returned SAT model. Eleven full-theory SAT certificates and eight isolated translation-mutation countermodels are retained as fixed reviewed inputs. CI checks rather than silently regenerates them.
6. **Publish outcomes and limits together.** Preserve the named scenarios, exact bounds, raw SMT-LIB inputs, solver version, source identities and evidence. Separate representational limits, absent axioms and unexpected failures.

## Reading the results

| Observation | What it establishes |
| --- | --- |
| 19 scenarios: 11 SAT, 8 UNSAT; zero unknowns | The named representative scenarios return their expected finite outcomes. These counts are not a percentage of scientific correctness. |
| Realization seed UNSAT at size one, SAT at size four | A small universe may be too small to satisfy the seed. Failure at one bound is not global inconsistency. |
| Populated native one-object model | The structural fragment permits overlapping types and self-links. This does not establish full UFO adequacy. |
| EV10/EV11 countermodels | Those admission joins do not follow from this FOL profile; they remain separately governed contracts. |
| A surviving three-cycle | Irreflexivity and asymmetry alone do not establish global acyclicity. |
| Eight detected translation faults | The controls can expose the tested plausible mistranslations; they do not prove compiler correctness for all inputs. |

An independently checked SAT witness is a model of the exact static fragment. Bounded UNSAT excludes models only at the stated exact size. The pilot does not prove unbounded translation equivalence, full OWL/UFO semantics, temporal or causal adequacy, external-owner equivalence, independent domain acceptance or production readiness. [All scenario results and limitations](../../evaluation/fol-pilot.md) remain available in the site.

## Reproduction and evidence

From a checkout of the accepted [v2.0.6 release](https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.6), use the documented Linux x86_64 runtime and pinned dependencies:

```bash
python -m pip install -r tools/publication/fol-requirements.txt
python tools/publication/test_fol_pilot.py
```

The harness checks the solver library identity. Raw solver queries and fresh witnesses are retained in the CI artifact. `--capture-witnesses` is an explicit certificate-review operation, not a normal validation shortcut. Transcription commands in the historical reference check translation; the command above executes the bounded pilot.

- [Native formulas and source structure](../../semantic/product/v2/formal-specification/native-structure.md)
- [Profile formulas and scope](../../semantic/product/v2/formal-specification/profile-projection.md)
- [Mappings and scoped contracts](../../semantic/product/v2/formal-specification/scoped-contracts.md)
- [Executed pilot, certificates and commands](../../evaluation/fol-pilot.md)
- [Other evaluation methods and results](../evaluation/index.html)
- [Historical reproduction guide](../guide/Reproduce.md)

The method and published numbers above describe the accepted v2.0.6 pilot. Subsequent site builds are documentation operations and do not by themselves rerun that solver or upgrade its scientific claims.
