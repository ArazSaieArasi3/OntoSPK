"""Check source binding and acceptance scope without importing the solver."""
import gzip
import hashlib
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]

def validate(report,read):
    assert report['status']=='PASS_BOUNDED_FOL_PILOT_WITH_DISCLOSED_LIMITS'
    assert (report['native_formulas'],report['profile_formulas'])==(892,3038)
    assert (report['native_source_differential_checks'],report['profile_family_differential_checks'])==(1784,22)
    assert report['scenario_count']==19 and report['scenario_statuses']=={'sat':11,'unsat':8}
    assert report['verified_sat_certificates']==11 and report['detected_mutations']==8
    assert report['unknown_results']==report['differential_mismatches']==0
    assert report['separate_theories'] and not report['theories_combined']
    assert report['solver_library_sha256']=='56d9977b9276bcb8cda9973a14058fcaa9f3bfee14ed57408b9faacd76d4d8f3'
    for field in ('ontology_wide_consistency_proved','full_owl_equivalence_proved','ufo_modal_causal_semantics_verified','independent_domain_acceptance','manuscript_changed','semantic_sources_changed'):assert report[field] is False
    for path,expected in report['source_sha256'].items():assert hashlib.sha256(read(path)).hexdigest()==expected,path
    assert all(c['actual']==c['expected'] for c in report['scenarios'])
    assert all(c['disagreement']=='unsat' for c in report['native_differential']+report['profile_differential'])
    certificates=json.loads(gzip.decompress(read('tools/publication/fol-pilot-witnesses.json.gz')))
    assert len(certificates['cases'])==19
    for path,expected in certificates['source_spec_sha256'].items():assert hashlib.sha256(read('semantic/product/v2/formal-specification/'+path)).hexdigest()==expected
    return {'status':'PASS_FOL_SOURCE_BINDING','native_formulas':892,'profile_formulas':3038,'scenarios':19,'separate_theories':True}

if __name__=='__main__':
    report=json.loads(gzip.decompress((ROOT/'evaluation/fol-pilot.json.gz').read_bytes()))
    print(json.dumps(validate(report,lambda path:(ROOT/path).read_bytes())))
