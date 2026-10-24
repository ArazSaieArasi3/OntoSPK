"""Publish the source-reviewed annotated view after successful main CI."""
import argparse
import gzip
import json
import os
from pathlib import Path
from publish_preservation_release import ROOT,REPO,git,gh,prepare,digest

TAG='v2.0.5'
ANNOTATED='docs/downloads/OntoSPK-v2.0.5-annotated.ttl'
NAMES={f'OntoSPK-{TAG}-source-and-evidence.zip','RELEASE_MANIFEST.json','SHA256SUMS.txt',Path(ANNOTATED).name}

def package(commit):
    def content(path):return git('show',commit+':'+path)
    review=json.loads(gzip.decompress(content('evaluation/robot-metadata-review.json.gz')))
    tests=json.loads(gzip.decompress(content('evaluation/robot-metadata-tests.json.gz')))
    assert review['status']=='SOURCE_REVIEW_AND_ANNOTATED_VIEW_COMPLETE' and review['findings_reviewed']==812
    assert tests['status']=='PASS_ANNOTATION_INCREMENT_WITH_RETAINED_DEFAULT_FINDINGS'
    assert (tests['resolved_findings'],tests['retained_findings'],tests['new_findings'])==(494,318,0)
    assert tests['after_counts']=={'ERROR':34,'WARN':211,'INFO':73} and tests['default_report_clean'] is False
    assert tests['logical_axioms_and_signature_equal'] and tests['named_classes_satisfiable']==121
    assert tests['cq_exact_answer_comparisons']==374 and tests['held_boundary_subjects_unchanged']==69
    assert tests['review_sha256']==digest(content('evaluation/robot-metadata-review.json.gz'))
    assert tests['runner_sha256']==digest(content('tools/publication/test_metadata_view.py'))
    assert tests['java_guard_sha256']==digest(content('tools/publication/MetadataLogicalIdentity.java'))
    for path,sha in review['source_sha256'].items():assert digest(content(path))==sha,path
    assert review['annotated_sha256']==tests['annotated_sha256']==digest(content(ANNOTATED))
    assets,manifest=prepare(commit,tag=TAG,
        extra_receipts=('local-identity-review.json','local-identity-tests.json.gz','robot-metadata-review.json.gz','robot-metadata-tests.json.gz'),
        archive_date=(2026,10,24,0,0,0),output_name='metadata-release',
        scope='Source-reviewed editorial annotation view; 494 resolved and 318 retained default ROBOT findings; unchanged logical axioms, frozen core and owner-held boundaries.')
    artifact=assets[0].parent/Path(ANNOTATED).name;artifact.write_bytes(content(ANNOTATED))
    manifest.update({'annotated_path':ANNOTATED,'annotated_sha256':digest(artifact.read_bytes()),
                     'annotated_version_iri':review['version_iri'],'logical_axioms_unchanged':True,
                     'robot_default_resolved':494,'robot_default_retained':318,'robot_default_clean':False})
    assets[1].write_text(json.dumps(manifest,indent=2)+'\n')
    assets[2].write_text(''.join(digest(p.read_bytes())+'  '+p.name+'\n' for p in (assets[0],assets[1],artifact)))
    return assets+[artifact],manifest

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--prepare-only',action='store_true');args=ap.parse_args()
    commit=git('rev-parse','HEAD').decode().strip()
    if not args.prepare_only:
        assert os.environ.get('GITHUB_REPOSITORY')==REPO and os.environ.get('GITHUB_REF')=='refs/heads/main'
        assert os.environ['GITHUB_SHA']==commit
        existing=gh('api','repos/'+REPO+'/releases/tags/'+TAG)
        if existing.returncode==0:
            previous=json.loads(existing.stdout)
            assert not previous['draft'] and not previous['prerelease'] and {a['name'] for a in previous['assets']}==NAMES
            print('Existing immutable metadata release retained: '+previous['html_url']);return
        assert '404' in existing.stderr,existing.stderr
        runs=gh('api','repos/'+REPO+'/actions/workflows/documentation.yml/runs?head_sha='+commit+'&event=push')
        assert runs.returncode==0 and any(r['head_sha']==commit and r['conclusion']=='success' for r in json.loads(runs.stdout)['workflow_runs'])
    assets,manifest=package(commit)
    assert {p.name for p in assets}==NAMES
    if args.prepare_only:
        print(json.dumps({'status':'PREPARED_AND_VALIDATED','source_commit':commit,'files':manifest['source_file_count'],'receipts':len(manifest['receipt_sha256']),'assets':len(assets)}));return
    result=gh('release','create',TAG,*map(str,assets),'--repo',REPO,'--target',commit,
        '--title','OntoSPK v2.0.5 — Source-reviewed editorial annotation view','--notes-file','docs/releases/v2.0.5/RELEASE_NOTES.md')
    assert result.returncode==0,result.stderr
    readback=gh('api','repos/'+REPO+'/releases/tags/'+TAG);assert readback.returncode==0
    release=json.loads(readback.stdout)
    assert release['target_commitish']==commit and not release['draft'] and not release['prerelease']
    assert {a['name'] for a in release['assets']}==NAMES
    ref=gh('api','repos/'+REPO+'/git/ref/tags/'+TAG)
    assert ref.returncode==0 and json.loads(ref.stdout)['object']['sha']==commit
    print(json.dumps({'release':release['html_url'],'source_commit':commit,'assets_verified':True}))

if __name__=='__main__':main()
