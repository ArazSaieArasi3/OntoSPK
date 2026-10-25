"""Reject source-authority, citation and plausible wrong-destination faults."""
import copy
import csv
import hashlib
import json
from pathlib import Path
import re

from bs4 import BeautifulSoup
import markdown

from concept_pages import ROOT, BASE, CATALOGUE, PROJECTION, TOKEN, parse_manuscript, route, validate, validate_references
from native_search import native_entries


def normalize(text):
    return re.sub(r'\s+', ' ', text).strip()


def audit(overrides=None):
    overrides = overrides or {}
    read = lambda p: overrides.get(str(p), (ROOT/p).read_text())
    catalogue = {r['native_id']: r for r in csv.DictReader(read(CATALOGUE).lstrip('\ufeff').splitlines())}
    projection = {r['native_id']: r for r in csv.DictReader(read(PROJECTION).lstrip('\ufeff').splitlines())}
    references = json.loads(read(BASE/'references.json'))['references']
    coverage = json.loads(read(BASE/'coverage.json'))
    errors = []
    def require(ok, message):
        if not ok:
            errors.append(message)
    require((coverage['local_total'], coverage['external_total'], coverage['local_manuscripts'], coverage['external_manuscripts'], coverage['awaiting_manuscript']) == (101,27,5,1,122), 'Pilot accounting')
    rows = coverage['entries']
    require(len(rows) == 128 and {r['native_id'] for r in rows} == set(catalogue), 'Coverage inventory')
    for p, h in coverage['inputs_sha256'].items():
        require(hashlib.sha256((ROOT/p).read_bytes()).hexdigest() == h, 'Input hash '+p)
    native = {e['id']: '../reference/'+e['href'] for e in native_entries(read('docs/reference/native/classes.html'))}
    manuscripts = {}
    for p in sorted((ROOT/BASE/'entries').glob('*.md')):
        meta, body = parse_manuscript(p.read_text())
        validate(meta, body, catalogue, references)
        manuscripts[meta['native_id']] = (meta, body)
    require(len(manuscripts) == 6, 'Six pilot manuscripts')
    by_id = {r['native_id']: r for r in rows}
    index = BeautifulSoup(read(BASE/'index.html'), 'html.parser')
    script_hash = hashlib.sha256((ROOT/'docs/assets/concept-filter.js').read_bytes()).hexdigest()[:16]
    require(index.find('script', src='../assets/concept-filter.js?v='+script_hash) is not None, 'Filter cache binding')
    entries = index.select('#concept-groups li.concept-entry')
    require(len(entries) == 128 and len({e['data-native-id'] for e in entries}) == 128, 'Index IDs')
    expected_domains = {r['domain'] for r in catalogue.values() if r['scope'] == 'LOCAL'}
    require(set(coverage['local_domains']) == expected_domains and len(expected_domains) == 12, 'Twelve domains')
    for e in entries:
        identifier = e['data-native-id']
        row = by_id[identifier]
        expected = route(identifier) if identifier in manuscripts else native[identifier]
        require(e.find('a')['href'] == expected, 'Index destination '+identifier)
        require(row['native_href'] == native[identifier], 'Native binding '+identifier)
        mapped = projection[identifier]
        require(row['mapped_iri'] == (mapped['mapped_iri'] if mapped['declared_owl_class'] == 'True' else None), 'Projection source '+identifier)
        require(row['route'] == (route(identifier) if identifier in manuscripts else None), 'Route accounting '+identifier)
        require(e.find('a').get_text() == catalogue[identifier]['label'], 'Index label '+identifier)
        require(row['status'] == ('editorial-source-checked' if identifier in manuscripts else 'awaiting-manuscript'), 'Editorial status '+identifier)
    require(route('EXT:EvidenceLayer:Evidence') != route('EXT:ExternalUnresolved:Evidence'), 'Duplicate label routes')
    actual_pages = {p.name for p in (ROOT/BASE).glob('*.html')}
    require(actual_pages == {'index.html', 'method.html'} | {route(i) for i in manuscripts}, 'No fabricated non-pilot pages')
    for identifier, (meta, body) in manuscripts.items():
        path = BASE/route(identifier)
        soup = BeautifulSoup(read(path), 'html.parser')
        main = soup.find('main')
        canonical = main.find(id='canonical')
        require(canonical['data-native-id'] == identifier, 'Canonical ID '+identifier)
        require(canonical.blockquote.get_text() == catalogue[identifier]['definition'], 'Canonical definition '+identifier)
        require(main.h1.get_text() == catalogue[identifier]['label'], 'Page label '+identifier)
        require(main.find('a', href=native[identifier]) is not None, 'Native section '+identifier)
        mapping = by_id[identifier]['mapped_iri']
        if mapping:
            expected = '../reference/owl/classes.html#'+hashlib.sha256(mapping.encode()).hexdigest()[:16]
            require(main.find('a', href=expected) is not None, 'OWL binding '+identifier)
        for citation in main.select('a.evidence-citation'):
            citation.decompose()
        # Compare the complete authored explanation and distinctions, not only headings.
        for heading, section in zip(re.findall(r'^## (.+)$', body, re.M), re.split(r'^## .+$', body, flags=re.M)[1:]):
            h = next(h for h in main.find_all('h2') if h.get_text() == heading)
            pieces = []
            for sibling in h.next_siblings:
                if getattr(sibling, 'name', None) == 'h2':
                    break
                pieces.append(str(sibling))
            actual = BeautifulSoup(''.join(pieces), 'html.parser').get_text(' ', strip=True)
            expected = BeautifulSoup(markdown.markdown(TOKEN.sub('', section), extensions=['tables']), 'html.parser').get_text(' ', strip=True)
            require(normalize(actual) == normalize(expected), 'Manuscript content '+identifier+' '+heading)
        order = []
        evidence = {e['id']:e for e in meta['evidence']}
        for token in TOKEN.findall(body):
            key = evidence[token]['source']
            if key not in order:
                order.append(key)
        require(len(main.select('ol.ieee-references > li')) == len(order), 'Reference count '+identifier)
        for e in meta['evidence']:
            tr = main.find(id='evidence-'+e['id'])
            require(tr is not None and tr.get('data-source') == e['source'], 'Evidence identity '+identifier)
            if tr is None:
                continue
            cells = tr.find_all('td')
            require(cells[0].get_text() == e['claim'] and cells[1].get_text() == e['support'] and cells[3].get_text() == e['limitation'], 'Claim support/limits '+identifier)
            n = order.index(e['source'])+1
            require(cells[2].a['href'] == '#ref-'+str(n) and e['locator'] in cells[2].get_text(), 'Claim locator/number '+identifier)
            ref = main.find(id='ref-'+str(n))
            require(ref is not None and references[e['source']]['title'] in ref.get_text() and ref.find('a', href=references[e['source']]['url']) is not None, 'Bibliography binding '+identifier)
        # Inspect inline citations again, because content comparison removed them above.
        inline = BeautifulSoup(read(path), 'html.parser').select('a.evidence-citation')
        require([c['data-evidence'] for c in inline] == TOKEN.findall(body), 'Inline evidence order '+identifier)
        for c in inline:
            e = evidence[c['data-evidence']]
            require(c['href'] == '#evidence-'+e['id'] and c.get_text() == '['+str(order.index(e['source'])+1)+']', 'Inline evidence binding '+identifier)
    return errors


assert not audit(), audit()
refs = json.loads((ROOT/BASE/'references.json').read_text())['references']
catalogue = {r['native_id']:r for r in csv.DictReader((ROOT/CATALOGUE).open(encoding='utf-8-sig'))}
meta, body = parse_manuscript((ROOT/BASE/'entries/Product.md').read_text())
source_faults = {
    'second editable canonical definition': lambda m: m.update(definition='An invented definition'),
    'unknown native ID': lambda m: m.update(native_id='IC:ImaginaryProduct'),
    'unknown reference': lambda m: m['evidence'][0].update(source='missing-paper'),
    'missing locator': lambda m: m['evidence'][0].update(locator=''),
    'unread full-text locator': lambda m: m['evidence'][0].update(locator='Chapter 7, p. 99'),
    'abstract inflated to direct support': lambda m: m['evidence'][0].update(support='direct'),
    'duplicate evidence ID': lambda m: m['evidence'].append(copy.deepcopy(m['evidence'][0])),
}
for name, mutate in source_faults.items():
    broken = copy.deepcopy(meta)
    mutate(broken)
    try:
        validate(broken, body, catalogue, refs)
    except (AssertionError, KeyError):
        continue
    raise AssertionError('Undetected source fault: '+name)
try:
    validate(meta, body+'\nUnresolved source [@absent].', catalogue, refs)
except AssertionError:
    pass
else:
    raise AssertionError('Undetected unresolved inline source')
broken_refs = copy.deepcopy(refs)
broken_refs['second-ebert'] = copy.deepcopy(refs['ebert2007'])
try:
    validate_references(broken_refs)
except AssertionError:
    pass
else:
    raise AssertionError('Undetected duplicated DOI')
product = str(BASE/route('IC:Product'))
original = (ROOT/product).read_text()
index_path = str(BASE/'index.html')
index = (ROOT/index_path).read_text()
coverage_path = str(BASE/'coverage.json')
cover = json.loads((ROOT/coverage_path).read_text())
badcover = copy.deepcopy(cover)
badcover['awaiting_manuscript'] = 0
faults = {
    'changed canonical definition': {product: original.replace(catalogue['IC:Product']['definition'], 'Invented definition')},
    'lost explanatory content': {product: original.replace('Its purpose and stewardship connect plans, versions and evidence across change.', '')},
    'wrong valid concept page': {index_path: index.replace('href="ic--ProductCapability.html"', 'href="ic--Product.html"')},
    'wrong existing duplicate Evidence section': {index_path: index.replace('classes.html#evidence_1', 'classes.html#evidence')},
    'lost reference locator': {product: original.replace('Abstract, study purpose and industry-project account', 'Full text')},
    'false complete coverage': {coverage_path: json.dumps(badcover)},
    'browser receives unversioned cached filter': {index_path: re.sub(r'concept-filter\.js\?v=[0-9a-f]+', 'concept-filter.js', index)},
}
for name, changes in faults.items():
    assert audit(changes), 'Undetected reader fault: '+name
print('PASS: six manuscript/HTML bindings, 128 IDs and destinations, 12 domains, 9 source faults and 7 reader faults; no independent scientific validation claimed')
