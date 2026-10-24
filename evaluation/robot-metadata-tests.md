# Annotated metadata view — executed acceptance

**492 of 812 default findings are resolved; 320 remain explicit.** The unmodified ROBOT 1.9.11 report is executed before and after, with default exit 1 on both. No profile override, severity change, result filter or suppressed row is used. This is not a clean default-report claim.

| Level | Frozen core | Annotated view |
| --- | ---: | ---: |
| ERROR | 288 | 34 |
| WARN | 451 | 213 |
| INFO | 73 | 73 |

The retained findings are 33 duplicate boundary labels, 213 missing definitions/elucidations, 73 superclass conventions and one missing project licence. There are zero new findings. Each of all 812 original rows has an exact review decision matching its actual before/after presence.

OWLAPI independently compares all parsed logical axioms and class/object/data-property signatures: they are equal. A deliberately added subclass axiom is rejected by this guard. Annotation-only stability, forbidden boundary-label mutation and unapproved-licence contrasts are exercised in memory/temp files only. The annotated view passes OWL 2 DL and fresh HermiT consistency/satisfiability checks for all 121 named classes.

All 56 retained CQ contracts match their source-bound expected answers in 374 fresh comparisons (fixture-only and fixture plus annotated profile, with no inference). The core suite, including 71 HermiT scenarios, all SHACL controls and CQ mutation observations, remains independently rerun in expanded CI. These overlapping counts are not added as coverage.

All 69 boundary declaration/relation subjects retain every outgoing assertion. No hierarchy, identity, equivalence, restriction, import, licence, class, object-property or data-property signature is changed. Full scientific/native-profile acceptance, external owner equivalence and production readiness are not established.

[Exact commands, raw findings, source hashes and CQ answers](robot-metadata-tests.json.gz) · [Individual review decisions and sources](robot-metadata-review.md)
