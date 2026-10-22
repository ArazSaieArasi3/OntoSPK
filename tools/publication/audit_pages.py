"""Check completeness of the Pages payload and identity of its RDF downloads."""
from pathlib import Path
from urllib.parse import unquote, urlsplit
import hashlib
import json
import re
from bs4 import BeautifulSoup
from rdflib import Graph, OWL, RDF, URIRef
from rdflib.compare import isomorphic

ROOT=Path(__file__).resolve().parents[2]
DOCS=ROOT/'docs'
errors=[]
def require(ok,message):
    if not ok: errors.append(message)

source=ROOT/'semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
graph=Graph().parse(source)
widoco=(DOCS/'widoco/index-en.html').read_text()
soup=BeautifulSoup(widoco,'html.parser')
metadata=soup.select_one('.head dl').get_text(' ',strip=True)
for forbidden in ['insertlicenseURIhere','Date issued','license name goes here','in preparation']:
    require(forbidden not in metadata,'WIDOCO metadata placeholder: '+forbidden)
require('No project-wide reuse licence selected' in metadata,'Actual licence disposition')
require('153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12' in metadata,'Logical source hash displayed')
require('document.getElementById' in widoco,'URN-safe WIDOCO anchor handling')
counts={}
for label,kind in [('classes',OWL.Class),('object_properties',OWL.ObjectProperty),('datatype_properties',OWL.DatatypeProperty)]:
    terms={str(s) for s in graph.subjects(RDF.type,kind) if isinstance(s,URIRef)}
    require(all(iri in widoco for iri in terms),'WIDOCO complete '+label)
    counts[label]=len(terms)
serializations={}
for name,fmt in [('ontology.ttl','turtle'),('ontology.owl','xml'),('ontology.jsonld','json-ld'),('ontology.nt','nt')]:
    path=DOCS/'widoco'/name
    same=isomorphic(graph,Graph().parse(path,format=fmt))
    require(same,'RDF graph identity: '+name)
    serializations[name]={'graph_isomorphic':same,'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
required=['index.html','widoco/index-en.html','reference/native/classes.html','reference/native/associations.html','reference/native/generalizations.html','reference/native/commitments.html','reference/formal/index.html','reference/formal/native-structure.html','reference/formal/profile-projection.html','reference/formal/scoped-contracts.html','reference/formal/review.html','reference/search.html','evaluation/index.html','evaluation/shacl-shapes-audit.html','evaluation/shacl-simple-constraints.html','explore/index.html','downloads/index.html']
for name in required:require((DOCS/name).is_file(),'Required documentation route: '+name)
guide=list((DOCS/'guide').glob('*.html'))
require(len(guide)==15,'All 15 curated guide pages')
search_soup=BeautifulSoup((DOCS/'reference/search.html').read_text(),'html.parser')
terms=json.loads(search_soup.find(id='term-data').string)
require(len(terms)==581,'581 native and OWL search entries')
anchor_cache={}
for term in terms:
    u=urlsplit(term['href']);target=DOCS/'reference'/u.path
    if target not in anchor_cache:
        target_soup=BeautifulSoup(target.read_text(),'html.parser')
        anchor_cache[target]={s['id'] for s in target_soup.find_all(id=True)}
    require(unquote(u.fragment) in anchor_cache[target],'Search anchor '+term['href'])
# Reader pages must expose navigation and basic keyboard/document landmarks.
reader_pages=[]
for path in DOCS.rglob('*.html'):
    if {'widoco','webvowl'} & set(path.relative_to(DOCS).parts):continue
    s=BeautifulSoup(path.read_text(),'html.parser')
    require(s.html.get('lang')=='en',str(path.relative_to(DOCS))+': English language')
    require(s.find('main',id='content') is not None,str(path.relative_to(DOCS))+': main landmark')
    require(s.find('a',attrs={'class':'skip-link'}) is not None,str(path.relative_to(DOCS))+': skip link')
    require(s.find('nav',attrs={'aria-label':'Primary'}) is not None,str(path.relative_to(DOCS))+': primary navigation')
    reader_pages.append(path.relative_to(DOCS).as_posix())
coverage=json.loads((DOCS/'webvowl/coverage.json').read_text())
require(len(coverage['omitted_properties'])==10,'Ten viewer omissions disclosed')
require('10' in (DOCS/'explore/index.html').read_text() or 'ten omitted' in (DOCS/'explore/index.html').read_text(),'Viewer scope text')
result={'status':'PASS' if not errors else 'FAIL','scope':'Static Pages completeness and RDF graph identity; live browser acceptance is separate','guide_pages':len(guide),'reader_html_pages':len(reader_pages),'widoco_declarations':counts,'search_entries':len(terms),'search_anchors_checked':len(terms),'serializations':serializations,'native_classes':128,'native_associations':286,'native_generalizations':34,'scoped_commitments':22,'required_routes':required,'errors':errors}
(ROOT/'evaluation/pages-completeness.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ['serializations','required_routes']}))
raise SystemExit(bool(errors))
