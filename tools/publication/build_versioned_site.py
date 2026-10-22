"""Publish immutable documentation snapshots alongside an explicitly mutable route."""
from pathlib import Path
import argparse
import hashlib
import io
import json
import re
import shutil
import subprocess
import tarfile
from html import escape

ROOT=Path(__file__).resolve().parents[2]
REGISTRY=ROOT/'tools/publication/pages-registry.json'
CORE='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12'
NATIVE='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
SEMANTIC={'semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl':CORE,'semantic/product/v2/source/formalization/Native_Model_v0_41_0.json':NATIVE}
REPO='https://github.com/ArazSaieArasi3/OntoSPK'
def git(*args):return subprocess.check_output(['git',*args],cwd=ROOT)
def verify(entry):
    sha=entry['source_commit']
    if not re.fullmatch('[0-9a-f]{40}',sha):raise ValueError('Invalid snapshot commit')
    if git('rev-parse',sha+':docs').decode().strip()!=entry['docs_tree']:raise ValueError('Frozen documentation tree changed')
    for path,digest in SEMANTIC.items():
        if hashlib.sha256(git('show',sha+':'+path)).hexdigest()!=digest:raise ValueError('Snapshot semantic identity changed: '+path)
def guard(old,new):
    for version,entry in old['releases'].items():
        if new['releases'].get(version)!=entry:raise ValueError('Existing release mapping cannot be replaced: '+version)
def decorate(folder,source,version,mutable):
    for path in folder.rglob('*.html'):
        text=path.read_text()
        text=text.replace(REPO+'/blob/main/',REPO+'/blob/'+source+'/').replace(REPO+'/tree/main/',REPO+'/tree/'+source+'/')
        relative='../'*len(path.relative_to(folder).parts)
        status='Mutable current documentation' if mutable else 'Frozen documentation release'
        banner=f'<aside class="publication-context" style="padding:10px;background:#edf3f8;color:#173b54;font:14px/1.5 system-ui,sans-serif">{status} <strong>{escape(version)}</strong> · ontology core <strong>v2.0.0</strong> · <a href="{REPO}/commit/{source}">source {source[:12]}</a> · <a href="{relative}versions/index.html">Documentation versions</a></aside>'
        if '/webvowl/' in path.as_posix():
            banner=banner.replace('class="publication-context"','class="publication-context" hidden')
            text=re.sub(r'(<div[^>]*id="ontospk-view-context"[^>]*>)',lambda m:m[1]+f'{status} {escape(version)} · <a href="{REPO}/commit/{source}">source {source[:12]}</a><br>',text,count=1)
        text=re.sub(r'(<body[^>]*>)',lambda m:m[1]+banner,text,count=1,flags=re.I)
        meta=f'<meta name="ontospk-documentation-source" content="{source}"><meta name="ontospk-documentation-version" content="{escape(version)}"><meta name="ontospk-ontology-core" content="v2.0.0">'
        text=text.replace('</head>',meta+'</head>',1)
        path.write_text(text)
def build(output,registry):
    if output.exists():shutil.rmtree(output)
    output.mkdir(parents=True)
    head=git('rev-parse','HEAD').decode().strip()
    shutil.copytree(ROOT/'docs',output/'current')
    decorate(output/'current',head,'current',True)
    links=[]
    for version,entry in registry['releases'].items():
        if not re.fullmatch(r'v\d+\.\d+\.\d+',version):raise ValueError('Invalid release route')
        verify(entry)
        target=output/'releases'/version;target.mkdir(parents=True)
        payload=git('archive',entry['source_commit'],'docs')
        with tarfile.open(fileobj=io.BytesIO(payload)) as archive:
            for member in archive.getmembers():
                name=Path(member.name)
                if not member.isfile():continue
                if name.parts[0]!='docs' or '..' in name.parts:raise ValueError('Unsafe archive path')
                dest=target.joinpath(*name.parts[1:]);dest.parent.mkdir(parents=True,exist_ok=True)
                dest.write_bytes(archive.extractfile(member).read())
        decorate(target,entry['source_commit'],version,False)
        links.append(f'<li><a href="../releases/{version}/index.html">Documentation {version}</a> — ontology core v2.0.0 — <a href="{REPO}/commit/{entry["source_commit"]}">source {entry["source_commit"][:12]}</a></li>')
    page='''<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>OntoSPK documentation</title><style>body{font:18px/1.7 system-ui,sans-serif;max-width:850px;margin:50px auto;padding:20px;color:#173b54}a{color:#145c9e}</style></head><body><main><h1>OntoSPK documentation</h1><p>Software product knowledge: conceptual model, bounded logical profile, constraints and evaluation.</p><p><a href="CURRENT/index.html">Read current documentation</a> · <a href="CURRENT/widoco/index-en.html">WIDOCO OWL reference</a> · <a href="CURRENT/explore/index.html">Explore WebVOWL</a></p><h2>Documentation versions</h2><p>The current route can change. Frozen releases retain their recorded documentation source and the ontology core version they describe.</p><ul>LINKS</ul><p><a href="https://github.com/ArazSaieArasi3/OntoSPK/wiki">Project Wiki</a> · <a href="https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.0">Ontology core release</a></p></main></body></html>'''
    (output/'versions').mkdir();(output/'versions/index.html').write_text(page.replace('CURRENT','../current').replace('LINKS',''.join(links)))
    (output/'index.html').write_text(page.replace('CURRENT','current').replace('LINKS',''.join(links).replace('../releases/','releases/')))
    (output/'.nojekyll').touch()
    manifest={'current_source_commit':head,'ontology_core':'v2.0.0','releases':registry['releases'],'files':{p.relative_to(output).as_posix():hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(output.rglob('*')) if p.is_file()}}
    (output/'publication-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    print(json.dumps({'html_pages':len(list(output.rglob('*.html'))),'frozen_releases':list(registry['releases']),'current_source_commit':head,'output':str(output)}))
if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--output',type=Path,default=ROOT/'build/site');parser.add_argument('--previous-ref');args=parser.parse_args()
    registry=json.loads(REGISTRY.read_text())
    if args.previous_ref:
        old=subprocess.run(['git','show',args.previous_ref+':tools/publication/pages-registry.json'],cwd=ROOT,capture_output=True)
        if old.returncode==0:guard(json.loads(old.stdout),registry)
    build(args.output,registry)
