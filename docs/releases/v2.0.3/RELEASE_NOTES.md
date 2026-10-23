# OntoSPK v2.0.3 — Boundary preservation and public evidence

This patch records the owner's acceptance of the existing reference-only boundary treatments and completes the current-use Market disposition in issue #24. It incorporates the already accepted Business review from #23. Ontology core v2.0.0 is preserved; no native, OWL, SHACL, identifier, constraint, external mapping or frozen runtime is changed.

- Four named Market references (CustomerSegment, Market, MarketSegment and Need) retain their public operational meanings and all 13 existing native uses.
- All 27 external boundary elements and all 543 tracked semantic files remain identical to frozen v2.0.0. Ninety controlled adverse changes are rejected by the preservation check; four direct runtime calls retain their disclosed legacy `REVIEW_REQUIRED` result. Owner acceptance of current reference use does not invent a typed runtime validator.
- The existing Business evidence retains five local reference contracts, eight native uses, 198 record cases and three CLI controls. No new Market adapter is added.
- Main-branch CI reruns the expanded SHACL, HermiT, CQ and core-regression controls before publication. The release includes the accepted tagged evidence; fresh workflow observations are separately available as an Actions artifact.
- Private sibling repositories are untouched. Their publication, local replacement concepts and new cross-ontology wiring are deferred by owner direction and do not block this patch.

The original external owner-alignment/localization objectives of #24 are superseded for this increment by the preserve-as-is decision. This is completion of the accepted current-use disposition, not a claim that the earlier external investigation was executed.

## Read and reproduce

- [Market decision and executed preservation evidence](https://github.com/ArazSaieArasi3/OntoSPK/blob/v2.0.3/evaluation/market-boundary-preservation.md)
- [Business review](https://github.com/ArazSaieArasi3/OntoSPK/blob/v2.0.3/evaluation/business-boundary-review.md)
- [Full finite evaluation and limitations](https://github.com/ArazSaieArasi3/OntoSPK/blob/v2.0.3/evaluation/v2.0.2-closeout.md)
- [Current evaluation portal](https://arazsaiearasi3.github.io/OntoSPK/current/evaluation/index.html)

Run `python tools/publication/review_market_preservation.py` with the documented dependencies installed and the frozen core commit available. Use the expanded CI workflow to rerun the full evaluation.

The source archive contains the complete tracked public repository at the tag. `RELEASE_MANIFEST.json` binds its checksum, exact source commit, core identities and accepted receipts; `SHA256SUMS.txt` covers the archive and manifest. Published v2.0.0, v2.0.1 and v2.0.2 identities are retained. Frozen documentation v2.0.1 is unchanged; current documentation adds this report. This patch does not create a new frozen Pages route.

## Limits and next work

External equivalence, owner-definition compatibility, UFO typing and independent scientific acceptance remain unclaimed. The default ROBOT report still contains 812 findings (288 ERROR, 451 WARN and 73 INFO), tracked in #44. A patch does not certify scientific completeness or production readiness. The conditional v2.1.0 scientific work remains separate; #25–#27 external rewiring is deferred. The next active local scientific review is #28, excluding deferred owner alignment, followed by the existing metadata, FOL, diagram and publication-evidence follow-ups.

No project-wide reuse licence is newly assigned. Existing licensing and third-party notices remain authoritative.
