# Publication-boundary review

Review date: 22 October 2026. Candidate reviewed: `df96c940e83ff333ee149ad93d8b5f5cf2c6b88a`. This report is a finite publication inspection, not a general certificate of confidentiality or a legal opinion.

## Observed results

| Inspection | Observed result | Interpretation |
| --- | --- | --- |
| Current-tree static publication checks | PASS; 450 local links, zero reported errors before this documentation increment | Checks source identity, evidence digests, navigation and configured content patterns. This is not browser or live-site acceptance. |
| Frozen native and bounded logical identity | Both recorded SHA-256 values match | The migration has not renamed or silently changed the fixed model. |
| Historical scope | Six reachable commits across the default and migration histories; 697 unique blobs | The history was fetched and inspected without importing a private Git history. Exact reviewed commits are in the JSON companion. |
| Configured historical disclosure scan | 694 text blobs; zero matches outside the checker configuration | The finite patterns cover known disclosure strings, private-key markers, common token forms and local workspace paths. Absence of these matches is not proof that every possible secret or confidential statement is absent. |
| Binary history | Three blobs were not text scanned | Historical synthetic database material is disclosed separately; this scan does not claim binary-content certification. |
| Current implementation payload | Physical database directory and SQL/SQLite downloads absent | Finite SQL admission fixtures remain test aids. No database or Explorer application is part of this core release. |
| Historical payload | Earlier public commits retain synthetic implementation material and the removed external owner snapshot | Current-tree cleanup does not erase history. The remaining third-party historical redistribution question is assigned to the rights review below. |
| Native external metadata | 27 handles; 17 preserved class locators use a private research namespace | Public access, observed declaration and accepted equivalence are different facts. The complete register and its limits are linked below. |

## Findings and disposition

1. **Private namespace locators.** Preserve the frozen native model and disclose all 27 reference states in the [external-reference register](../../guide/External-References.md). The namespace repository is private at the authenticated metadata readback on the review date. No public owner-approved equivalence is claimed. Owner-specific decisions are separately tracked in issues #23–#27.
2. **Historical third-party material.** The old owner snapshot remains reachable in public history. Record its exact historical scope and permission state in the [rights review](https://github.com/ArazSaieArasi3/OntoSPK/issues/4). Removing the current copy does not resolve this historical question. Do not describe the current migration as history erasure.
3. **Bundled documentation assets.** Existing notices cover WebVOWL, D3, Lodash and WIDOCO at component level. The WIDOCO resource directory additionally carries jQuery, marked, a Google dark-mode module and a W3C stylesheet with individual licence/copyright headers. The rights issue must reconcile those files, retained headers, complete licence notices and source identities before release acceptance.
4. **No project-wide reuse grant.** [LICENSING.md](../../../LICENSING.md) states the actual position. Public inspection does not create an asserted blanket grant; no new licence or DOI is selected by this review.
5. **Execution boundary.** The expanded SHACL/HermiT program remains planned. The release gate uses the disclosed bounded baseline and checks on the final public candidate, as tracked in [#5](https://github.com/ArazSaieArasi3/OntoSPK/issues/5).

## Evidence and acceptance

- [Machine-readable inspection result and exact historical commit set](../../../evaluation/publication-boundary-review.json)
- [Static publication checker](../../../tools/publication/check_publication.py)
- [External-reference register](../../guide/External-References.md)
- [Release plan and issue register](../../development/release-plan.md)

The publication-boundary inspection is complete within the stated scope. Release approval remains conditional on disposition of the rights findings and final-candidate evidence. No Wiki deployment, Pages deployment, browser acceptance, independent expert review or comprehensive semantic verification is inferred from this inspection.
