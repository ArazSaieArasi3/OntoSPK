# Remaining metadata findings and publication readiness

All **318 retained v2.0.5 findings** are reconciled individually with their original severity, exact source IRI, disposition and follow-up. This v2.0.8 accounting resolves no additional ROBOT rows and does not change the released annotation artifact. The default report still exits 1: **34 ERROR, 211 WARN and 73 INFO**. Successful publication checks do not make it a clean report.

| Disposition | Rows | Next action |
| --- | ---: | --- |
| Owner-held declarations and relations | 122 | Keep accepted reference-only use; review applicable external contracts in #25–#27 only when resumed. No external equivalence is inferred. |
| Unsupported local property definitions | 142 | Carry into #37's source/scope discussion. Existing names and endpoints do not justify inventing definitions. Relation work needs an explicit reviewed scope. |
| Authored local roots | 53 | Preserve 52 kinds and one category without authored parents. Adding superclass axioms merely to silence an OBO-style convention would change semantics. |
| Project reuse licence unselected | 1 | Resolve rights-holder authority and licence/deposit metadata in #29. No grant is invented. |

The rule totals are 33 duplicate labels, 211 missing definitions/elucidations, 73 superclass conventions and one missing licence. These are a different grouping of the same 318 rows, not extra findings. Duplicate external labels remain unchanged; the reader search now disambiguates exact native identifiers without renaming their ontology declarations.

## DOI and rights prerequisites

The consolidated v2.0.8 archive is intended to include PC-01 and the documentation corrections. The release record and its exact tag/manifest determine whether that archive has actually been published; a prepared source tree is not a completed deposit. The earlier v2.0.7 archive remains valid for its own scope.

Existing rights evidence permits public inspection and retains a narrow historical Market snapshot decision. It does not establish a project-wide reuse licence or authority to relicense all material. Before a real DOI registration, #29 must establish the rights-holder/licence decision, deposit eligibility, verified contributor metadata and actual access to a deposit service. The available connected capabilities were checked during this increment; none exposes a DOI-deposit operation. This is a capability limit, not a claim that the maintainer has no account. No DOI has been assigned by this work.

The current station is complete documentation accounting with explicit publication prerequisites. Independent concept sourcing, held external contracts and a rights decision remain separate work. The native/OWL core, v2.0.5 annotations and historical execution receipts are unchanged.

[Every residual row and source hash](metadata-residual-review.json) · [Historical annotated execution](robot-metadata-tests.md) · [Historical source review](robot-metadata-review.md) · [Current publication handoff](../docs/handbook/publication-handoff.md) · [Rights notice](../LICENSING.md)

Reproduce: `python tools/publication/build_metadata_residual_review.py`. Re-execute the historical default reports without coupling them to the mutable README: `python tools/publication/replay_metadata_baseline.py --robot /path/to/robot.jar`. The helper checks out the exact v2.0.5 source in an isolated build directory and requires byte-identical released results; it does not overwrite them.
