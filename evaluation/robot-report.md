# ROBOT execution and finding adjudication

ROBOT 1.9.11 was actually executed for version readback, OWL 2 DL profile validation, HermiT orchestration and its unmodified default report. The profile and reason commands pass. The default report returns exit 1 with **812 findings: 288 ERROR, 451 WARN, 73 INFO**. These are not hidden or relabelled as a clean report.

| Default rule | Findings | Disposition |
| --- | ---: | --- |
| duplicate_label | 41 | Lexical collision across distinct IRIs; not owl:sameAs or a logical contradiction. Retain distinct meanings; review disambiguation in the next metadata increment. |
| missing_definition | 451 | Editorial evidence debt; no definition is invented by this release. Source-backed concept pages remain #37. |
| missing_label | 244 | Editorial metadata debt; identifiers remain authoritative. Add curated source-bound labels only in a new version. |
| missing_ontology_description | 1 | Ontology-header metadata follow-up; repository/guide descriptions do not fill an OWL annotation automatically. |
| missing_ontology_license | 1 | Known rights state: no project-wide reuse licence selected. Do not manufacture a licence axiom. |
| missing_ontology_title | 1 | Ontology-header metadata follow-up; no frozen graph mutation in this evaluation patch. |
| missing_superclass | 73 | Default OBO hierarchy expectation; an undeclared superclass is not proof of logical incoherence. All named classes are checked independently below. |

The default report applies OBO-style editorial conventions. These findings are metadata/hierarchy conventions, not evidence of an inconsistent ontology. No labels, definitions, ontology headers or licence assertions were fabricated to clear them. Future metadata repair requires its own version and source review; this evaluation patch preserves the frozen logical graph. The follow-up is tracked in [issue #44](https://github.com/ArazSaieArasi3/OntoSPK/issues/44).

[Unfiltered findings and exact dispositions](robot-report.json.gz) · [Actual tool commands, exit statuses and outputs](owl-hermit.json.gz)
