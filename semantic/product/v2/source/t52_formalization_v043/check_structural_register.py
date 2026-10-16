from pathlib import Path
import hashlib,json
W=Path(__file__).resolve().parent;R=W.parent
path=R/'formalization/Native_Model_v0_41_0.json'
native=json.loads(path.read_text());by={e['id']:e for e in native['elements']}
register=json.loads((R/'formalization/Structural_Axioms_892.json').read_text())
def bounds(s):
 if s=='*':return 0,None
 if '..' in s:
  lo,hi=s.split('..');return int(lo),None if hi=='*' else int(hi)
 return int(s),int(s)
expected={}
for e in native['elements']:
 if e['type']=='BinaryRelation':
  a,b=[by[p] for p in e['properties']];id=e['id'];rel='R['+json.dumps(id)+']';ca='C['+json.dumps(a['propertyType'])+']';cb='C['+json.dumps(b['propertyType'])+']'
  expected[id+':TYPING']=f'forall x,y: {rel}(x,y) => ({ca}(x) and {cb}(y))'
  for suffix,end,var,owner,term in [('RIGHT_END',b,'x',ca,f'card{{y | {rel}(x,y)}}'),('LEFT_END',a,'y',cb,f'card{{x | {rel}(x,y)}}')]:
   lo,hi=bounds(end['cardinality']);expected[id+':'+suffix]=f'forall {var}: {owner}({var}) => {lo} <= {term}'+('' if hi is None else f' <= {hi}')
 elif e['type']=='Generalization':expected[e['id']]=f'forall x: C[{json.dumps(e["specific"])}](x) => C[{json.dumps(e["general"])}](x)'
actual={x['id']:x['formula'] for x in register['axioms']}
assert expected==actual and len(expected)==892
assert register['source_sha256']==hashlib.sha256(path.read_bytes()).hexdigest()
out=dict(version='0.43.0',native_sha256=register['source_sha256'],freshly_compared=892,matched=892,typing_rules=286,cardinality_rules=572,generalization_rules=34,scope='Static native signatures only. These are not 892 independent OWL axioms or proofs of modal meaning.')
(W/'results/Structural_Reconciliation_v0_43_0.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out))
