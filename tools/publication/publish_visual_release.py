"""Publish the verified diagram/documentation increment after main evaluation."""
import argparse
import hashlib
import json
import os
from publish_preservation_release import ROOT,REPO,git,gh,prepare

TAG='v2.0.7'
NAMES={f'OntoSPK-{TAG}-source-and-evidence.zip','RELEASE_MANIFEST.json','SHA256SUMS.txt'}

def package(commit):
    content=lambda path:git('show',commit+':'+path)
    report=json.loads(content('evaluation/diagram-provenance.json'))
    assert report['status']=='PASS_BOUNDED_VIEW_REVIEW' and not report['errors']
    assert (len(report['classes']),len(report['relations']),len(report['historical_manifest_drift']))==(40,59,6)
    assert len(report['domain_views']['associations'])==286 and len(report['domain_views']['backbone'])==11
    for path,digest in report['sources'].items():assert hashlib.sha256(content(path)).hexdigest()==digest,path
    expected={'selected-reviewed.svg','domain-matrix.svg','domain-matrix.png','domain-backbone.svg','domain-backbone.png'}
    assert set(report['artifacts'])==expected
    for path,digest in report['artifacts'].items():assert hashlib.sha256(content('docs/assets/diagrams/'+path)).hexdigest()==digest,path
    parity=json.loads(content('evaluation/documentation-parity.json'))
    assert parity['status']=='PASS' and not parity['errors'] and parity['wiki_pages']==15 and parity['source_reader_pages']==18
    for row in parity['pages']:assert hashlib.sha256(content(row['source'])).hexdigest()==row['source_sha256']
    citation=content('docs/releases/v2.0.7/CITATION.cff').decode()
    assert 'version: "2.0.7"' in citation and '\ndoi:' not in citation.lower()
    return prepare(commit,tag=TAG,
        extra_receipts=('local-identity-review.json','local-identity-tests.json.gz','robot-metadata-review.json.gz','robot-metadata-tests.json.gz','fol-pilot.json.gz','diagram-provenance.json','documentation-parity.json'),
        archive_date=(2026,10,24,0,0,0),output_name='visual-release',
        scope='Verified selected/domain views, complete reader documentation and author-review citation/evidence handoff; unchanged ontology core v2.0.0, no DOI or independent scientific acceptance claim.')

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--prepare-only',action='store_true');ap.add_argument('--source-ref');args=ap.parse_args()
    assert not args.source_ref or args.prepare_only, 'Alternate source is prepare-only'
    commit=git('rev-parse',args.source_ref or 'HEAD').decode().strip()
    if not args.prepare_only:
        assert os.environ.get('GITHUB_REPOSITORY')==REPO and os.environ.get('GITHUB_REF')=='refs/heads/main'
        assert os.environ['GITHUB_SHA']==commit
        existing=gh('api','repos/'+REPO+'/releases/tags/'+TAG)
        if existing.returncode==0:
            old=json.loads(existing.stdout);assert not old['draft'] and not old['prerelease'] and {a['name'] for a in old['assets']}==NAMES
            print('Existing immutable diagram/documentation release retained: '+old['html_url']);return
        assert '404' in existing.stderr,existing.stderr
        runs=gh('api','repos/'+REPO+'/actions/workflows/documentation.yml/runs?head_sha='+commit+'&event=push')
        assert runs.returncode==0 and any(r['head_sha']==commit and r['conclusion']=='success' for r in json.loads(runs.stdout)['workflow_runs'])
    assets,manifest=package(commit)
    if args.prepare_only:
        print(json.dumps({'status':'PREPARED_AND_VALIDATED','source_commit':commit,'files':manifest['source_file_count'],'receipts':len(manifest['receipt_sha256'])}));return
    result=gh('release','create',TAG,*map(str,assets),'--repo',REPO,'--target',commit,
        '--title','OntoSPK v2.0.7 — Verified diagrams and publication handoff',
        '--notes-file','docs/releases/v2.0.7/RELEASE_NOTES.md')
    assert result.returncode==0,result.stderr
    readback=gh('api','repos/'+REPO+'/releases/tags/'+TAG);assert readback.returncode==0
    release=json.loads(readback.stdout)
    assert release['target_commitish']==commit and not release['draft'] and not release['prerelease'] and {a['name'] for a in release['assets']}==NAMES
    ref=gh('api','repos/'+REPO+'/git/ref/tags/'+TAG)
    assert ref.returncode==0 and json.loads(ref.stdout)['object']['sha']==commit
    print(json.dumps({'release':release['html_url'],'source_commit':commit,'assets_verified':True}))

if __name__=='__main__':main()
