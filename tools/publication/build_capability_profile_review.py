"""Focused project-profile adjudication, without editing the frozen semantics."""
import argparse
import csv
import json
import subprocess
from rdflib import Graph, RDF, URIRef
from evaluation_common import ROOT, SOURCE, sha, write_json

DECISION = ROOT/'tools/publication/capability-profile-decision.json'
NATIVE = SOURCE/'formalization/Native_Model_v0_41_0.json'
CAP = 'IC:ProductCapability'


def structural_findings(model):
    es = {e['id']: e for e in model['elements']}
    parents, children = {}, {}
    for e in es.values():
        if e['type'] == 'Generalization':
            parents.setdefault(e['specific'], set()).add(e['general'])
            children.setdefault(e['general'], set()).add(e['specific'])
    def closure(i, edges, seen=frozenset()):
        if i in seen:
            raise ValueError('GENERALIZATION_CYCLE')
        return set(edges.get(i, ())) | set().union(*(closure(x, edges, seen | {i}) for x in edges.get(i, ())))
    try:
        ancestors = closure(CAP, parents)
        descendants = closure(CAP, children)
    except ValueError:
        return {'errors': ['GENERALIZATION_CYCLE']}
    providers = {'kind', 'collective', 'quantity', 'quality', 'relator', 'mode'}
    inherited = {'subkind', 'role', 'phase'}
    mixed = {'category', 'roleMixin', 'phaseMixin', 'mixin'}
    anti = {'role', 'roleMixin', 'phase', 'phaseMixin'}
    modes = {CAP} | ancestors
    relations = []
    for r in es.values():
        if r['type'] == 'BinaryRelation' and r.get('stereotype') == 'characterization':
            ends = [es[p] for p in r['properties']]
            if any(e['propertyType'] in modes for e in ends):
                mode_end = next(e for e in ends if e['propertyType'] in modes)
                bearer = next((e for e in ends if e['propertyType'] not in modes), None)
                relations.append({'relation': r['id'], 'mode': mode_end['propertyType'],
                                  'bearer': bearer['propertyType'] if bearer else None,
                                  'bearer_cardinality': bearer['cardinality'] if bearer else None})
    checks = {
        'C1_characterization': bool(relations),
        'C2_exactly_one_bearer': bool(relations) and all(r['bearer_cardinality'] == '1' for r in relations),
        'C3_no_provider_ancestor': not any(es[i]['stereotype'] in providers for i in ancestors),
        'C4_no_identity_inheritor_ancestor': not any(es[i]['stereotype'] in inherited for i in ancestors),
        'C5_no_mixed_identity_descendant': not any(es[i]['stereotype'] in mixed for i in descendants),
        'C6_no_anti_rigid_ancestor': not any(es[i]['stereotype'] in anti for i in ancestors),
    }
    return {'checks': checks, 'errors': [k for k, v in checks.items() if not v],
            'ancestors': sorted(ancestors), 'descendants': sorted(descendants), 'characterizations': relations,
            'reference_abstractness_matches': es[CAP]['isAbstract'] is True}


def review():
    decision = json.loads(DECISION.read_text())
    model = json.loads(NATIVE.read_text())
    es = {e['id']: e for e in model['elements']}
    cap = es[CAP]
    assert decision['status'] == 'ADOPTED_BOUNDED_PROJECT_PROFILE'
    assert decision['strict_reference_conformance'] is False and decision['semantic_migration'] == 'NONE'
    for key in ('isAbstract', 'stereotype', 'restrictedTo'):
        assert cap[key] == decision[key], key
    focused = structural_findings(model)
    assert not focused['errors'] and not focused['reference_abstractness_matches'], focused
    assert focused['ancestors'] == [] and focused['descendants'] == [], 'Reopen PC-01 before introducing a hierarchy'
    assert focused['characterizations'] == [{'relation': 'ICREL:CP:bearsCapability', 'mode': CAP,
          'bearer': 'IC:ProductRealization', 'bearer_cardinality': '1'}]
    projection = ROOT/'semantic/product/v2/reference/native-class-projection.csv'
    mapping = next(r for r in csv.DictReader(projection.open()) if r['native_id'] == CAP)
    assert mapping['mapped_iri'] == 'urn:productium:specification-profile:ProductCapability'
    population = []
    sources = [NATIVE, DECISION, projection]
    for name in ('occurrence-positive-v041', 'same_population_new_snapshot', 'two_events_one_population'):
        p = SOURCE/'validation_v041/fixtures'/(name+'.ttl')
        graph = Graph().parse(p)
        instances = sorted(map(str, graph.subjects(RDF.type, URIRef(mapping['mapped_iri']))))
        assert instances
        population.append({'source': p.relative_to(ROOT).as_posix(), 'explicit_capability_instances': instances,
            'concrete_descendant_typings': 0,
            'abstract_leaf_counterfactual': 'NO_CONCRETE_NATIVE_SPECIALIZATION_FOR_RECORDED_TYPES'})
        sources.append(p)
    axioms_path = SOURCE/'formalization/Structural_Axioms_892.json'
    axioms = json.loads(axioms_path.read_text())['axioms']
    affected = [a for a in axioms if '"'+CAP+'"' in a['formula']]
    assert len(affected) == 8
    sources.append(axioms_path)
    report = {'status': 'ADOPTED_BOUNDED_PROFILE_WITH_DECLARED_REFERENCE_DEVIATION',
        'decision': decision, 'source_sha256': {p.relative_to(ROOT).as_posix(): sha(p) for p in sources},
        'structural_comparison': focused, 'mapping': mapping, 'sampled_positive_populations': population,
        'affected_native_formulas': affected, 'native_formula_count': len(axioms),
        'migration': {'native_changes': 0, 'new_classes': 0, 'instance_retyping': 0, 'owl_mapping_changes': 0,
                      'shacl_changes': 0, 'fol_changes': 0, 'external_boundary_changes': 0},
        'limits': decision['limits'] + ['Three synthetic positive populations are sampled, not all user data or all possible instances. No deployed population was inspected.']}
    return report


def verify_reference(reference_root, decision):
    commit = subprocess.check_output(['git', '-C', str(reference_root), 'rev-parse', 'HEAD'], text=True).strip()
    assert commit == decision['reference']['commit']
    for path, digest in decision['reference']['files'].items():
        assert sha(reference_root/path) == digest, path
    assert '  abstract: true' in (reference_root/'classes/aspects/mode/meta.yml').read_text()
    return {'reference_commit': commit, 'verified_reference_files': len(decision['reference']['files'])}


def main():
    from pathlib import Path
    ap = argparse.ArgumentParser()
    ap.add_argument('--reference-root', type=Path, help='Optional exact official Git checkout; routine CI remains offline')
    args = ap.parse_args()
    report = review()
    if args.reference_root:
        print(json.dumps(verify_reference(args.reference_root, report['decision'])))
    write_json('evaluation/capability-profile-review.json', report)
    print(json.dumps({'status': report['status'], 'focused_checks': 6, 'sampled_populations': 3,
                      'affected_native_formulas': len(report['affected_native_formulas']), 'semantic_migration': 'NONE'}))


if __name__ == '__main__':
    main()
