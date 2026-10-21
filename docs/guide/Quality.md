# Evaluation and reasoning

The current evidence consists of finite synthetic controls and exact-source checks. It reports what was executed, the input baseline, tool versions, expected outcomes, observed outcomes and limitations.

| Method | Evaluated scope |
| --- | --- |
| Structural reconciliation | 892 registered expressions compared with the native structure. |
| Combined admission | 42 bounded population and admission controls. |
| Revision controls | 146 regression and occurrence/history controls. |
| Competency questions | 374 exact-answer comparisons across 56 contracts and 187 fixtures. |
| Project-owned rules | 80 rule, applicability and adapter controls. |
| Upstream validator | Direct execution of the 13 implemented class-rule functions. |
| OntoUML SDK | Pinned-source serialization and fidelity controls. |
| OWL/HermiT | 13 reasoner cases and four open-/closed-world contrast controls. |

These denominators overlap and must not be summed as independent observations. Fifty-eight of the 71 declared upstream validator rules are unimplemented. The evaluated direct-call harness retains 54 warnings and reports no errors in its implemented functions. This does not constitute a complete upstream whole-model validation.

The [execution receipt](../../evaluation/results/INTEGRATION_RESULTS.json) and method-specific reports record the current local run. Command paths in the published receipt are normalized to repository-relative paths and named external-tool placeholders for portability; outcomes are not changed. Successful local execution and successful remote CI are separate statuses.

The full recorded integration includes a finite SQL admission harness; this is a test of supplied synthetic records, not a public database distribution or a claim about a production implementation. The public ontology core excludes the physical database.

Independent semantic/domain review, external-owner acceptance and production deployment remain outside these results. See [Limitations](Limitations.md) and [Reproduce](Reproduce.md).
