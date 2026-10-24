"""Require the documentation audit to detect realistic reader regressions."""
from audit_documentation import ROOT, audit
from bs4 import BeautifulSoup

baseline = audit()
assert not baseline['errors'], baseline['errors']
guide = 'docs/guide/Formalization.html'
original = (ROOT/guide).read_text()

def variant(change):
    soup = BeautifulSoup(original, 'html.parser')
    change(soup)
    return str(soup)

faults = {
    'lost paragraph': variant(lambda s: s.find('main').find('p', recursive=False).decompose()),
    'changed heading': variant(lambda s: setattr(s.find('main').find('h2'), 'string', 'Unrelated heading')),
    'missing route': variant(lambda s: s.find('main').find('a').__setitem__('href', 'does-not-exist.html')),
    'wrong existing destination': variant(lambda s: s.find('main').find('a', string='All structural formulas and association contracts').__setitem__('href', 'Overview.html')),
    'lost version context': variant(lambda s: s.find('aside', class_='current-context').decompose()),
}
for name, text in faults.items():
    result = audit(overrides={guide: text})
    assert result['errors'], f'Undetected fault: {name}'
diagram='docs/reference/diagrams/index.html'
soup=BeautifulSoup((ROOT/diagram).read_text(),'html.parser')
soup.find('main').find('img')['src']='../../assets/diagrams/domain-matrix.svg'
assert audit(overrides={diagram:str(soup)})['errors'],'Undetected swapped diagram image'
print(f"PASS: baseline and {len(faults)+1} independently injected reader regressions")
