"""Execute the unmodified default reports and check the annotated distribution."""
from collections import Counter
import argparse
import csv
import gzip
import json
import os
import re
from pathlib import Path
import subprocess
from rdflib import Graph, Literal, RDF, RDFS, OWL, URIRef
from rdflib.compare import isomorphic
from build_metadata_review import CORE,NATIVE,OUTPUT,BASE,CAT,MAP,REGISTER,DC,IAO,ANNOTATIONS,ADDED_DECLARATIONS,boundary_subjects,logical_rdf,validate_view
from evaluation_common import ROOT,SOURCE,sha,graph_text,write_json

ap=argparse.ArgumentParser();ap.add_argument('--robot',type=Path,required=True);args=ap.parse_args()
jar=args.robot.resolve();assert sha(jar)=='53cd275c8e4c0dad1fc2c1c34174876795cd7d6b6926e1444adcbb0cb3c7ab26'
work=ROOT/'build/metadata-tests';work.mkdir(parents=True,exist_ok=True)
commands=[]
def run(args,allowed=(0,)):
    p=subprocess.run(list(map(str,args)),cwd=ROOT,capture_output=True,text=True,timeout=180)
    # Keep substantive log messages while making the receipt reproducible on CI.
    # The unmodified command's dated raw output remains in the CI artifact.
    raw=work/'raw-command-logs';raw.mkdir(exist_ok=True)
    (raw/(str(len(commands)+1)+'.txt')).write_text(p.stdout+'\nSTDERR\n'+p.stderr)
    def portable(s):
        s=s.replace(str(jar),'${ROBOT_JAR}').replace(str(ROOT)+os.sep,'')
        return re.sub(r'(?m)^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3} ', '', s)
    commands.append({'command':[portable(str(s)) for s in args],'exit_code':p.returncode,'stdout':portable(p.stdout),'stderr':portable(p.stderr)})
    assert p.returncode in allowed,commands[-1]
    return p

def report(path,name):
    out=work/(name+'.tsv')
    p=run(['java','-jar',jar,'report','--input',path.relative_to(ROOT),'--format','tsv','--output',out.relative_to(ROOT)],(1,))
    with out.open() as f:rows=list(csv.DictReader(f,delimiter='\t'))
    return sorted(rows,key=lambda r:json.dumps(r,sort_keys=True))

def row_key(row):return tuple(row[k] for k in ('Level','Rule Name','Subject','Property','Value'))
with gzip.open(BASE,'rt') as f:baseline=json.load(f)
with gzip.open(ROOT/'evaluation/robot-metadata-review.json.gz','rt') as f:review=json.load(f)
assert review['annotated_sha256']==sha(OUTPUT)
for path,digest in review['source_sha256'].items():assert sha(ROOT/path)==digest,path
before=report(CORE,'before');after=report(OUTPUT,'after')
assert {row_key(r) for r in before}=={row_key(r) for r in baseline['findings']}
before_keys={row_key(r) for r in before};after_keys={row_key(r) for r in after}
assert len(before)==812 and len(after)==320
assert after_keys<=before_keys, 'New or changed default finding'
assert Counter(r['Level'] for r in after)=={'ERROR':34,'WARN':213,'INFO':73}
assert Counter(r['Rule Name'] for r in after)=={'duplicate_label':33,'missing_definition':213,'missing_superclass':73,'missing_ontology_license':1}
for r in review['findings']:
    expected_resolved=r['decision']=='ANNOTATION_REPAIRED'
    assert (row_key(r) not in after_keys)==expected_resolved,r
run(['java','-jar',jar,'validate-profile','--profile','DL','--input',OUTPUT.relative_to(ROOT),'--output',(work/'dl.txt').relative_to(ROOT)])
run(['java','com.sun.tools.javac.Main','-cp',jar,'-d',work.relative_to(ROOT),'tools/publication/MetadataLogicalIdentity.java','tools/publication/HermitProbe.java'])
identity=run(['java','-cp',str(work.relative_to(ROOT))+os.pathsep+str(jar),'MetadataLogicalIdentity',CORE.relative_to(ROOT),OUTPUT.relative_to(ROOT)])
assert 'IDENTICAL_CLASSES\t121' in identity.stdout
# Exercise the equality guard with a real logical defect in memory/temp only.
a=Graph().parse(CORE);b=Graph().parse(OUTPUT)
adverse=Graph()+b;adverse.add((URIRef('urn:productium:specification-profile:Product'),RDFS.subClassOf,URIRef('urn:productium:specification-profile:TestCase')))
(adverse.serialize(work/'changed.owl',format='xml'))
run(['java','-cp',str(work.relative_to(ROOT))+os.pathsep+str(jar),'MetadataLogicalIdentity',CORE.relative_to(ROOT),(work/'changed.owl').relative_to(ROOT)],(1,))
assert isomorphic(logical_rdf(a),logical_rdf(b)) and not isomorphic(logical_rdf(a),logical_rdf(adverse))
def must_reject(candidate):
    try:validate_view(a,candidate)
    except AssertionError:return
    raise AssertionError('Adverse edit escaped the publication guard')
must_reject(adverse)
held=boundary_subjects(a)
assert len(held)==69 and all(set(a.predicate_objects(s))==set(b.predicate_objects(s)) for s in held)
ontology=next(b.subjects(RDF.type,OWL.Ontology));assert not list(b.objects(ontology,DC.license))
assert not list(b.objects(None,OWL.imports))
# Local-only annotation edit is allowed; logical or held-boundary changes are not.
control=Graph()+b;control.add((URIRef('urn:productium:specification-profile:Product'),RDFS.label,Literal('temporary control')))
assert isomorphic(logical_rdf(b),logical_rdf(control))
validate_view(a,control)
control=Graph()+b;s=sorted(held,key=str)[0];control.add((s,RDFS.label,Literal('unauthorized boundary edit')))
must_reject(control)
control=Graph()+b;control.add((ontology,DC.license,URIRef('urn:unapproved:licence')))
must_reject(control)
# Fresh annotated HermiT TBox checks; logical identity above covers every axiom,
# while the core's 71 scenarios remain separately rerun in expanded CI.
manifest=work/'manifest.tsv';manifest.write_text('tbox\t'+str(OUTPUT.relative_to(ROOT))+'\t\n')
probe=run(['java','-Xmx1200m','-cp',str(work.relative_to(ROOT))+os.pathsep+str(jar),'HermitProbe',manifest.relative_to(ROOT)])
sat=[line.split('\t') for line in probe.stdout.splitlines() if line.startswith('tbox\tSAT\t')]
assert 'tbox\tCONSISTENT\ttrue' in probe.stdout and len(sat)==121 and all(row[3]=='true' for row in sat)
# Exact retained expected answers against both fixture-only and the new view.
base=SOURCE/'validation_v041/cq_replay'
with (base/'Evidence_Index_v0_24_0.csv').open(encoding='utf-8-sig') as f:index=list(csv.DictReader(f))
def canonical(rows):return sorted([list(row) for row in rows],key=lambda row:json.dumps(row,sort_keys=True))
cq=[];sources={}
for item in index:
    for kind in ('query','fixture','expected'):
        path=base/item[kind+'_path'];assert sha(path)==item[kind+'_sha256'];sources[str(path.relative_to(ROOT))]=sha(path)
    query=(base/item['query_path']).read_text();expected=canonical(json.loads((base/item['expected_path']).read_text()))
    data=Graph().parse(base/item['fixture_path'])
    for scope,profile in [('FIXTURE_ONLY',Graph()),('FIXTURE_PLUS_ANNOTATED_PROFILE_NO_INFERENCE',b)]:
        answer=(data+profile).query(query);actual=canonical([[None if v is None else str(v) for v in row] for row in answer])
        assert actual==expected,(item['cq_id'],item['case'],scope)
        cq.append({'cq_id':item['cq_id'],'case':item['case'],'scope':scope,'expected':expected,'actual':actual,'status':'PASS'})
assert len(cq)==374 and len({r['cq_id'] for r in cq})==56
result={'status':'PASS_ANNOTATION_INCREMENT_WITH_RETAINED_DEFAULT_FINDINGS','release':'v2.0.5',
    'baseline_findings':812,'resolved_findings':492,'retained_findings':320,'new_findings':0,
    'before_counts':dict(Counter(r['Level'] for r in before)),'after_counts':dict(Counter(r['Level'] for r in after)),
    'after_rule_counts':dict(Counter(r['Rule Name'] for r in after)),
    'default_report_clean':False,'default_before_exit':1,'default_after_exit':1,
    'logical_axioms_and_signature_equal':True,'logical_rdf_isomorphic':True,'held_boundary_subjects_unchanged':69,
    'native_and_core_sha256':{str(p.relative_to(ROOT)):sha(p) for p in (NATIVE,CORE)},
    'annotated_sha256':sha(OUTPUT),'review_sha256':sha(ROOT/'evaluation/robot-metadata-review.json.gz'),
    'runner_sha256':sha(Path(__file__)),'java_guard_sha256':sha(ROOT/'tools/publication/MetadataLogicalIdentity.java'),
    'log_normalization':'Machine paths and volatile logging timestamps only; substantive messages unchanged. Raw dated command outputs remain in the CI artifact.',
    'adverse_and_stability_controls':4,'named_classes_satisfiable':121,'cq_contracts':56,'cq_exact_answer_comparisons':374,
    'source_sha256':sources,'before':before,'after':after,'commands':commands,'cq_cases':cq,
    'limits':'Internal sourced annotation/elucidation review, not independent semantic acceptance. Default ERROR remains. Rights, owner-held boundaries and scientific/profile decisions are unchanged.'}
write_json('evaluation/robot-metadata-tests.json.gz',result)
lines=['# Annotated metadata view — executed acceptance','',
    '**492 of 812 default findings are resolved; 320 remain explicit.** The unmodified ROBOT 1.9.11 report is executed before and after, with default exit 1 on both. No profile override, severity change, result filter or suppressed row is used. This is not a clean default-report claim.','',
    '| Level | Frozen core | Annotated view |','| --- | ---: | ---: |',
    '| ERROR | 288 | 34 |','| WARN | 451 | 213 |','| INFO | 73 | 73 |','',
    'The retained findings are 33 duplicate boundary labels, 213 missing definitions/elucidations, 73 superclass conventions and one missing project licence. There are zero new findings. Each of all 812 original rows has an exact review decision matching its actual before/after presence.','',
    'OWLAPI independently compares all parsed logical axioms and class/object/data-property signatures: they are equal. A deliberately added subclass axiom is rejected by this guard. Annotation-only stability, forbidden boundary-label mutation and unapproved-licence contrasts are exercised in memory/temp files only. The annotated view passes OWL 2 DL and fresh HermiT consistency/satisfiability checks for all 121 named classes.','',
    'All 56 retained CQ contracts match their source-bound expected answers in 374 fresh comparisons (fixture-only and fixture plus annotated profile, with no inference). The core suite, including 71 HermiT scenarios, all SHACL controls and CQ mutation observations, remains independently rerun in expanded CI. These overlapping counts are not added as coverage.','',
    'All 69 boundary declaration/relation subjects retain every outgoing assertion. No hierarchy, identity, equivalence, restriction, import, licence, class, object-property or data-property signature is changed. Full scientific/native-profile acceptance, external owner equivalence and production readiness are not established.','',
    'Command receipts normalize machine paths and volatile logging timestamps only; substantive messages are retained. Raw dated command outputs are included in the CI artifact.','',
    '[Exact commands, raw findings, source hashes and CQ answers](robot-metadata-tests.json.gz) · [Individual review decisions and sources](robot-metadata-review.md)','']
(ROOT/'evaluation/robot-metadata-tests.md').write_text('\n'.join(lines))
print(json.dumps({k:result[k] for k in ('status','baseline_findings','resolved_findings','retained_findings','new_findings','after_counts','after_rule_counts','named_classes_satisfiable','cq_contracts','cq_exact_answer_comparisons')}))
