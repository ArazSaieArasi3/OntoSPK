"""Publish the bounded FOL pilot only after successful main evaluation."""
import argparse
import gzip
import json
import os
from publish_preservation_release import ROOT,REPO,git,gh,prepare
from check_fol_pilot_sources import validate
TAG='v2.0.6'
NAMES={f'OntoSPK-{TAG}-source-and-evidence.zip','RELEASE_MANIFEST.json','SHA256SUMS.txt'}

def package(commit):
    content=lambda path:git('show',commit+':'+path)
    report=json.loads(gzip.decompress(content('evaluation/fol-pilot.json.gz')))
    validate(report,content)
    assets,manifest=prepare(commit,tag=TAG,
        extra_receipts=('local-identity-review.json','local-identity-tests.json.gz','robot-metadata-review.json.gz','robot-metadata-tests.json.gz','fol-pilot.json.gz'),
        archive_date=(2026,10,24,0,0,0),output_name='fol-release',
        scope='Executed bounded FOL pilot with separate signatures, source differential checks and independently verified finite model/countermodel certificates; frozen semantic sources and manuscript unchanged.')
    return assets,manifest

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--prepare-only',action='store_true');args=ap.parse_args()
    commit=git('rev-parse','HEAD').decode().strip()
    if not args.prepare_only:
        assert os.environ.get('GITHUB_REPOSITORY')==REPO and os.environ.get('GITHUB_REF')=='refs/heads/main'
        assert os.environ['GITHUB_SHA']==commit
        old=gh('api','repos/'+REPO+'/releases/tags/'+TAG)
        if old.returncode==0:
            previous=json.loads(old.stdout);assert not previous['draft'] and not previous['prerelease']
            assert {a['name'] for a in previous['assets']}==NAMES
            print('Existing immutable FOL release retained: '+previous['html_url']);return
        assert '404' in old.stderr,old.stderr
        runs=gh('api','repos/'+REPO+'/actions/workflows/documentation.yml/runs?head_sha='+commit+'&event=push')
        assert runs.returncode==0 and any(r['head_sha']==commit and r['conclusion']=='success' for r in json.loads(runs.stdout)['workflow_runs'])
    assets,manifest=package(commit);assert {p.name for p in assets}==NAMES
    if args.prepare_only:
        print(json.dumps({'status':'PREPARED_AND_VALIDATED','source_commit':commit,'files':manifest['source_file_count'],'receipts':len(manifest['receipt_sha256']),'assets':len(assets)}));return
    result=gh('release','create',TAG,*map(str,assets),'--repo',REPO,'--target',commit,
        '--title','OntoSPK v2.0.6 — Executed bounded FOL verification pilot','--notes-file','docs/releases/v2.0.6/RELEASE_NOTES.md')
    assert result.returncode==0,result.stderr
    readback=gh('api','repos/'+REPO+'/releases/tags/'+TAG);assert readback.returncode==0
    release=json.loads(readback.stdout)
    assert release['target_commitish']==commit and not release['draft'] and not release['prerelease']
    assert {a['name'] for a in release['assets']}==NAMES
    ref=gh('api','repos/'+REPO+'/git/ref/tags/'+TAG)
    assert ref.returncode==0 and json.loads(ref.stdout)['object']['sha']==commit
    print(json.dumps({'release':release['html_url'],'source_commit':commit,'assets_verified':True}))

if __name__=='__main__':main()
