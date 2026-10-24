"""Bind reader search entries to rendered native identifiers, not label slugs."""
import re
from bs4 import BeautifulSoup


def native_entries(html):
    soup = BeautifulSoup(html, 'html.parser')
    entries = []
    main = soup.find('main') or soup
    for heading in main.find_all('h2'):
        block = []
        for sibling in heading.next_siblings:
            if getattr(sibling, 'name', None) == 'h2':
                break
            if getattr(sibling, 'name', None):
                block.append(sibling)
        identifier = None
        for item in block:
            for li in item.find_all('li'):
                if li.get_text(' ', strip=True).startswith('Native identifier:'):
                    identifier = li.find('code').get_text(strip=True)
                    break
            if identifier:
                break
        assert identifier and heading.get('id'), 'Missing native section identity'
        entries.append({'label': heading.get_text(' ', strip=True),
                        'kind': 'Native class or external handle',
                        'id': identifier,
                        'href': 'native/classes.html#'+heading['id']})
    assert len(entries) == 128
    assert len({e['id'] for e in entries}) == len({e['href'] for e in entries}) == 128
    return entries


def search_errors(search_html, native_html):
    import json
    soup = BeautifulSoup(search_html, 'html.parser')
    terms = json.loads(soup.find(id='term-data').string)
    actual = [t for t in terms if t['kind'] == 'Native class or external handle']
    expected = native_entries(native_html)
    return [] if actual == expected else ['Native search identity/section binding differs']
