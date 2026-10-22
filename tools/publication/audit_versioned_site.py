"""Verify versioned artifact links, revision metadata and payload hashes."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit,unquote
import hashlib,json
ROOT=Path(__file__).resolve().parents[2];SITE=ROOT/'build/site'
class Links(HTMLParser):
    def __init__(self):super().__init__();self.links=[];self.meta={};self.ids={}
    def handle_starttag(self,tag,attrs):
        a=dict(attrs)
        if a.get("id"):self.ids[a["id"]]=a
        if tag in ['a','link','script','img','iframe']:
            value=a.get('href' if tag in ['a','link'] else 'src','')
            if value:self.links.append(value)
        if tag=='meta':self.meta[a.get('name')]=a.get('content')
errors=[];checked=0
for file in SITE.rglob('*.html'):
    parser=Links();parser.feed(file.read_text())
    if file.relative_to(SITE).parts[0] in ['current','releases']:
        if not parser.meta.get('ontospk-documentation-source'):errors.append('Missing source metadata: '+str(file.relative_to(SITE)))
    if file.relative_to(SITE).as_posix().endswith('/webvowl/index.html'):
        for identifier in ['empty','emptyContainer']:
            if identifier not in parser.ids:errors.append('Missing upstream view-mode control: '+identifier)
        if 'hidden' not in parser.ids.get('editMode',{}):errors.append('Unavailable editing must be hidden')
        if parser.ids.get('search-input-text',{}).get('aria-label')!='Search ontology terms':errors.append('Viewer search needs an accessible name')
    if file.relative_to(SITE).as_posix().endswith('/explore/index.html') and 'viewer-filter-instructions' not in parser.ids:
        errors.append('Explorer must explain the automatic collapsing filter')
    for link in parser.links:
        u=urlsplit(link)
        if u.scheme or link.startswith('//') or not u.path:continue
        target=(file.parent/unquote(u.path)).resolve();checked+=1
        if not target.is_relative_to(SITE.resolve()) or not target.exists():errors.append(str(file.relative_to(SITE))+': '+link)
manifest=json.loads((SITE/'publication-manifest.json').read_text())
for name,digest in manifest['files'].items():
    if hashlib.sha256((SITE/name).read_bytes()).hexdigest()!=digest:errors.append('Payload digest: '+name)
print(json.dumps({'status':'PASS' if not errors else 'FAIL','versioned_html_pages':len(list(SITE.rglob('*.html'))),'local_destinations':checked,'payload_hashes':len(manifest['files']),'errors':errors},indent=2))
raise SystemExit(bool(errors))
