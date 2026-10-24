"""Compare authored guide, accepted Wiki snapshot and generated reader content.

This deterministic source audit is not a fresh network/publication receipt.
"""
from pathlib import Path
from urllib.parse import unquote, urlsplit
import hashlib
import json
import re
import markdown
from bs4 import BeautifulSoup

ROOT = Path(__file__).resolve().parents[2]
REPO = 'https://github.com/ArazSaieArasi3/OntoSPK/'
OLD_HOME = 'These are source snapshots; versioned live Pages routes will be linked after publication.'
LIVE_HOME = 'The references below are served within the same documentation version.'


def normalize(text):
    return re.sub(r'\s+', ' ', text.replace(OLD_HOME, LIVE_HOME)).strip()


def rendered(text):
    return BeautifulSoup(markdown.markdown(text, extensions=['tables', 'fenced_code', 'toc']), 'html.parser')


def audit(root=ROOT, overrides=None):
    overrides = overrides or {}
    def read(path):
        return overrides.get(path.relative_to(root).as_posix(), path.read_text())
    docs = root/'docs'
    guide = docs/'guide'
    wiki = root/'wiki-src'
    method_source = docs/'handbook/formal-verification.md'
    method_page = docs/'reference/formal/method.html'
    sources = sorted(guide.glob('*.md'))
    wiki_sources = sorted(p for p in wiki.glob('*.md') if not p.name.startswith('_') and p.name != 'README.md')
    mapping = {p: p.with_suffix('.html') for p in sources}
    mapping[method_source] = method_page
    mapping[docs/'research/related-ontologies/related-ontology-comparison.md'] = docs/'related-ontologies.html'
    for p in (root/'semantic/product/v2/formal-specification').glob('*.md'):
        mapping[p] = docs/'reference/formal'/('index.html' if p.stem == 'README' else p.stem+'.html')
    for p in (root/'semantic/product/v2/reference').glob('*.md'):
        target = docs/'reference/native'/('index.html' if p.stem == 'README' else p.stem+'.html')
        if target.exists():
            mapping[p] = target
    for p in (root/'evaluation').glob('*.md'):
        target = docs/'evaluation'/(p.stem+'.html')
        if target.exists():
            mapping[p] = target
    errors, rows = [], []
    def require(ok, message):
        if not ok:
            errors.append(message)
    require({p.name for p in sources} == {p.name for p in wiki_sources}, 'Wiki/guide reader inventory differs')

    def destination(source, href):
        u = urlsplit(href)
        if href.startswith(REPO):
            parts = unquote(u.path).split('/', 5)
            if len(parts) == 6 and parts[3] in ('blob', 'tree'):
                target = root/parts[5]
            else:
                return href
        elif u.scheme or href.startswith('//'):
            return href
        elif source.parent == wiki and u.path and not Path(u.path).suffix:
            target = guide/(unquote(u.path)+'.md')
        else:
            target = (source.parent/unquote(u.path)).resolve() if u.path else source
        target = mapping.get(target, target)
        prefix = 'reader:' if target.is_relative_to(docs) and target.suffix == '.html' else 'artifact:'
        if not target.is_relative_to(root):
            return 'outside:'+str(target)
        return prefix+target.relative_to(root).as_posix()+('#'+unquote(u.fragment) if u.fragment else '')

    def links(soup, source):
        return [(normalize(a.get_text(' ', strip=True)), destination(source, a['href']))
                for a in soup.find_all('a', href=True)]

    def verify_links(main, page):
        for a in main.find_all('a', href=True):
            href = a['href']
            u = urlsplit(href)
            canonical = destination(page, href)
            require(not (canonical.startswith('reader:') and u.scheme), f'{page.relative_to(root)}: reader link leaves Pages: {href}')
            if u.scheme or href.startswith('//'):
                continue
            target = (page.parent/unquote(u.path)).resolve() if u.path else page
            require(target.is_relative_to(docs) and target.is_file(), f'{page.relative_to(root)}: missing/outside local route {href}')
            if target.is_file() and target.suffix == '.html' and u.fragment and 'webvowl' not in target.parts:
                target_soup = BeautifulSoup(read(target), 'html.parser')
                require(target_soup.find(id=unquote(u.fragment)) is not None or target_soup.find(attrs={'name': unquote(u.fragment)}) is not None,
                        f'{page.relative_to(root)}: missing anchor {href}')

    for source in sources+[method_source]:
        target = mapping[source]
        if not target.exists():
            errors.append(f'Missing rendered reader page: {target.relative_to(root)}')
            continue
        authored = rendered(read(source))
        page = BeautifulSoup(read(target), 'html.parser')
        main = page.find('main', id='content')
        if main is None:
            errors.append(f'Missing reader main: {target.relative_to(root)}')
            continue
        verify_links(main, target)
        if source.parent == guide:
            note = main.find('aside', class_='current-context')
            require(note is not None and 'v2.0.6' in note.get_text() and 'v2.0.0' in note.get_text(), f'{source.name}: current baseline context missing')
            if note:
                note.decompose()
            wiki_source = wiki/source.name
            if wiki_source.exists():
                wiki_content = rendered(read(wiki_source))
                require(normalize(authored.get_text(' ', strip=True)) == normalize(wiki_content.get_text(' ', strip=True)), f'{source.name}: Wiki text differs from authored guide')
                require(links(authored, source) == links(wiki_content, wiki_source), f'{source.name}: Wiki link destinations differ')
        require(normalize(authored.get_text(' ', strip=True)) == normalize(main.get_text(' ', strip=True)), f'{source.name}: rendered full content differs')
        heads = lambda soup: [(h.name, normalize(h.get_text(' ', strip=True))) for h in soup.find_all(re.compile('^h[1-6]$'))]
        require(heads(authored) == heads(main), f'{source.name}: rendered headings differ')
        require(links(authored, source) == links(main, target), f'{source.name}: rendered link destinations differ')
        rows.append({'source': source.relative_to(root).as_posix(), 'page': target.relative_to(root).as_posix(),
                     'source_sha256': hashlib.sha256(read(source).encode()).hexdigest(),
                     'normalized_content_sha256': hashlib.sha256(normalize(authored.get_text(' ', strip=True)).encode()).hexdigest(),
                     'headings': len(heads(authored)), 'links': len(links(authored, source))})
    return {'status': 'PASS' if not errors else 'FAIL',
            'scope': 'Accepted repository Wiki snapshot to current Pages; no fresh live Wiki or browser readback',
            'wiki_pages': len(wiki_sources), 'source_reader_pages': len(sources)+1,
            'normalization': 'Whitespace and one declared historical Home publication sentence; current-context asides checked separately',
            'pages': rows, 'errors': errors}


if __name__ == '__main__':
    result = audit()
    (ROOT/'evaluation/documentation-parity.json').write_text(json.dumps(result, indent=2)+'\n')
    table = '\n'.join(f"| {r['source']} | {r['page']} | {r['headings']} | {r['links']} |" for r in result['pages'])
    (ROOT/'evaluation/documentation-parity.md').write_text(
        '# Reader documentation parity\n\n'
        'This source audit compares the accepted Wiki snapshot, authored guide and current generated Pages. '
        'It checks full normalized text, headings and ordered link destinations, local reader routing and anchors; '
        'it is not a fresh readback of the mutable live Wiki or proof of scientific completeness. '
        'The historical Wiki receipt and frozen documentation snapshots remain unchanged.\n\n'
        f"**Result: {result['status']}.** {result['wiki_pages']} Wiki pages; {result['source_reader_pages']} authored reader pages including the current FOL method; {len(result['errors'])} errors.\n\n"
        '| Authored source | Pages route | Headings | Links |\n| --- | --- | ---: | ---: |\n'+table+'\n\n'
        'Whitespace and the existing Home publication-status sentence adapter are normalized. '
        'Current-context asides are checked separately and excluded from historical-content equality. '
        'The method explanation is compared with its own Markdown source. The finite fault-detection tests '
        'exercise paragraph deletion, heading changes, broken routes, misdirected existing links and absent current context.\n\n'
        'Reproduce: `python tools/publication/audit_documentation.py` and '
        '`python tools/publication/test_documentation_audit.py`.\n')
    print(json.dumps({k: v for k, v in result.items() if k != 'pages'}))
    raise SystemExit(bool(result['errors']))
