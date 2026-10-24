"""Reject wrong-but-existing destinations and drift in current reader claims."""
import copy
import gzip
import json
from pathlib import Path
from bs4 import BeautifulSoup
from native_search import native_entries, search_errors
from build_metadata_residual_review import reconcile

ROOT = Path(__file__).resolve().parents[2]


def check(overrides=None):
    overrides = overrides or {}
    read = lambda name: overrides.get(name, (ROOT/name).read_text())
    errors = search_errors(read('docs/reference/search.html'), read('docs/reference/native/classes.html'))
    entries = native_entries(read('docs/reference/native/classes.html'))
    native = json.loads(read('semantic/product/v2/source/formalization/Native_Model_v0_41_0.json'))
    actual = {e['id']: e['label'] for e in entries}
    expected = {e['id']: e['name']['en'] for e in native['elements'] if e['type'] == 'Class'}
    if actual != expected:
        errors.append('Native catalogue/search differs from exact model identifiers and names')
    home = BeautifulSoup(read('docs/index.html'), 'html.parser').find('main')
    image = home.find('img')
    if image.get('src') != 'assets/diagrams/selected-reviewed.svg':
        errors.append('Home reader figure is not the reviewed copy')
    if home.find('a', href='assets/selected-model.svg'):
        errors.append('Home advertises historical figure as current')
    current = json.loads(read('docs/current-status.json'))
    if current != json.loads(read('tools/publication/current-status.json')) or current['ontology_core'] != 'v2.0.0' or current['documentation_increment'] != 'v2.0.8':
        errors.append('Governed current-status projection differs')
    for source in ['docs/guide/Home.md', 'docs/guide/Versions.md', 'docs/development/release-plan.md']:
        if any(term in read(source) for term in ['will be linked after publication', 'next active item', '#48 remains a separate scientific decision', '#48 is a specific future']):
            errors.append('Obsolete current status in '+source)
    for path in ['docs/status/index.html', 'docs/reference/publication/index.html', 'docs/evaluation/metadata-residual-review.html']:
        if not (ROOT/path).is_file():
            errors.append('Missing current reader route '+path)
    return errors


assert not check(), check()
search = 'docs/reference/search.html'
original = (ROOT/search).read_text()
soup = BeautifulSoup(original, 'html.parser')
terms = json.loads(soup.find(id='term-data').string)


def search_variant(change):
    variant = copy.deepcopy(terms)
    change(variant)
    s = BeautifulSoup(original, 'html.parser')
    s.find(id='term-data').string = json.dumps(variant)
    return str(s)


def entry(rows, identifier):
    return next(r for r in rows if r['id'] == identifier)


faults = {
    'duplicate label points to wrong existing section': {search: search_variant(lambda r: entry(r, 'EXT:ExternalUnresolved:Evidence').update(href='native/classes.html#evidence'))},
    'native identity replaced by name': {search: search_variant(lambda r: entry(r, 'IC:ProductCapability').update(id='ProductCapability'))},
    'native entry omitted': {search: search_variant(lambda r: r.remove(entry(r, 'IC:ProductCapability')))},
    'wrong native label': {search: search_variant(lambda r: entry(r, 'IC:ProductCapability').update(label='Product'))},
    'old home figure': {'docs/index.html': (ROOT/'docs/index.html').read_text().replace('assets/diagrams/selected-reviewed.svg', 'assets/selected-model.svg')},
    'stale future status': {'docs/guide/Home.md': (ROOT/'docs/guide/Home.md').read_text()+'\nThese routes will be linked after publication.'},
    'wrong current core': {'docs/current-status.json': (ROOT/'docs/current-status.json').read_text().replace('v2.0.0', 'v2.1.0')},
}
for name, changes in faults.items():
    assert check(changes), 'Undetected reader fault: '+name

load = lambda name: json.loads(gzip.decompress((ROOT/'evaluation'/name).read_bytes()))
review, tests = load('robot-metadata-review.json.gz'), load('robot-metadata-tests.json.gz')
assert len(reconcile(review, tests)) == 318
for name, change in [('lost residual row', lambda d: d['after'].pop()),
                     ('hidden error severity', lambda d: next(r for r in d['after'] if r['Level'] == 'ERROR').update(Level='WARN'))]:
    broken = copy.deepcopy(tests)
    change(broken)
    try:
        reconcile(review, broken)
    except (AssertionError, KeyError):
        continue
    raise AssertionError('Undetected residual accounting fault: '+name)
print('PASS: 128 source-bound native identities, current reader routes, seven reader faults and two residual-accounting faults')
