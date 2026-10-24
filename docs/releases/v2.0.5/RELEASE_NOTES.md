# OntoSPK v2.0.5 — Source-reviewed editorial annotation view

This patch completes the bounded source review in issue #44 and distributes a separately named annotated OWL view. The ontology core remains v2.0.0; the native model, frozen OWL/SHACL sources, all 543 semantic files, all 27 boundary handles and the versioned documentation registry are unchanged. No sibling/private repository work or cross-ontology rewiring is performed.

## Changes

All 812 original ROBOT findings have exact source IRIs, scope groups, evidence and dispositions. The annotated view adds 244 readable labels from authored IRI tokens, disambiguates eight local relation labels using their declared endpoints/token while retaining old alternatives, copies 101 existing local catalogue definitions, and records 137 authored operational comments as elucidations. For 22 properties sharing comment text, exact existing property tokens qualify the text without inventing a new relational meaning. The public ontology name/scope supply title and description. A distinct OWL version IRI and checksummed standalone download identify this artifact.

## Actual report result

The unmodified ROBOT 1.9.11 default report resolves **492 of 812** original findings, with **320 retained** and **zero new findings**:

| Level | Frozen core | Annotated view |
| --- | ---: | ---: |
| ERROR | 288 | 34 |
| WARN | 451 | 213 |
| INFO | 73 | 73 |

The retained rows are 33 duplicate boundary labels, 213 missing definitions/elucidations, 73 superclass conventions and one missing ontology licence. The command still exits 1. This release does not claim a clean default report. Existing boundary annotations remain unchanged. Unsupported definitions remain visible editorial debt for the separately planned sourced-concept workflow (#37). No project-wide reuse licence is selected or manufactured.

## Verification

OWLAPI compares all parsed logical axioms and logical signatures between core and view; they are equal. RDF comparison independently confirms identity after removing only permitted editorial annotations/version identity. All 69 declared boundary proxy/relation subjects retain every outgoing assertion. A logical mutation, boundary-label mutation and unapproved licence are rejected by the guard; a local annotation-only contrast is accepted. The annotated view passes OWL 2 DL and HermiT consistency with all 121 named classes satisfiable. All 56 CQ contracts pass 374 source-bound exact-answer comparisons against the annotated view and fixture-only scope.

PR and main CI rerun the preserved SHACL/HermiT/CQ/core evaluation and publication gates. The release package binds its complete public source tree, ten evidence receipts, the annotated artifact and their hashes to the accepted main commit. Published assets are independently downloaded and compared with the exact Git source before #44 is closed.

## Reuse and limits

The standalone `OntoSPK-v2.0.5-annotated.ttl` is a complete annotation view, not a replacement mapping, import or model migration. Existing identifiers and logical axioms are preserved; choose the frozen core when reproducing its exact byte identity. WIDOCO/WebVOWL continue to describe their frozen core input. Internally authored definitions/provenance do not imply independent expert/literature acceptance. Profile adjudication remains #48 and the previously disclosed legacy direct-DML limitation remains unchanged. Existing releases and fixed Pages/Wiki snapshots retain their identities.

See `evaluation/robot-metadata-review.md`, `evaluation/robot-metadata-review.json.gz`, `evaluation/robot-metadata-tests.md`, and `evaluation/robot-metadata-tests.json.gz` for every decision, command and observation.
