"""Execute the owner's preserve-as-is decision using public OntoSPK inputs only."""
from pathlib import Path
import copy
import csv
import hashlib
import importlib
import json
import shutil
import subprocess
import sys
import tempfile
from rdflib import Graph, OWL, RDF, RDFS, URIRef
from evaluation_common import ROOT, SOURCE, sha, write_json

BASELINE='ccea141bcc238a4aae47e631cadc1809b738bc73'
IDS=['EXT:Market:'+n for n in ('CustomerSegment','Market','MarketSegment','Need')]
NATIVE=SOURCE/'formalization/Native_Model_v0_41_0.json'
LOGICAL=SOURCE/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
CROSSWALK=SOURCE/'validation_v041/inputs/Relation_OWL_SQL_Crosswalk_v0_16_0.csv'

def git(*args):
    return subprocess.check_output(['git',*args],cwd=ROOT)

def snapshot(model):
    elements={e['id']:e for e in model['elements']}
    boundary=sorted((e for e in model['elements'] if e['type']=='Class' and e['id'].startswith('EXT:')),key=lambda e:e['id'])
    relations=[]
    for relation in model['elements']:
        if relation['type']!='BinaryRelation':continue
        ends=[elements[p] for p in relation['properties']]
        if any(e['propertyType'] in IDS for e in ends):
            relations.append({'relation':relation,'ends':ends})
    return {'all_boundary_elements':boundary,'market_uses':sorted(relations,key=lambda r:r['relation']['id'])}

def preserved(model,expected):
    try:return snapshot(model)==expected
    except (KeyError,TypeError):return False

def main():
    baseline=json.loads(git('show',BASELINE+':'+NATIVE.relative_to(ROOT).as_posix()))
    model=json.loads(NATIVE.read_text());expected=snapshot(baseline)
    assert preserved(model,expected)
    assert len(expected['all_boundary_elements'])==27 and len(expected['market_uses'])==13
    tree=git('ls-tree','-r',BASELINE,'--','semantic').decode().splitlines()
    blobs={line.split('\t',1)[1]:line.split()[2] for line in tree}
    assert set(blobs)==set(git('ls-files','semantic').decode().splitlines())
    for path,digest in blobs.items():
        payload=(ROOT/path).read_bytes()
        assert hashlib.sha1(b'blob '+str(len(payload)).encode()+b'\0'+payload).hexdigest()==digest,path
    assert sha(NATIVE)=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
    assert sha(LOGICAL)=='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12'
    elements={e['id']:e for e in model['elements']};graph=Graph().parse(LOGICAL)
    with CROSSWALK.open(encoding='utf-8-sig') as f:crosswalk={r['relation_id']:r for r in csv.DictReader(f)}
    rows=[];relations=[]
    for identifier in IDS:
        e=elements[identifier];contract=e['customProperties']['v0_17_boundary_contract']
        assert e['stereotype'] is None and contract['semantic_equivalence']=='NOT_ASSERTED'
        assert not e['customProperties'].get('v0_41_boundary_contract')
        rows.append({'native_id':identifier,'label':contract['display_label'],
                     'operational_definition':contract['operational_definition'],
                     'recorded_kind':contract['allowed_target_kinds'],
                     'existing_contract':contract,
                     'disposition':'OWNER_ACCEPTED_CURRENT_REFERENCE_ONLY_USE',
                     'owner_alignment':'DEFERRED_NO_NEW_ASSESSMENT','new_local_class':False,
                     'new_equivalence':False,'model_change':False})
    for use in expected['market_uses']:
        relation=use['relation'];ends=use['ends'];mapping=crosswalk[relation['id']]
        predicate=URIRef(mapping['predicate'])
        assert (predicate,RDF.type,OWL.ObjectProperty) in graph
        relations.append({'native_relation_id':relation['id'],'title':relation['name']['en'],
                          'source':ends[0]['propertyType'],'target':ends[1]['propertyType'],
                          'recorded_source_bounds':ends[0]['cardinality'],
                          'recorded_target_bounds':ends[1]['cardinality'],
                          'source_end_metadata':ends[0]['customProperties'],
                          'target_end_metadata':ends[1]['customProperties'],
                          'logical_predicate':str(predicate),
                          'logical_ranges':sorted(str(o) for o in graph.objects(predicate,RDFS.range)),
                          'existing_external_typing':mapping['external_typing']})
    # Exercise the frozen runtime. Do not add a new Market adapter or relabel its result.
    runtime=[]
    with tempfile.TemporaryDirectory() as folder:
        isolated=Path(folder)
        shutil.copytree(ROOT/'semantic',isolated/'semantic',ignore=shutil.ignore_patterns('__pycache__'))
        shutil.copytree(ROOT/'tools/ontospk',isolated/'tools/ontospk')
        subprocess.run([sys.executable,str(isolated/'tools/ontospk/bootstrap_inputs.py')],check=True,capture_output=True)
        sys.path.insert(0,str(isolated/'semantic/product/v2/source/validation_v041'))
        legacy=importlib.import_module('boundary_profile')
        for row in rows:
            data={'handle':row['native_id'],'kind':row['recorded_kind'],
                  'target':'urn:ontospk:synthetic:market-target','source':'urn:ontospk:synthetic:source','version':'synthetic-v1'}
            outcome=legacy.assess(data)
            assert outcome=={'status':'REVIEW_REQUIRED','errors':['NO_IMPLEMENTED_TYPED_BOUNDARY_CONTRACT']}
            runtime.append({'input':data,'actual':outcome,'interpretation':'Legacy typed validation remains unimplemented; current reference use is accepted by owner policy only.'})
    # Memory-only adverse changes prove that the preservation guard rejects semantic drift.
    mutants=[]
    for identifier in IDS:
        changes=[('label',lambda e:e['name'].update(en='changed label')),
                 ('kind',lambda e:e['customProperties']['v0_17_boundary_contract'].update(allowed_target_kinds='new_kind')),
                 ('definition',lambda e:e['customProperties']['v0_17_boundary_contract'].update(operational_definition='changed meaning')),
                 ('locator',lambda e:e['customProperties']['v0_17_boundary_contract'].update(owner_class_locator='urn:synthetic:retargeted')),
                 ('equivalence',lambda e:e['customProperties']['v0_17_boundary_contract'].update(semantic_equivalence='ACCEPTED')),
                 ('stereotype',lambda e:e.update(stereotype='kind')),
                 ('typed_contract',lambda e:e['customProperties'].update(v0_41_boundary_contract={'allowed_target_kinds':['market']}))]
        for name,change in changes:
            changed=copy.deepcopy(model);e=next(e for e in changed['elements'] if e['id']==identifier);change(e)
            assert not preserved(changed,expected),(identifier,name)
            mutants.append({'id':identifier+':'+name,'drift_rejected':True})
    for use in expected['market_uses']:
        for name in ('cardinality','endpoint','relation_removal'):
            changed=copy.deepcopy(model);items={e['id']:e for e in changed['elements']}
            relation=items[use['relation']['id']]
            if name=='relation_removal':changed['elements'].remove(relation)
            elif name=='cardinality':items[relation['properties'][1]]['cardinality']='1..*'
            else:items[relation['properties'][1]]['propertyType']='IC:Product'
            assert not preserved(changed,expected),(relation['id'],name)
            mutants.append({'id':relation['id']+':'+name,'drift_rejected':True})
    # The owner decision preserves every boundary, including those outside issue #24.
    for item in expected['all_boundary_elements']:
        if item['id'] in IDS:continue
        changed=copy.deepcopy(model);e=next(e for e in changed['elements'] if e['id']==item['id'])
        e['name']['en']='changed outside-scope label'
        assert not preserved(changed,expected)
        mutants.append({'id':item['id']+':outside_scope_change','drift_rejected':True})
    report={'status':'PASS_OWNER_DIRECTED_PRESERVATION','issue':24,'patch_target':'v2.0.3',
            'decision_date':'2026-10-23','ontology_core':'v2.0.0','baseline_commit':BASELINE,
            'scope':'Preserve the four named Market references; do not execute the earlier owner-alignment/localization proposal.',
            'owner_decision':'All current boundary treatments are accepted for present OntoSPK use. Private repository publication and cross-ontology rewiring are deferred to the owner.',
            'all_boundary_handles_preserved':27,'semantic_files_byte_identical':len(blobs),
            'semantic_tree_git_blobs':blobs,'source_sha256':{str(p.relative_to(ROOT)):sha(p) for p in (NATIVE,LOGICAL,CROSSWALK)},
            'market_handles':rows,'native_relation_count':len(relations),'native_relations':relations,
            'legacy_runtime_checks':runtime,'adverse_change_controls':mutants,
            'private_repository_reads':0,'private_repository_mutations':0,'new_boundary_adapters':0,
            'semantic_changes':0,'new_external_equivalences':0,
            'deferred':'Owner-definition review, public visibility, local replacement concepts and cross-ontology mappings are outside this increment.',
            'limits':'Owner acceptance of current use is not owner-definition equivalence, UFO validation, or a new claim that the legacy typed gate validates these four handles.'}
    write_json('evaluation/market-boundary-preservation.json',report)
    lines=['# Market boundary preservation — issue #24','',
           '**Current reference-only use is accepted and preserved by owner direction (23 October 2026).** The earlier proposal to reassess owner alignment, introduce locally owned replacement concepts or publish sibling repositories is deferred. This increment changes documentation and preservation checks only.','',
           '| Handle | Existing public operational meaning | Recorded kind | Disposition |','| --- | --- | --- | --- |']
    lines += [f"| `{r['native_id']}` | {r['operational_definition']} | `{r['recorded_kind']}` | Preserve unchanged |" for r in rows]
    lines += ['', 'These meanings and locators already exist in the public native v2.0.0 model. No new definition, class, owner mapping, import, constraint or Market runtime adapter is introduced. No sibling/private repository is read or changed by this workflow.','',
              '## Existing native uses','',
              '| Relation | Source | Market target | Recorded target bounds | Existing logical predicate |','| --- | --- | --- | --- | --- |']
    lines += [f"| `{r['native_relation_id']}` {r['title']} | `{r['source']}` | `{r['target']}` | `{r['recorded_target_bounds']}` | `{r['logical_predicate']}` |" for r in relations]
    lines += ['', 'The table reproduces recorded bounds; their original candidate/review metadata is retained in the JSON receipt and is not promoted to a new scientific acceptance. Two reference-record relations use generic `referenceTarget`; the other eleven retain their existing logical range projections. None establishes an accepted mapping to an external owner class.','',
              '## Executed preservation evidence','',
              f"- All {len(blobs)} tracked semantic files are byte-identical to frozen v2.0.0; all 27 boundary elements and the 13 incident Market relations are preserved.",
              f"- All {len(mutants)} memory-only adverse changes are rejected: definitions, labels, kinds, locators, equivalence flags, stereotypes, typed contracts, relation endpoints/cardinalities/removals, and changes to the other 23 boundaries.",
              '- Four direct calls to the frozen boundary runtime retain `REVIEW_REQUIRED / NO_IMPLEMENTED_TYPED_BOUNDARY_CONTRACT`. This result is disclosed unchanged; present reference use is accepted by policy and does not imply a newly implemented typed validator.','',
              '## Release and deferred scope','',
              'v2.0.3 is a documentation/evidence patch over ontology core v2.0.0. Existing Business evidence from #23 is retained. No semantic migration is required. The frozen v2.0.1 documentation and v2.0.2 evaluation release remain unchanged. The future v2.1.0 semantic work remains conditional; private-repository publication is not a prerequisite for this patch.','',
              'The original external alignment/localization objectives of #24 are superseded for this increment by the owner preservation decision. The acceptance is explicitly limited to current reference-only use. ProductLine, Architecture and unresolved/composite external reviews (#25–#27) are deferred; they are not silently reported implemented. Later cross-ontology rewiring requires a new owner-directed review.','',
              '[Exact source identities, all file blobs, relation metadata, runtime observations and adverse controls](market-boundary-preservation.json) · [Frozen native source](../semantic/product/v2/source/formalization/Native_Model_v0_41_0.json)','',
              'Reproduce with `python tools/publication/review_market_preservation.py` from the repository root with the frozen v2.0.0 commit available. No network request is made by this runner.','']
    (ROOT/'evaluation/market-boundary-preservation.md').write_text('\n'.join(lines))
    print(json.dumps({'status':report['status'],'semantic_files':len(blobs),'boundary_handles':27,'market_handles':4,'market_relations':13,'adverse_controls':len(mutants),'legacy_runtime_checks':4}))

if __name__=='__main__':main()
