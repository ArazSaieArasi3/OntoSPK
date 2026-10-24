"""Publish the bounded local-review patch after full main-branch evaluation."""
import argparse
import gzip
import json
import os
from publish_preservation_release import ROOT,REPO,git,gh,prepare,digest

TAG='v2.0.4'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--prepare-only',action='store_true');args=ap.parse_args()
    commit=git('rev-parse','HEAD').decode().strip()
    if not args.prepare_only:
        assert os.environ.get('GITHUB_REPOSITORY')==REPO and os.environ.get('GITHUB_REF')=='refs/heads/main'
        assert os.environ['GITHUB_SHA']==commit
        previous=gh('api','repos/'+REPO+'/releases/tags/'+TAG)
        if previous.returncode==0:
            release=json.loads(previous.stdout)
            assert not release['draft'] and not release['prerelease']
            assert {a['name'] for a in release['assets']}=={f'OntoSPK-{TAG}-source-and-evidence.zip','RELEASE_MANIFEST.json','SHA256SUMS.txt'}
            print('Existing immutable local-review release retained: '+release['html_url']);return
        assert '404' in previous.stderr,previous.stderr
        runs=gh('api','repos/'+REPO+'/actions/workflows/documentation.yml/runs?head_sha='+commit+'&event=push')
        assert runs.returncode==0 and any(r['head_sha']==commit and r['conclusion']=='success' for r in json.loads(runs.stdout)['workflow_runs'])
    def content(path):return git('show',commit+':'+path)
    review=json.loads(content('evaluation/local-identity-review.json'))
    tests=json.loads(gzip.decompress(content('evaluation/local-identity-tests.json.gz')))
    assert review['status']=='BOUNDED_LOCAL_REVIEW_COMPLETE_WITH_RETAINED_LIMITS'
    assert review['existing_review_questions']==37 and review['reviewed_entries']==39
    assert review['profile_finding']['followup_issue']==48
    assert tests['status']=='PASS_BOUNDED_TESTS_WITH_DISCLOSED_LIMITS' and tests['identity_grid_cases']==864
    assert tests['retained_case_replays']==25 and tests['iri_renaming_controls']==48
    assert tests['review_sha256']==digest(content('evaluation/local-identity-review.json'))
    assert tests['runner_sha256']==digest(content('tools/publication/test_local_identity_review.py'))
    assert len(tests['implementation_limits'])==1 and tests['scientific_acceptance'] is False
    for path,expected in review['source_sha256'].items():assert digest(content(path))==expected
    assets,manifest=prepare(commit,tag=TAG,extra_receipts=('local-identity-review.json','local-identity-tests.json.gz'),
                            archive_date=(2026,10,24,0,0,0),output_name='identity-release',
                            scope='Bounded local identity/bearer/event review and finite execution evidence; retained scientific/profile limits; no semantic change.')
    if args.prepare_only:
        print(json.dumps({'status':'PREPARED_AND_VALIDATED','source_commit':commit,'files':manifest['source_file_count'],'receipts':len(manifest['receipt_sha256'])}));return
    result=gh('release','create',TAG,*map(str,assets),'--repo',REPO,'--target',commit,
              '--title','OntoSPK v2.0.4 — Bounded local identity and event review',
              '--notes-file','docs/releases/v2.0.4/RELEASE_NOTES.md')
    assert result.returncode==0,result.stderr
    readback=gh('api','repos/'+REPO+'/releases/tags/'+TAG);assert readback.returncode==0
    release=json.loads(readback.stdout)
    assert release['target_commitish']==commit and not release['draft'] and not release['prerelease']
    assert {a['name'] for a in release['assets']}=={p.name for p in assets}
    ref=gh('api','repos/'+REPO+'/git/ref/tags/'+TAG)
    assert ref.returncode==0 and json.loads(ref.stdout)['object']['sha']==commit
    print(json.dumps({'release':release['html_url'],'source_commit':commit,'assets_verified':True}))

if __name__=='__main__':main()
