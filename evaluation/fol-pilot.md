# First-order verification pilot — v2.0.6

**The bounded FOL pilot is complete.** The native structural theory (892 formulas) and object-level profile theory (3,038 formulas) retain separate signatures. All semantic source files and existing formal specifications remain unchanged; no manuscript claim is edited.

The prior transcription audit was freshly reproduced in isolation, including 71,872 native relation interpretations and 544 generalization interpretations. Z3 4.15.4 then compared all 892 native translations against a separate source encoder at domain sizes two and three (1,784 disagreement searches), and all eleven profile families at both sizes (22 searches). No disagreement model was found within those bounds. Native cardinalities use independently encoded integer counts; profile restrictions/relations are read directly from RDF.

The representative pilot executes 19 full-theory scenarios: 11 SAT and 8 UNSAT at their stated finite sizes, with zero unknown results. Every SAT model is checked by a separate Python FOL interpreter, including a fixed public certificate. Eight plausible translation mutations produce independently checked countermodels. Raw SMT-LIB inputs and fresh solver witnesses are included in the CI artifact.

| Scenario | Theory / exact domain size | Result | Interpretation |
| --- | --- | --- | --- |
| native_empty_extensions | native / 1 | SAT | Nonempty one-object universe, all unary/binary extensions empty; exposes vacuity, not populated adequacy. |
| profile_empty_extensions | profile / 1 | SAT | Nonempty one-object universe, all unary/binary extensions empty; exposes vacuity, not populated adequacy. |
| native_all_types_one_object | native / 1 | SAT | A populated model of all 892 native structural formulas; overlapping types and self-links show the limited structural theory, not UFO adequacy. |
| profile_one_object_bound_too_small | profile / 1 | UNSAT | UNSAT at bound one is a size limitation; the same seed has a model at bound four. |
| profile_realization_populated | profile / 4 | SAT | Version, capability and bearer constraints are completed by a nonempty finite witness. |
| profile_capability_populated | profile / 4 | SAT | A seeded actual capability admits a bearer/version witness. |
| profile_realization_without_any_version | profile / 4 | UNSAT | Existence is required; explicit absence of every version contradicts this seeded profile within the bound. |
| profile_capability_without_any_bearer | profile / 4 | UNSAT | Explicit absence of every bearer conflicts with the actual-mode restriction. |
| profile_distinct_versions | profile / 4 | UNSAT | Indices one and two are explicitly distinct objects; two fillers violate exact one. |
| profile_alias_names | profile / 4 | SAT | Two fixture names may refer to the same object index. No unique-name assumption is added. |
| profile_concluded_execution_populated | profile / 10 | SAT | A nonempty execution witness for the entire profile abstraction, with abstract datatype predicates. |
| profile_result_domain_counterexample | profile / 10 | UNSAT | No countermodel to the declared domain inference in this finite domain. |
| profile_inverse_counterexample | profile / 10 | UNSAT | No countermodel to the declared inverse orientation in this finite domain. |
| profile_chain_counterexample | profile / 10 | UNSAT | No countermodel to the recorded-attribution property chain; no claim-truth assertion is introduced. |
| EV10_join_is_not_a_profile_consequence | profile / 10 | SAT | Concrete countermodel: the scoped admission join is not an axiom of this published FOL profile. |
| EV11_suite_closure_is_not_a_profile_consequence | profile / 10 | SAT | Concrete countermodel: the suite/case admission closure is not an asserted profile implication. |
| profile_three_cycle_not_excluded | profile / 4 | SAT | A three-cycle survives asymmetry/irreflexivity; global acyclicity is not provided. |
| profile_self_loop_excluded | profile / 4 | UNSAT | A self-loop violates the declared irreflexivity/asymmetry. |
| profile_abstract_datatype_overlap | profile / 4 | SAT | The object-level export permits datatype/class overlap; it omits OWL object/data-domain separation and literal value semantics. |

## Findings and limits

The all-empty predicate baseline uses a **nonempty** universe and makes vacuity explicit. The nonempty native one-object model demonstrates how weak static typing/cardinality structure is: it is not a valid claim about UFO kinds, disjointness or real-world individuals. The populated profile models test stronger retained restrictions separately.

Concrete countermodels confirm that EV10/EV11 joins remain admission contracts and that a three-cycle is not excluded by asymmetry/irreflexivity. Abstract datatype predicates permit overlap with object classes; this does not implement OWL datatype value spaces, literal equality, lexical normalization or object/data-domain separation. These are disclosed representation limits, not silently repaired model defects. Profile adjudication remains #48.

The published function-free TPTP text is read by the retained custom parser; Z3 solves its fully grounded Boolean encoding, not the TPTP source directly. Source-side differential checks at two bounds and an independent witness interpreter provide separate controls, not a universal compiler-correctness proof.

A failed finite bound is not global inconsistency: a realization seed has no one-object model but has a verified four-object model. SAT witnesses are models of the exact published static fragment. UNSAT results exclude models/countermodels only at the declared exact size. Neither family-level differential checks nor this representative pilot prove full OWL equivalence, temporal/modal/causal adequacy or independent domain acceptance. Native and profile theories are never merged or bridged.

[Source hashes, every search result and assumptions](fol-pilot.json.gz) · [Fixed model/countermodel certificates](../tools/publication/fol-pilot-witnesses.json.gz) · [Frozen specification and scope](../semantic/product/v2/formal-specification/README.md)

Reproduce with `python -m pip install -r tools/publication/fol-requirements.txt`, then `python tools/publication/test_fol_pilot.py`. The `--capture-witnesses` option is only for explicitly reviewing new certificate inputs; CI reuses and independently validates the committed certificates.

Method references: [official Z3 guide](https://microsoft.github.io/z3guide/docs/logic/intro/) and [quantifier guidance](https://microsoft.github.io/z3guide/docs/logic/Quantifiers/). This harness expands quantifiers over explicit finite domains before solving, rather than relying on heuristic instantiation of unbounded quantified formulas.
