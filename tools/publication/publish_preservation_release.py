"""Package the reviewed public tree and publish v2.0.3 after successful main CI."""
from pathlib import Path
import argparse
import gzip
import hashlib
import json
import os
import subprocess
import zipfile

ROOT=Path(__file__).resolve().parents[2]
REPO='ArazSaieArasi3/OntoSPK'
TAG='v2.0.3'
FROZEN='ccea141bcc238a4aae47e631cadc1809b738bc73'
PRIOR='43b76d47ac0776b8b1d0a8ca312337969ef22154'

def git(*args):return subprocess.check_output(['git',*args],cwd=ROOT)
def digest(data):return hashlib.sha256(data).hexdigest()
def gh(*args):return subprocess.run(['gh',*args],cwd=ROOT,capture_output=True,text=True)

def prepare(commit,tag=TAG,extra_receipts=(),archive_date=(2026,10,23,0,0,0),output_name='preservation-release',scope=None):
    assert git('rev-parse',commit+'^{commit}').decode().strip()==commit
    def content(path):return git('show',commit+':'+path)
    market=json.loads(content('evaluation/market-boundary-preservation.json'))
    business=json.loads(content('evaluation/business-boundary-tests.json'))
    old=json.loads(gzip.decompress(content('evaluation/v2.0.2-closeout.json.gz')))
    assert market['status']=='PASS_OWNER_DIRECTED_PRESERVATION'
    assert market['all_boundary_handles_preserved']==27 and market['native_relation_count']==13
    assert market['semantic_files_byte_identical']==543 and len(market['adverse_change_controls'])==90
    assert all(c['drift_rejected'] for c in market['adverse_change_controls'])
    assert len(market['legacy_runtime_checks'])==4
    assert business['status']=='PASS' and business['reference_cases']==198 and business['cli_exit_controls']==3
    assert old['status']=='PASS_FINITE_EVALUATION_RELEASE_GATE'
    assert old['summary']['unexpected_positive_failures']==old['summary']['unaccounted_shacl_components']==0
    for path in market['semantic_tree_git_blobs']:
        assert git('rev-parse',commit+':'+path)==git('rev-parse',FROZEN+':'+path),path
    for path,expected in market['source_sha256'].items():assert digest(content(path))==expected
    for path,expected in old['source_identity'].items():assert digest(content(path))==expected
    for path,expected in old['receipt_sha256'].items():assert digest(content('evaluation/'+path))==expected
    assert business['review_sha256']==digest(content('evaluation/business-boundary-review.json'))
    assert business['adapter_sha256']==digest(content('tools/boundaries/business_reference.py'))
    for path in ('evaluation/publication-checks.json','evaluation/pages-completeness.json'):
        report=json.loads(content(path));assert report['status']=='PASS' and not report['errors']
    assert content('tools/publication/pages-registry.json')==git('show',PRIOR+':tools/publication/pages-registry.json')
    assert git('rev-parse',commit+':wiki-src')==git('rev-parse',PRIOR+':wiki-src')
    dest=ROOT/'build'/output_name;dest.mkdir(parents=True,exist_ok=True)
    archive=dest/f'OntoSPK-{tag}-source-and-evidence.zip'
    paths=git('ls-tree','-r','--name-only',commit).decode().splitlines()
    with zipfile.ZipFile(archive,'w',compression=zipfile.ZIP_DEFLATED) as z:
        for path in paths:
            info=zipfile.ZipInfo(path,date_time=archive_date);info.compress_type=zipfile.ZIP_DEFLATED
            z.writestr(info,content(path))
    receipts=['market-boundary-preservation.json','business-boundary-review.json','business-boundary-tests.json','v2.0.2-closeout.json.gz','pages-completeness.json','publication-checks.json']
    receipts += list(extra_receipts)
    manifest={'release':tag,'source_commit':commit,'ontology_core':'v2.0.0',
              'scope':scope or 'Owner-accepted boundary preservation and reproducible public evidence; no semantic change.',
              'source_file_count':len(paths),'archive':archive.name,'archive_sha256':digest(archive.read_bytes()),
              'native_sha256':old['native_sha256'],'logical_sha256':old['logical_sha256'],
              'semantic_files_preserved':543,'boundary_handles_preserved':27,
              'receipt_sha256':{name:digest(content('evaluation/'+name)) for name in receipts}}
    mf=dest/'RELEASE_MANIFEST.json';mf.write_text(json.dumps(manifest,indent=2)+'\n')
    sums=dest/'SHA256SUMS.txt';sums.write_text(''.join(digest(p.read_bytes())+'  '+p.name+'\n' for p in (archive,mf)))
    return [archive,mf,sums],manifest

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--prepare-only',action='store_true');args=ap.parse_args()
    commit=git('rev-parse','HEAD').decode().strip()
    if not args.prepare_only:
        assert os.environ.get('GITHUB_REPOSITORY')==REPO and os.environ.get('GITHUB_REF')=='refs/heads/main'
        assert os.environ['GITHUB_SHA']==commit
        existing=gh('api','repos/'+REPO+'/releases/tags/'+TAG)
        if existing.returncode==0:
            previous=json.loads(existing.stdout)
            assert not previous['draft'] and not previous['prerelease'] and previous['tag_name']==TAG
            assert {a['name'] for a in previous['assets']}=={f'OntoSPK-{TAG}-source-and-evidence.zip','RELEASE_MANIFEST.json','SHA256SUMS.txt'}
            print('Existing immutable preservation release retained: '+previous['html_url']);return
        assert '404' in existing.stderr,existing.stderr
        runs=gh('api','repos/'+REPO+'/actions/workflows/documentation.yml/runs?head_sha='+commit+'&event=push')
        assert runs.returncode==0,runs.stderr
        assert any(r['head_sha']==commit and r['conclusion']=='success' for r in json.loads(runs.stdout)['workflow_runs']),'Main documentation CI must pass first'
    assets,manifest=prepare(commit)
    if args.prepare_only:
        print(json.dumps({'status':'PREPARED_AND_VALIDATED','source_commit':commit,'files':manifest['source_file_count'],'archive_sha256':manifest['archive_sha256']}));return
    result=gh('release','create',TAG,*map(str,assets),'--repo',REPO,'--target',commit,
              '--title','OntoSPK v2.0.3 — Boundary preservation and public evidence',
              '--notes-file','docs/releases/v2.0.3/RELEASE_NOTES.md')
    assert result.returncode==0,result.stderr
    readback=gh('api','repos/'+REPO+'/releases/tags/'+TAG);assert readback.returncode==0,readback.stderr
    published=json.loads(readback.stdout)
    assert published['target_commitish']==commit and not published['draft'] and not published['prerelease']
    assert {a['name'] for a in published['assets']}=={p.name for p in assets}
    ref=gh('api','repos/'+REPO+'/git/ref/tags/'+TAG)
    assert ref.returncode==0 and json.loads(ref.stdout)['object']['sha']==commit
    print(json.dumps({'release':published['html_url'],'source_commit':commit,'assets_verified':True}))

if __name__=='__main__':main()
