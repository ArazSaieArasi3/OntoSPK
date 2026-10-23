# OWL profile, satisfiability and HermiT execution

ROBOT 1.9.11 (verified JAR SHA-256) passes OWL 2 DL validation and HermiT baseline reasoning. HermiT's actual isSatisfiable call returns true for all 121 named classes. 71 isolated scenarios match their expected consistency; queried entailments/non-entailments match their explicit oracles.

All 27 exact-cardinality restrictions and all 18 explicit disjointWith pairs receive isolated contradictory witnesses. Seven event predicates receive domain/range entailment probes. Equality, explicit differentFrom, existential omissions, timestamps and non-propagation are checked separately.

Multiple names do not imply distinct individuals in OWL. Two distinct fillers violate an exact-one restriction; two unseparated names can entail equality. A missing explicit filler remains OWL-consistent but fails the closed-world identity SHACL contract. Domain/range infer types; they do not reject absent explicit type assertions.

Temporal continuity, historical persistence and independent domain acceptance are not inferred from these tests. The command receipt records ROBOT orchestration separately from direct HermiT consistency, satisfiability and entailment calls.

[Inputs, commands and per-case observations](owl-hermit.json.gz) · [Default ROBOT report findings](robot-report.md)
