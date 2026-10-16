"""Fresh OWL 2 DL/HermiT checks against the retained operational TBox.

The finite fixtures below compare logical consistency with closed-world
admission. They do not establish independent conceptual acceptance.
"""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib,json,subprocess,sys,time,copy
from rdflib import Graph,Namespace,URIRef,Literal,RDF,RDFS,OWL
from rdflib.compare import to_isomorphic
from pyshacl import validate

W=Path(__file__).resolve().parent;R=W.parent;F=W/'fixtures';OUT=W/'results'
F.mkdir(exist_ok=True);OUT.mkdir(exist_ok=True)
jar=Path(sys.argv[1]).resolve()
P=Namespace('urn:productium:specification-profile:')
N=Namespace('urn:ontospk:t52:fixture:')
retained=R/'validation_v041/cq_replay/Retained_Formal_Profile_v0_22_0.ttl'
tbox=Graph().parse(retained)
# Update only explanatory annotations. Logical axioms and identifiers persist.
for subject,text in [
 (P.TestExecution,'A concluded attempt concerning one declared TestCase and ProductRealization. A setup-only abort does not establish actual target participation. One consolidated result documents the attempt.'),
 (P.recordsExecution,'A consolidated result documents one concluded attempt; inverse of the native hasResult association, not a report-creation relation.')]:
 tbox.remove((subject,RDFS.comment,None));tbox.add((subject,RDFS.comment,Literal(text)))
current_profile=Graph().parse(W/'Current_Logical_Profile_v0_43_0.ttl')
assert to_isomorphic(tbox)==to_isomorphic(current_profile)
logical=lambda g:Graph()+g
before=Graph().parse(retained)
for g in [before,tbox]:g.remove((None,RDFS.comment,None))
assert to_isomorphic(before)==to_isomorphic(tbox)
# Restore annotations in the actual current profile after logical comparison.
tbox=Graph().parse(W/'Current_Logical_Profile_v0_43_0.ttl')
base=Graph().parse(R/'validation_v041/fixtures/combined-positive.ttl')
node=lambda typ:next(base.subjects(RDF.type,typ))
real=node(P.ProductRealization);cap=node(P.ProductCapability);version=node(P.ProductVersion)
event=node(P.TestExecution);result=node(P.TestResult);product=node(P.Product)
cases=[]
def case(name,g,consistent,meaning):
 full=Graph()+tbox+g
 for p,ns in [('p',P),('test',N)]:full.bind(p,ns)
 path=F/(name+'.owl');full.serialize(path,format='xml')
 cases.append(dict(id=name,input=str(path.relative_to(W)),expected_consistent=consistent,meaning=meaning,asserted_fixture_triples=len(g)))
case('tbox',Graph(),True,'Consistency and satisfiability check of retained logical theory; not model adequacy.')
case('positive_population',base,True,'Combined 13-class, 37-triple synthetic population.')
g=Graph();g.add((N.cap,RDF.type,P.ProductCapability))
case('missing_bearer_open_world',g,True,'Existential bearer need not be an explicitly named RDF filler under open-world semantics.')
for distinct in [False,True]:
 g=Graph()+base;g.add((N.second_real,RDF.type,P.ProductRealization));g.add((N.second_real,P.bearsCapability,cap));g.add((N.second_real,P.realizesVersion,version))
 if distinct:g.add((N.second_real,OWL.differentFrom,real))
 case('two_bearers_'+('distinct' if distinct else 'unseparated'),g,not distinct,'Two named bearers violate uniqueness only when logically distinct; SQL/SHACL count RDF terms separately.')
for distinct in [False,True]:
 g=Graph()+base;g.add((N.second_version,RDF.type,P.ProductVersion));g.add((product,P.hasVersion,N.second_version));g.add((real,P.realizesVersion,N.second_version))
 if distinct:g.add((N.second_version,OWL.differentFrom,version))
 case('two_versions_'+('distinct' if distinct else 'unseparated'),g,not distinct,'Exactly-one version does not impose a unique-name assumption.')
g=Graph()+base;g.remove((real,P.realizesVersion,None))
case('missing_version_open_world',g,True,'OWL can satisfy the missing version existential; explicit completeness requires data validation.')
g=Graph()+base;g.add((event,RDF.type,P.TestResult))
case('event_also_result',g,False,'An attempt event and result record cannot be one individual under retained disjointness.')
g=Graph()+base;g.add((cap,RDF.type,P.CapabilitySpecification))
case('actual_capability_also_specification',g,False,'Actual disposition and capability specification are disjoint in the retained profile.')
g=Graph()+base;g.add((product,RDF.type,P.ProductVersion))
case('product_also_version',g,False,'Product and version are distinct categories under retained disjointness.')
g=Graph()+base;g.remove((real,RDF.type,P.ProductRealization))
case('missing_explicit_type_open_world',g,True,'OWL can infer realization type from declared property domain; explicit-type validation is a separate contract.')
occ=Graph().parse(R/'validation_v041/fixtures/occurrence-positive-v041.ttl')
q=Namespace('urn:ontospk:occurrence-profile:0.41:')
logical_occ=Graph();metadata=Graph()
for t in occ:(metadata if str(t[1]).startswith(str(q)) else logical_occ).add(t)
assert len(occ)==len(logical_occ)+len(metadata)
metadata.serialize(F/'occurrence_operational_metadata.ttl',format='turtle')
logical_occ.serialize(F/'occurrence_logical_population.ttl',format='turtle')
case('current_occurrence_logical_projection',logical_occ,True,'All profile metadata preserved separately; only the declared logical vocabulary enters this reasoner input.')

def run_one(c):
 inp=W/c['input'];start=time.monotonic()
 prof=['java','-Xmx768m','-jar',str(jar),'validate-profile','--profile','DL','--input',str(inp),'--output',str(OUT/(c['id']+'_DL.txt'))]
 p=subprocess.run(prof,text=True,capture_output=True,timeout=90)
 cmd=['java','-Xmx768m','-jar',str(jar),'reason','--input',str(inp),'--reasoner','HermiT','--output',str(OUT/(c['id']+'_reasoned.owl'))]
 r=subprocess.run(cmd,text=True,capture_output=True,timeout=90)
 message=r.stdout+r.stderr
 observed=True if r.returncode==0 else (False if 'ontology is inconsistent' in message.lower() else None)
 record=dict(**c,input_sha256=hashlib.sha256(inp.read_bytes()).hexdigest(),profile_exit_code=p.returncode,profile_stdout=p.stdout,profile_stderr=p.stderr,command=cmd,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr,observed_consistent=observed,passed=p.returncode==0 and observed is c['expected_consistent'],seconds=round(time.monotonic()-start,3))
 (OUT/(c['id']+'_command.json')).write_text(json.dumps(record,indent=2)+'\n')
 return record
with ThreadPoolExecutor(max_workers=3) as pool:results=list(pool.map(run_one,cases))
identity=Graph().parse(R/'validation_v041/inputs/identity-slice.shacl.ttl')
g=Graph();g.add((N.cap,RDF.type,P.ProductCapability))
ok,_,report=validate(g,shacl_graph=identity,inference='none')
data=[dict(id='missing_bearer_explicit_population',expected_conforms=False,observed_conforms=bool(ok),passed=not ok,report=report)]
# Explicit double bindings in the same minimal identity slice.
for id,g in [('two_explicit_bearers',Graph()+base),('two_explicit_versions',Graph()+base),('missing_explicit_version',Graph()+base)]:
 if id=='two_explicit_bearers':g.add((N.second_real,RDF.type,P.ProductRealization));g.add((N.second_real,P.bearsCapability,cap));g.add((N.second_real,P.realizesVersion,version))
 if id=='two_explicit_versions':g.add((real,P.realizesVersion,N.second_version));g.add((N.second_version,RDF.type,P.ProductVersion))
 if id=='missing_explicit_version':g.remove((real,P.realizesVersion,None))
 ok,_,report=validate(g,shacl_graph=identity,inference='none')
 data.append(dict(id=id,expected_conforms=False,observed_conforms=bool(ok),passed=not ok,report=report))
version_run=subprocess.run(['java','-jar',str(jar),'--version'],capture_output=True,text=True,check=True)
summary=dict(version='0.43.0',date=__import__('datetime').datetime.now(__import__('datetime').timezone.utc).date().isoformat(),tool_version=version_run.stdout.strip(),tool_sha256=hashlib.sha256(jar.read_bytes()).hexdigest(),tool_source='https://github.com/ontodev/robot/releases/download/v1.9.11/robot.jar',reasoner='HermiT',logical_axioms_unchanged=True,explanatory_annotation_changes=2,reasoner_cases=len(results),profile_passes=sum(x['profile_exit_code']==0 for x in results),expected_consistent=sum(x['expected_consistent'] for x in results),expected_inconsistent=sum(not x['expected_consistent'] for x in results),passed=sum(x['passed'] for x in results),closed_world_contrast_controls=len(data),contrast_passed=sum(x['passed'] for x in data),occurrence_projection=dict(input_triples=len(occ),logical_triples=len(logical_occ),preserved_metadata_triples=len(metadata)),results=results,data_contrasts=data,scope='Full retained operational TBox with selected synthetic populations; no complete UFO modal/causal formalization, independent acceptance or production claim.')
(OUT/'Formal_Checks_v0_43_0.json').write_text(json.dumps(summary,indent=2)+'\n')
print(json.dumps({k:v for k,v in summary.items() if k not in ['results','data_contrasts']},indent=2))
assert all(x['passed'] for x in results+data)
