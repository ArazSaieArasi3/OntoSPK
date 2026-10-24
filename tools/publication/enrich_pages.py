"""Assemble the reader portal around WIDOCO and complete governed references."""
from pathlib import Path
from urllib.parse import urlsplit, unquote
import csv
import hashlib
import html
import json
import os
import re
import markdown
from markdown.extensions.toc import slugify
from bs4 import BeautifulSoup
from rdflib import Graph, OWL, RDF, RDFS, URIRef

ROOT = Path(__file__).resolve().parents[2]
DOCS = ROOT / 'docs'
REPO = 'https://github.com/ArazSaieArasi3/OntoSPK'
CORE = 'semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
SOURCE_BASELINE = 'cea116fbd022bb8ded5f33b6b4dfb779d1a7cb05'
GUIDE_NAMES = ['Home','Overview','Domains','Conceptual-Model','Formalization','Constraints','Competency-Questions','Quality','Reproduce','Visualization','External-References','Versions','Citation','References','Limitations']


def esc(value):
    return html.escape(str(value), quote=True)


def relative(target, source):
    return os.path.relpath(target, source.parent).replace(os.sep, '/')


def enrich():
    viewer_path = DOCS/'webvowl/index.html'
    viewer = BeautifulSoup(viewer_path.read_text(), 'html.parser')
    for duplicate in viewer.find_all(id='ontospk-view-context'):
        duplicate.decompose()
    viewer.html['lang']='en'
    viewer.find('meta',attrs={'name':'viewport'})['content']='width=device-width,initial-scale=1'
    old_banner=viewer.find(id='ontospk-view-context') or viewer.body.find('div',recursive=False)
    if old_banner and (old_banner.get('id') == 'ontospk-view-context' or 'OntoSPK documentation' in old_banner.get_text()):
        old_banner.decompose()
    viewer.body.insert(0,BeautifulSoup('<div id="ontospk-view-context" style="position:fixed;left:10px;top:6px;z-index:10000;background:white;padding:6px;font:12px/1.4 system-ui,sans-serif;color:#173b54;max-width:75%"><a href="../index.html">OntoSPK</a> · <a href="../widoco/index-en.html">OWL reference</a> · <a href="../downloads/index.html">Downloads</a> · <a href="coverage.json">10 omitted properties and scope</a><br>Exploratory view of ontology core v2.0.0; source identifiers preserved.</div>','html.parser'))
    viewer_path.write_text(str(viewer),encoding='utf-8')
    mapping = {}
    formal = ROOT / 'semantic/product/v2/formal-specification'
    for source in formal.glob('*.md'):
        mapping[source] = DOCS / 'reference/formal' / ('index.html' if source.stem == 'README' else source.stem+'.html')
    expanded_reports = ['v2.0.2-closeout','shacl-complex','owl-hermit','robot-report','cq-regression','core-regression']
    boundary_reports = ['business-boundary-review','business-boundary-tests','market-boundary-preservation']
    current_reports = boundary_reports + ['local-identity-review','local-identity-tests','robot-metadata-review','robot-metadata-tests']
    reports = ['coverage-register','comprehensive-coverage-plan','shacl-shapes-audit','shacl-simple-constraints','wiki-publication-verification'] + expanded_reports + current_reports
    for name in reports:
        mapping[ROOT/'evaluation'/f'{name}.md'] = DOCS/'evaluation'/f'{name}.html'
    for name in ['README','classes','associations','generalizations','commitments']:
        mapping[ROOT/'semantic/product/v2/reference'/f'{name}.md'] = DOCS/'reference/native'/('index.html' if name=='README' else name+'.html')
    for name in GUIDE_NAMES:
        mapping[DOCS/'guide'/f'{name}.md'] = DOCS/'guide'/f'{name}.html'

    for source, target in mapping.items():
        if source.parent == formal or source.parent == ROOT/'evaluation':
            soup = BeautifulSoup(markdown.markdown(source.read_text(), extensions=['tables','fenced_code','toc']), 'html.parser')
            for a in soup.find_all('a', href=True):
                u = urlsplit(a['href'])
                if u.scheme or not u.path:
                    continue
                dest = (source.parent/unquote(u.path)).resolve()
                evidence_ref = 'v2.0.2' if dest.parent == ROOT/'evaluation' and any(dest.name.startswith(n+'.') for n in expanded_reports) else SOURCE_BASELINE
                if dest.parent == ROOT/'evaluation' and any(dest.name.startswith(n+'.') for n in current_reports):
                    evidence_ref = 'main'
                a['href'] = relative(mapping[dest], target) if dest in mapping else REPO+'/blob/'+('v2.0.0' if dest.is_relative_to(ROOT/'semantic') else evidence_ref)+'/'+dest.relative_to(ROOT).as_posix()
                if u.fragment:
                    a['href'] += '#'+u.fragment
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text('<html lang="en"><head><title>'+esc(source.stem)+'</title></head><body><main>'+str(soup)+'</main></body></html>')

    graph = Graph().parse(ROOT/CORE)
    terms = []
    for kind, rdf_type, page in [('OWL class',OWL.Class,'classes'),('Object property',OWL.ObjectProperty,'object-properties'),('Datatype property',OWL.DatatypeProperty,'datatype-properties')]:
        for iri in sorted({s for s in graph.subjects(RDF.type,rdf_type) if isinstance(s,URIRef)}, key=str):
            label = str(graph.value(iri,RDFS.label) or str(iri).rsplit(':',1)[-1])
            terms.append({'label':label,'kind':kind,'id':str(iri),'href':'owl/'+page+'.html#'+hashlib.sha256(str(iri).encode()).hexdigest()[:16]})
    native_text = (ROOT/'semantic/product/v2/reference/classes.md').read_text()
    for label in re.findall(r'^## (.+)$', native_text, re.M):
        terms.append({'label':label,'kind':'Native class or external handle','id':label,'href':'native/classes.html#'+slugify(label,'-')})
    search = '<h1>Find a class or property</h1><p>Search the 128 native class/handle entries and 453 OWL declarations. These are different inventories; the native and OWL models have distinct interpretations.</p><label for="term-query">Name, identifier or declaration kind</label><input id="term-query" type="search" placeholder="For example: ProductRealization" autocomplete="off"><p id="term-count" role="status"></p><ul id="term-results"></ul><noscript><p>Search needs JavaScript. Use the complete <a href="native/classes.html">native catalogue</a> or <a href="../widoco/index-en.html">WIDOCO index</a>.</p></noscript>'
    search += '<script id="term-data" type="application/json">'+json.dumps(terms).replace('</','<\\/')+'</script><script src="../assets/term-search.js" defer></script>'
    (DOCS/'reference/search.html').write_text('<html lang="en"><head><title>Term search</title></head><body><main>'+search+'</main></body></html>')
    (DOCS/'assets/term-search.js').write_text('''const terms=JSON.parse(document.getElementById('term-data').textContent);const query=document.getElementById('term-query');const results=document.getElementById('term-results');const count=document.getElementById('term-count');function render(){const q=query.value.trim().toLowerCase();const selected=terms.filter(t=>(t.label+' '+t.id+' '+t.kind).toLowerCase().includes(q));results.replaceChildren();for(const t of selected){const li=document.createElement('li');const a=document.createElement('a');a.href=t.href;a.textContent=t.label;li.append(a,document.createTextNode(' — '+t.kind));results.append(li)}count.textContent=selected.length+' matching entries'}query.addEventListener('input',render);render();\n''')

    evaluation = '<h1>Evaluation and evidence</h1><p>OntoSPK publishes finite test outcomes and their limitations. The ontology core remains v2.0.0. The expanded evaluation increment is v2.0.2; <a href="'+REPO+'/releases/tag/v2.0.2">GitHub Releases</a> records its publication state. These overlapping denominators are not a semantic-correctness percentage.</p><h2>Expanded evaluation v2.0.2</h2><p><a href="v2.0.2-closeout.html">Read the accepted scope and full closeout</a>. All 1,977 SHACL components are accounted for, including 113 complex components. The bounded OWL profile passes OWL 2 DL and consistency checks; all 121 named classes are satisfiable, and 71 expanded HermiT scenarios match their expected results. All 56 CQ contracts pass 374 exact-answer comparisons. The default ROBOT report retains 812 metadata findings (288 ERROR, 451 WARN, 73 INFO); these are adjudicated, not claimed repaired.</p><ul>'
    evaluation += ''.join('<li><a href="'+name+'.html">'+name.replace('-',' ').title()+'</a></li>' for name in expanded_reports)
    evaluation += '</ul><h2>Released core baseline</h2><ul><li><a href="../guide/Quality.html">Historical core methods, outcomes and interpretation</a></li><li><a href="../guide/Competency-Questions.html">Competency questions and replay contracts</a></li><li><a href="'+REPO+'/blob/v2.0.0/evaluation/results/INTEGRATION_RESULTS.json">Exact original ten-stage integration receipt</a></li></ul><h2>Source inventories and simple components</h2><p>The graph audit covers four active SHACL graphs; isolated simple-component cases cover 1,864 occurrences, with 1,754 constructible expected violations and 110 logically unreachable negative cases. The register is the original test design; actual execution is recorded in the v2.0.2 closeout.</p><ul>'
    evaluation += ''.join('<li><a href="'+name+'.html">'+name.replace('-',' ').title()+'</a></li>' for name in reports[:4])
    evaluation += '</ul><h2>Current boundary policy reviews</h2><p>The <a href="business-boundary-review.html">Business review</a> decides five local reference-only policies and traces all eight native uses. Its <a href="business-boundary-tests.html">executable record tests</a> cover the separate adapter. The <a href="market-boundary-preservation.html">Market preservation receipt</a> records owner acceptance of current reference use, all 13 native uses, 90 adverse controls and preservation of all 27 boundaries and 543 semantic files. Private repository publication and new cross-ontology wiring are deferred. External equivalence is not asserted. The <a href="'+REPO+'/releases/tag/v2.0.3">v2.0.3 release record</a> identifies publication of this documentation/evidence patch; no v2.1.0 semantic release is claimed.</p><h2>Bounded local identity and event review</h2><p>The <a href="local-identity-review.html">local review</a> assesses 37 retained questions and two updated commitments. Its <a href="local-identity-tests.html">focused tests</a> include 864 transition combinations and explicit occurrence/history contrasts. Native Mode profile adjudication remains <a href="https://github.com/ArazSaieArasi3/OntoSPK/issues/48">issue #48</a>; the legacy direct-DML limit and independent scientific limits are retained. The <a href="https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.4">v2.0.4 release record</a> identifies publication of this evidence patch.</p><h2>Editorial annotation increment v2.0.5</h2><p>The <a href="robot-metadata-review.html">source review</a> accounts for all 812 baseline ROBOT findings. The separate <a href="../downloads/OntoSPK-v2.0.5-annotated.ttl">annotated editorial view</a> resolves 492; its <a href="robot-metadata-tests.html">fresh default-report and logical checks</a> retain 320 findings (34 ERROR, 213 WARN, 73 INFO), including held boundaries and the unselected licence. The core and WIDOCO source remain v2.0.0. This is not a clean default report. See <a href="https://github.com/ArazSaieArasi3/OntoSPK/releases/tag/v2.0.5">v2.0.5</a> for the immutable package.</p><h2>Publication acceptance</h2><p>The <a href="wiki-publication-verification.html">Wiki receipt</a> records a separate publication check. Browser and deployment receipts for Pages must identify their own exact source.</p><h2>Limits</h2><p>Independent domain review, external-owner equivalence, modal and causal adequacy, and production readiness are not established by these finite checks. Read <a href="../guide/Limitations.html">the limitations</a> before reuse.</p>'
    (DOCS/'evaluation/index.html').write_text('<html lang="en"><head><title>Evaluation and evidence</title></head><body><main>'+evaluation+'</main></body></html>')

    coverage = json.loads((DOCS/'webvowl/coverage.json').read_text())
    omissions = ''.join('<tr><td><code>'+esc(row['iri'])+'</code></td><td>'+esc(row['reason'])+'</td></tr>' for row in coverage['omitted_properties'])
    explore = '<h1>Explore the OWL profile</h1><p>WebVOWL 1.1.7 displays the bounded OWL profile, preserving its original identifiers. It includes all 121 named classes, 322 properties with exact declared URI endpoints and 34 URI subclass edges. The ten omitted properties are listed below.</p><p><a href="../webvowl/index.html#ontospk" target="_blank" rel="noopener">Open the full-size viewer</a> · <a href="../widoco/index-en.html">WIDOCO reference</a> · <a href="../downloads/index.html">Source downloads</a> · <a href="../webvowl/coverage.json">Machine-readable coverage</a></p><p class="note">The graph does not show all anonymous restrictions, disjointness, native identity commitments or SHACL conditions. Use the conceptual diagram and formal reference to interpret those commitments.</p><iframe class="explorer-frame" title="OntoSPK bounded OWL profile in WebVOWL" src="../webvowl/index.html#ontospk" loading="lazy"></iframe><h2>Omitted properties</h2><table><thead><tr><th>Property IRI</th><th>Reason</th></tr></thead><tbody>'+omissions+'</tbody></table><h2>Reproduce this view</h2><p>The explicit adapter and pinned viewer build are described in <a href="../guide/Visualization.html">Visualization</a>. <a href="../tool-provenance.json">Tool provenance</a> records the input identity, viewer source and dependency lock.</p>'
    (DOCS/'explore').mkdir(exist_ok=True)
    (DOCS/'explore/index.html').write_text('<html lang="en"><head><title>Explore the OWL profile</title></head><body><main>'+explore+'</main></body></html>')

    for path in sorted(DOCS.rglob('*.html')):
        if 'widoco' in path.relative_to(DOCS).parts or 'webvowl' in path.relative_to(DOCS).parts:
            continue
        soup = BeautifulSoup(path.read_text(), 'html.parser')
        main = soup.find('main')
        if not main:
            continue
        # Convert links to already-generated source documents into local Pages
        # routes. Frozen semantic source references keep their release identity.
        for a in main.find_all('a', href=True):
            href = a['href']
            for prefix in [REPO+'/blob/main/',REPO+'/blob/v2.0.0/']:
                if href.startswith(prefix):
                    relpath, _, fragment = href[len(prefix):].partition('#')
                    dest = ROOT/unquote(relpath)
                    if dest in mapping:
                        a['href'] = relative(mapping[dest], path)+(('#'+fragment) if fragment else '')
                    elif dest.is_relative_to(DOCS) and dest.is_file() and dest.suffix == '.html':
                        a['href'] = relative(dest, path)+(('#'+fragment) if fragment else '')
                    elif relpath.startswith('semantic/'):
                        a['href'] = REPO+'/blob/v2.0.0/'+relpath+(('#'+fragment) if fragment else '')
        for tag in main.find_all(string=lambda s: s and 'These are source snapshots; versioned live Pages routes will be linked after publication.' in s):
            tag.replace_with(str(tag).replace('These are source snapshots; versioned live Pages routes will be linked after publication.','The references below are served within the same documentation version.'))
        if path == DOCS/'index.html':
            for a in main.find_all('a', href=True):
                if a['href']=='reference/owl/index.html':
                    a['href']='widoco/index-en.html'
            intro = BeautifulSoup('<p class="eyebrow">Ontology core v2.0.0 · WIDOCO reference</p><p>Start with the <a href="guide/Overview.html">overview</a>, browse the <a href="widoco/index-en.html">complete OWL reference</a>, or <a href="reference/search.html">find a class or property</a>. The guide, formal specification, evaluation and downloads are connected by the same version.</p>', 'html.parser')
            main.find('h1').insert_after(intro)
        if path == DOCS/'downloads/index.html':
            extra = BeautifulSoup('<h2>RDF serializations</h2><p>All four downloads are checked for RDF graph equivalence to the released logical source.</p><ul>'+''.join('<li><a href="../widoco/'+name+'">'+label+'</a></li>' for name,label in [('ontology.ttl','Turtle'),('ontology.owl','RDF/XML'),('ontology.jsonld','JSON-LD'),('ontology.nt','N-Triples')])+'</ul><p><a href="../widoco/serialization-receipt.json">Serialization hashes and graph-equivalence receipt</a></p><h2>Native model and complete sources</h2><ul><li><a href="https://raw.githubusercontent.com/ArazSaieArasi3/OntoSPK/v2.0.0/semantic/product/v2/source/formalization/Native_Model_v0_41_0.json">Native conceptual model (JSON)</a></li><li><a href="'+REPO+'/tree/v2.0.0/semantic/product/v2/source/validation_v041">Four SHACL source graphs and validation fixtures</a></li><li><a href="'+REPO+'/archive/refs/tags/v2.0.0.zip">Complete released ontology-core source (ZIP)</a></li><li><a href="../reference/formal/index.html">First-order specification and source bindings</a></li></ul>', 'html.parser')
            main.append(extra)
        headings = main.find_all(['h2','h3'])
        toc=[]
        for index,h in enumerate(headings[:18]):
            if not h.get('id'):
                h['id']='section-'+str(index+1)
            toc.append('<li><a href="#'+esc(h['id'])+'">'+esc(h.get_text(' ',strip=True))+'</a></li>')
        top = [('Overview',DOCS/'index.html'),('OWL reference',DOCS/'widoco/index-en.html'),('Conceptual reference',DOCS/'reference/native/index.html'),('Evaluation',DOCS/'evaluation/index.html'),('Explore',DOCS/'explore/index.html'),('Downloads',DOCS/'downloads/index.html')]
        links=''.join('<a'+(' aria-current="page"' if p==path else '')+' href="'+relative(p,path)+'">'+label+'</a>' for label,p in top)
        sidebar='<h2>Documentation</h2><ul>'+''.join('<li><a'+(' aria-current="page"' if path==DOCS/'guide'/f'{n}.html' else '')+' href="'+relative(DOCS/'guide'/f'{n}.html',path)+'">'+n.replace('-',' ')+'</a></li>' for n in GUIDE_NAMES)+'</ul><h2>Reference tools</h2><ul><li><a href="'+relative(DOCS/'reference/search.html',path)+'">Find a class or property</a></li><li><a href="'+relative(DOCS/'reference/formal/index.html',path)+'">First-order specification</a></li><li><a href="'+REPO+'/wiki">GitHub Wiki</a></li></ul>'
        title = main.find('h1').get_text(' ',strip=True) if main.find('h1') else 'OntoSPK'
        output='<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="description" content="'+esc(title)+' — OntoSPK ontology documentation"><title>'+esc(title)+' — OntoSPK</title><link rel="stylesheet" href="'+relative(DOCS/'assets/portal.css',path)+'"></head><body><a class="skip-link" href="#content">Skip to content</a><header><a class="brand" href="'+relative(DOCS/'index.html',path)+'">OntoSPK</a><p>Software Product Knowledge Ontology · core v2.0.0</p><nav aria-label="Primary">'+links+'</nav></header><div class="layout"><aside class="sidebar" aria-label="Documentation navigation">'+sidebar+'</aside><main id="content">'+str(main.decode_contents())+'</main><aside class="toc" aria-label="On this page"><h2>On this page</h2><ul>'+''.join(toc)+'</ul></aside></div><footer><a href="'+REPO+'/releases/tag/v2.0.0">Ontology core v2.0.0</a> · <a href="'+relative(DOCS/'guide/Citation.html',path)+'">Citation and reuse</a> · <a href="'+relative(DOCS/'guide/Limitations.html',path)+'">Limits of the evidence</a> · <a href="'+REPO+'">Repository</a><p>Native model 0.41.0 · logical profile 0.43.0. Generated references describe the supplied source; evaluation claims are tied to their recorded inputs and methods.</p></footer></body></html>'
        path.write_text(output,encoding='utf-8')
    print(json.dumps({'reader_pages':len(GUIDE_NAMES),'search_entries':len(terms),'additional_reference_pages':len(mapping)-20,'framework':'WIDOCO with governed conceptual, formal and evaluation pages'}))


if __name__=='__main__':
    enrich()
