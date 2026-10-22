"""Describe preserved external-reference metadata without changing the native model."""
from collections import Counter
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / 'semantic/product/v2/source/formalization/Native_Model_v0_41_0.json'
digest = hashlib.sha256(SOURCE.read_bytes()).hexdigest()
assert digest == 'b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
model = json.loads(SOURCE.read_text())
rows = []
for element in model['elements']:
    props = element.get('customProperties') or {}
    if element.get('type') != 'Class' or not props.get('external_target_stub'):
        continue
    review = props.get('v0_16_boundary_review') or {}
    contract = props.get('v0_17_boundary_contract') or {}
    rows.append({
        'native_id': element['id'],
        'owner_family': element['id'].split(':')[1],
        'recorded_declaration_status': review.get('declaration_status'),
        'recorded_owner_repository': review.get('owner_repository'),
        'recorded_owner_commit': review.get('owner_commit'),
        'recorded_declaration_iri': review.get('verified_declaration_iri') or None,
        'recorded_class_locator': contract.get('owner_class_locator') or None,
        'recorded_target_iri_status': props.get('target_iri_status'),
        'recorded_equivalence_status': contract.get('semantic_equivalence'),
        'public_owner_alignment_accepted': False,
    })
rows.sort(key=lambda row: row['native_id'])
counts = dict(Counter(row['recorded_declaration_status'] for row in rows))
assert len(rows) == 27
assert counts == {
    'EXACT_NAME_CLASS_DECLARATION_VERIFIED': 16,
    'RENAMED_TARGET_CANDIDATE': 1,
    'OWNER_CONTRACT_UNRESOLVED': 7,
    'CLASS_NOT_DECLARED_IN_PINNED_OWNER': 2,
    'COMPOSITE_TARGET_REQUIRES_SEPARATION': 1,
}
assert sum(bool(row['recorded_class_locator']) for row in rows) == 17
assert all(row['recorded_equivalence_status'] == 'NOT_ASSERTED' for row in rows)
result = {
    'native_sha256': digest,
    'scope': 'Recorded native metadata; not fresh validation of external ontology declarations.',
    'external_handles': len(rows), 'declaration_status_counts': counts,
    'recorded_class_locators': 17, 'recorded_exact_name_declarations': 16,
    'namespace_repository_visibility': 'private at authenticated repository-metadata readback on 2026-10-22',
    'namespace_public_resolvability': 'not established; do not treat namespace IRIs as public download URLs',
    'rows': rows,
}
output = ROOT / 'evaluation/external-boundary-status.json'
output.write_text(json.dumps(result, indent=2) + '\n')
parts = [
    '# External references and ownership boundaries\n',
    'The native model contains 27 reference-only external handles. They retain conceptual boundaries without importing an owner ontology or asserting class equivalence. This page explains preserved metadata; it does not repeat the historical owner-snapshot inspection as a new experiment.\n',
    '## How to read the recorded evidence\n',
    'Sixteen records contain `EXACT_NAME_CLASS_DECLARATION_VERIFIED`: the earlier review observed a same-name class declaration in a pinned owner snapshot. The field `verified_declaration_iri` records that historical declaration evidence. It does **not** mean that the IRI is publicly dereferenceable, that definitions are equivalent, that UFO types have been accepted, or that an external owner approved an alignment. All 27 records retain `target_iri_status: NOT_VERIFIED` and `semantic_equivalence: NOT_ASSERTED`.\n',
    'Seventeen records have an `owner_class_locator`; one of these is only the Business `Service` to `BusinessService` rename candidate. All 17 use a namespace under a separately governed research repository. An authenticated repository-metadata readback on 22 October 2026 reports that namespace repository as private. These namespace strings are preserved as identifiers and evidence locators, not advertised as public file-download links. Public readers cannot be expected to reproduce the private owner-snapshot inspection from these locators.\n',
    '## Decisions for the fixed core\n',
    '- Preserve the native model and logical-profile identities in the public core.\n- Disclose inaccessible or unresolved evidence instead of presenting a broken public link as accepted alignment.\n- Keep private owner payloads outside the distribution; use explicitly synthetic boundary fixtures for the disclosed local revision tests.\n- Resolve each owner contract through the linked follow-ups. If accepted work changes native metadata or semantics, publish a new version and explain the change; never replace the frozen release silently.\n',
    '## Complete register\n',
    '| Handle | Recorded declaration status | Recorded class locator |\n| --- | --- | --- |',
]
for row in rows:
    locator = '`' + row['recorded_class_locator'] + '`' if row['recorded_class_locator'] else 'No recorded exact locator'
    parts.append(f"| `{row['native_id']}` | `{row['recorded_declaration_status']}` | {locator} |")
parts += [
    '\n## Follow-up decisions\n',
    'Business: [#23](https://github.com/ArazSaieArasi3/OntoSPK/issues/23); Market: [#24](https://github.com/ArazSaieArasi3/OntoSPK/issues/24); ProductLine: [#25](https://github.com/ArazSaieArasi3/OntoSPK/issues/25); Architecture: [#26](https://github.com/ArazSaieArasi3/OntoSPK/issues/26); unresolved and composite targets: [#27](https://github.com/ArazSaieArasi3/OntoSPK/issues/27). None is relabeled as completed external-owner acceptance.\n',
    '## Sources and reproduction\n',
    '- [Frozen native model](../../semantic/product/v2/source/formalization/Native_Model_v0_41_0.json)\n- [Machine-readable register with owner snapshot identifiers](../../evaluation/external-boundary-status.json)\n- [Generator](../../tools/publication/build_external_boundary_report.py)\n- [Quality evidence and limits](Quality.md)\n- [Release plan](../development/release-plan.md)\n',
    'Run `python tools/publication/build_external_boundary_report.py` from the repository root. The script checks the native digest and category totals and produces this page and its JSON companion. The visibility observation is a separately recorded metadata readback, not a network request performed by this generator.\n',
]
(ROOT / 'docs/guide/External-References.md').write_text('\n'.join(parts))
assert hashlib.sha256(SOURCE.read_bytes()).hexdigest() == digest
print(json.dumps({'external_handles': len(rows), 'class_locators': 17, 'native_identity_preserved': True}))
