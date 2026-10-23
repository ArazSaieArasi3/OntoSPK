"""Verify public source identity, evidence, navigation and conservative view coverage."""
from pathlib import Path
from urllib.parse import urlsplit,unquote
import csv,hashlib,json,re
from bs4 import BeautifulSoup
from rdflib import Graph,RDF,RDFS,OWL,URIRef
ROOT=Path(__file__).resolve().parents[2];V=ROOT/'semantic/product/v2';errors=[]
def require(ok,msg):
 if not ok:errors.append(msg)
native=V/'source/formalization/Native_Model_v0_41_0.json'
logical=V/'source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
require(hashlib.sha256(native.read_bytes()).hexdigest()=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed','Native source identity')
require(hashlib.sha256(logical.read_bytes()).hexdigest()=='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12','Logical source identity')
inv=json.loads((V/'reference/inventory.json').read_text())
require((inv['local_class_count'],inv['external_handles'],inv['associations'],inv['structural_expressions'],inv['commitments'])==(101,27,286,892,22),'Conceptual inventory')
receipt=json.loads((ROOT/'evaluation/results/INTEGRATION_RESULTS.json').read_text())
require(receipt['passed'] and len(receipt['steps'])==10 and all(x['passed'] for x in receipt['steps']),'Ten-stage published execution receipt')
for row in receipt['result_files'].values():require(hashlib.sha256((ROOT/'evaluation/results'/row['path']).read_bytes()).hexdigest()==row['sha256'],'Evidence digest: '+row['path'])
require(not (ROOT/'data-models').exists(),'Implementation directory must be outside the public core tree')
require(not (ROOT/'docs/downloads/schema.sql').exists(),'No SQL schema in core downloads')
require(not (ROOT/'docs/downloads/synthetic.sqlite.gz').exists(),'No SQLite database in core downloads')
g=Graph().parse(logical);view=json.loads((ROOT/'docs/webvowl/data/ontospk.json').read_text());coverage=json.loads((ROOT/'docs/webvowl/coverage.json').read_text())
byid={a['id']:a for a in view['classAttribute']};iris={a['iri'] for a in byid.values()}
classes={str(x) for x in g.subjects(RDF.type,OWL.Class) if isinstance(x,URIRef)}
require(classes<=iris,'Every named OWL class is represented in WebVOWL')
for a in view['propertyAttribute']:
 require(a['domain'] in byid and a['range'] in byid,'WebVOWL endpoint exists')
 if 'iri' not in a:continue
 p=URIRef(a['iri'])
 require(URIRef(byid[a['domain']]['iri']) in set(g.objects(p,RDFS.domain)),'WebVOWL domain was asserted')
 require(URIRef(byid[a['range']]['iri']) in set(g.objects(p,RDFS.range)),'WebVOWL range was asserted')
require(len(coverage['omitted_properties'])==10 and coverage['rendered_declared_properties']==322,'WebVOWL omission accounting')
sourcehash=hashlib.sha256(logical.read_bytes()).hexdigest();require(coverage['logical_source_sha256']==sourcehash,'WebVOWL source binding')
widoco=ROOT/'docs/widoco/index-en.html';require(widoco.exists(),'WIDOCO generated')
if widoco.exists():
 w=widoco.read_text();require('[Ontology Name]' not in w,'No WIDOCO title placeholder')
 require(all(x in w for x in classes),'WIDOCO contains all named class IRIs')

checked=0;fragment_warnings=[];anchors={}
def local_target(src,url):
 u=urlsplit(url)
 base='https://github.com/ArazSaieArasi3/OntoSPK/'
 if url.startswith(base+'blob/main/') or url.startswith(base+'tree/main/'):
  return ROOT/unquote(u.path.split('/main/',1)[1]),u.fragment
 if u.scheme or url.startswith('//') or not u.path:return None,u.fragment
 return (src.parent/unquote(u.path)).resolve(),u.fragment
for src in ROOT.rglob('*.html'):
 if {'.git','.venv','build','dist'} & set(src.relative_to(ROOT).parts):continue
 soup=BeautifulSoup(src.read_text(),'html.parser')
 for a in soup.find_all(['a','img','script','link']):
  attr='href' if a.name in ['a','link'] else 'src';url=a.get(attr,'')
  if not url:continue
  target,frag=local_target(src,url)
  if target is None:continue
  checked+=1;require(target.exists(),str(src.relative_to(ROOT))+': missing '+url)
  if target.exists() and frag and target.suffix=='.html' and '/webvowl/' not in target.as_posix():
   # Generated reference uses some script-driven navigation; missing static IDs are recorded separately.
   if target not in anchors:
    ts=BeautifulSoup(target.read_text(),'html.parser');anchors[target]={x.get('id') for x in ts.find_all(id=True)}|{x.get('name') for x in ts.find_all(attrs={'name':True})}
   if unquote(frag) not in anchors[target]:fragment_warnings.append({'source':str(src.relative_to(ROOT)),'target':url})
for src in list((ROOT/'docs/guide').glob('*.md'))+[ROOT/'README.md',ROOT/'CONTRIBUTING.md']:
 text=src.read_text();plain=re.sub(r'```[\s\S]*?```','',text)
 for title in re.findall(r'^#{1,3}\s+(.+)$',plain,re.M):require(not re.search(r'\b(?:W\d+|Wave|Gate|T\d{2,})\b',title),str(src.relative_to(ROOT))+': process identifier in heading')
 for url in re.findall(r'\]\(([^)]+)\)',plain):
  target,_=local_target(src,url)
  if target is not None:checked+=1;require(target.exists(),str(src.relative_to(ROOT))+': missing '+url)
patterns=['/workspace/','-----BEGIN PRIVATE KEY-----','Simotech','LenderFinance','Lender Finance','SemSCF']
for p in ROOT.rglob('*'):
 if not p.is_file() or {'.git','.venv','__pycache__','build','dist'} & set(p.parts) or p.suffix in ['.gz','.ico','.pyc']:continue
 if p==Path(__file__):continue
 try:text=p.read_text()
 except UnicodeDecodeError:continue
 for pat in patterns:require(pat.lower() not in text.lower(),str(p.relative_to(ROOT))+': disallowed public-content pattern')
for line in (ROOT/'docs/downloads/SHA256SUMS.txt').read_text().splitlines():
 digest,name=line.split('  ',1);require(hashlib.sha256((ROOT/'docs/downloads'/name).read_bytes()).hexdigest()==digest,'Download checksum '+name)
result={'status':'PASS' if not errors else 'FAIL','native_and_logical_identity_verified':not any('source identity' in e for e in errors),'local_links_checked':checked,'html_files':sum(1 for p in ROOT.rglob('*.html') if not {'.git','.venv','build','dist'} & set(p.relative_to(ROOT).parts)),'guide_pages':len(list((ROOT/'docs/guide').glob('*.md'))),'webvowl_named_classes':len(classes),'webvowl_rendered_declared_properties':322,'webvowl_omitted_properties':10,'database_payload_in_core':False,'local_evaluation_stages':len(receipt['steps']),'fragment_warnings':fragment_warnings,'browser_rendered_verification':'NOT_PERFORMED_BY_THIS_STATIC_CHECK','online_publication_verification':'NOT_EXECUTED','errors':errors}
out=ROOT/'evaluation/publication-checks.json';out.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
raise SystemExit(bool(errors))
