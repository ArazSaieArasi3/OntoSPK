"""Re-run retained controls in an isolated copy, preserving the frozen tree."""
from pathlib import Path
import argparse
import json
import shutil
import subprocess
import sys
from evaluation_common import ROOT, SOURCE, sha, write_json

ap=argparse.ArgumentParser()
ap.add_argument('--robot',type=Path)
ap.add_argument('--receipt',type=Path,help='Normalize an already completed fresh isolated execution.')
args=ap.parse_args()
out=ROOT/'build/core-regression-results'
copy=ROOT/'build/core-regression-source'
if args.receipt:
    out=args.receipt.resolve()
else:
    assert args.robot and sha(args.robot)=='53cd275c8e4c0dad1fc2c1c34174876795cd7d6b6926e1444adcbb0cb3c7ab26'
    if copy.exists():shutil.rmtree(copy)
    shutil.copytree(ROOT/'semantic',copy/'semantic')
    shutil.copytree(ROOT/'tools/ontospk',copy/'tools/ontospk')
    command=[sys.executable,str(copy/'tools/ontospk/run_validation.py'),'--robot',str(args.robot.resolve()),'--output',str(out)]
    subprocess.run(command,check=True,cwd=ROOT)
receipt=json.loads((out/'INTEGRATION_RESULTS.json').read_text())
assert receipt['passed'] and len(receipt['steps'])==8 and all(s['passed'] for s in receipt['steps'])
assert receipt['native_sha256']=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
assert receipt['robot_sha256']=='53cd275c8e4c0dad1fc2c1c34174876795cd7d6b6926e1444adcbb0cb3c7ab26'
for f in receipt['result_files'].values():
    assert sha(out/f['path'])==f['sha256']
suite={name:json.loads((out/(name+'.json')).read_text()) for name in ('combined','revision','structural','project_rules','cq','formal')}
assert suite['combined']['total']==suite['combined']['passed']==42
assert suite['revision']['total']==suite['revision']['passed']==146
assert suite['structural']['freshly_compared']==suite['structural']['matched']==892
assert suite['project_rules']['total']==suite['project_rules']['passed']==80
assert suite['cq']['comparisons']==suite['cq']['passed']==374
assert suite['formal']['reasoner_cases']==suite['formal']['passed']==13
# Keep actual commands/exit statuses and dates while replacing machine-specific
# paths in this portable report. No private content is introduced.
recorded_root=Path(receipt['steps'][0]['command'][1]).parents[2]
python_path=receipt['steps'][0]['command'][0]
jar_path=next(s['command'][-1] for s in receipt['steps'] if s['id']=='owl-profile-hermit')
def portable(value):
    if isinstance(value,str):
        return value.replace(str(recorded_root)+'/', '').replace(python_path,'${PYTHON}').replace(jar_path,'${ROBOT_JAR}')
    if isinstance(value,list):return [portable(x) for x in value]
    if isinstance(value,dict):return {k:portable(v) for k,v in value.items()}
    return value
report={'status':'PASS','execution_started_utc':receipt['started_utc'],
        'execution_finished_utc':receipt['finished_utc'],'native_sha256':receipt['native_sha256'],
        'robot_sha256':receipt['robot_sha256'],'python':receipt['python'],'packages':receipt['packages'],
        'steps':portable(receipt['steps']), 'suites':portable(suite),
        'omitted':'Upstream native SDK/validator were not rerun in this evaluation-only increment; their historical acceptance is unchanged and not claimed fresh.',
        'scope':'Fresh finite core regression in an isolated copy; synthetic storage controls are tests, not a released database or production deployment.'}
write_json('evaluation/core-regression.json.gz',report)
(ROOT/'evaluation/core-regression.md').write_text('\n'.join([
 '# Retained core regression','',
 'Eight stages were freshly executed in an isolated source copy. The frozen semantic source tree was not rewritten. All stages passed.','',
 '| Suite | Passed / expected |','| --- | ---: |',
 '| Combined population, persistence and mapping | 42 / 42 |',
 '| Revision, identity policy, occurrence and history | 146 / 146 |',
 '| Static native structural reconciliation | 892 / 892 |',
 '| Project rule controls | 80 / 80 |',
 '| Exact-answer CQ comparisons | 374 / 374 |',
 '| Retained HermiT consistency fixtures | 13 / 13 |','',
 'The upstream native SDK and native validator were not rerun here. Their original acceptance remains historical. The expanded HermiT/SHACL/CQ reports provide the new focused evidence; these overlapping counts must not be summed as independent coverage.','',
 '[Actual commands, exit statuses, dates and suite observations](core-regression.json.gz)','']))
print(json.dumps({'status':'PASS','stages':len(receipt['steps']),'combined':42,'revision':146,'structural':892}))
