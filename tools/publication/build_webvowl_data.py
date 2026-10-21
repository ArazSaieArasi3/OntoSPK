"""Project declared URI endpoints into WebVOWL without inventing missing axioms."""
from pathlib import Path
import hashlib,json
from rdflib import Graph,RDF,RDFS,OWL,URIRef

ROOT=Path(__file__).resolve().parents[2]
source=ROOT/'semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
g=Graph().parse(source)
classes={x for x in g.subjects(RDF.type,OWL.Class) if isinstance(x,URIRef)}
objects={x for x in g.subjects(RDF.type,OWL.ObjectProperty) if isinstance(x,URIRef)}
data={x for x in g.subjects(RDF.type,OWL.DatatypeProperty) if isinstance(x,URIRef)}
nodes=set(classes);edges=[];omitted=[]
for p in sorted(objects|data):
 ds=list(g.objects(p,RDFS.domain));rs=list(g.objects(p,RDFS.range))
 if len(ds)!=1 or len(rs)!=1 or not isinstance(ds[0],URIRef) or not isinstance(rs[0],URIRef):
  omitted.append({'iri':str(p),'reason':'An exact single declared URI domain and range are required for this view.','declared_domains':list(map(str,ds)),'declared_ranges':list(map(str,rs))});continue
 nodes.update([ds[0],rs[0]]);edges.append((p,ds[0],rs[0],'owl:DatatypeProperty' if p in data else 'owl:ObjectProperty'))
for a,b in g.subject_objects(RDFS.subClassOf):
 if isinstance(a,URIRef) and isinstance(b,URIRef):nodes.update([a,b]);edges.append((None,a,b,'rdfs:subClassOf'))
def ident(x):return 'n'+hashlib.sha256(str(x).encode()).hexdigest()[:20]
def label(x):return str(g.value(x,RDFS.label) or str(x).rsplit('#',1)[-1].rsplit(':',1)[-1])
v={'_comment':'Derived exploratory view; missing endpoints are omitted, not supplied. See coverage.json.','header':{'languages':['en'],'title':{'en':'OntoSPK bounded OWL profile'},'iri':'urn:productium:specification-profile:','version':'Logical profile 0.43.0; public 2.0.0 preparation','description':{'en':'An exploratory projection of asserted named classes, declared property endpoints and URI subclass edges. It does not encode all restrictions, disjointness, SHACL or SQL policies.'}},'namespace':[{'name':p,'iri':str(n)} for p,n in g.namespaces()],'class':[],'classAttribute':[],'property':[],'propertyAttribute':[]}
for n in sorted(nodes):
 typ='owl:Class' if n in classes else ('owl:Thing' if n==OWL.Thing else 'rdfs:Datatype')
 v['class'].append({'id':ident(n),'type':typ})
 a={'id':ident(n),'iri':str(n),'label':{'en':label(n)}}
 if g.value(n,RDFS.comment):a['comment']={'en':str(g.value(n,RDFS.comment))}
 if typ=='rdfs:Datatype':a['attributes']=['datatype']
 v['classAttribute'].append(a)
for i,(p,a,b,typ) in enumerate(edges):
 id='p'+str(i);v['property'].append({'id':id,'type':typ})
 x={'id':id,'domain':ident(a),'range':ident(b),'label':{'en':label(p) if p else 'subclass of'}}
 if p:x['iri']=str(p)
 v['propertyAttribute'].append(x)
v['metrics']={'classCount':len(classes),'datatypeCount':len(nodes-classes),'objectPropertyCount':sum(t=='owl:ObjectProperty' for _,_,_,t in edges),'datatypePropertyCount':sum(t=='owl:DatatypeProperty' for _,_,_,t in edges),'propertyCount':len(edges),'nodeCount':len(nodes),'individualCount':0}
out=ROOT/'docs/webvowl/data';out.mkdir(parents=True,exist_ok=True)
(out/'ontospk.json').write_text(json.dumps(v,indent=2)+'\n')
receipt={'logical_source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'adapter':'tools/publication/build_webvowl_data.py','named_classes':len(classes),'named_classes_rendered':len(classes&nodes),'declared_object_properties':len(objects),'declared_datatype_properties':len(data),'rendered_declared_properties':sum(p is not None for p,_,_,_ in edges),'rendered_uri_subclass_edges':sum(p is None for p,_,_,_ in edges),'omitted_properties':omitted,'scope':'Asserted URI endpoints only; anonymous axioms, disjointness, SHACL and SQL remain in the formal reference. No missing domain or range is invented.','widoco_default_converter':'The unmodified source produced an empty WebVOWL entity projection with the bundled converter; this explicit adapter preserves original URN identifiers.'}
(out.parent/'coverage.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({k:v for k,v in receipt.items() if k!='omitted_properties'},indent=2));print('Omitted properties:',len(omitted))
