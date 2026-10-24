"""Reconcile every retained ROBOT row with an explicit follow-up and limit."""
from collections import Counter
import gzip
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
KEYS = ('Level', 'Rule Name', 'Subject', 'Property', 'Value')
INPUTS = ['evaluation/robot-metadata-review.json.gz', 'evaluation/robot-metadata-tests.json.gz', 'LICENSING.md']


def reconcile(review, tests):
    key = lambda row: tuple(row[k] for k in KEYS)
    decisions = {key(r): r for r in review['findings']}
    rows = []
    assert len(decisions) == 812 and len(tests['after']) == 318
    for finding in tests['after']:
        source = decisions[key(finding)]
        assert source['decision'] != 'ANNOTATION_REPAIRED'
        decision = source['decision']
        if decision == 'RETAIN_OWNER_HELD_BOUNDARY':
            route = 'Owner-held contract review; #25–#27 where applicable; accepted Business/Market reference-only policies otherwise.'
        elif decision == 'RETAIN_UNSOURCED_DEFINITION':
            route = '#37 source/page schema discussion; relation definitions require an explicit scope decision before a separate reviewed increment.'
        elif decision == 'RETAIN_NO_LICENCE_SELECTED':
            route = '#29 rights-holder decision and actual deposit-service access; no licence grant is inferred.'
        else:
            assert decision == 'RETAIN_AUTHORED_ROOT'
            route = 'Retain authored native root; revisit only with justified semantic hierarchy change, not to satisfy an OBO convention.'
        rows.append({**{k: finding[k] for k in KEYS}, 'scope': source['scope'],
                     'decision': decision, 'rationale': source['rationale'], 'follow_up': route,
                     'resolved': False})
    assert Counter(r['Level'] for r in rows) == {'ERROR': 34, 'WARN': 211, 'INFO': 73}
    assert Counter(r['decision'] for r in rows) == {
        'RETAIN_OWNER_HELD_BOUNDARY': 122, 'RETAIN_UNSOURCED_DEFINITION': 142,
        'RETAIN_AUTHORED_ROOT': 53, 'RETAIN_NO_LICENCE_SELECTED': 1}
    return rows


def build():
    read = lambda name: json.loads(gzip.decompress((ROOT/name).read_bytes()))
    rows = reconcile(read(INPUTS[0]), read(INPUTS[1]))
    result = {'status': 'PASS_RESIDUAL_ACCOUNTING_NOT_CLEAN_REPORT', 'release_increment': 'v2.0.8',
              'source_release': 'v2.0.5', 'retained_findings': 318, 'resolved_in_this_increment': 0,
              'counts': dict(Counter(r['Level'] for r in rows)),
              'rules': dict(Counter(r['Rule Name'] for r in rows)),
              'decisions': dict(Counter(r['decision'] for r in rows)),
              'source_sha256': {name: hashlib.sha256((ROOT/name).read_bytes()).hexdigest() for name in INPUTS},
              'default_report_clean': False, 'default_exit': 1,
              'doi_registered': False, 'project_licence_selected': False,
              'rights_evidence': 'Public inspection and narrow historical snapshot permission only; no project-wide reuse grant.',
              'registration_prerequisites': ['Exact immutable archive including PC-01', 'Rights-holder authority and project licence decision', 'Deposit eligibility and contributor metadata', 'Actual deposit service access and returned DOI landing page'],
              'findings': rows}
    (ROOT/'evaluation/metadata-residual-review.json').write_text(json.dumps(result, indent=2)+'\n')
    text = '''# Remaining metadata findings and publication readiness

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
'''
    (ROOT/'evaluation/metadata-residual-review.md').write_text(text)
    print(json.dumps({k: v for k, v in result.items() if k != 'findings'}))


if __name__ == '__main__':
    build()
