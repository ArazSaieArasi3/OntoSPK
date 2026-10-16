# Bounded commitments

OWL uses open-world semantics with no unique-name assumption. SHACL, SQL and admission policies assess supplied finite records. Operational policies are identified separately from logical axioms.

## ID01 — One version per ProductRealization

```text
forall r: ProductRealization(r) -> exists v: ProductVersion(v) and realizesVersion(r,v)
```

```text
forall r,v1,v2: realizesVersion(r,v1) and realizesVersion(r,v2) -> v1=v2
```

```text
forall x,y: R["ICREL:CP:realizesVersion"](x,y) => (C["IC:ProductRealization"](x) and C["IC:ProductVersion"](y))
```

```text
forall x: C["IC:ProductRealization"](x) => 1 <= card{y | R["ICREL:CP:realizesVersion"](x,y)} <= 1
```

```text
forall y: C["IC:ProductVersion"](y) => 0 <= card{x | R["ICREL:CP:realizesVersion"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Exact cardinality 1 on realizesVersion; open-world semantics. |
| SHACL | Identity slice retained; newly added to event slice. |
| SQL | Snapshot INSERT maximum plus separate completeness audit; new event SQL count/type checks. |
| History/policy | v0.34 records one stable realization/version binding across admitted events. |

Example: One typed version bound to a realization.

Counterexample: Two explicitly distinct versions for one realization.

Limit: Static uniqueness does not prove conformance to a baseline or temporal continuity.

## ID02 — At least one actual capability per realization

```text
forall r: ProductRealization(r) -> exists c: ProductCapability(c) and bearsCapability(r,c)
```

```text
forall x,y: R["ICREL:CP:bearsCapability"](x,y) => (C["IC:ProductRealization"](x) and C["IC:ProductCapability"](y))
```

```text
forall x: C["IC:ProductRealization"](x) => 1 <= card{y | R["ICREL:CP:bearsCapability"](x,y)}
```

```text
forall y: C["IC:ProductCapability"](y) => 1 <= card{x | R["ICREL:CP:bearsCapability"](x,y)} <= 1
```

| Mechanism | Scope |
| --- | --- |
| OWL | minCardinality 1 on bearsCapability. |
| SHACL | Retained identity shape minCount 1. |
| SQL | Retained schema stores links; lower-bound check is external to draft DDL. |
| History/policy | Explorer admits declared capability; new event ledger intentionally excludes this slice. |

Example: A configured whole with one or more actual capabilities.

Counterexample: An admitted realization with no explicit actual capability.

Limit: A local restriction to capability-bearing configured wholes; not a universal claim about every broken software installation.

## ID03 — Exactly one bearer per ProductCapability

```text
forall c: ProductCapability(c) -> exists r: ProductRealization(r) and bearsCapability(r,c)
```

```text
forall c,r1,r2: bearsCapability(r1,c) and bearsCapability(r2,c) -> r1=r2
```

```text
forall x,y: R["ICREL:CP:bearsCapability"](x,y) => (C["IC:ProductRealization"](x) and C["IC:ProductCapability"](y))
```

```text
forall x: C["IC:ProductRealization"](x) => 1 <= card{y | R["ICREL:CP:bearsCapability"](x,y)}
```

```text
forall y: C["IC:ProductCapability"](y) => 1 <= card{x | R["ICREL:CP:bearsCapability"](x,y)} <= 1
```

| Mechanism | Scope |
| --- | --- |
| OWL | Exact cardinality 1 on inverse bearsCapability. |
| SHACL | Retained identity inverse min/max 1. |
| SQL | Retained link_bears_capability inverse maximum. |
| History/policy | Explorer submit checks persisted bearer; direct-DML hardening of that old runtime is not done here. |

Example: One actual disposition bound to one bearer.

Counterexample: One capability bound to two explicitly distinct bearers.

Limit: OWL names do not imply distinct individuals. Explicit SHACL/SQL counts have a different admission meaning. Full modal dependence is not encoded.

## ID04 — Realization and capability continuity

```text
Policy input: operation, before/after realization, version, capability, continuity evidence and branching.
```

```text
VersionChange or Clone or Recreate or Branching or BrokenSystemContinuity => RequireDistinctRealization
```

```text
SameRealization and PreservedDispositionContinuity => RequireSameCapability
```

```text
Unknown continuity => REVIEW_REQUIRED; no fabricated continuity conclusion
```

| Mechanism | Scope |
| --- | --- |
| OWL | No temporal identity inference from the static OWL restrictions. |
| SHACL | No cross-history identity decision. |
| SQL | No such decision in the 438-table snapshot schema. |
| History/policy | Retained v0.22 policy: preserved/broken/unknown evidence, version changes, branching and successors. |

Example: Restart with evidenced system and disposition continuity retains both identities.

Counterexample: Upgrade reuses the prior realization; another bearer reuses the prior capability.

Limit: Executable decision rules over supplied evidence, not a modal theory. The policy remains separate from combined SQL admission. Product constitutive lineage is an authored identity criterion, not an OWL key.

## ID05 — Do not infer identity from equal identifiers or timestamps

```text
Equal(recordedTimestamp(e1),recordedTimestamp(e2)) does not entail e1=e2.
```

```text
Reuse of an identifier does not entail continuous real-world identity.
```

| Mechanism | Scope |
| --- | --- |
| OWL | No universal unique-name or event-key claim. |
| SHACL | Record counts are graph constraints, not event individuation. |
| SQL | Primary keys identify records, not real-world occurrences. |
| History/policy | Distinct events may share time/case/realization; separate result IDs required. |

Example: Distinct attempts can have the same timestamp and inputs.

Counterexample: Treat a repeated record as a newly observed occurrence.

Limit: SQL keys identify records. They do not independently individuate real-world events.

## EV01 — hasResult / inverse recordsExecution endpoint types and native multiplicities

```text
forall e,r: hasResult(e,r) <-> recordsExecution(r,e)
```

```text
forall e: TestExecution(e) -> exists! r: TestResult(r) and hasResult(e,r)
```

```text
forall r: TestResult(r) -> exists! e: TestExecution(e) and recordsExecution(r,e)
```

```text
forall x,y: R["REL:W2:091"](x,y) => (C["IC:TestExecution"](x) and C["IC:TestResult"](y))
```

```text
forall x: C["IC:TestExecution"](x) => 1 <= card{y | R["REL:W2:091"](x,y)} <= 1
```

```text
forall y: C["IC:TestResult"](y) => 1 <= card{x | R["REL:W2:091"](x,y)} <= 1
```

| Mechanism | Scope |
| --- | --- |
| OWL | Mapped predicate domain/range and retained forward/inverse restrictions; see extracted triples. |
| SHACL | Both incident endpoints are targeted; typed endpoints and min/max counts. |
| SQL | Retained table link_records_execution; new bounded SQL count/type validation. |
| History/policy | Admission requires both SQL and SHACL; stored completed-event payload is immutable. |

Example: A consolidated report recorded after the concluded attempt.

Counterexample: One consolidated result bound to two attempts, or an attempt without its required result.

Limit: hasResult is a native display association mapped by inversion to recordsExecution; no new owl:inverseOf property is invented. It asserts documentation, not contemporaneous creation or causation. Multiple source logs remain possible.

## EV02 — executes endpoint types and native multiplicities

```text
forall x,y: R["REL:W2:090"](x,y) => (C["IC:TestExecution"](x) and C["IC:TestCase"](y))
```

```text
forall x: C["IC:TestExecution"](x) => 1 <= card{y | R["REL:W2:090"](x,y)} <= 1
```

```text
forall y: C["IC:TestCase"](y) => 0 <= card{x | R["REL:W2:090"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Mapped predicate domain/range and retained forward/inverse restrictions; see extracted triples. |
| SHACL | Both incident endpoints are targeted; typed endpoints and min/max counts. |
| SQL | Retained table link_executes; new bounded SQL count/type validation. |
| History/policy | Admission requires both SQL and SHACL; stored completed-event payload is immutable. |

Example: One concluded attempt has one declared test-case binding.

Counterexample: One attempt explicitly bound to two cases, or a case of the wrong type.

Limit: A declared binding does not establish that every specified test step occurred.

## EV03 — hasRecordedExecution endpoint types and native multiplicities

```text
forall x,y: R["REL:W2:147"](x,y) => (C["IC:TestSuiteSpecification"](x) and C["IC:TestExecution"](y))
```

```text
forall x: C["IC:TestSuiteSpecification"](x) => 0 <= card{y | R["REL:W2:147"](x,y)}
```

```text
forall y: C["IC:TestExecution"](y) => 0 <= card{x | R["REL:W2:147"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Mapped predicate domain/range and retained forward/inverse restrictions; see extracted triples. |
| SHACL | Both incident endpoints are targeted; typed endpoints and min/max counts. |
| SQL | Retained table link_r147_has_recorded_execution; new bounded SQL count/type validation. |
| History/policy | Admission requires both SQL and SHACL; stored completed-event payload is immutable. |

Example: A suite can index an attempt of one of its contained cases.

Counterexample: The indexing suite does not contain the executed case.

Limit: The index is a recorded association, not proof of suite-wide execution; full suite identity is outside this profile.

## EV04 — testsRealization endpoint types and native multiplicities

```text
forall x,y: R["ICREL:CP:testsRealization"](x,y) => (C["IC:TestExecution"](x) and C["IC:ProductRealization"](y))
```

```text
forall x: C["IC:TestExecution"](x) => 1 <= card{y | R["ICREL:CP:testsRealization"](x,y)} <= 1
```

```text
forall y: C["IC:ProductRealization"](y) => 0 <= card{x | R["ICREL:CP:testsRealization"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Mapped predicate domain/range and retained forward/inverse restrictions; see extracted triples. |
| SHACL | Both incident endpoints are targeted; typed endpoints and min/max counts. |
| SQL | Retained table link_tests_realization; new bounded SQL count/type validation. |
| History/policy | Admission requires both SQL and SHACL; stored completed-event payload is immutable. |

Example: The attempt has one declared realization target.

Counterexample: The target is absent, multiply bound or incorrectly typed.

Limit: testsRealization records the declared target. It does not entail actual participation; setup-only aborts explicitly leave participation unestablished.

## EV05 — assessesSpecification endpoint types and native multiplicities

```text
forall x,y: R["ICREL:CP:assessesSpecification"](x,y) => (C["IC:TestExecution"](x) and C["IC:CapabilitySpecification"](y))
```

```text
forall x: C["IC:TestExecution"](x) => 1 <= card{y | R["ICREL:CP:assessesSpecification"](x,y)}
```

```text
forall y: C["IC:CapabilitySpecification"](y) => 0 <= card{x | R["ICREL:CP:assessesSpecification"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Mapped predicate domain/range and retained forward/inverse restrictions; see extracted triples. |
| SHACL | Both incident endpoints are targeted; typed endpoints and min/max counts. |
| SQL | Retained table link_assesses_specification; new bounded SQL count/type validation. |
| History/policy | Admission requires both SQL and SHACL; stored completed-event payload is immutable. |

Example: An attempt identifies its declared assessment scope.

Counterexample: Missing or incorrectly typed assessment scope.

Limit: Binding a specification does not imply that it was evaluated, satisfied or successfully tested.

## EV06 — executionContext endpoint types and native multiplicities

```text
forall x,y: R["REL:ORSD05:executionContext"](x,y) => (C["IC:TestExecution"](x) and C["IC:AssessmentContextSpecification"](y))
```

```text
forall x: C["IC:TestExecution"](x) => 1 <= card{y | R["REL:ORSD05:executionContext"](x,y)} <= 1
```

```text
forall y: C["IC:AssessmentContextSpecification"](y) => 0 <= card{x | R["REL:ORSD05:executionContext"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Mapped predicate domain/range and retained forward/inverse restrictions; see extracted triples. |
| SHACL | Both incident endpoints are targeted; typed endpoints and min/max counts. |
| SQL | Retained table link_execution_context; new bounded SQL count/type validation. |
| History/policy | Admission requires both SQL and SHACL; stored completed-event payload is immutable. |

Example: One documented assessment-context binding.

Counterexample: Missing, multiply bound or incorrectly typed context.

Limit: A context document is not proof of actual environmental conditions.

## EV07 — executionCriterion endpoint types and native multiplicities

```text
forall x,y: R["REL:ORSD05:executionCriterion"](x,y) => (C["IC:TestExecution"](x) and C["IC:ConditionSpecification"](y))
```

```text
forall x: C["IC:TestExecution"](x) => 1 <= card{y | R["REL:ORSD05:executionCriterion"](x,y)}
```

```text
forall y: C["IC:ConditionSpecification"](y) => 0 <= card{x | R["REL:ORSD05:executionCriterion"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Mapped predicate domain/range and retained forward/inverse restrictions; see extracted triples. |
| SHACL | Both incident endpoints are targeted; typed endpoints and min/max counts. |
| SQL | Retained table link_execution_criterion; new bounded SQL count/type validation. |
| History/policy | Admission requires both SQL and SHACL; stored completed-event payload is immutable. |

Example: At least one typed declared assessment criterion.

Counterexample: Missing or incorrectly typed criterion.

Limit: No automatic propagation to other specifications or success entailment.

## EV08 — One known observed end; start explicitly known or unknown; timezone-qualified recorded times

```text
For each admitted concluded attempt e: count(end(e))=1; each supplied time satisfies the declared timezone/calendar envelope.
```

```text
knownStart(e) => count(start(e))=1; unknownStart(e) => count(start(e))=0
```

```text
start(e) and end(e) supplied => start(e)<=end(e)
```

| Mechanism | Scope |
| --- | --- |
| OWL | Functional executionEndedAt dateTime; no explicit minimum in inspected OWL. |
| SHACL | Occurrence shape requires start knowledge, provenance and conditional start count; SQL path additionally validates calendar and timezone envelope. |
| SQL | occurrence_profile.sql_check enforces counts, supplied timestamp envelope, timezone, known-start ordering and provenance fields; base gate adds native population checks. |
| History/policy | NOT NULL, validity check and immutable stored time. |

Example: Known start precedes the observed end; an unknown start is absent.

Counterexample: Invented start for unknown knowledge, reversed times, missing end or missing timezone.

Limit: The selected OWL profile declares end as functional but does not enforce the operational minimum or time ordering. SHACL and the SQL/Python envelope have explicitly different coverage. Full XSD lexical space, unknown-end events and general event lifecycles are not claimed.

## EV09 — Tested realization has a typed single version

```text
testsRealization(e,r) => exists! v: ProductVersion(v) and realizesVersion(r,v)
```

```text
forall x,y: R["ICREL:CP:realizesVersion"](x,y) => (C["IC:ProductRealization"](x) and C["IC:ProductVersion"](y))
```

```text
forall x: C["IC:ProductRealization"](x) => 1 <= card{y | R["ICREL:CP:realizesVersion"](x,y)} <= 1
```

```text
forall y: C["IC:ProductVersion"](y) => 0 <= card{x | R["ICREL:CP:realizesVersion"](x,y)}
```

| Mechanism | Scope |
| --- | --- |
| OWL | Retained realizesVersion class/cardinality restrictions. |
| SHACL | v0.34 adds property-based target and one typed version. |
| SQL | v0.34 counts and endpoint types; old event validator lacked these supporting checks. |
| History/policy | Admission checks current snapshot and historical realization/version binding. |

Example: The declared target has one typed version.

Counterexample: A target without a version, or with conflicting explicit bindings.

Limit: The realization/version link does not establish baseline satisfaction.

## EV10 — Assessed specification belongs to tested version

```text
testsRealization(e,r) and assessesSpecification(e,s) => exists v: realizesVersion(r,v) and specifiesCapability(v,s)
```

| Mechanism | Scope |
| --- | --- |
| OWL | Individual predicates present; no inspected property-chain enforcement claimed. |
| SHACL | Retained SPARQL same-version constraint. |
| SQL | Retained bounded join query, rerun in v0.34. |
| History/policy | Checked at admission and retained in immutable declared snapshot. |

Example: The assessed capability specification is declared by the target version.

Counterexample: An assessed capability belongs to a different version.

Limit: A selected graph/SQL join contract; no truth, achieved capability or test success follows.

## EV11 — Indexing suite contains the executed case

```text
hasRecordedExecution(suite,e) and executes(e,c) => containsCase(suite,c)
```

| Mechanism | Scope |
| --- | --- |
| OWL | Predicates present; no general closure inference claimed. |
| SHACL | Retained suite-membership SPARQL constraint. |
| SQL | Retained bounded join query, rerun in v0.34. |
| History/policy | Admission preserves explicit membership evidence. |

Example: Suite contains the case of the indexed attempt.

Counterexample: Indexing an attempt whose case is not contained.

Limit: Adding a later index must not rewrite the accepted event snapshot. This is not a general mereological or temporal suite theory.

## EV12 — No automatic criterion propagation or success entailment

```text
No axiom or operational rule propagates a declared criterion to an unrelated assessed item.
```

```text
recordsExecution(result,event) does not entail passed(result).
```

| Mechanism | Scope |
| --- | --- |
| OWL | No additional composition/satisfaction axiom added. |
| SHACL | Only explicit checked criteria counted. |
| SQL | No implicit closure added. |
| History/policy | Stores declarations only; unsuccessful/aborted concluded runs remain valid. |

Example: An inconclusive or aborted result documents an attempt.

Counterexample: Infer success from the existence of a result or criterion link.

Limit: These are inference exclusions and controlled probes, not a proof against all possible downstream rules.

## LG01 — Completed record cannot be renamed, rebound or erased

```text
Accepted(snapshot) => storedGraph(snapshot) is immutable under the supported admission API.
```

```text
Correction => AppendSourcedObservation; accepted occurrence remains unchanged.
```

| Mechanism | Scope |
| --- | --- |
| OWL | OWL does not enforce database history. |
| SHACL | Snapshot checks do not protect past records. |
| SQL | Old snapshot DDL is not an event history store. |
| History/policy | Accepted occurrence and historical bindings remain protected; append_observation records a sourced correction assertion without mutating accepted occurrence. |

Example: Append a sourced superseding observation without changing the accepted graph.

Counterexample: UPDATE, DELETE, replacement or rebinding of an accepted record.

Limit: Operational invariants, not OWL axioms. Database-owner/schema changes and external tampering remain outside the protection.

## LG02 — Replay is idempotent; conflicting replay is rejected

```text
Admit(id,G); Admit(id,G) => idempotent receipt and no state mutation.
```

```text
Admit(id,G); Admit(id,H) with H != G under recorded graph equivalence => reject and rollback.
```

| Mechanism | Scope |
| --- | --- |
| OWL | Not an OWL identity inference. |
| SHACL | Duplicate graph statements have set semantics. |
| SQL | Duplicate inputs normalized before primary-key insertion. |
| History/policy | Same normalized graph fields accepted; changed payload rejected. |

Example: Replay the same admitted graph.

Counterexample: Reuse a snapshot identifier with a changed payload.

Limit: Graph equivalence and record identity are not real-world event identity. Literal normalization is explicitly bounded.

## LG03 — Persistence survives close/reopen

```text
Export(Reopen(Persist(Admit(G)))) is RDF-isomorphic to G for the selected profile.
```

| Mechanism | Scope |
| --- | --- |
| OWL | Not applicable. |
| SHACL | Revalidation still available. |
| SQL | File-backed SQLite used in the test. |
| History/policy | Stored record reloaded; conflicting rebind remains rejected. |

Example: Close, reopen and reconstruct the accepted population.

Counterexample: Stored graph differs from the receipt hash or count.

Limit: A finite persistence probe, not a production durability, concurrency or fault-recovery benchmark.

## INT01 — OWL/native/SHACL/SQL identifiers are explicitly mapped

```text
For each mapped native signature: preserve identifier, direction, endpoint type and bound.
```

```text
For selected admitted population G: Export(Import(G)) is RDF-isomorphic to G.
```

| Mechanism | Scope |
| --- | --- |
| OWL | Retained formal predicates differ from native-contract URNs. |
| SHACL | Event URNs encode native IDs; identity shapes use the retained formal namespace. |
| SQL | Eleven selected relations mapped to physical tables, including inversions. |
| History/policy | New ledger local node IDs are scoped record identifiers; no automatic universal equivalence. |

Example: 37 baseline and 46 revised occurrence triples reconstruct without dropped input.

Counterexample: Unmapped predicates, missing types, inverse-direction mistakes or historical rebinding.

Limit: Static inventory mapping is complete for the declared source; executed reconstruction is selected. It does not establish whole-population equivalence, complete UFO semantics or production deployment.

## OPEN01 — Full modal/Event semantics and independent acceptance

```text
No complete modal, causal or counterfactual UFO theory is asserted.
```

| Mechanism | Scope |
| --- | --- |
| OWL | Bounded operational profile only. |
| SHACL | No independent conceptual adequacy proof. |
| SQL | No scientific acceptance proof. |
| History/policy | No independent observation truth established. |

Example: Each reported result retains its input, method and scope.

Counterexample: Treat passing tests or author approval as independent conceptual acceptance.

Limit: Independent reviewers, external owner/IRI acceptance, full event causality and modal dependence remain deferred scientific work.
