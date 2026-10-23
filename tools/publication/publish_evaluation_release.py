"""Publish immutable tagged receipts after the main-branch evaluation job passes."""
from pathlib import Path
import gzip
import hashlib
import io
import json
import os
import subprocess
import zipfile

ROOT=Path(__file__).resolve().parents[2]
REPO='ArazSaieArasi3/OntoSPK'
TAG='v2.0.2'
assert os.environ.get('GITHUB_REPOSITORY')==REPO
assert os.environ.get('GITHUB_REF')=='refs/heads/main'
commit=os.environ['GITHUB_SHA']
assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()==commit
def gh(*args):
    return subprocess.run(['gh',*args],cwd=ROOT,capture_output=True,text=True)
existing=gh('api','repos/'+REPO+'/releases/tags/'+TAG)
if existing.returncode==0:
    previous=json.loads(existing.stdout)
    assert not previous['draft'] and not previous['prerelease'] and previous['tag_name']==TAG
    print('Existing immutable evaluation release retained: '+previous['html_url'])
    raise SystemExit(0)
assert '404' in existing.stderr, existing.stderr
closeout=json.loads(gzip.decompress((ROOT/'evaluation/v2.0.2-closeout.json.gz').read_bytes()))
assert closeout['status']=='PASS_FINITE_EVALUATION_RELEASE_GATE'
assert closeout['summary']['unexpected_positive_failures']==0
assert closeout['summary']['unaccounted_shacl_components']==0
for path,digest in closeout['source_identity'].items():
    assert hashlib.sha256((ROOT/path).read_bytes()).hexdigest()==digest
for name,digest in closeout['receipt_sha256'].items():
    assert hashlib.sha256((ROOT/'evaluation'/name).read_bytes()).hexdigest()==digest
dest=ROOT/'build/evaluation-release'
dest.mkdir(parents=True,exist_ok=True)
archive=dest/'OntoSPK-v2.0.2-evaluation.zip'
paths=subprocess.check_output(['git','ls-files','evaluation','tools/publication','docs/releases/v2.0.2'],cwd=ROOT,text=True).splitlines()
assert paths
with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_DEFLATED) as z:
    for path in sorted(paths):
        # Git contents, not a CI-mutated worktree, bind assets to the tag.
        payload=subprocess.check_output(['git','show',commit+':'+path],cwd=ROOT)
        info=zipfile.ZipInfo(path,date_time=(2026,10,23,0,0,0))
        info.compress_type=zipfile.ZIP_DEFLATED
        z.writestr(info,payload)
manifest={'release':TAG,'source_commit':commit,'ontology_core':'v2.0.0',
          'scope':'Expanded finite evaluation; source semantics unchanged; default ROBOT editorial findings retained.',
          'archive':archive.name,'archive_sha256':hashlib.sha256(archive.read_bytes()).hexdigest(),
          'accepted_closeout_sha256':hashlib.sha256((ROOT/'evaluation/v2.0.2-closeout.json.gz').read_bytes()).hexdigest(),
          'native_sha256':closeout['native_sha256'],'logical_sha256':closeout['logical_sha256']}
mf=dest/'RELEASE_MANIFEST.json';mf.write_text(json.dumps(manifest,indent=2)+'\n')
sums=dest/'SHA256SUMS.txt'
sums.write_text(''.join(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+p.name+'\n' for p in [archive,mf]))
result=gh('release','create',TAG,str(archive),str(mf),str(sums),'--repo',REPO,'--target',commit,
          '--title','OntoSPK v2.0.2 — Expanded finite evaluation',
          '--notes-file','docs/releases/v2.0.2/RELEASE_NOTES.md')
assert result.returncode==0,result.stderr
readback=gh('api','repos/'+REPO+'/releases/tags/'+TAG)
assert readback.returncode==0,readback.stderr
published=json.loads(readback.stdout)
assert published['target_commitish']==commit and not published['draft'] and not published['prerelease']
assert {a['name'] for a in published['assets']}=={archive.name,mf.name,sums.name}
tag=gh('api','repos/'+REPO+'/git/ref/tags/'+TAG)
assert tag.returncode==0 and json.loads(tag.stdout)['object']['sha']==commit
print(json.dumps({'release':published['html_url'],'commit':commit,'assets_verified':True}))
