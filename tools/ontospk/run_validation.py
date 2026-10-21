"""Re-run the bounded source integration, recording actual execution provenance."""
from pathlib import Path
import argparse,datetime,hashlib,importlib.metadata,json,os,platform,shutil,sqlite3,subprocess,sys,time

ROOT=Path(__file__).resolve().parents[2]
V=ROOT/'semantic/product/v2';S=V/'source'
ap=argparse.ArgumentParser()
ap.add_argument('--robot',type=Path)
ap.add_argument('--validator',type=Path)
ap.add_argument('--sdk',type=Path)
ap.add_argument('--retry-failed',action='store_true',help='Retain successful steps for this unchanged native input; rerun only failed steps.')
ap.add_argument('--output',type=Path,default=V/'evidence/integration')
args=ap.parse_args();out=args.output.resolve();out.mkdir(parents=True,exist_ok=True)
previous=json.loads((out/'INTEGRATION_RESULTS.json').read_text()) if args.retry_failed and (out/'INTEGRATION_RESULTS.json').exists() else None
if previous:assert previous['native_sha256']=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
report={'release':'v2.0.0-public-preparation','started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),
        'python':platform.python_version(),'sqlite':sqlite3.sqlite_version,
        'packages':{n:importlib.metadata.version(n) for n in ['rdflib','pyshacl','owlrl','loguru']},
        'steps':[],'independent_acceptances':0,
        'scope':'Finite synthetic controls and static source reconciliation; no production, browser, full modal/causal or independent expert acceptance.'}
def run(name,cmd,timeout=900):
    old=next((s for s in (previous or {}).get('steps',[]) if s['id']==name and s['passed']),None)
    if old and name!='bootstrap':
        report['steps'].append(dict(old,retained_execution_started_utc=previous['started_utc']));print(name,'retained successful execution',flush=True);return True
    start=time.monotonic()
    p=subprocess.run([str(x) for x in cmd],cwd=ROOT,capture_output=True,text=True,timeout=timeout)
    (out/(name+'.stdout.txt')).write_text(p.stdout)
    (out/(name+'.stderr.txt')).write_text(p.stderr)
    row={'id':name,'command':[str(x) for x in cmd],'exit_code':p.returncode,'seconds':round(time.monotonic()-start,3),'passed':p.returncode==0}
    report['steps'].append(row);print(name,p.returncode,flush=True)
    if p.returncode:print(p.stdout[-1500:]+p.stderr[-1500:],flush=True)
    return p.returncode==0
def save():
    report['finished_utc']=datetime.datetime.now(datetime.timezone.utc).isoformat()
    report['passed']=all(s['passed'] for s in report['steps'])
    report['execution_kind']='FRESH_LOCAL_OR_CI_RUN'
    (out/'INTEGRATION_RESULTS.json').write_text(json.dumps(report,indent=2)+'\n')
run('bootstrap',[sys.executable,ROOT/'tools/ontospk/bootstrap_inputs.py'])
run('structural',[sys.executable,S/'t52_formalization_v043/check_structural_register.py'])
run('combined-admission',[sys.executable,S/'validation_v041/test_integration.py'])
run('revision',[sys.executable,S/'validation_v041/test_revision.py'])
run('cq',[sys.executable,S/'validation_v041/cq_replay/replay_cqs.py'])
run('project-rule-applicability',[sys.executable,S/'validation_v041/project_rules/remaining_rules.py'])
run('project-rule-controls',[sys.executable,S/'validation_v041/project_rules/test_remaining_rules.py'])
if args.validator:
    sha=subprocess.check_output(['git','-C',str(args.validator.resolve()),'rev-parse','HEAD'],text=True).strip()
    assert sha=='46f54c1a5225fc9ea74ac2256fd4a673e9101a40',sha
    report['validator_commit']=sha
    run('upstream-class-rules',[sys.executable,S/'validation_v041/official_tools/run_graph_validation.py',args.validator.resolve()])
else:report['upstream_class_rules']='NOT_RUN_THIS_EXECUTION'
if args.sdk:
    sha=subprocess.check_output(['git','-C',str(args.sdk.resolve()),'rev-parse','HEAD'],text=True).strip()
    assert sha=='a0e44530564331cf17c850d659fae4b6adad4415',sha
    report['sdk_commit']=sha
    run('upstream-sdk',['node',S/'validation_v041/official_tools/sdk_roundtrip.cjs',args.sdk.resolve()])
else:report['upstream_sdk']='NOT_RUN_THIS_EXECUTION'
if args.robot:
    jar=args.robot.resolve();h=hashlib.sha256(jar.read_bytes()).hexdigest()
    assert h=='53cd275c8e4c0dad1fc2c1c34174876795cd7d6b6926e1444adcbb0cb3c7ab26',h
    report['robot_sha256']=h
    run('owl-profile-hermit',[sys.executable,S/'t52_formalization_v043/run_formal_checks.py',jar])
else:report['owl_profile_hermit']='NOT_RUN_THIS_EXECUTION'
paths={
 'combined':'validation_v041/results/Integration_Results_v0_35_0.json',
 'revision':'validation_v041/results/Revision_Results_v0_41_0.json',
 'cq':'validation_v041/cq_replay/CQ_Replay_Report_v0_24_0.json',
 'project_rules':'validation_v041/project_rules/Test_Results_v0_32_0.json',
 'structural':'t52_formalization_v043/results/Structural_Reconciliation_v0_43_0.json',
}
if args.validator:paths['upstream_class_rules']='validation_v041/official_tools/Official_Graph_Validation_v0_41_0.json'
if args.sdk:paths['upstream_sdk']='validation_v041/official_tools/SDK_Fidelity_v0_41_0.json'
if args.robot:paths['formal']='t52_formalization_v043/results/Formal_Checks_v0_43_0.json'
report['result_files']={}
for name,rel in paths.items():
    p=S/rel
    if p.exists():
        dest=out/(name+'.json');shutil.copy2(p,dest)
        report['result_files'][name]={'path':dest.name,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest()}
native=S/'formalization/Native_Model_v0_41_0.json'
report['native_sha256']=hashlib.sha256(native.read_bytes()).hexdigest()
assert report['native_sha256']=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
save()
print(json.dumps({'passed':report['passed'],'steps':len(report['steps']),'output':str(out)},indent=2))
sys.exit(0 if report['passed'] else 1)
