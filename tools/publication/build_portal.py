"""Build the static reference and Wiki snapshot from governed public sources."""
from pathlib import Path
import csv,hashlib,html,json,os,re,shutil
from urllib.parse import urlsplit,unquote
import markdown
from bs4 import BeautifulSoup
from rdflib import Graph,RDF,RDFS,OWL,URIRef,BNode,Literal

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'docs';GUIDE=OUT/'guide';V=ROOT/'semantic/product/v2'
SOURCE=V/'source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
REPO='https://github.com/ArazSaieArasi3/OntoSPK'
CORE_REF='v2.0.0'
G=Graph().parse(SOURCE)
def esc(x):return html.escape(str(x))
def rel(a,b):return os.path.relpath(a,b).replace(os.sep,'/')
def write(p,text):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(text,encoding='utf-8')

CSS='''*{box-sizing:border-box}body{margin:0;color:#172b3a;background:#f5f7fa;font:16px/1.7 system-ui,sans-serif}header{background:#173b54;color:white;padding:20px max(24px,calc((100vw - 1160px)/2))}header a{color:white;text-decoration:none}header strong{font-size:26px}nav{display:flex;flex-wrap:wrap;gap:18px;margin-top:10px}main{max-width:1160px;background:white;margin:24px auto;padding:30px}h1,h2,h3{line-height:1.35;color:#16394e}h1{font-size:32px}a{color:#075b9a;overflow-wrap:anywhere}table{border-collapse:collapse;width:100%;display:block;overflow:auto;margin:20px 0}th,td{border:1px solid #bdcbd4;padding:9px 12px;text-align:left;vertical-align:top}th{font-weight:700;background:white}pre{background:#edf2f6;border-left:3px solid #497991;padding:16px;white-space:pre-wrap;overflow-wrap:anywhere;font:13px/1.65 ui-monospace,monospace}code{font-size:.9em;overflow-wrap:anywhere}article{border-top:1px solid #d4dfe6;padding-top:15px;margin-top:24px}footer{max-width:1160px;margin:20px auto;padding:12px 24px;font-size:13px;color:#405667}.note{border-left:4px solid #37738d;background:#eff6f9;padding:16px}.cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(235px,1fr));gap:16px}.card{border:1px solid #cbd8e2;padding:18px;border-radius:4px}img{max-width:100%;height:auto}@media(max-width:700px){main{padding:18px;margin:0}h1{font-size:27px}}@media print{header,nav{display:none}main{margin:0;padding:0}article{break-inside:avoid}}'''
write(OUT/'assets/site.css',CSS)
def page(path,title,body):
 base=path.parent
 links=[('Home',OUT/'index.html'),('Guide',GUIDE/'Home.html'),('Conceptual reference',OUT/'reference/native/index.html'),('Logical reference',OUT/'reference/owl/index.html'),('Downloads',OUT/'downloads/index.html'),('WebVOWL',OUT/'webvowl/index.html')]
 nav=''.join('<a href="'+rel(p,base)+('' if n!='WebVOWL' else '#ontospk')+'">'+n+'</a>' for n,p in links)
 text='<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>'+esc(title)+' — OntoSPK</title><link rel="stylesheet" href="'+rel(OUT/'assets/site.css',base)+'"><header><strong><a href="'+rel(OUT/'index.html',base)+'">OntoSPK</a></strong><div>Software Product Knowledge Ontology · core 2.0.0</div><nav>'+nav+'</nav></header><main>'+body+'</main><footer>Native model 0.41.0 · logical profile 0.43.0 · <a href="'+REPO+'/releases">public release record</a>. <a href="'+REPO+'">Repository</a> · <a href="'+rel(GUIDE/'Citation.html',base)+'">Citation and reuse</a> · <a href="'+rel(GUIDE/'Limitations.html',base)+'">Limitations</a>. Generated reference is derived from the declared source; it is not independent semantic acceptance.</footer></html>'
 write(path,text)

mapping={p:GUIDE/(p.stem+'.html') for p in GUIDE.glob('*.md')}
for name in ['README','classes','associations','generalizations','commitments']:
 mapping[V/'reference'/(name+'.md')]=OUT/'reference/native'/('index.html' if name=='README' else name+'.html')
mapping[OUT/'research/related-ontologies/related-ontology-comparison.md']=OUT/'related-ontologies.html'
for src,dst in list(mapping.items()):
 if not src.exists():continue
 soup=BeautifulSoup(markdown.markdown(src.read_text(),extensions=['tables','fenced_code','toc']), 'html.parser')
 for a in soup.find_all(['a','img']):
  attr='src' if a.name=='img' else 'href';url=a.get(attr,'');u=urlsplit(url)
  if not url or u.scheme or url.startswith('#'):continue
  target=(src.parent/unquote(u.path)).resolve()
  if target in mapping:a[attr]=rel(mapping[target],dst.parent)
  elif target.is_relative_to(OUT) and target.exists():a[attr]=rel(target,dst.parent)
  elif target.is_relative_to(ROOT):a[attr]=REPO+('/tree/main/' if target.is_dir() else '/blob/main/')+target.relative_to(ROOT).as_posix()
  if u.fragment:a[attr]+='#'+u.fragment
 title=soup.find('h1').get_text() if soup.find('h1') else src.stem
 page(dst,title,str(soup))

def label(x):return str(G.value(x,RDFS.label) or str(x).rsplit('#',1)[-1].rsplit(':',1)[-1])
def term(x,depth=0):
 if isinstance(x,URIRef):return G.namespace_manager.normalizeUri(x)
 if isinstance(x,Literal):return x.n3()
 if isinstance(x,BNode):
  if depth>8:return '[nested expression]'
  return '[ '+' ; '.join(term(p,depth+1)+' '+term(o,depth+1) for p,o in sorted(G.predicate_objects(x),key=lambda t:(str(t[0]),str(t[1]))))+' ]'
 return str(x)
groups=[('classes',OWL.Class),('object-properties',OWL.ObjectProperty),('datatype-properties',OWL.DatatypeProperty),('individuals',OWL.NamedIndividual)]
counts={}
for name,typ in groups:
 entities=sorted({s for s in G.subjects(RDF.type,typ) if isinstance(s,URIRef)},key=lambda x:(label(x).lower(),str(x)));counts[name]=len(entities)
 body='<h1>'+name.replace('-',' ').title()+'</h1><p>All '+str(len(entities))+' named declarations in the pinned logical profile. Missing axioms remain unspecified; endpoints or characteristics are not guessed.</p>'
 body+='<ul>'+''.join('<li><a href="#'+hashlib.sha256(str(x).encode()).hexdigest()[:16]+'">'+esc(label(x))+'</a></li>' for x in entities)+'</ul>'
 for x in entities:
  rows=''.join('<tr><td><code>'+esc(term(p))+'</code></td><td><pre>'+esc(term(o))+'</pre></td></tr>' for p,o in sorted(G.predicate_objects(x),key=lambda t:(str(t[0]),str(t[1]))))
  body+='<article id="'+hashlib.sha256(str(x).encode()).hexdigest()[:16]+'"><h2>'+esc(label(x))+'</h2><p><code>'+esc(x)+'</code></p><table><thead><tr><th>Asserted predicate</th><th>Asserted value / expression</th></tr></thead><tbody>'+rows+'</tbody></table></article>'
 page(OUT/'reference/owl'/(name+'.html'),name.replace('-',' ').title(),body)
ontologies=list(G.subjects(RDF.type,OWL.Ontology))
meta=''.join('<li><code>'+esc(s)+'</code><pre>'+esc('\n'.join(term(p)+' '+term(o) for p,o in G.predicate_objects(s)))+'</pre></li>' for s in ontologies)
imports=list(G.objects(None,OWL.imports))
index='<h1>Logical ontology reference</h1><p>The reference enumerates asserted declarations and their actual axioms from logical profile 0.43.0. It does not add inferred domain/range declarations or convert data checks into OWL axioms.</p><ul>'+''.join('<li><a href="'+n+'.html">'+n.replace('-',' ').title()+'</a> — '+str(counts[n])+'</li>' for n,_ in groups)+'</ul><h2>Ontology metadata</h2><ul>'+meta+'</ul><p>Declared imports: '+esc(', '.join(map(str,imports)) if imports else 'none')+'.</p><p>Source graph: '+str(len(G))+' RDF triples. Full source is available in Downloads. Conceptual inventories and operational constraints are documented separately.</p>'
page(OUT/'reference/owl/index.html','Logical reference',index)

download=OUT/'downloads';download.mkdir(exist_ok=True)
assets=[(SOURCE,'ontospk.ttl'),(V/'reference/native-class-projection.csv','native-to-owl.csv'),(ROOT/'CITATION.cff','CITATION.cff'),(OUT/'downloads/OntoSPK-v2.0.5-annotated.ttl','OntoSPK-v2.0.5-annotated.ttl')]
for src,name in assets:
 if src.resolve()!=(download/name).resolve():shutil.copy2(src,download/name)
write(download/'SHA256SUMS.txt',''.join(hashlib.sha256((download/n).read_bytes()).hexdigest()+'  '+n+'\n' for _,n in assets))
page(download/'index.html','Downloads','<h1>Downloads</h1><p>The separately named <strong>v2.0.5 annotated view</strong> adds source-reviewed editorial annotations and retains 318 default ROBOT findings. Its logical axioms equal the frozen core; it has a distinct version IRI. The WIDOCO serializations below remain the original core. Read the <a href="../evaluation/robot-metadata-review.html">annotation review</a> and <a href="../evaluation/robot-metadata-tests.html">executed checks</a>.</p><p>Ontology-core files for distribution 2.0.0; inspect the release record, version and licensing information before reuse. No database is distributed in this core package.</p><ul>'+''.join('<li><a href="'+n+'">'+n+'</a></li>' for _,n in assets)+'<li><a href="SHA256SUMS.txt">SHA-256 checksums</a></li></ul>')
shutil.copy2(V/'figures/OntoSPK_Selected_40_v0_45_0.svg',OUT/'assets/selected-model.svg')
page(OUT/'index.html','Software Product Knowledge Ontology','''<h1>Software product knowledge, explicitly modeled</h1><p>OntoSPK distinguishes continuing products, intended specifications, actual realizations and evidence about their use. Its twelve domains connect strategic and development knowledge with testing, delivery and product evidence.</p><p class="note">The <strong>2.0.0 ontology core</strong> has a separate release record on GitHub. Check that record for publication state. Finite evaluation and independent scientific acceptance are separate matters.</p><div class="cards"><div class="card"><h2>Understand the model</h2><p>Read domain definitions, identity commitments and conceptual relations.</p><a href="guide/Home.html">Read the guide</a></div><div class="card"><h2>Inspect formal commitments</h2><p>Read every class, association and structural formula, then inspect the bounded OWL profile.</p><a href="reference/native/index.html">Conceptual and structural reference</a></div><div class="card"><h2>Use the formal reference</h2><p>Look up actual OWL declarations and asserted axioms.</p><a href="reference/owl/index.html">Logical reference</a></div><div class="card"><h2>Reproduce the evidence</h2><p>Run the finite published controls and read their limits.</p><a href="guide/Reproduce.html">Reproduction instructions</a></div></div><h2>Selected conceptual view</h2><p>Forty selected concepts; the complete model and its external boundaries remain in the reference.</p><a href="assets/selected-model.svg"><img src="assets/selected-model.svg" alt="Selected conceptual view of OntoSPK with forty concepts and declared relations"></a><p><a href="webvowl/index.html#ontospk">Explore the OWL view in WebVOWL</a> · <a href="related-ontologies.html">Related-ontology comparison</a> · <a href="downloads/index.html">Downloads</a></p>''')
wiki=ROOT/'wiki-src';wiki.mkdir(exist_ok=True)
for p in GUIDE.glob('*.md'):
 text=p.read_text()
 def wiki_link(m):
  title,url=m.group(1),m.group(2);u=urlsplit(url)
  if u.scheme or url.startswith('#'):return m.group(0)
  target=(p.parent/u.path).resolve()
  if target in mapping and target.parent==GUIDE:return '['+title+']('+target.stem+(('#'+u.fragment) if u.fragment else '')+')'
  source_path=target.relative_to(ROOT).as_posix()
  frozen=source_path.startswith(('semantic/','evaluation/','docs/downloads/','docs/reference/','docs/widoco/','docs/webvowl/')) or source_path in {'CITATION.cff','LICENSING.md','THIRD_PARTY_NOTICES.md','distribution-manifest.json'}
  ref=CORE_REF if frozen else 'main'
  return '['+title+']('+REPO+('/tree/' if target.is_dir() else '/blob/')+ref+'/'+source_path+(('#'+u.fragment) if u.fragment else '')+')'
 text=re.sub(r'\[([^\]]+)\]\(([^)]+)\)',wiki_link,text)
 write(wiki/p.name,text)
wiki_sections=[('Start',['Home','Overview','Domains','Conceptual-Model','External-References']),('Model and evidence',['Formalization','Constraints','Competency-Questions','Quality','Reproduce']),('Use and cite',['Visualization','Versions','Citation','References','Limitations'])]
write(wiki/'_Sidebar.md','## OntoSPK\n\n'+'\n\n'.join('### '+heading+'\n'+ '\n'.join('- ['+name.replace('-',' ')+']('+name+')' for name in names) for heading,names in wiki_sections)+'\n')
write(wiki/'_Footer.md','[Repository]('+REPO+') · [Core release]('+REPO+'/releases/tag/'+CORE_REF+') · [Guide source]('+REPO+'/blob/main/docs/guide/Versions.md) · [Citation]('+REPO+'/blob/'+CORE_REF+'/CITATION.cff)')
write(wiki/'README.md','# Wiki publication source\n\nGenerated from `docs/guide` by `tools/publication/build_portal.py`. Edit curated source, not these projections. File preparation does not imply that the GitHub Wiki has been published. See `docs/publication-status.json`.')
write(OUT/'.nojekyll','')
write(OUT/'reference/coverage.json',json.dumps({'native':json.loads((V/'reference/inventory.json').read_text()),'logical_declarations':counts,'owl_triples':len(G),'logical_source_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),'formal_description_dimensions':['identity_language','architecture','classes','object_properties','datatype_properties','individuals','axioms_constraints','reasoning','conceptual_formal_traceability','competency_questions'],'coverage_scope':'Generated inventory and curated explanation; not independent semantic acceptance.'},indent=2)+'\n')
from finish_widoco import finish
from enrich_pages import enrich
finish()
shutil.copyfile(ROOT/'tools/publication/portal.css', OUT/'assets/portal.css')
enrich()
print(json.dumps({'guide_pages':len(list(GUIDE.glob('*.md'))),'wiki_pages':len(list(wiki.glob('*.md')))-1,'logical_declarations':counts,'owl_triples':len(G),'site':'docs'},indent=2))
