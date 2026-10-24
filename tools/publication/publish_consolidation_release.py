"""Publish an exact-source v2.0.8 package only after required main CI passes."""
import argparse
import gzip
import hashlib
import io
import json
import os
import re
import tarfile
import zipfile
from publish_preservation_release import ROOT, REPO, git, gh

TAG = 'v2.0.8'
NAMES = {f'OntoSPK-{TAG}-source-and-evidence.zip', 'RELEASE_MANIFEST.json', 'SHA256SUMS.txt'}


def package(commit):
    content = lambda name: git('show', commit+':'+name)
    data = lambda name: json.loads(content(name))
    registry = data('tools/publication/pages-registry.json')['releases']
    old_registry = json.loads(git('show', 'v2.0.7:tools/publication/pages-registry.json'))['releases']
    assert all(registry[k] == v for k, v in old_registry.items())
    entry = registry[TAG]
    assert git('rev-parse', entry['source_commit']+':docs').decode().strip() == entry['docs_tree']
    assert git('merge-base', '--is-ancestor', entry['source_commit'], commit) == b''
    frozen_paths = git('ls-tree', '-r', '--name-only', 'v2.0.0', 'semantic').decode().splitlines()
    assert len(frozen_paths) == 543
    for name in frozen_paths:
        assert content(name) == git('show', 'v2.0.0:'+name), name
    for name in ['evaluation/robot-metadata-review.json.gz', 'evaluation/robot-metadata-tests.json.gz', 'docs/downloads/OntoSPK-v2.0.5-annotated.ttl']:
        assert content(name) == git('show', 'v2.0.5:'+name), name
    html = content('docs/reference/search.html').decode()
    terms = json.loads(re.search(r'<script id="term-data" type="application/json">(.*?)</script>',html,re.S)[1])
    native_terms = [t for t in terms if t['kind'] == 'Native class or external handle']
    assert len(native_terms) == len({t['id'] for t in native_terms}) == len({t['href'] for t in native_terms}) == 128
    assert next(t for t in native_terms if t['id']=='EXT:ExternalUnresolved:Evidence')['href'].endswith('#evidence_1')
    parity = data('evaluation/documentation-parity.json')
    assert parity['status'] == 'PASS' and not parity['errors'] and parity['wiki_pages'] == 15 and parity['source_reader_pages'] == 19
    for row in parity['pages']:
        assert hashlib.sha256(content(row['source'])).hexdigest() == row['source_sha256']
    profile = data('evaluation/capability-profile-review.json')
    assert profile['status'] == 'ADOPTED_BOUNDED_PROFILE_WITH_DECLARED_REFERENCE_DEVIATION'
    residual = data('evaluation/metadata-residual-review.json')
    assert residual['retained_findings'] == len(residual['findings']) == 318
    for name, digest in residual['source_sha256'].items():
        assert hashlib.sha256(content(name)).hexdigest() == digest
    for name in ['publication-checks.json', 'pages-completeness.json']:
        assert data('evaluation/'+name)['status'] == 'PASS'
    citation = content('docs/releases/v2.0.8/CITATION.cff').decode()
    assert 'version: "2.0.8"' in citation and '\ndoi:' not in citation.lower()
    paths = git('ls-tree', '-r', '--name-only', commit).decode().splitlines()
    target = ROOT/'build/consolidation-release'
    target.mkdir(parents=True, exist_ok=True)
    archive = target/f'OntoSPK-{TAG}-source-and-evidence.zip'
    with zipfile.ZipFile(archive, 'w', compression=zipfile.ZIP_DEFLATED) as z:
        for name in paths:
            info = zipfile.ZipInfo(name, date_time=(2026, 10, 24, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            z.writestr(info, content(name))
    receipts = ['market-boundary-preservation.json', 'business-boundary-review.json', 'business-boundary-tests.json',
                'v2.0.2-closeout.json.gz', 'pages-completeness.json', 'publication-checks.json', 'local-identity-review.json',
                'local-identity-tests.json.gz', 'robot-metadata-review.json.gz', 'robot-metadata-tests.json.gz',
                'fol-pilot.json.gz', 'diagram-provenance.json', 'documentation-parity.json',
                'capability-profile-review.json', 'metadata-residual-review.json']
    manifest = {'release': TAG, 'source_commit': commit, 'ontology_core': 'v2.0.0',
                'scope': 'Consolidated reader corrections, PC-01 and explicit residual/rights accounting; unchanged semantic core.',
                'documentation_snapshot': entry, 'previous_documentation_mappings_preserved': True,
                'source_file_count': len(paths), 'archive': archive.name,
                'archive_sha256': hashlib.sha256(archive.read_bytes()).hexdigest(),
                'semantic_files_preserved': 543, 'boundary_handles_preserved': 27,
                'receipt_sha256': {n: hashlib.sha256(content('evaluation/'+n)).hexdigest() for n in receipts},
                'doi_registered': False, 'project_licence_selected': False}
    mf = target/'RELEASE_MANIFEST.json'
    mf.write_text(json.dumps(manifest, indent=2)+'\n')
    sums = target/'SHA256SUMS.txt'
    sums.write_text(''.join(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+p.name+'\n' for p in (archive, mf)))
    return [archive, mf, sums], manifest


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--prepare-only', action='store_true')
    args = ap.parse_args()
    commit = git('rev-parse', 'HEAD').decode().strip()
    if not args.prepare_only:
        assert os.environ.get('GITHUB_REPOSITORY') == REPO and os.environ.get('GITHUB_REF') == 'refs/heads/main'
        assert os.environ['GITHUB_SHA'] == commit
        existing = gh('api', 'repos/'+REPO+'/releases/tags/'+TAG)
        if existing.returncode == 0:
            old = json.loads(existing.stdout)
            assert not old['draft'] and not old['prerelease'] and {a['name'] for a in old['assets']} == NAMES
            print('Existing consolidated release retained: '+old['html_url'])
            return
        assert '404' in existing.stderr, existing.stderr
        runs = gh('api', 'repos/'+REPO+'/actions/workflows/documentation.yml/runs?head_sha='+commit+'&event=push')
        assert runs.returncode == 0 and any(r['head_sha'] == commit and r['conclusion'] == 'success' for r in json.loads(runs.stdout)['workflow_runs'])
    assets, manifest = package(commit)
    if args.prepare_only:
        print(json.dumps({'status': 'PREPARED_AND_VALIDATED', 'source_commit': commit, 'files': manifest['source_file_count'], 'receipts': len(manifest['receipt_sha256'])}))
        return
    result = gh('release', 'create', TAG, *map(str, assets), '--repo', REPO, '--target', commit,
                '--title', 'OntoSPK v2.0.8 — Consolidated documentation and evidence',
                '--notes-file', 'docs/releases/v2.0.8/RELEASE_NOTES.md')
    assert result.returncode == 0, result.stderr
    print(result.stdout)


if __name__ == '__main__':
    main()
