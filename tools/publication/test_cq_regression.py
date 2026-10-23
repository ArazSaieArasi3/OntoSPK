"""Replay every retained CQ and measure controlled graph-data mutations."""
from collections import Counter
import csv
import gzip
import json
from rdflib import Graph, Literal, RDF, URIRef
from evaluation_common import ROOT, SOURCE, graph_text, sha, write_json

BASE = SOURCE / 'validation_v041/cq_replay'
PROFILE = SOURCE / 't52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'

def read(name):
    with (BASE/name).open(encoding='utf-8-sig') as f:
        return list(csv.DictReader(f))

def canonical(rows):
    return sorted([list(row) for row in rows], key=lambda row: json.dumps(row, sort_keys=True))

def answer(graph, query):
    result = graph.query(query)
    return [str(v) for v in result.vars], canonical([[None if v is None else str(v) for v in row] for row in result])

index = read('Evidence_Index_v0_24_0.csv')
contracts = read('CQ_Contracts_v0_24_0.csv')
contracts = [c for c in contracts if c['cq_id'] in {x['cq_id'] for x in index}]
assert len(contracts) == len({x['cq_id'] for x in index}) == 56
profile = Graph().parse(PROFILE)
baselines = []
mutations = []
sources = {}
for item in index:
    for kind in ('query', 'fixture', 'expected'):
        p = BASE/item[kind+'_path']
        sources[str(p.relative_to(ROOT))] = sha(p)
        assert sha(p) == item[kind+'_sha256']
    query = (BASE/item['query_path']).read_text()
    expected = canonical(json.loads((BASE/item['expected_path']).read_text()))
    data = Graph().parse(BASE/item['fixture_path'])
    for scope in ('FIXTURE_ONLY', 'FIXTURE_PLUS_CURRENT_PROFILE_NO_INFERENCE'):
        graph = Graph()+data
        if scope != 'FIXTURE_ONLY':
            graph += profile
        fields, actual = answer(graph, query)
        assert actual == expected, (item['cq_id'], item['case'], scope)
        baselines.append({'cq_id': item['cq_id'], 'case': item['case'], 'scope': scope,
                          'fields': fields, 'expected': expected, 'actual': actual, 'status': 'PASS'})
    if item['case'] != 'positive':
        continue
    assert expected, (item['cq_id'], 'Positive contract unexpectedly empty')
    for triple in sorted(data, key=lambda t: tuple(x.n3() for x in t)):
        candidates = [('delete', None)]
        if isinstance(triple[2], URIRef) and triple[1] != RDF.type:
            candidates.append(('reverse', (triple[2],triple[1],triple[0])))
        for kind, replacement in candidates:
            changed = Graph()+data
            changed.remove(triple)
            if replacement:
                changed.add(replacement)
            for scope in ('FIXTURE_ONLY', 'FIXTURE_PLUS_CURRENT_PROFILE_NO_INFERENCE'):
                test = Graph()+changed
                if scope != 'FIXTURE_ONLY':
                    test += profile
                fields, actual = answer(test, query)
                mutations.append({'cq_id':item['cq_id'], 'kind':kind, 'scope':scope,
                                  'removed':[x.n3() for x in triple],
                                  'added':[x.n3() for x in replacement] if replacement else None,
                                  'actual':actual, 'baseline_expected':expected,
                                  'detected':actual != expected})
    # An unrelated fact is a stability control, not a fault to be detected.
    data.add((URIRef('urn:ontospk:cq-control'),URIRef('urn:ontospk:irrelevant'),Literal('unrelated')))
    assert answer(data,query)[1] == expected

per_cq=[]
for contract in contracts:
    cq = contract['cq_id']
    relevant = [x for x in mutations if x['cq_id'] == cq]
    assert relevant and any(x['detected'] for x in relevant), cq
    per_cq.append({'cq_id':cq, 'mutations':len(relevant), 'detected':sum(x['detected'] for x in relevant),
                   'survived':sum(not x['detected'] for x in relevant)})
assert len(baselines) == 374
report={'status':'PASS', 'cq_contracts':56, 'fixtures':len(index), 'exact_answer_comparisons':len(baselines),
        'data_mutations':len(mutations), 'detected':sum(x['detected'] for x in mutations),
        'survived':sum(not x['detected'] for x in mutations), 'unrelated_fact_controls':56,
        'inference':'NONE', 'profile':str(PROFILE.relative_to(ROOT)), 'profile_sha256':sha(PROFILE),
        'sources':sources, 'per_cq':per_cq, 'baselines':baselines, 'mutations':mutations,
        'limits':'Survivors include facts not used by the query and redundant paths. Every survivor is retained. Exact-answer graph querying without inference cannot detect arbitrary TBox defects, prove entailments, validate external owners, or establish independent domain correctness.'}
write_json('evaluation/cq-regression.json.gz',report)
lines=['# Competency-question replay and data mutation sensitivity','',
       f"All 56 contracts and {len(index)} fixtures passed {len(baselines)} exact-answer comparisons, in fixture-only and fixture-plus-current-profile scopes with no inference. Each source query, fixture and expected answer matches its retained SHA-256.",'',
       f"{len(mutations)} controlled single-triple deletions/reversals: {report['detected']} changed the expected answer and {report['survived']} survived. Each of the 56 CQs detects at least one data mutation. All 56 unrelated-fact stability controls passed.",'',
       'Surviving mutations are explicitly retained per CQ and triple; not every stored fact affects every query. This is query sensitivity, not OWL entailment testing or independent domain validation. Source axioms and contracts were not edited to improve the score.','',
       '| CQ | Mutations | Detected | Survived |','| --- | ---: | ---: | ---: |']
lines += [f"| {x['cq_id']} | {x['mutations']} | {x['detected']} | {x['survived']} |" for x in sorted(per_cq,key=lambda x:x['cq_id'])]
lines += ['', '[All inputs, expected/actual answers and mutation observations](cq-regression.json.gz)', '']
(ROOT/'evaluation/cq-regression.md').write_text('\n'.join(lines))
print(json.dumps({k:report[k] for k in ('status','cq_contracts','exact_answer_comparisons','data_mutations','detected','survived')}))
