"""Generate the editorial concept reader without adding semantic definitions."""
import csv
from datetime import date
import hashlib
import html
import json
import os
from pathlib import Path
import re
from urllib.parse import unquote, urlsplit

from bs4 import BeautifulSoup
import markdown

ROOT = Path(__file__).resolve().parents[2]
BASE = Path('docs/concepts')
CATALOGUE = Path('semantic/product/v2/catalogue/Concept_Catalogue_v0_41_0.csv')
PROJECTION = Path('semantic/product/v2/reference/native-class-projection.csv')
MODEL = Path('semantic/product/v2/source/formalization/Native_Model_v0_41_0.json')
REPO = 'https://github.com/ArazSaieArasi3/OntoSPK'
TOKEN = re.compile(r'\[@([a-z][a-z0-9-]*)\]')
SECTIONS = ['Extended explanation', 'Distinctions', 'Illustrative example', 'Evidence gaps and lineage']
SUPPORT = {'direct', 'adapted', 'partial', 'contrast'}


def esc(value):
    return html.escape(str(value), quote=True)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def route(identifier):
    assert re.fullmatch(r'(IC:[A-Za-z][A-Za-z0-9_]*|EXT:[A-Za-z][A-Za-z0-9_]*:[A-Za-z][A-Za-z0-9_]*)', identifier), identifier
    prefix, tail = identifier.split(':', 1)
    return prefix.lower()+'--'+tail.replace(':', '--')+'.html'


def parse_manuscript(text):
    match = re.fullmatch(r'```json\n(.*?)\n```\n\n(.*)', text, re.S)
    assert match, 'Expected fenced JSON metadata and Markdown body'
    return json.loads(match[1]), match[2]


def validate(meta, body, catalogue, references):
    assert set(meta) == {'native_id', 'editorial_status', 'reviewed_on', 'evidence', 'related_ids'}, 'Unknown/duplicated authority field'
    assert meta['native_id'] in catalogue, 'Unknown native ID'
    assert meta['editorial_status'] == 'editorial-source-checked', 'Unknown review status'
    assert re.fullmatch(r'\d{4}-\d{2}-\d{2}', meta['reviewed_on']), 'Review date'
    date.fromisoformat(meta['reviewed_on'])
    assert re.findall(r'^## (.+)$', body, re.M) == SECTIONS, 'Required sections/order'
    paragraphs = body.split('## Distinctions')[0].split('\n\n')[1:]
    assert len([p for p in paragraphs if p.strip()]) == 2, 'Two explanatory paragraphs required'
    evidence = meta['evidence']
    ids = [e['id'] for e in evidence]
    assert evidence and len(ids) == len(set(ids)), 'Missing/duplicate evidence identity'
    assert set(TOKEN.findall(body)) == set(ids), 'Unused or unresolved evidence token'
    assert not re.search(r'\[@[^\]]*\]', TOKEN.sub('', body)), 'Malformed evidence token'
    for e in evidence:
        assert set(e) == {'id', 'source', 'claim', 'support', 'locator', 'limitation'}, 'Evidence schema'
        assert re.fullmatch(r'[a-z][a-z0-9-]*', e['id']), 'Evidence ID'
        assert e['source'] in references, 'Unknown bibliography key'
        assert e['support'] in SUPPORT, 'Unknown support classification'
        assert all(isinstance(e[k], str) and e[k].strip() for k in e), 'Empty evidence field'
        source = references[e['source']]
        assert source['access'] != 'abstract_only' or 'abstract' in e['locator'].lower(), 'Unread passage cited'
        assert not (source['access'] == 'abstract_only' and e['support'] in {'direct', 'adapted'}), 'Abstract-only source must expose partial scope'
    assert len(meta['related_ids']) == len(set(meta['related_ids'])), 'Duplicate related ID'
    assert set(meta['related_ids']) <= set(catalogue), 'Unknown related ID'
    if meta['native_id'].startswith('EXT:'):
        assert 'reference-only' in body and 'not established' in body, 'External boundary disclosure'
    if meta['native_id'] == 'IC:ProductCapability':
        assert 'PC-01' in body and 'Strict reference-profile conformity remains unclaimed' in body, 'PC-01 disclosure'


def validate_references(references):
    dois = []
    for key, r in references.items():
        assert re.fullmatch(r'[a-z][a-z0-9-]*', key), 'Bibliography key'
        assert r['kind'] in {'journal_article', 'conference_paper', 'book', 'standard', 'ontology_documentation'}
        assert r['authors'] and all(isinstance(a, str) and a.strip() for a in r['authors'])
        assert r['title'] and r['venue'] and r['inspected_sections']
        assert r['year'] is None or isinstance(r['year'], int)
        assert r['access'] in {'abstract_only', 'reviewed_sections'}
        assert re.fullmatch(r'\d{4}-\d{2}-\d{2}', r['verified_on'])
        date.fromisoformat(r['verified_on'])
        for field in ['url', 'reading_url', 'verification_url']:
            if field in r:
                assert urlsplit(r[field]).scheme == 'https' and urlsplit(r[field]).netloc, 'Original-source URL'
        if r.get('doi'):
            assert re.fullmatch(r'10\.\d{4,9}/\S+', r['doi'])
            dois.append(r['doi'].lower())
    assert len(dois) == len(set(dois)), 'Duplicate DOI identities'


def ieee(r):
    authors = r['authors']
    names = authors[0] if len(authors) == 1 else ', '.join(authors[:-1])+(' and ' if len(authors) == 2 else ', and ')+authors[-1]
    if r.get('editors'):
        names += ', Eds.'
    title = '<em>'+esc(r['title'])+'</em>' if r['kind'] == 'book' else '“'+esc(r['title'])+'”'
    parts = [esc(names), title, '<em>'+esc(r['venue'])+'</em>']
    if r.get('edition'):
        parts.append(r['edition']+' ed.')
    if r.get('volume'):
        parts.append('vol. '+r['volume'])
    if r.get('number'):
        parts.append('no. '+r['number'])
    if r.get('pages'):
        parts.append('pp. '+r['pages'])
    parts.append(str(r['year']) if r['year'] else 'n.d.')
    text = ', '.join(parts)+'.'
    if r.get('doi'):
        text += ' doi: <a href="https://doi.org/'+esc(r['doi'])+'">'+esc(r['doi'])+'</a>.'
    accessed = date.fromisoformat(r['verified_on'])
    months = ['Jan.', 'Feb.', 'Mar.', 'Apr.', 'May', 'Jun.', 'Jul.', 'Aug.', 'Sep.', 'Oct.', 'Nov.', 'Dec.']
    text += ' [Online]. Available: <a href="'+esc(r['url'])+'">'+esc(r['url'])+'</a>. Accessed: '+months[accessed.month-1]+' '+str(accessed.day)+', '+str(accessed.year)+'.'
    if r.get('reading_url'):
        text += ' <a href="'+esc(r['reading_url'])+'">Inspected text</a>.'
    text += ' <span class="source-access">Reading scope: '+esc(r['access'].replace('_', ' '))+'.</span>'
    return text


def shell(title, body):
    return '<!doctype html><html lang="en"><head><meta charset="utf-8"><title>'+esc(title)+'</title></head><body><main>'+body+'</main></body></html>\n'


def build(root=ROOT):
    def read(path):
        return (root/path).read_bytes()
    catalogue = {r['native_id']: r for r in csv.DictReader(read(CATALOGUE).decode('utf-8-sig').splitlines())}
    projection = {r['native_id']: r for r in csv.DictReader(read(PROJECTION).decode('utf-8-sig').splitlines())}
    model = json.loads(read(MODEL))
    assert {i: r['label'] for i, r in catalogue.items()} == {e['id']: e['name']['en'] for e in model['elements'] if e['type'] == 'Class'}
    assert len(catalogue) == 128 and sum(r['scope'] == 'LOCAL' for r in catalogue.values()) == 101
    assert len({route(i).casefold() for i in catalogue}) == 128, 'Route collision'
    domains = sorted({r['domain'] for r in catalogue.values() if r['scope'] == 'LOCAL'})
    assert len(domains) == 12
    from native_search import native_entries
    native = {e['id']: '../reference/'+e['href'] for e in native_entries(read(Path('docs/reference/native/classes.html')).decode())}
    reference_document = json.loads(read(BASE/'references.json'))
    assert reference_document['schema_version'] == 1
    refs = reference_document['references']
    validate_references(refs)
    manuscripts = {}
    for p in sorted((root/BASE/'entries').glob('*.md')):
        meta, body = parse_manuscript(p.read_text())
        validate(meta, body, catalogue, refs)
        identifier = meta['native_id']
        assert identifier not in manuscripts, 'Duplicate manuscript ID'
        manuscripts[identifier] = (p, meta, body)
    assert manuscripts, 'No manuscripts'
    target = root/BASE
    for p in target.glob('*.html'):
        p.unlink()
    outputs = {}
    rows = []
    for identifier, row in catalogue.items():
        p = projection[identifier]
        iri = p['mapped_iri'] if p['declared_owl_class'] == 'True' else None
        record = {'native_id': identifier, 'label': row['label'], 'scope': 'local' if identifier.startswith('IC:') else 'external', 'domain': row['domain'],
                  'owner': identifier.split(':')[1] if identifier.startswith('EXT:') else None,
                  'route': route(identifier) if identifier in manuscripts else None,
                  'native_href': native[identifier], 'mapped_iri': iri,
                  'status': 'editorial-source-checked' if identifier in manuscripts else 'awaiting-manuscript'}
        rows.append(record)
    by_id = {r['native_id']: r for r in rows}

    def destination(identifier):
        r = by_id[identifier]
        return r['route'] or r['native_href']

    for identifier, (source, meta, body) in manuscripts.items():
        row = catalogue[identifier]
        evidence = {e['id']: e for e in meta['evidence']}
        order = []
        for token in TOKEN.findall(body):
            key = evidence[token]['source']
            if key not in order:
                order.append(key)
        def cite(match):
            e = evidence[match[1]]
            n = order.index(e['source'])+1
            return '<a class="evidence-citation" data-evidence="'+esc(e['id'])+'" href="#evidence-'+esc(e['id'])+'" title="'+esc(e['support']+'; '+e['locator'])+'">['+str(n)+']</a>'
        rendered = markdown.markdown(TOKEN.sub(cite, body), extensions=['tables', 'fenced_code', 'toc'])
        rendered_soup = BeautifulSoup(rendered, 'html.parser')
        for a in rendered_soup.find_all('a', href=True):
            url = urlsplit(a['href'])
            if url.scheme or not url.path:
                continue
            destination_path = (source.parent/unquote(url.path)).resolve()
            assert destination_path.is_relative_to(root), 'Manuscript link outside repository'
            assert destination_path.is_file(), 'Missing manuscript destination '+str(destination_path)
            if destination_path.is_relative_to(root/'docs'):
                a['href'] = os.path.relpath(destination_path, target).replace(os.sep, '/')
            else:
                ref = 'v2.0.0' if destination_path.is_relative_to(root/'semantic') else 'main'
                a['href'] = REPO+'/blob/'+ref+'/'+destination_path.relative_to(root).as_posix()
            if url.fragment:
                a['href'] += '#'+url.fragment
        rendered = str(rendered_soup)
        canonical = '<section id="canonical" data-native-id="'+esc(identifier)+'"><h2>Canonical short '+('boundary description' if identifier.startswith('EXT:') else 'definition')+'</h2><blockquote>'+esc(row['definition'])+'</blockquote><p>Read directly from the frozen native catalogue. Literature support for individual claims is classified below; this block is the project commitment.</p></section>'
        head = '<h1>'+esc(row['label'])+'</h1><p><a href="index.html">Concept index</a> · <a href="method.html">Sources and editorial method</a></p><dl><dt>Native ID</dt><dd><code>'+esc(identifier)+'</code></dd><dt>Scope</dt><dd>'+esc(row['scope'])+'</dd><dt>'+('Owner' if identifier.startswith('EXT:') else 'Domain')+'</dt><dd>'+esc(identifier.split(':')[1] if identifier.startswith('EXT:') else row['domain'])+'</dd><dt>Native stereotype</dt><dd>'+esc(row['stereotype'] or 'External handle; no local stereotype')+'</dd><dt>Editorial status</dt><dd>'+esc(meta['editorial_status'])+' · '+esc(meta['reviewed_on'])+'; independent scientific review remains open.</dd></dl>'
        mapping = by_id[identifier]['mapped_iri']
        links = '<h2>Model, relations and source bindings</h2><ul><li><a href="'+native[identifier]+'">Exact native definition and incident relations</a></li>'
        if mapping:
            links += '<li><a href="../reference/owl/classes.html#'+digest(mapping.encode())[:16]+'">Existing bounded OWL projection</a>: <code>'+esc(mapping)+'</code>. Mapping is not complete semantic equivalence.</li>'
        else:
            links += '<li>No declared named OWL class in the existing projection; no IRI is invented.</li>'
        links += '<li><a href="'+REPO+'/blob/v2.0.0/'+CATALOGUE.as_posix()+'">Canonical catalogue (core v2.0.0)</a></li><li><a href="'+REPO+'/blob/main/'+source.relative_to(root).as_posix()+'">Authored manuscript</a></li><li><a href="coverage.json">Input hashes and coverage</a></li></ul>'
        links += '<h2>Related concepts and boundaries</h2><ul>'+''.join('<li><a href="'+destination(i)+'">'+esc(catalogue[i]['label'])+'</a> · <code>'+esc(i)+'</code></li>' for i in meta['related_ids'])+'</ul>'
        table = '<h2>Claim-specific evidence</h2><p>Support labels apply to the stated claim, not the entire concept. Exact locators refer to the original reading listed in References.</p><table><thead><tr><th>Claim</th><th>Support</th><th>Reference and locator</th><th>Limit</th></tr></thead><tbody>'
        for e in meta['evidence']:
            n = order.index(e['source'])+1
            table += '<tr id="evidence-'+esc(e['id'])+'" data-source="'+esc(e['source'])+'"><td>'+esc(e['claim'])+'</td><td>'+esc(e['support'])+'</td><td><a href="#ref-'+str(n)+'">['+str(n)+']</a> '+esc(e['locator'])+'</td><td>'+esc(e['limitation'])+'</td></tr>'
        table += '</tbody></table><h2>References</h2><ol class="ieee-references">'+''.join('<li id="ref-'+str(n)+'" value="'+str(n)+'">'+ieee(refs[k])+'</li>' for n, k in enumerate(order, 1))+'</ol>'
        outputs[route(identifier)] = shell(row['label'], head+canonical+rendered+table+links)

    def item(r, anchor=True):
        data = esc((r['label']+' '+r['native_id']+' '+r['domain']+' '+(r['owner'] or '')).lower())
        return '<li class="concept-entry"'+(' id="entry-'+esc(r['native_id'].replace(':', '--'))+'"' if anchor else '')+' data-search="'+data+'" data-native-id="'+esc(r['native_id'])+'"><a href="'+destination(r['native_id'])+'">'+esc(r['label'])+'</a> · <code>'+esc(r['native_id'])+'</code> · '+esc(r['status'])+'</li>'
    local = sum(i.startswith('IC:') for i in manuscripts)
    external = len(manuscripts)-local
    intro = '<h1>Source-backed concept reader</h1><p>Browse 101 local concepts in twelve domains and 27 separately governed external handles. This first increment provides '+str(local)+' local explanations and '+str(external)+' external boundary explanation. The other '+str(128-len(manuscripts))+' entries link to the exact native reference and await an authored manuscript.</p><p><a href="method.html">Scientific sources and editorial method</a> · <a href="coverage.json">Machine-readable coverage and input hashes</a></p><p class="note">Editorial source checking is not independent scientific validation. Canonical definitions, explanatory synthesis and source support remain distinct. External handles are not accepted ontology imports.</p><label for="concept-query">Filter by name, native ID, domain or owner</label><input id="concept-query" type="search" autocomplete="off" placeholder="For example: IC:ProductCapability"><p id="concept-count" role="status">128 entries</p><noscript><p>The full categorized and alphabetical lists below work without JavaScript.</p></noscript>'
    alpha = '<details><summary>Alphabetical index (all 128 entries)</summary><ul>'+''.join(item(r, False) for r in sorted(rows, key=lambda r:(r['label'].lower(), r['native_id'])))+'</ul></details>'
    grouped = '<div id="concept-groups"><h2>Local concepts by domain</h2>'
    for domain in domains:
        grouped += '<section><h3>'+esc(domain)+'</h3><ul>'+''.join(item(r) for r in sorted(rows, key=lambda r:r['label'].lower()) if r['scope'] == 'local' and r['domain'] == domain)+'</ul></section>'
    grouped += '<h2>External handles by owner</h2><p>These owner groups are separate from the twelve local domains.</p>'
    for owner in sorted({r['owner'] for r in rows if r['owner']}):
        grouped += '<section><h3>'+esc(owner)+'</h3><ul>'+''.join(item(r) for r in sorted(rows, key=lambda r:r['label'].lower()) if r['owner'] == owner)+'</ul></section>'
    grouped += '</div><script src="../assets/concept-filter.js" defer></script>'
    outputs['index.html'] = shell('Source-backed concept reader', intro+alpha+grouped)
    method = markdown.markdown((root/BASE/'README.md').read_text(), extensions=['tables', 'fenced_code', 'toc'])
    outputs['method.html'] = shell('Concept editorial method', method+'<p><a href="index.html">Browse the concepts</a></p>')
    for name, text in outputs.items():
        (target/name).write_text(text)
    (root/'docs/assets/concept-filter.js').write_text("const input=document.getElementById('concept-query');const count=document.getElementById('concept-count');function filterConcepts(){const q=input.value.trim().toLowerCase();document.querySelectorAll('.concept-entry').forEach(e=>{e.hidden=!e.dataset.search.includes(q)});document.querySelectorAll('#concept-groups section').forEach(s=>{s.hidden=![...s.querySelectorAll('.concept-entry')].some(e=>!e.hidden)});count.textContent=[...document.querySelectorAll('#concept-groups .concept-entry')].filter(e=>!e.hidden).length+' matching entries'}input.addEventListener('input',filterConcepts);filterConcepts();\n")
    inputs = [CATALOGUE, PROJECTION, MODEL, BASE/'references.json', BASE/'README.md', Path('tools/publication/concept_pages.py')]+[p.relative_to(root) for p, _, _ in manuscripts.values()]
    coverage = {'schema_version': 1, 'ontology_core': 'v2.0.0', 'scope': 'Editorial pilot; no semantic migration or independent scientific acceptance',
                'local_total': 101, 'external_total': 27, 'local_manuscripts': local, 'external_manuscripts': external,
                'awaiting_manuscript': 128-len(manuscripts), 'local_domains': domains,
                'references': len(refs), 'evidence_records': sum(len(m['evidence']) for _, m, _ in manuscripts.values()),
                'inputs_sha256': {p.as_posix(): digest(read(p)) for p in sorted(inputs)}, 'entries': rows}
    (target/'coverage.json').write_text(json.dumps(coverage, indent=2)+'\n')
    return coverage


if __name__ == '__main__':
    result = build()
    print(json.dumps({k:v for k,v in result.items() if k not in {'entries', 'inputs_sha256', 'local_domains'}}))
