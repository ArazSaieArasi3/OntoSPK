from pathlib import Path
import csv,json,hashlib,collections,sys
import rdflib
R=Path(__file__).resolve().parent
def read(n):
 with (R/n).open(encoding='utf-8-sig') as f:return list(csv.DictReader(f))
def canonical(rows):return sorted([list(row) for row in rows],key=lambda row:json.dumps(row,ensure_ascii=False))
index=read('Evidence_Index_v0_24_0.csv');results=[]
profile=R/'Retained_Formal_Profile_v0_22_0.ttl'
for item in index:
 for key in ['query','fixture','expected']:
  assert hashlib.sha256((R/item[key+'_path']).read_bytes()).hexdigest()==item[key+'_sha256']
 expected=json.loads((R/item['expected_path']).read_text())
 for scope in ['FIXTURE_ONLY','FIXTURE_PLUS_CURRENT_PROFILE_NO_INFERENCE']:
  g=rdflib.Graph()
  if scope!='FIXTURE_ONLY':g.parse(profile,format='turtle')
  g.parse(R/item['fixture_path'],format='turtle')
  try:
   answer=g.query((R/item['query_path']).read_text());variables=[str(v) for v in answer.vars]
   actual=[[None if v is None else str(v) for v in row] for row in answer]
   ok=canonical(actual)==canonical(expected);error=None
  except Exception as e:actual=[];variables=[];ok=False;error=repr(e)
  results.append(dict(cq_id=item['cq_id'],case=item['case'],scope=scope,pass_=ok,variables=variables,actual=actual,expected=expected,error=error))
report={'version':'0.24.0','rdflib_version':rdflib.__version__,'inference':'NONE','test_kind':'Retained exact-answer regression; not independent validation or OWL entailment testing','cq_count':len({x['cq_id'] for x in index}),'fixture_count':len(index),'comparisons':len(results),'passed':sum(x['pass_'] for x in results),'failed':sum(not x['pass_'] for x in results),'profile_sha256':hashlib.sha256(profile.read_bytes()).hexdigest(),'results':results}
(R/'CQ_Replay_Report_v0_24_0.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='results'},indent=2))
if report['failed']:sys.exit(1)
for file,status in [('Requirements_Register_v0_24_0.csv','test_status'),('CQ_Contracts_v0_24_0.csv','execution_status')]:
 rows=read(file)
 for row in rows:
  if row[status]=='PORTABLE_FIXTURE_REPLAY_PENDING':row[status]='RETAINED_FIXTURES_REPLAYED_NO_INFERENCE_ACCEPTANCE_PENDING'
 with (R/file).open('w',encoding='utf-8-sig',newline='') as f:
  w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
