"""Detect profile drift and distinguish native abstractness from OWL typing."""
import copy
import json
from build_capability_profile_review import NATIVE, ROOT, review, structural_findings

model = json.loads(NATIVE.read_text())
baseline = review()
assert baseline == json.loads((ROOT/'evaluation/capability-profile-review.json').read_text())
assert baseline['structural_comparison']['ancestors'] == []
assert baseline['structural_comparison']['descendants'] == []

def mutate(change):
    data = copy.deepcopy(model)
    elements = {e['id']: e for e in data['elements']}
    change(data, elements)
    return structural_findings(data)

faults = {
    'lost_characterization': lambda m, e: e['ICREL:CP:bearsCapability'].update(stereotype=None),
    'optional_bearer': lambda m, e: e['ICEND:CP:bearsCapability:0'].update(cardinality='0..1'),
    'multiple_bearers': lambda m, e: e['ICEND:CP:bearsCapability:0'].update(cardinality='1..*'),
}
for name, parent, child in (
    ('provider_parent', 'IC:Product', 'IC:ProductCapability'),
    ('identity_inheritor_parent', 'IC:RequirementSpecification', 'IC:ProductCapability'),
    ('mixed_descendant', 'IC:ProductCapability', 'IC:EvidenceArtifact'),
    ('cycle', 'IC:ProductCapability', 'IC:ProductCapability'),
):
    faults[name] = lambda m, e, p=parent, c=child: m['elements'].append(
        {'type': 'Generalization', 'id': 'synthetic', 'general': p, 'specific': c})

def anti_parent(m, e):
    m['elements'].extend([{'type': 'Class', 'id': 'synthetic-role', 'stereotype': 'role'},
        {'type': 'Generalization', 'id': 'synthetic', 'general': 'synthetic-role', 'specific': 'IC:ProductCapability'}])
faults['anti_rigid_parent'] = anti_parent
for name, change in faults.items():
    findings = mutate(change)
    expected = {
        'lost_characterization': 'C1_characterization',
        'optional_bearer': 'C2_exactly_one_bearer',
        'multiple_bearers': 'C2_exactly_one_bearer',
        'provider_parent': 'C3_no_provider_ancestor',
        'identity_inheritor_parent': 'C4_no_identity_inheritor_ancestor',
        'mixed_descendant': 'C5_no_mixed_identity_descendant',
        'anti_rigid_parent': 'C6_no_anti_rigid_ancestor',
        'cycle': 'GENERALIZATION_CYCLE',
    }[name]
    assert expected in findings['errors'], (name, findings)

abstract = mutate(lambda m, e: e['IC:ProductCapability'].update(isAbstract=True))
assert abstract['reference_abstractness_matches'] and not abstract['errors']
# Passing the reference's table alone would not create a concrete descendant.
assert abstract['descendants'] == []
# An unsaved, hypothetical specialization shows the missing migration surface.
def specialization(m, e):
    e['IC:ProductCapability']['isAbstract'] = True
    m['elements'].extend([{'type': 'Class', 'id': 'hypothetical', 'stereotype': 'subkind', 'isAbstract': False},
        {'type': 'Generalization', 'id': 'hypothetical-generalization', 'general': 'IC:ProductCapability', 'specific': 'hypothetical'}])
candidate = mutate(specialization)
assert candidate['descendants'] == ['hypothetical'] and not candidate['errors']
# This demonstrates structural possibility only; no domain justification or
# population migration is inferred and no candidate semantic file is written.
assert baseline['migration']['native_changes'] == 0
print(f'PASS: exact baseline, {len(faults)} detected structural faults, abstract-leaf and hypothetical-subkind contrasts')
