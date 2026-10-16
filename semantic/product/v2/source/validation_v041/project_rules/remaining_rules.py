"""Declared-model applicability for 40 rules and project checks for nine active rules.
This pinned-profile audit does not claim full OntoUML/UFO or external semantics.
"""
import collections,copy,hashlib,json
from pathlib import Path
W=Path(__file__).resolve().parent
def read(p):return json.loads(p.read_text())
def write(n,x):(W/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
BASE={'historicalRole','phase','role','subkind'}
ULT={'collective','kind','mode','quality','quantity','relator','type'}
NON={'category','historicalRoleMixin','mixin','phaseMixin','roleMixin'}
SORTAL=BASE|ULT
RIGID={'category','collective','kind','mode','quality','quantity','relator','subkind'}
SEMI={'mixin'};ANTI={'historicalRole','historicalRoleMixin','phase','phaseMixin','role','roleMixin'}
ENDURANT={'functional-complex','collective','quantity','relator','intrinsic-mode','extrinsic-mode','quality'}
MOMENT={'intrinsic-mode','extrinsic-mode','quality'}
ACTIVE={'R_CL_ASZ','R_CL_BLE','R_CL_LAX','R_CL_PPZ','R_CL_ZEF','R_GE_EPG','R_GE_HGQ','R_GS_YKW','R_RE_ECP'}
RELATIONS={'R_RE_CDJ':'mediation','R_RE_ECP':'characterization','R_RE_FIX':'componentOf','R_RE_GZF':'instantiation',
 'R_RE_JND':'instantiation','R_RE_RON':'memberOf','R_RE_SEI':'instantiation','R_RE_UCH':'subCollectionOf','R_RE_VDQ':'derivation','R_RE_VMI':'externalDependence'}
def order1(e):return e.get('order') in ['1',1] and not isinstance(e.get('order'),bool)
def select(code,els):
 es={e['id']:e for e in els};out=[]
 for e in els:
  t=e['type'];s=e.get('stereotype');n=e.get('restrictedTo',[]);power=e.get('isPowertype') is True
  if t=='Class':
   conditions={
    'R_CL_ANY':power,'R_CL_ASZ':s in NON and order1(e),'R_CL_BFO':n==['collective'],
    'R_CL_BLE':s in RIGID|SEMI,'R_CL_BQI':n==['type'],'R_CL_CMS':s=='phase',
    'R_CL_GAZ':'type' in n and len(set(n))>1,'R_CL_JFW':power,
    'R_CL_LAX':s in BASE and order1(e),'R_CL_NBG':s=='phaseMixin',
    'R_CL_OEV':s=='role' and e.get('isDerived') is not True,'R_CL_PPZ':e.get('isAbstract') is True,
    'R_CL_PSQ':s=='type','R_CL_QOV':power,'R_CL_UTL':'type' in n,'R_CL_ZEF':s=='mode'}
   if conditions.get(code,False):out.append(e)
  elif t=='Generalization':
   a=es.get(e['general'],{});g=a.get('stereotype')
   conditions={'R_GE_BAK':g=='abstract','R_GE_EPG':g in ULT,'R_GE_HGQ':g in SORTAL,
    'R_GE_JLW':g=='datatype','R_GE_MXI':g in ANTI,'R_GE_UXR':g=='situation','R_GE_VEZ':g=='enumeration','R_GE_XRS':a.get('isExtensional') is True}
   if conditions.get(code,False):out.append(e)
  elif t=='GeneralizationSet':
   cat=e.get('categorizer') is not None
   conditions={'R_GS_LHD':cat,'R_GS_PQP':cat,'R_GS_UTW':cat,'R_GS_XXB':cat and e.get('isComplete') is True,
    'R_GS_YKW':True,'R_GS_ZMQ':cat and e.get('isDisjoint') is False}
   if conditions.get(code,False):out.append(e)
  elif t=='BinaryRelation' and code in RELATIONS and s==RELATIONS[code]:
   if code in ['R_RE_GZF','R_RE_JND']:
    ends=e.get('properties',[]);source=es.get(es.get(ends[0],{}).get('propertyType'),{}) if ends else {}
    o=source.get('order');is_numeric=(isinstance(o,int) and not isinstance(o,bool)) or isinstance(o,str) and o.isdecimal()
    if (code=='R_RE_GZF' and not is_numeric) or (code=='R_RE_JND' and o!='*'):continue
   out.append(e)
 return out

def closure(start,edges):
 seen=set();todo=list(edges.get(start,[]))
 while todo:
  x=todo.pop()
  if x not in seen:seen.add(x);todo.extend(edges.get(x,[]))
 return seen
def evaluate(code,els):
 assert code in ACTIVE
 es={e['id']:e for e in els};parents=collections.defaultdict(set);children=collections.defaultdict(set)
 for e in els:
  if e['type']=='Generalization':parents[e['specific']].add(e['general']);children[e['general']].add(e['specific'])
 findings=[];focus=select(code,els)
 for e in focus:
  ok=True;witness=[];reason=''
  if code in ['R_CL_ASZ','R_CL_LAX','R_CL_ZEF']:
   n=set(e.get('restrictedTo',[]));allowed={'intrinsic-mode','extrinsic-mode'} if code=='R_CL_ZEF' else ENDURANT
   ok=bool(n) and n<=allowed and (code!='R_CL_LAX' or len(n)==1);reason='restrictedTo domain/cardinality'
  elif code=='R_CL_BLE':
   ancestors=closure(e['id'],parents);witness=sorted(x for x in ancestors if es.get(x,{}).get('stereotype') in ANTI)
   unknown=[x for x in ancestors if x not in es or es[x].get('stereotype') is None]
   ok=False if witness else None if unknown or e['id'] in ancestors else True;reason='all-depth anti-rigid ancestry; unknowns/cycles cannot establish acceptance'
  elif code=='R_CL_PPZ':
   ancestors=closure(e['id'],parents);candidates=closure(e['id'],children)
   for a in ancestors:candidates|=closure(a,children)
   candidates.discard(e['id'])
   # Explicit false is a concrete witness; do not silently turn null into false.
   witness=sorted(x for x in candidates if es.get(x,{}).get('isAbstract') is False)
   uncertain=[x for x in candidates if es.get(x,{}).get('isAbstract') is None]
   ok=None if e['id'] in ancestors else True if witness else None if uncertain else False
   reason='concrete descendant or concrete specialization of an ancestor; null concreteness stays unknown'
  elif code in ['R_GE_EPG','R_GE_HGQ']:
   s=es.get(e['specific'],{}).get('stereotype');ok=None if s is None else s not in (ULT if code=='R_GE_EPG' else NON)
   reason='specific stereotype restriction'
  elif code=='R_GS_YKW':
   gens=[es.get(i) for i in e.get('generalizations',[])]
   ok=None if not gens or any(not x or x['type']!='Generalization' for x in gens) else len({x['general'] for x in gens})==1
   reason='all listed generalizations share one explicit general class'
  elif code=='R_RE_ECP':
   ends=[es.get(i,{}) for i in e.get('properties',[])];types=[es.get(x.get('propertyType'),{}) for x in ends]
   if len(types)!=2 or any(x.get('type')!='Class' or not x.get('restrictedTo') for x in types):ok=None
   else:ok=set(types[0]['restrictedTo'])<=MOMENT and set(types[1]['restrictedTo'])<=ENDURANT|{'type'}
   witness=[{'end':x.get('id'),'type':x.get('propertyType'),'cardinality':x.get('cardinality')} for x in ends]
   reason='pinned graph profile requires moment -> endurant, unlike the retained catalogue-oriented bearer -> feature relation'
  findings.append({'id':e['id'],'status':'PASS' if ok is True else 'FAIL' if ok is False else 'UNDETERMINED','reason':reason,'witness':witness})
 status='NOT_APPLICABLE' if not findings else 'FAIL' if any(x['status']=='FAIL' for x in findings) else 'UNDETERMINED' if any(x['status']=='UNDETERMINED' for x in findings) else 'PASS'
 return {'rule':code,'focus_count':len(findings),'status':status,'findings':findings}

def adapt_characterization(model):
 out=copy.deepcopy(model);es={e['id']:e for e in out['elements']};mapping=[]
 for e in out['elements']:
  if e['type']!='BinaryRelation' or e.get('stereotype')!='characterization':continue
  if len(e['properties'])!=2:raise ValueError('Expected binary characterization')
  a,b=[es[es[p]['propertyType']] for p in e['properties']]
  an=set(a.get('restrictedTo',[]));bn=set(b.get('restrictedTo',[]))
  if an and an<=MOMENT and bn and bn<=MOMENT:
   raise ValueError('Both endpoints are moments; orientation needs an explicit owner contract')
  if an and an<=ENDURANT|{'type'} and bn and bn<=MOMENT:
   old=e['properties'][:];e['properties'].reverse();mapping.append({'relation':e['id'],'native_properties':old,'graph_profile_properties':e['properties'][:],
    'policy':'Invert orientation in validation view only; end IDs, adjacent multiplicities, readonly flags, labels and canonical model remain unchanged.'})
  elif an and an<=MOMENT and bn and bn<=ENDURANT|{'type'}:pass
  else:raise ValueError('Unresolved characterization endpoint natures; adapter refuses to guess')
 return out,mapping

def main():
 model=read(W/'inputs/Native_Model_v0_41_0.json');previous=read(W/'inputs/Rule_Coverage_71_v0_31_0.json')
 pending=[r for r in previous if r['official_implementation']!='EXECUTED' and not r['project_supplementary_implementation']]
 assert len(pending)==40
 applicability=[{'rule':r['rule'],'definition':r['definition'],'focus_ids':[e['id'] for e in select(r['rule'],model['elements'])],
  'status':'APPLICABLE' if select(r['rule'],model['elements']) else 'NO_DECLARED_NATIVE_FOCUS',
  'implementation':'PROJECT_IMPLEMENTED_THIS_RELEASE' if r['rule'] in ACTIVE else 'NOT_IMPLEMENTED_NO_NATIVE_FOCUS',
  'scope':'Declared native profile; external untyped handles do not acquire inferred stereotypes.'} for r in pending]
 assert {r['rule'] for r in applicability if r['focus_ids']}==ACTIVE
 write('Remaining_40_Applicability_v0_32_0.json',applicability)
 raw=[evaluate(c,model['elements']) for c in sorted(ACTIVE)]
 adapted,mapping=adapt_characterization(model);fixed=[evaluate(c,adapted['elements']) for c in sorted(ACTIVE)]
 assert [x['rule'] for x in raw if x['status']=='FAIL']==['R_RE_ECP']
 assert all(x['status']=='PASS' for x in fixed)
 write('Graph_Profile_Validation_View_v0_32_0.json',adapted)
 write('Characterization_Orientation_Map_v0_32_0.json',mapping)
 write('Applicable_Rule_Results_v0_32_0.json',{'rules':9,'raw_native_results':raw,'validation_view_results':fixed,
  'interpretation':'One cross-profile orientation mismatch, not a confirmed domain defect. Eight rules pass on raw native model; all nine pass on explicitly adapted validation view.',
  'canonical_model_changed':False,'upstream_validator_modified':False,'official_rule_execution_claimed':False,
  'grouping_source':'Pinned validator/vocab_lib/variables.py; its rigidity/ultimate-sortals grouping differs from newer SDK groups. No type classes are present; do not generalize the result to other profiles.',
  'independent_semantic_acceptance':False})
 # Exactly one relation-end ordering change; every other serialized element field equal.
 orig={e['id']:e for e in model['elements']};dest={e['id']:e for e in adapted['elements']}
 diff=[{'id':i,'field':k,'before':orig[i].get(k),'after':dest[i].get(k)} for i in orig for k in set(orig[i])|set(dest[i]) if orig[i].get(k)!=dest[i].get(k)]
 assert len(diff)==1 and diff[0]['field']=='properties' and diff[0]['id']=='ICREL:CP:bearsCapability'
 write('Validation_View_Fidelity_v0_32_0.json',{'elements':len(orig),'changes':diff,'all_other_fields_equal':True,
  'canonical_native_sha256':hashlib.sha256((W/'inputs/Native_Model_v0_41_0.json').read_bytes()).hexdigest(),
  'not_a_native_model_release':True,'not_a_universal_orientation_adapter':True})
 print(json.dumps({'remaining_rules':40,'applicable':len(ACTIVE),'no_declared_focus':40-len(ACTIVE),'native_pass':8,'profile_orientation_mismatch':1,'adapted_pass':9}))
if __name__=='__main__':main()
