"""Fresh OWLAPI/HermiT probes and unfiltered ROBOT profile/report receipts."""
from collections import Counter
from pathlib import Path
import argparse
import csv
import json
import os
import subprocess
import time
from rdflib import BNode, Graph, Literal, Namespace, OWL, RDF, RDFS, URIRef, XSD
from rdflib.compare import to_canonical_graph
from pyshacl import validate
from evaluation_common import ROOT, SOURCE, graph_text, sha, write_json

ap=argparse.ArgumentParser()
ap.add_argument('--robot',type=Path,required=True)
args=ap.parse_args()
jar=args.robot.resolve()
assert sha(jar)=='53cd275c8e4c0dad1fc2c1c34174876795cd7d6b6926e1444adcbb0cb3c7ab26'
work=ROOT/'build/expanded-owl'
work.mkdir(parents=True,exist_ok=True)
profile=SOURCE/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
tbox=Graph().parse(profile)
assert sha(profile)=='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12'
P=Namespace('urn:productium:specification-profile:')
D=Namespace('urn:product-ontology:delivery-profile:0.5:')
A=Namespace('urn:product-ontology:assessment-profile:0.4:')
U=Namespace('urn:ontospk:reasoner-probe:')
commands=[]

def run(command, allowed=(0,),timeout=600):
    p=subprocess.run([str(c) for c in command],cwd=ROOT,capture_output=True,text=True,timeout=timeout)
    portable=lambda text:text.replace(str(jar),'${ROBOT_JAR}').replace(str(ROOT)+os.sep,'')
    commands.append({'command':[portable(str(x)) for x in command], 'exit_code':p.returncode,
                     'stdout':portable(p.stdout),'stderr':portable(p.stderr)})
    assert p.returncode in allowed, commands[-1]
    return p

version=run(['java','-jar',jar,'--version']).stdout.strip()
assert version=='ROBOT version 1.9.11'
run(['java','-jar',jar,'validate-profile','--profile','DL','--input',profile.relative_to(ROOT),
     '--output','build/expanded-owl/dl-profile.txt'])
run(['java','-jar',jar,'reason','--reasoner','HermiT','--equivalent-classes-allowed','all',
     '--input',profile.relative_to(ROOT),'--output','build/expanded-owl/reasoned.owl'])
editorial=run(['java','-jar',jar,'report','--input',profile.relative_to(ROOT),'--format','tsv',
               '--output','build/expanded-owl/robot-report.tsv'],allowed=(0,1))
with (work/'robot-report.tsv').open() as f:
    rows=list(csv.DictReader(f,delimiter='\t'))
known={'missing_label','duplicate_label','missing_definition','missing_superclass',
       'missing_ontology_description','missing_ontology_license','missing_ontology_title'}
assert {r['Rule Name'] for r in rows} <= known, 'Unadjudicated ROBOT finding'
assert len(rows)==812 and Counter(r['Level'] for r in rows)=={'ERROR':288,'WARN':451,'INFO':73}
dispositions={
 'missing_label':'Editorial metadata debt; identifiers remain authoritative. Add curated source-bound labels only in a new version.',
 'duplicate_label':'Lexical collision across distinct IRIs; not owl:sameAs or a logical contradiction. Retain distinct meanings; review disambiguation in the next metadata increment.',
 'missing_definition':'Editorial evidence debt; no definition is invented by this release. Source-backed concept pages remain #37.',
 'missing_superclass':'Default OBO hierarchy expectation; an undeclared superclass is not proof of logical incoherence. All named classes are checked independently below.',
 'missing_ontology_description':'Ontology-header metadata follow-up; repository/guide descriptions do not fill an OWL annotation automatically.',
 'missing_ontology_title':'Ontology-header metadata follow-up; no frozen graph mutation in this evaluation patch.',
 'missing_ontology_license':'Known rights state: no project-wide reuse licence selected. Do not manufacture a licence axiom.'}
for row in rows:
    row['disposition']=dispositions[row['Rule Name']]
rows=sorted(rows,key=lambda x:json.dumps(x,sort_keys=True))

cases=[]
def case(name, data, consistent=True, query=None, entails=None, commitments=(),meaning=''):
    assert name not in {x['id'] for x in cases}
    cases.append({'id':name,'data':data,'consistent':consistent,'query':query,
                  'entails':entails,'commitments':list(commitments),'meaning':meaning})

def triples(*ts):
    g=Graph()
    for t in ts:g.add(t)
    return g

case('tbox',Graph(),commitments=['OPEN01'],meaning='Consistency and individual satisfiability of every named class; not conceptual adequacy.')
case('positive_population',Graph().parse(SOURCE/'validation_v041/fixtures/combined-positive.ttl'),commitments=['INT01'])
# Every explicit exact-cardinality restriction receives a distinctly bound
# counterexample. This includes inverse restrictions and does not assume UNA.
restrictions=[]
for cls, restriction in tbox.subject_objects(RDFS.subClassOf):
    cardinality=tbox.value(restriction,OWL.cardinality)
    if cardinality is None:continue
    assert int(cardinality)==1
    prop=tbox.value(restriction,OWL.onProperty)
    data=triples((U.focus,RDF.type,cls))
    if isinstance(prop,BNode):
        inv=tbox.value(prop,OWL.inverseOf)
        assert isinstance(inv,URIRef)
        data.add((U.one,inv,U.focus));data.add((U.two,inv,U.focus))
        display='inverse '+str(inv)
    else:
        if (prop,RDF.type,OWL.DatatypeProperty) in tbox:
            datatype=tbox.value(prop,RDFS.range)
            assert datatype==XSD.string
            data.add((U.focus,prop,Literal('first',datatype=datatype)))
            data.add((U.focus,prop,Literal('second',datatype=datatype)))
        else:
            assert (prop,RDF.type,OWL.ObjectProperty) in tbox
            data.add((U.focus,prop,U.one));data.add((U.focus,prop,U.two))
        display=str(prop)
    data.add((U.one,OWL.differentFrom,U.two))
    restrictions.append((str(cls),display,data))
for i,(cls,prop,data) in enumerate(sorted(restrictions,key=lambda x:x[:2])):
    case(f'exact_cardinality_distinct_{i:02}',data,False,meaning=cls+' exact 1 on '+prop)
assert len(restrictions)==27

# All explicit disjointWith pairs are tested, independently of class labels.
for i,(a,b) in enumerate(sorted(tbox.subject_objects(OWL.disjointWith),key=lambda x:tuple(map(str,x)))):
    case(f'disjoint_{i:02}',triples((U.focus,RDF.type,a),(U.focus,RDF.type,b)),False,
         meaning=str(a)+' disjointWith '+str(b))

for name, prop, subject, target, commitments in [
 ('has_result','recordsExecution',P.TestResult,P.TestExecution,['EV01']),
 ('executes','executes',P.TestExecution,P.TestCase,['EV02']),
 ('suite_index','r147_hasRecordedExecution',P.TestSuiteSpecification,P.TestExecution,['EV03']),
 ('tested_realization','testsRealization',P.TestExecution,P.ProductRealization,['EV04']),
 ('assessed_specification','assessesSpecification',P.TestExecution,P.CapabilitySpecification,['EV05']),
 ('execution_context',str(D.executionContext),P.TestExecution,A.AssessmentContextSpecification,['EV06']),
 ('execution_criterion',str(D.executionCriterion),P.TestExecution,P.ConditionSpecification,['EV07']),
]:
    p=URIRef(prop) if prop.startswith('urn:') else P[prop]
    assert (p,RDFS.domain,subject) in tbox and (p,RDFS.range,target) in tbox
    query=triples((U.source,RDF.type,subject),(U.target,RDF.type,target))
    query.add((subject,RDF.type,OWL.Class));query.add((target,RDF.type,OWL.Class))
    case('domain_range_'+name,triples((U.source,p,U.target)),query=query,entails=True,commitments=commitments,
         meaning='Endpoint types are inferred from the asserted property, not rejected as missing explicit types.')

for label,data,query,commitment in [
 ('version',triples((U.r,RDF.type,P.ProductRealization),(U.r,P.realizesVersion,U.one),(U.r,P.realizesVersion,U.two)),triples((U.one,OWL.sameAs,U.two)),['ID01','EV09']),
 ('bearer',triples((U.cap,RDF.type,P.ProductCapability),(U.one,P.bearsCapability,U.cap),(U.two,P.bearsCapability,U.cap)),triples((U.one,OWL.sameAs,U.two)),['ID03']),
 ('result_event',triples((U.result,RDF.type,P.TestResult),(U.result,P.recordsExecution,U.one),(U.result,P.recordsExecution,U.two)),triples((U.one,OWL.sameAs,U.two)),['EV01'])
]:
    case('equality_'+label,data,query=query,entails=True,commitments=commitment)
    distinct=Graph()+data;distinct.add((U.one,OWL.differentFrom,U.two))
    case('distinct_'+label,distinct,False,commitments=commitment)

case('missing_version_open_world',triples((U.r,RDF.type,P.ProductRealization)),query=triples((U.r,P.realizesVersion,U.unspecified)),entails=False,commitments=['ID01','EV09'])
case('missing_capability_open_world',triples((U.r,RDF.type,P.ProductRealization)),query=triples((U.r,P.bearsCapability,U.unspecified)),entails=False,commitments=['ID02'])
case('missing_bearer_open_world',triples((U.cap,RDF.type,P.ProductCapability)),query=triples((U.unspecified,P.bearsCapability,U.cap)),entails=False,commitments=['ID03'])
case('missing_end_open_world',triples((U.event,RDF.type,P.TestExecution)),query=triples((U.event,D.executionEndedAt,Literal('2026-01-01T00:00:00Z',datatype=XSD.dateTime))),entails=False,commitments=['EV08'])
case('two_end_times',triples((U.event,RDF.type,P.TestExecution),(U.event,D.executionEndedAt,Literal('2026-01-01T00:00:00Z',datatype=XSD.dateTime)),(U.event,D.executionEndedAt,Literal('2026-01-02T00:00:00Z',datatype=XSD.dateTime))),False,commitments=['EV08'])
time_data=triples((U.one,RDF.type,P.TestExecution),(U.two,RDF.type,P.TestExecution),
                  (U.one,D.executionEndedAt,Literal('2026-01-01T00:00:00Z',datatype=XSD.dateTime)),
                  (U.two,D.executionEndedAt,Literal('2026-01-01T00:00:00Z',datatype=XSD.dateTime)))
case('equal_times_no_identity',time_data,query=triples((U.one,OWL.sameAs,U.two)),entails=False,commitments=['ID05'])
separate=Graph()+time_data;separate.add((U.one,OWL.differentFrom,U.two))
case('equal_times_distinct_events',separate,commitments=['ID05'])
case('no_version_specification_chain',triples((U.event,P.assessesSpecification,U.spec),(U.event,P.testsRealization,U.r),(U.r,P.realizesVersion,U.v)),query=triples((U.v,P.specifiesCapability,U.spec)),entails=False,commitments=['EV10'])
case('no_suite_case_closure',triples((U.suite,P.r147_hasRecordedExecution,U.event),(U.event,P.executes,U.case)),query=triples((U.suite,P.containsCase,U.case)),entails=False,commitments=['EV11'])
case('no_criterion_propagation',triples((U.event,D.executionCriterion,U.criterion),(U.event,P.testsRealization,U.r)),query=triples((U.r,D.executionCriterion,U.criterion)),entails=False,commitments=['EV12'])
case('no_success_from_result',triples((U.result,P.recordsExecution,U.event)),query=triples((U.result,D.resultOutcome,Literal('passed'))),entails=False,commitments=['EV12'])

# Declare query vocabulary so RDF/XML is parsed as the intended OWL axiom,
# rather than as an undeclared annotation assertion.
manifest=[]
for c in cases:
    inp=work/(c['id']+'.owl')
    to_canonical_graph(tbox+c['data']).serialize(inp,format='xml')
    query_path=''
    if c['query'] is not None:
        q=Graph()+c['query']
        for s,p,o in list(q):
            if p in (RDF.type,OWL.sameAs,OWL.differentFrom):continue
            typ=OWL.DatatypeProperty if isinstance(o,Literal) else OWL.ObjectProperty
            q.add((p,RDF.type,typ))
        query_path=work/(c['id']+'-query.owl')
        to_canonical_graph(q).serialize(query_path,format='xml')
    manifest.append('\t'.join([c['id'],str(inp.relative_to(ROOT)),str(query_path.relative_to(ROOT)) if query_path else '']))
(work/'manifest.tsv').write_text('\n'.join(manifest)+'\n')
run(['java','com.sun.tools.javac.Main','-cp',jar,'-d',str(work.relative_to(ROOT)),
     'tools/publication/HermitProbe.java'])
probe=run(['java','-Xmx1200m','-cp',str(work.relative_to(ROOT))+os.pathsep+str(jar),
           'HermitProbe',str((work/'manifest.tsv').relative_to(ROOT))],timeout=1200)
actual={c['id']:{'entailments':[]} for c in cases}
classes=[]
versions=set()
for line in probe.stdout.splitlines():
    cols=line.split('\t')
    if len(cols)<3 or cols[0] not in actual:continue
    if cols[1]=='CONSISTENT':actual[cols[0]]['consistent']=cols[2]=='true'
    elif cols[1]=='SAT':classes.append({'iri':cols[2],'satisfiable':cols[3]=='true'})
    elif cols[1]=='ENTAIL':actual[cols[0]]['entailments'].append({'entailed':cols[2]=='true','axiom':cols[3]})
    elif cols[1]=='VERSION':versions.add(cols[2])
named={str(c) for c in tbox.subjects(RDF.type,OWL.Class) if isinstance(c,URIRef)}
assert {c['iri'] for c in classes}==named and len(classes)==121 and all(c['satisfiable'] for c in classes)
observations=[]
for c in cases:
    observed=actual[c['id']]
    assert observed.get('consistent') is c['consistent'], (c['id'],observed)
    if c['query'] is not None:
        assert observed['entailments'] and all(q['entailed'] is c['entails'] for q in observed['entailments']), (c['id'],observed)
    observations.append({'id':c['id'],'expected_consistent':c['consistent'],
                         'expected_entails':c['entails'],'observed':observed,
                         'data_ntriples':graph_text(c['data']),
                         'query_ntriples':graph_text(c['query']) if c['query'] is not None else None,
                         'commitments':c['commitments'],'meaning':c['meaning'],'status':'PASS'})

# Actual closed-world contrast for a missing explicit version/bearer.
identity=Graph().parse(SOURCE/'validation_v041/inputs/identity-slice.shacl.ttl')
contrasts=[]
for name,data in [('missing_version',triples((U.r,RDF.type,P.ProductRealization))),
                  ('missing_bearer',triples((U.cap,RDF.type,P.ProductCapability)))]:
    conforms,report,_=validate(data,shacl_graph=identity,inference='none')
    assert not conforms
    contrasts.append({'id':name,'owl_consistent':True,'shacl_conforms':False,
                      'shacl_report_ntriples':graph_text(report)})
result={'status':'PASS','logical_source':str(profile.relative_to(ROOT)),'logical_sha256':sha(profile),
        'robot_version':version,'robot_sha256':sha(jar),'hermit_versions':sorted(versions),
        'java_version':run(['java','-version']).stderr.strip(),
        'owl2_dl':'PASS','tbox_consistent':True,'named_classes':classes,
        'scenarios':observations,'closed_world_contrasts':contrasts,'commands':commands,
        'explicit_exact_cardinality_counterexamples':len(restrictions),
        'scope':'Read-only checks of the bounded released OWL profile; no new axioms, full UFO modal/causal verification or independent scientific acceptance.'}
write_json('evaluation/owl-hermit.json.gz',result)
editorial_report={'status':'EXECUTED_AND_ADJUDICATED_NOT_ZERO_FINDINGS',
                  'tool':'ROBOT 1.9.11 report default profile','source_sha256':sha(profile),
                  'exit_code':editorial.returncode,'counts':dict(Counter(r['Level'] for r in rows)),
                  'rule_counts':dict(sorted(Counter(r['Rule Name'] for r in rows).items())),
                  'findings':rows,'dispositions':dispositions,
                  'release_gate':'No unexplained logical failure. The unfiltered default metadata findings remain explicit follow-ups, not claimed repaired.'}
write_json('evaluation/robot-report.json.gz',editorial_report)
(ROOT/'evaluation/owl-hermit.md').write_text('\n'.join([
 '# OWL profile, satisfiability and HermiT execution','',
 f"ROBOT 1.9.11 (verified JAR SHA-256) passes OWL 2 DL validation and HermiT baseline reasoning. HermiT's actual isSatisfiable call returns true for all 121 named classes. {len(cases)} isolated scenarios match their expected consistency; queried entailments/non-entailments match their explicit oracles.",'',
 f"All {len(restrictions)} exact-cardinality restrictions and all 18 explicit disjointWith pairs receive isolated contradictory witnesses. Seven event predicates receive domain/range entailment probes. Equality, explicit differentFrom, existential omissions, timestamps and non-propagation are checked separately.",'',
 'Multiple names do not imply distinct individuals in OWL. Two distinct fillers violate an exact-one restriction; two unseparated names can entail equality. A missing explicit filler remains OWL-consistent but fails the closed-world identity SHACL contract. Domain/range infer types; they do not reject absent explicit type assertions.','',
 'Temporal continuity, historical persistence and independent domain acceptance are not inferred from these tests. The command receipt records ROBOT orchestration separately from direct HermiT consistency, satisfiability and entailment calls.','',
 '[Inputs, commands and per-case observations](owl-hermit.json.gz) · [Default ROBOT report findings](robot-report.md)','']))
lines=['# ROBOT execution and finding adjudication','',
       'ROBOT 1.9.11 was actually executed for version readback, OWL 2 DL profile validation, HermiT orchestration and its unmodified default report. The profile and reason commands pass. The default report returns exit 1 with **812 findings: 288 ERROR, 451 WARN, 73 INFO**. These are not hidden or relabelled as a clean report.','',
       '| Default rule | Findings | Disposition |','| --- | ---: | --- |']
lines += [f'| {rule} | {count} | {dispositions[rule]} |' for rule,count in sorted(Counter(r['Rule Name'] for r in rows).items())]
lines += ['', 'The default report applies OBO-style editorial conventions. These findings are metadata/hierarchy conventions, not evidence of an inconsistent ontology. No labels, definitions, ontology headers or licence assertions were fabricated to clear them. Future metadata repair requires its own version and source review; this evaluation patch preserves the frozen logical graph. The follow-up is tracked in [issue #44](https://github.com/ArazSaieArasi3/OntoSPK/issues/44).','',
          '[Unfiltered findings and exact dispositions](robot-report.json.gz) · [Actual tool commands, exit statuses and outputs](owl-hermit.json.gz)','']
(ROOT/'evaluation/robot-report.md').write_text('\n'.join(lines))
print(json.dumps({'status':'PASS','classes':len(classes),'scenarios':len(cases),'robot_findings':len(rows)}))
