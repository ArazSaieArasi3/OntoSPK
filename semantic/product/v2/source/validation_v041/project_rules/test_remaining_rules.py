"""Independent small witness graphs; expected outcomes taken from pinned rule prose."""
import copy,json
from remaining_rules import *
C=lambda i,s='kind',n=None,**kw:dict(id=i,type='Class',stereotype=s,order='1',restrictedTo=n if n is not None else ['functional-complex'],**kw)
G=lambda i,a,b:dict(id=i,type='Generalization',general=a,specific=b)
S=lambda gens:dict(id='set',type='GeneralizationSet',generalizations=gens,categorizer=None)
def R(source=['intrinsic-mode'],target=['functional-complex']):
 return [C('m','mode',source),C('b','kind',target),dict(id='e1',type='Property',propertyType='m',cardinality='1..*',isReadOnly=False),dict(id='e2',type='Property',propertyType='b',cardinality='1',isReadOnly=True),dict(id='r',type='BinaryRelation',stereotype='characterization',properties=['e1','e2'])]
fixtures=[]
def case(code,name,els,expected):
 actual=evaluate(code,els)['status'];fixtures.append(dict(rule=code,name=name,elements=els,expected=expected,actual=actual,passed=actual==expected));assert actual==expected,(code,name,actual,expected)
for code,st,good,bad in [('R_CL_ASZ','category',['quality','functional-complex'],['event']),('R_CL_LAX','subkind',['quality'],['quality','functional-complex']),('R_CL_ZEF','mode',['intrinsic-mode','extrinsic-mode'],['quality'])]:
 case(code,'allowed nature', [C('x',st,good)],'PASS');case(code,'forbidden nature/cardinality',[C('x',st,bad)],'FAIL');case(code,'empty nature',[C('x',st,[])],'FAIL')
case('R_CL_BLE','rigid ancestry',[C('a'),C('b','subkind'),G('g','a','b')],'PASS')
case('R_CL_BLE','deep anti-rigid ancestry',[C('a','role'),C('b','phase'),C('c'),G('g','a','b'),G('h','b','c')],'FAIL')
case('R_CL_BLE','unknown parent',[C('a',None),C('b'),G('g','a','b')],'UNDETERMINED')
case('R_CL_BLE','cycle',[C('a'),C('b'),G('g','a','b'),G('h','b','a')],'UNDETERMINED')
case('R_CL_PPZ','concrete descendant',[C('a',isAbstract=True),C('b',isAbstract=False),G('g','a','b')],'PASS')
case('R_CL_PPZ','abstract leaf',[C('a',isAbstract=True)],'FAIL')
case('R_CL_PPZ','concrete sibling',[C('p',isAbstract=False),C('a',isAbstract=True),C('b',isAbstract=False),G('g','p','a'),G('h','p','b')],'PASS')
case('R_CL_PPZ','unknown concreteness',[C('a',isAbstract=True),C('b',isAbstract=None),G('g','a','b')],'UNDETERMINED')
case('R_CL_PPZ','cycle despite witness',[C('a',isAbstract=True),C('b',isAbstract=False),G('g','a','b'),G('h','b','a')],'UNDETERMINED')
for code,good,bad in [('R_GE_EPG','subkind','kind'),('R_GE_HGQ','subkind','category')]:
 for s,result in [(good,'PASS'),(bad,'FAIL'),(None,'UNDETERMINED')]:case(code,str(s),[C('a'),C('b',s),G('g','a','b')],result)
case('R_GS_YKW','shared general',[C('a'),C('b'),C('c'),G('g','a','b'),G('h','a','c'),S(['g','h'])],'PASS')
case('R_GS_YKW','different general',[C('a'),C('b'),C('c'),G('g','a','b'),G('h','c','b'),S(['g','h'])],'FAIL')
case('R_GS_YKW','empty set',[S([])],'UNDETERMINED')
case('R_GS_YKW','missing generalization',[S(['missing'])],'UNDETERMINED')
case('R_RE_ECP','pinned orientation',R(),'PASS')
case('R_RE_ECP','catalogue orientation',R(['functional-complex'],['intrinsic-mode']),'FAIL')
case('R_RE_ECP','missing nature',R([],['functional-complex']),'UNDETERMINED')
case('R_RE_ECP','invalid event target',R(['quality'],['event']),'FAIL')
for code in sorted(ACTIVE):case(code,'no focus',[],'NOT_APPLICABLE')

# Guard tests prove each absent selector activates on a declared witness. They
# validate applicability selection only, NOT the 31 unimplemented rule bodies.
select_fixtures=[]
for r in read(W/'Remaining_40_Applicability_v0_32_0.json'):
 code=r['rule']
 if code in ACTIVE:continue
 if code in ['R_CL_ANY','R_CL_JFW','R_CL_QOV']:els=[C('x',isPowertype=True)]
 elif code=='R_CL_BFO':els=[C('x',n=['collective'])]
 elif code in ['R_CL_BQI','R_CL_UTL']:els=[C('x',n=['type'])]
 elif code=='R_CL_GAZ':els=[C('x',n=['type','quality'])]
 elif code.startswith('R_CL_'):els=[C('x',{'R_CL_CMS':'phase','R_CL_NBG':'phaseMixin','R_CL_OEV':'role','R_CL_PSQ':'type'}[code])]
 elif code.startswith('R_GE_'):
  opts={'R_GE_BAK':'abstract','R_GE_JLW':'datatype','R_GE_MXI':'role','R_GE_UXR':'situation','R_GE_VEZ':'enumeration','R_GE_XRS':'collective'}
  els=[C('a',opts[code],isExtensional=True),C('b'),G('g','a','b')]
 elif code.startswith('R_GS_'):els=[dict(S([]),categorizer='cat',isComplete=True,isDisjoint=False)]
 else:
  els=R();els[-1]['stereotype']=RELATIONS[code]
  if code=='R_RE_JND':els[0]['order']='*'
 actual=[e['id'] for e in select(code,els)];assert actual,(code,els)
 assert select(code,[])==[]
 select_fixtures.append(dict(rule=code,elements=els,activated_ids=actual,empty_input_focus=[],passed=True))
assert len(select_fixtures)==31
# Adapter is a bounded, lossless validation-view transform, not an axiom edit.
checks=[]
def check(name,ok):checks.append(dict(name=name,passed=bool(ok)));assert ok,name
raw={'elements':R(['functional-complex'],['intrinsic-mode'])};before=copy.deepcopy(raw)
adapted,mapping=adapt_characterization(raw)
check('source input unmodified',raw==before)
check('graph direction passes',evaluate('R_RE_ECP',adapted['elements'])['status']=='PASS')
check('exactly one explicit orientation map',len(mapping)==1)
again,m2=adapt_characterization(adapted);check('idempotent with no repeated map',again==adapted and m2==[])
restored=copy.deepcopy(adapted);restored['elements'][-1]['properties'].reverse();check('inverse restores every field',restored==raw)
for name,els in [('unknown endpoint',R([],['functional-complex'])),('ambiguous two moments',R(['quality'],['intrinsic-mode']))]:
 try:adapt_characterization({'elements':els});rejected=False
 except ValueError:rejected=True
 check('refuses '+name,rejected)
model=read(W/'inputs/Native_Model_v0_41_0.json');a,mp=adapt_characterization(model)
check('canonical adapter replay',a==read(W/'Graph_Profile_Validation_View_v0_32_0.json') and mp==read(W/'Characterization_Orientation_Map_v0_32_0.json'))
report={'semantic_controls':len(fixtures),'applicability_controls':len(select_fixtures),'adapter_controls':len(checks),'total':len(fixtures)+len(select_fixtures)+len(checks),'passed':len(fixtures)+len(select_fixtures)+len(checks),'scope':'Project-owned encodings and bounded orientation view. Selector activation is not semantic rule execution. No independent acceptance or browser execution.'}
write('Rule_Test_Fixtures_v0_32_0.json',fixtures);write('Applicability_Selector_Controls_v0_32_0.json',select_fixtures);write('Validation_View_Controls_v0_32_0.json',checks);write('Test_Results_v0_32_0.json',report)
print(json.dumps(report))
