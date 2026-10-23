# OntoSPK v2.0.2 — Expanded finite evaluation

This release completes the finite evaluation increment for **ontology core v2.0.0**. The native model and bounded logical profile retain their original bytes, identifiers and hashes. It adds tests, execution evidence, finding decisions and current documentation.

[Closeout and traceability](https://github.com/ArazSaieArasi3/OntoSPK/blob/v2.0.2/evaluation/v2.0.2-closeout.md) · [Current evaluation portal](https://arazsaiearasi3.github.io/OntoSPK/current/evaluation/index.html)

- All 1,977 SHACL component occurrences are accounted for: 1,864 simple and 113 complex. The 110 logically unreachable simple negative cases are explicitly excluded from negative passes. Complex controls include 449 observations, 244 inverse property projections and 42 complete native event fixtures.
- OWL 2 DL validation and TBox consistency pass. All 121 named classes are satisfiable. Seventy-one expanded HermiT scenarios match expected consistency/entailment outcomes, including exact cardinality, disjointness, domain/range, equality, open-world omissions and inference exclusions.
- All 56 CQ contracts pass 374 exact-answer comparisons. Of 9,128 controlled data mutation probes, 1,314 change the expected answer and 7,814 survive; all observations are retained and every CQ detects at least one mutation. These are no-inference query tests, not an OWL completeness or domain-validation score.
- Eight retained core stages were freshly executed in isolation. The original native SDK/validator acceptance remains historical; it is not claimed newly executed.
- **The unfiltered default ROBOT report is not clean:** 812 findings remain (288 ERROR, 451 WARN, 73 INFO), concerning labels, definitions, hierarchy conventions and ontology-header metadata. Each is retained and adjudicated; the follow-up is [issue #44](https://github.com/ArazSaieArasi3/OntoSPK/issues/44). No definitions, equivalences or licence assertions were invented to remove findings.

There are zero unexplained positive-baseline failures and zero unaccounted SHACL components in the declared test scope. The 22 commitments have explicit method/scope traceability. This does not establish universal semantic correctness, full UFO modal/causal adequacy, external-owner acceptance, independent domain validation or production readiness. External-contract work and later scientific/metadata review remain separate follow-ups.

The release archive contains the **tagged, locally executed receipts** and reproducible runners. The successful release workflow separately reruns the controls and retains its fresh CI receipts as an Actions artifact. Machine-specific execution times/tool-environment details can differ; source identities and acceptance gates remain fixed. The manifest binds the archive to the exact public commit and the unchanged native/logical inputs. Documentation v2.0.1 remains frozen; the current portal includes this evaluation increment.
