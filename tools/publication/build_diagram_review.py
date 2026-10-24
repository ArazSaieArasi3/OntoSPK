"""Audit the frozen selected figure and derive declared domain reading views."""
from pathlib import Path
from collections import Counter
import argparse
import copy
import hashlib
import html
import json
import math
import re
import textwrap
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[2]
NATIVE = ROOT/'semantic/product/v2/source/formalization/Native_Model_v0_41_0.json'
MANIFEST = ROOT/'semantic/product/v2/figures/Selected_View_Manifest_v0_45_0.json'
FIGURE = ROOT/'semantic/product/v2/figures/OntoSPK_Selected_40_v0_45_0.svg'
OUT = ROOT/'docs/assets/diagrams'
NS = '{http://www.w3.org/2000/svg}'
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def name(obj): return (obj.get('name') or {}).get('en', '')
def norm(text): return re.sub('[^a-z0-9]', '', text.lower())
def text(x,y,value,size=17,anchor='start',fill='#173b54'):
    return f'<text x="{x:.2f}" y="{y:.2f}" font-size="{size}" text-anchor="{anchor}" fill="{fill}">{html.escape(str(value))}</text>'
def document(width,height,title,body):
    return f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}"><title>{html.escape(title)}</title><desc>Derived reading projection of frozen OntoSPK core v2.0.0; exact source and omitted relations are recorded in diagram-provenance.json. Domain boxes are not OntoUML classes.</desc><rect width="100%" height="100%" fill="white"/><g font-family="DejaVu Sans, sans-serif">{body}</g></svg>\n'
def numbers(path): return list(map(float,re.findall(r'-?\d+(?:\.\d+)?',path)))
def rect(g):
    r=next(x for x in g.iter() if x.tag==NS+'rect')
    return tuple(float(r.get(k)) for k in ('x','y','width','height'))
def boundary_distance(point,box):
    px,py=point;x,y,w,h=box
    return min(math.hypot(px-X,py-min(max(py,y),y+h)) for X in (x,x+w)) if y<=py<=y+h else min(math.hypot(py-Y,px-min(max(px,x),x+w)) for Y in (y,y+h))

def review(native,manifest,svg):
    by={e['id']:e for e in native['elements']}
    groups={g.get('id'):g for g in svg.iter() if g.get('id')}
    errors=[];drift=[];classes=[];relations=[];colors={}
    def check(ok,message):
        if not ok: errors.append(message)
    check(manifest['source_sha256']==sha(NATIVE), 'Manifest native source hash')
    for c in manifest['classes']:
        e=by[c['native_id']];g=groups[c['display_code']]
        check(c['name']==e['name'] and c['stereotype']==e['stereotype'], c['display_code']+': class declaration')
        check(g.get('data-native-id')==e['id'] and g.get('data-stereotype')==e['stereotype'],c['display_code']+': SVG class identity/stereotype')
        labels=[''.join(t.itertext()) for t in g.iter() if t.tag==NS+'text']
        check(norm(''.join(t for t in labels if '«' not in t))==norm(name(e)),c['display_code']+': visible class label')
        check(any('«'+e['stereotype']+'»' in t for t in labels),c['display_code']+': visible stereotype')
        check(('{abstract}' in ' '.join(labels))==(e.get('isAbstract') is True),c['display_code']+': displayed abstractness')
        check(c['domain']==e['customProperties']['domain']==g.get('data-domain'),c['display_code']+': domain')
        color=next(x.get('fill') for x in g.iter() if x.tag==NS+'rect')
        if c['domain'] in colors:check(colors[c['domain']]==color,c['domain']+': color consistency')
        colors[c['domain']]=color
        classes.append({'display_code':c['display_code'],'native_id':e['id'],'name':name(e),'stereotype':e['stereotype'],'domain':c['domain'],'native_isAbstract':e.get('isAbstract'),'bounds':rect(g)})
    class_groups={g.get('data-native-id'):g for g in groups.values() if g.get('data-domain')}
    for row in manifest['relationships']:
        old=row['native_element'];e=by[old['id']];g=groups[row['display_code']]
        check(old==e,row['display_code']+': relation declaration')
        check(g.get('data-native-id')==e['id'],row['display_code']+': SVG relation identity')
        paths=[p for p in g.iter() if p.tag==NS+'path']
        check(len(paths)==2,row['display_code']+': route and head inventory')
        head=paths[1];coords=numbers(head.get('d'))
        if e['type']=='BinaryRelation':
            ends=[by[p] for p in e['properties']]
            s,t=[p['propertyType'] for p in ends]
            for index,(frozen,current) in enumerate(zip(row['properties'],ends)):
                fields={k:[frozen.get(k),current.get(k)] for k in frozen.keys()|current.keys() if frozen.get(k)!=current.get(k)}
                if fields:drift.append({'relation':row['display_code'],'property':current['id'],'differences':fields})
                check(set(fields)<= {'isReadOnly'},row['display_code']+': unadjudicated manifest drift')
                check(g.get(f'data-end-{index}-readonly')==str(bool(current.get('isReadOnly'))).lower(),row['display_code']+': current readOnly metadata')
            check(g.get('data-source-cardinality')==ends[0]['cardinality'] and g.get('data-target-cardinality')==ends[1]['cardinality'],row['display_code']+': cardinalities')
            check(g.get('data-stereotype','')==(e.get('stereotype') or ''),row['display_code']+': relation stereotype')
            labels=[''.join(x.itertext()) for x in g.iter() if x.tag==NS+'text']
            relation_labels=[v for v in labels[2:] if v!='«'+(e.get('stereotype') or '')+'»']
            check(''.join(relation_labels)==name(e) and labels[:2]==[p['cardinality'] for p in ends],row['display_code']+': visible association label/cardinalities')
            if e.get('stereotype'):check('«'+e['stereotype']+'»' in labels,row['display_code']+': visible relation stereotype')
            check(head.get('fill')=='none' and not head.get('d').strip().upper().endswith('Z'),row['display_code']+': open navigability head')
            check(g.get('data-view-target-navigable')=='true' and g.get('data-native-navigability')=='unspecified',row['display_code']+': explicit view-only navigation')
            tip=coords[2:4]
        else:
            s,t=e['specific'],e['general'];ends=[]
            check(head.get('fill')=='#ffffff' and head.get('d').strip().upper().endswith('Z'),row['display_code']+': hollow generalization triangle')
            check(not list(g.iter(NS+'text')),row['display_code']+': no generalization multiplicity')
            tip=coords[:2]
        check(g.get('data-source')==s and g.get('data-target')==t and g.get('data-head-target')==t,row['display_code']+': directed endpoints')
        distance=boundary_distance(tip,rect(class_groups[t]))
        check(distance<=3,row['display_code']+': head misses target boundary')
        relations.append({'display_code':row['display_code'],'native_id':e['id'],'type':e['type'],'name':name(e),'source':s,'target':t,'properties':copy.deepcopy(ends),'head_boundary_distance':round(distance,4)})
    check(len(drift)==6 and all(set(d['differences'])=={'isReadOnly'} for d in drift),'Six known stale manifest readOnly fields')
    all_classes=[e['id'] for e in native['elements'] if e['type']=='Class']
    all_rel=[e['id'] for e in native['elements'] if e['type']=='BinaryRelation']
    all_gen=[e['id'] for e in native['elements'] if e['type']=='Generalization']
    shown={r['native_id'] for r in relations}
    return {'status':'PASS_BOUNDED_VIEW_REVIEW' if not errors else 'FAIL','errors':errors,'classes':classes,'relations':relations,'domain_colors':colors,'historical_manifest_drift':drift,
            'omitted_classes':sorted(set(all_classes)-{c['native_id'] for c in classes}),
            'omitted_associations':sorted(set(all_rel)-shown),'omitted_generalizations':sorted(set(all_gen)-shown),
            'limits':['Open association heads assert an explicit selected-view navigation convention, not native navigability.','Generalization heads point to the general class; the review does not establish full native UFO conformance (#48).','Six historical manifest isReadOnly fields are stale; current endpoint records are supplied separately.','The frozen SVG description claims embedded draw.io data, but no mxfile/content payload exists; no editable source is claimed recovered.','Physical selected SVG size is 178 by 222.5 mm; its viewBox is portrait. It is an article-sized selected view, not a full A4 page.']}

def domains(native,colors):
    by={e['id']:e for e in native['elements']}
    packages=[e for e in native['elements'] if e['type']=='Package' and e['id'].startswith('PKG:ORSD04:')]
    names=[name(p) for p in packages];ids={n:f'D{i+1:02d}' for i,n in enumerate(names)}
    counts=Counter(e.get('customProperties',{}).get('domain','External boundaries') for e in by.values() if e['type']=='Class')
    pairs=[]
    for e in by.values():
        if e['type']!='BinaryRelation':continue
        ends=[by[p] for p in e['properties']];classes=[by[p['propertyType']] for p in ends]
        ds=[c['customProperties'].get('domain','External boundaries') for c in classes]
        pairs.append({'native_id':e['id'],'label':name(e),'source':classes[0]['id'],'target':classes[1]['id'],'source_domain':ds[0],'target_domain':ds[1],'cardinalities':[p['cardinality'] for p in ends]})
    matrix=Counter((e['source_domain'],e['target_domain']) for e in pairs)
    assert len(pairs)==286 and sum(counts.values())==128 and sum(counts[n] for n in names)==101
    assert all(a in names+['External boundaries'] and b in names+['External boundaries'] for a,b in matrix)
    weights=Counter(tuple(sorted((a,b))) for (a,b),v in matrix.items() for _ in range(v) if a!=b and a in names and b in names)
    parent={n:n for n in names}
    def find(x):
        while parent[x]!=x:x=parent[x]
        return x
    tree=[]
    for (a,b),weight in sorted(weights.items(),key=lambda x:(-x[1],x[0])):
        if find(a)==find(b):continue
        parent[find(a)]=find(b)
        candidates=sorted((e for e in pairs if {e['source_domain'],e['target_domain']}=={a,b}),key=lambda e:e['native_id'])
        tree.append({'pair':[a,b],'weight':weight,'representative':candidates[0]})
    assert len(tree)==len(names)-1
    return {'domains':[{'id':ids[n],'name':n,'color':colors[n],'classes':counts[n]} for n in names],
            'boundary_bucket':{'name':'External boundaries','classes':counts['External boundaries'],'is_domain':False},
            'associations':pairs,'matrix':[{'source':a,'target':b,'count':v} for (a,b),v in sorted(matrix.items())],
            'backbone':tree,'backbone_policy':'Deterministic maximum spanning tree of undirected cross-domain association counts; ties use domain names. One native association per retained pair is chosen by exact native ID. Arrow direction follows that representative endpoint order, not dependency, causation or native navigability.',
            'backbone_omitted_native_associations':sorted(set(e['native_id'] for e in pairs)-{e['representative']['native_id'] for e in tree})}

def draw_matrix(data):
    ds=data['domains'];names=[d['name'] for d in ds]+['External boundaries'];c=Counter({(r['source'],r['target']):r['count'] for r in data['matrix']})
    body=text(40,45,'OntoSPK domain association matrix',27)+text(40,78,'All 286 native associations. Rows: first endpoint; columns: second endpoint.',16)
    body+=text(40,104,'D01-D12 are local domains; B is the separately governed external boundary bucket.',16)
    cell=48;left=295;top=170
    for i,n in enumerate(names):
        label=ds[i]['id'] if i<12 else 'B';color=ds[i]['color'] if i<12 else '#eeeeee'
        body+=text(left+i*cell+cell/2,top-16,label,15,'middle')+text(20,top+i*cell+30,label+' '+n,14)
        for j,target in enumerate(names):
            count=c[n,target]
            body+=f'<rect x="{left+j*cell}" y="{top+i*cell}" width="{cell}" height="{cell}" fill="{color if count else "#ffffff"}" stroke="#adbcc8"/>'
            body+=text(left+j*cell+cell/2,top+i*cell+30,str(count) if count else '·',17,'middle')
    y=top+len(names)*cell+45
    body+=text(40,y,'Counts are association declarations, not records, dependencies, temporal order or causal strength.',15)
    body+=text(40,y+28,'Diagonal cells retain within-domain associations. All 34 generalizations are outside this matrix.',15)
    body+=text(40,y+56,'Source: native 0.41.0 / core v2.0.0. Full ID-level aggregation and omissions: diagram-provenance.json.',14)
    return document(1010,y+95,'OntoSPK complete domain association matrix',body)

def draw_backbone(data):
    ds={d['name']:d for d in data['domains']};adj={n:[] for n in ds}
    edge_labels=[]
    for edge in data['backbone']:
        a,b=edge['pair'];adj[a].append(b);adj[b].append(a)
    coords={};leaf=[0];levels={};children={}
    def place(n,parent=None,depth=0):
        kids=sorted(x for x in adj[n] if x!=parent);children[n]=kids;levels[n]=depth
        for k in kids:place(k,n,depth+1)
        if not kids:x=leaf[0];leaf[0]+=1
        else:x=sum(coords[k][0] for k in kids)/len(kids)
        coords[n]=(x,depth)
    place('Product Portfolio')
    step=300;nodew=250;nodeh=76;top=160
    coords={n:(90+x*step,top+d*205) for n,(x,d) in coords.items()}
    width=max(1050,leaf[0]*step+180);height=max(y for x,y in coords.values())+230
    body='<defs><marker id="orientation" markerWidth="10" markerHeight="10" refX="9" refY="5" orient="auto"><path d="M 1 1 L 9 5 L 1 9" fill="none" stroke="#344d60" stroke-width="1.4"/></marker></defs>'
    body+=text(35,45,'OntoSPK domain overview — selected navigation backbone',27)
    body+=text(35,78,'12 domain boxes; 11 representative native associations. This is a declared reading projection.',16)
    body+=text(35,104,'Arrows show the representative association endpoint order, not domain dependency or native navigability.',15)
    for edge in data['backbone']:
        e=edge['representative'];a,b=e['source_domain'],e['target_domain'];x1,y1=coords[a];x2,y2=coords[b]
        child=b if levels[a]<levels[b] else a
        dx=x2-x1;dy=y2-y1;fraction=min(nodew/2/abs(dx) if dx else float('inf'),nodeh/2/abs(dy) if dy else float('inf'))
        start=(x1+nodew/2+fraction*dx,y1+nodeh/2+fraction*dy)
        end=(x2+nodew/2-fraction*dx,y2+nodeh/2-fraction*dy)
        body+=f'<g data-native-id="{html.escape(e["native_id"])}" data-source-domain="{html.escape(a)}" data-target-domain="{html.escape(b)}"><title>{html.escape(e["label"]+": "+e["source"]+" to "+e["target"])}</title><path d="M {start[0]} {start[1]} L {end[0]} {end[1]}" fill="none" stroke="#344d60" stroke-width="1.6" marker-end="url(#orientation)"/></g>'
        par=a if child==b else b
        cx,cy=coords[child];px,py=coords[par]
        lx=.75*(cx+nodew/2)+.25*(px+nodew/2);ly=.75*(cy+nodeh/2)+.25*(py+nodeh/2)
        label=e['label'];font=min(14,360/max(1,len(label)));labelw=len(label)*font*.62+12
        edge_labels.append(f'<rect x="{lx-labelw/2}" y="{ly-12}" width="{labelw}" height="24" fill="white"/>'+text(lx,ly+5,label,font,'middle'))
    body+=''.join(edge_labels)
    for n,(x,y) in coords.items():
        d=ds[n];body+=f'<g data-domain="{html.escape(n)}"><rect x="{x}" y="{y}" width="{nodew}" height="{nodeh}" rx="4" fill="{d["color"]}" stroke="#344d60"/>'
        body+=text(x+nodew/2,y+30,d['id']+' '+n,16,'middle')+text(x+nodew/2,y+55,str(d['classes'])+' local classes',14,'middle')+'</g>'
    y=height-75;body+=text(35,y,'Selection: maximum spanning tree of cross-domain association counts; exact tie-breaks and all omitted IDs are recorded.',14)
    body+=text(35,y+26,'Boxes denote domain groupings, not OntoUML classes. Read the complete matrix and native reference for all relations and boundaries.',14)
    return document(width,height,'OntoSPK selected domain relationship overview',body)

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--render-png',action='store_true');args=ap.parse_args()
    native=json.loads(NATIVE.read_text());manifest=json.loads(MANIFEST.read_text());svg=ET.parse(FIGURE).getroot()
    result=review(native,manifest,svg);assert not result['errors'],result['errors']
    result['sources']={p.relative_to(ROOT).as_posix():sha(p) for p in (NATIVE,MANIFEST,FIGURE)}
    result['domain_views']=domains(native,result['domain_colors'])
    OUT.mkdir(parents=True,exist_ok=True)
    for filename,payload in [('domain-matrix.svg',draw_matrix(result['domain_views'])),('domain-backbone.svg',draw_backbone(result['domain_views']))]:
        (OUT/filename).write_text(payload)
    # Preserve the visible selected geometry but remove the unsupported editable-source claim.
    ET.register_namespace('','http://www.w3.org/2000/svg')
    svg.find(NS+'title').text='OntoSPK reviewed selected conceptual view — portrait article figure'
    svg.find(NS+'desc').text='Reviewed selected view: 40 classes, 48 associations, 11 generalizations. Geometry, visible labels, cardinalities and domain colors retain the released view. Open association heads are explicitly view-only navigability; native navigability is unspecified. Exact source bindings, current endpoint properties, historical manifest drift and omissions are recorded in diagram-provenance.json. No embedded draw.io source is present.'
    ET.SubElement(svg,NS+'metadata',{'id':'current-review-binding'}).text=json.dumps(result['sources'],sort_keys=True)
    ET.ElementTree(svg).write(OUT/'selected-reviewed.svg',encoding='unicode',xml_declaration=True)
    if args.render_png:
        import cairosvg
        from PIL import Image,PngImagePlugin
        for stem in ('domain-matrix','domain-backbone'):
            source=OUT/(stem+'.svg');target=OUT/(stem+'.png')
            cairosvg.svg2png(url=str(source),write_to=str(target),scale=2)
            image=Image.open(target);info=PngImagePlugin.PngInfo();info.add_text('SourceSVG_SHA256',sha(source));info.add_text('Renderer','CairoSVG 2.8.2; presentation raster, not a semantic source')
            image.save(target,pnginfo=info)
    result['artifacts']={p.name:sha(p) for p in sorted(OUT.iterdir()) if p.is_file()}
    (ROOT/'evaluation/diagram-provenance.json').write_text(json.dumps(result,indent=2)+'\n')
    rows='\n'.join(f"| {r['display_code']} | `{r['native_id']}` | {r['type']} | `{r['source']}` | `{r['target']}` | {r['head_boundary_distance']} |" for r in result['relations'])
    doc='# Diagram provenance and verification\n\n'
    doc+='**Result: PASS_BOUNDED_VIEW_REVIEW.** The complete native source contains 128 classes, 286 associations and 34 generalizations. The approved public selected view contains 40 classes, 48 associations and 11 generalizations. All visible names, stereotypes, endpoint cardinalities and arrow target geometry match the declared selected-view profile and current native inputs. This is a bounded source/notation review, not independent scientific acceptance.\n\n'
    doc+='## Historical discrepancies and disposition\n\nSix isReadOnly fields in the historical manifest are null although current native endpoints and SVG metadata say true. The accepted inputs are preserved; this report supplies complete current endpoint records for the 59 displayed relationships. The old SVG description also claims embedded draw.io data, which its XML does not contain. The reviewed presentation copy removes that unsupported claim while preserving visible geometry. No editable source is claimed recovered.\n\n'
    doc+='## Reading the notation\n\nAssociation heads are open and declare target navigability only in this selected-view convention. They do not establish native navigability or causal/dependency relations. Generalization heads are hollow triangles pointing to the general class; generalizations carry no multiplicities. All 59 head tips meet the intended class boundary within three SVG coordinate units. Explicitly abstract classes are marked; unspecified native abstractness is not promoted to a scientific decision. Relation-family stereotypes are not invented for plain associations. The physical SVG is 178 by 222.5 mm with a portrait viewBox, rather than a full A4 page.\n\n'
    doc+='## Two domain views\n\nThe complete matrix accounts for all 286 association declarations, including within-domain cells and a separate external boundary bucket. Its row/column direction follows native endpoint order. The rectangle/arrow view uses a deterministic maximum spanning tree over local cross-domain association counts: twelve domains and eleven representative associations. Native ID breaks representative ties. The machine-readable report lists every omitted relation and every representative endpoint/cardinality; this is a navigation subset, not a new domain ontology, dependency architecture or assertion that the omitted links are absent. All twelve domain colors are taken directly from the selected figure. The 34 generalizations are not counted as associations.\n\n'
    doc+='## Scope and omissions\n\nThe selected view omits 88 class symbols, 238 associations and 23 generalizations. Exact omitted identifiers and all current displayed endpoint properties are recorded in `diagram-provenance.json`. The complete native model and exhaustive reference remain the full ontology source; no full-model image or independent UFO conformance certificate is claimed. PNGs are presentation exports tied to their SVG source hash; CI regenerates SVGs and verifies PNG source binding, not cross-platform byte-identical font rasterization.\n\n'
    doc+='| Display | Native relation | Type | Source | Target | Head distance |\n| --- | --- | --- | --- | --- | ---: |\n'+rows+'\n\nReproduce with `python tools/publication/build_diagram_review.py`; use `--render-png` to explicitly refresh presentation exports.\n'
    (ROOT/'evaluation/diagram-provenance.md').write_text(doc)
    print(json.dumps({'status':result['status'],'classes':len(result['classes']),'relations':len(result['relations']),'historical_manifest_fields':len(result['historical_manifest_drift']),'domain_associations':len(result['domain_views']['associations']),'backbone_edges':len(result['domain_views']['backbone']),'errors':result['errors']}))

if __name__=='__main__': main()
