# OntoSPK v2.0.6 — Executed bounded FOL verification pilot

This evidence patch completes the representative pilot in #31. The existing native structural FOL theory and object-level OWL-profile FOL abstraction retain their separate signatures. The native model, bounded OWL/SHACL sources, all 543 semantic files, all 27 external handles, the manuscript, owner-held boundaries and prior publication identities are unchanged.

## Executed scope

- Fresh isolated regeneration and transcription readback match the published 892 native and 3,038 profile formulas. The prior 71,872 two-object native relation interpretations and 544 generalization interpretations are replayed.
- A pinned Z3 4.15.4 engine checks 1,784 native source/FOF disagreement searches and 22 profile-family searches at exact domain sizes two and three. The source encoders independently read native endpoint/cardinality data and RDF constructs; no differential mismatch occurs within these bounds.
- Nineteen representative full-theory scenarios produce eleven SAT and eight UNSAT outcomes at their declared exact finite sizes, with zero unknown results. All eleven SAT witnesses and eight isolated translation-mutation countermodels have fixed public certificates checked by a separate FOL interpreter. Raw SMT-LIB queries and fresh solver witnesses are retained in CI artifacts.
- Nonempty/vacuous baselines, seeded realizations/capabilities/executions, existence, equality/aliasing, distinct fillers, inverse/chain inference, scoped joins, cycles and abstract datatype separation are distinguished. Eight plausible translation faults are detected.

## Findings and acceptance limits

A nonempty one-object native model with all types overlapping exposes the limited static structural theory; it does not validate UFO kinds or real-world identity. Concrete profile countermodels confirm that EV10/EV11 joins remain separate graph/admission contracts, asymmetry/irreflexivity do not provide general acyclicity, and abstract datatype predicates do not enforce OWL object/data-domain separation or literal value semantics. A realization seed is UNSAT at bound one yet SAT at bound four; a small-bound failure is not global inconsistency.

The retained custom parser reads the TPTP subset and the new compiler fully grounds quantifiers into Boolean SMT over an explicit nonempty universe. Z3 does not directly parse the TPTP source. SAT certificates are models of the exact static fragment. UNSAT excludes models only at the stated exact finite size. Neither the differential checks nor this pilot prove unbounded translation equivalence, whole-ontology consistency/adequacy, full OWL datatype semantics, temporal/modal/causal meaning, signature equivalence or independent expert acceptance. No theories are concatenated or bridged. Existing historical release labels inside frozen source documents remain historical; current acceptance is bound by hashes and this release record.

## Publication and reproduction

Install the Linux x86_64 pilot dependency from `tools/publication/fol-requirements.txt`, then run `python tools/publication/test_fol_pilot.py`. The native solver library is SHA-256 checked. CI validates committed witness inputs and never silently regenerates their acceptance certificates; `--capture-witnesses` is a separate explicit certificate-review operation.

Documentation and expanded-evaluation CI rerun the source binding, pilot and retained SHACL/HermiT/CQ gates before main publication. The three release assets bind the complete public Git tree and eleven evidence receipts to the exact accepted commit. The existing v2.0.5 annotated view retains its identity and its 318 disclosed ROBOT findings; no default-report-clean or new licence claim is added. #48 remains a separate profile decision; sourced concept pages and sibling/private repositories remain deferred.

Read `evaluation/fol-pilot.md`, `evaluation/fol-pilot.json.gz` and `tools/publication/fol-pilot-witnesses.json.gz` for all searches, source hashes, certificates and scope decisions.
