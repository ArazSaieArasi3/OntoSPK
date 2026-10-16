// Upstream source is unmodified. This process-local environment fallback supplies
// no network-interface data to uniqid; parsed IDs are restored from native input.
const os = require('os'); const networkInterfaces = os.networkInterfaces;
let fallbackUsed=false;
os.networkInterfaces=()=>{try{return networkInterfaces();}catch{fallbackUsed=true;return {};}};
const fs=require('fs'),path=require('path'),crypto=require('crypto'),assert=require('assert');
const W=__dirname, repo=path.resolve(process.argv[2]);
const sdk=require(path.join(repo,'dist/index.js'));
const inputPath=path.join(W,'inputs/Native_Model_v0_41_0.json');
const raw=JSON.parse(fs.readFileSync(inputPath));
const outdir=path.join(W,'results');fs.mkdirSync(outdir,{recursive:true});
const save=(n,x)=>fs.writeFileSync(path.join(W,n),JSON.stringify(x,null,2)+'\n');
const hash=x=>crypto.createHash('sha256').update(x).digest('hex');
const first=sdk.serializationUtils.parse(JSON.stringify(raw));
const one=sdk.serializationUtils.serialize(first);
fs.writeFileSync(path.join(outdir,'SDK_saved.json'),one);
const second=sdk.serializationUtils.parse(fs.readFileSync(path.join(outdir,'SDK_saved.json'),'utf8'));
const two=sdk.serializationUtils.serialize(second);
fs.writeFileSync(path.join(outdir,'SDK_reloaded.json'),two);
assert.strictEqual(one,two);
const after=JSON.parse(two), beforeMap=new Map(raw.elements.map(e=>[e.id,e])),afterMap=new Map(after.elements.map(e=>[e.id,e]));
assert.deepStrictEqual([...beforeMap.keys()].sort(),[...afterMap.keys()].sort());
const differences=[], failures=[];
for(const old of [raw,...raw.elements]){
 const next=old===raw?after:afterMap.get(old.id);
 for(const key of new Set([...Object.keys(old),...Object.keys(next)])){
  if(key==='elements')continue;
  try{assert.deepStrictEqual(old[key],next[key]);continue;}catch{}
  const a=old[key],b=next[key];
  const safe=(['created','modified'].includes(key)&&a&&b&&new Date(a).toISOString()===b)
    ||(a===null&&['isDerived','isAbstract','isPowertype','isOrdered','isReadOnly'].includes(key)&&b===false)
    ||(a===null&&key==='aggregationKind'&&b==='NONE');
  differences.push({id:old.id,field:key,before:a,after:b,allowed_documented_normalization:safe});
  if(!safe)failures.push(differences.at(-1));
 }
}
save('SDK_Normalization_Audit_v0_41_0.json',differences);
if(failures.length){console.log(JSON.stringify(failures.slice(0,15)));throw Error('Unexpected normalization');}
const target=JSON.parse(fs.readFileSync(path.join(W,'inputs/Event_Validation_Input_v0_29_0.json')));
const protectedFields=['name','isReadOnly','type','stereotype','restrictedTo','propertyType','cardinality','properties','description','customProperties','general','specific','generalizations','isDisjoint','isComplete'];
function fidelity(candidate){
 const m=new Map(candidate.elements.map(e=>[e.id,e])); const errors=[];
 if(m.size!==beforeMap.size)errors.push('element_inventory');
 for(const [id,a] of beforeMap){const b=m.get(id);if(!b){errors.push(id+':missing');continue;}
  for(const k of protectedFields){try{assert.deepStrictEqual(k==='isReadOnly'?!!a[k]:a[k],k==='isReadOnly'?!!b[k]:b[k]);}catch{errors.push(id+':'+k);}}
 } return errors;
}
assert.deepStrictEqual(fidelity(after),[]);
const mutations=[
 ['readonly_loss',m=>m.get('END:W2:090:B').isReadOnly=false],
 ['event_stereotype',m=>m.get('IC:TestExecution').stereotype='kind'],
 ['event_nature',m=>m.get('IC:TestExecution').restrictedTo=['functional-complex']],
 ['relation_loss',m=>m.delete('REL:W2:090')],
 ['end_loss',m=>m.delete('END:W2:090:B')],
 ['end_target',m=>m.get('END:W2:090:B').propertyType='IC:TestResult'],
 ['multiplicity',m=>m.get('END:ORSD05:executionCriterion:B').cardinality='0..*'],
 ['occurrence_contract',m=>m.get('IC:TestExecution').customProperties.core_profile_decision.identity='Same ID only'],
 ['end_reversal',m=>m.get('REL:W2:090').properties.reverse()]
];
const controls=mutations.map(([id,mutate])=>{const copy=structuredClone(after),m=new Map(copy.elements.map(e=>[e.id,e]));mutate(m);copy.elements=[...m.values()];const errors=fidelity(copy);assert(errors.length);return {id,passed:true,detected_by:'project fidelity guard, not SDK semantic validator',errors};});
const schemaControls=[];
for(const [id,mutation] of [['invalid_stereotype_datatype',m=>m.find(e=>e.id==='IC:TestExecution').stereotype=42],['dangling_endpoint',m=>m.find(e=>e.id==='END:W2:090:B').propertyType='MISSING:Class']]){
 const x=structuredClone(raw);mutation(x.elements);let message;try{sdk.serializationUtils.parse(JSON.stringify(x));}catch(e){message=e.message;}
 assert(message);schemaControls.push({id,passed:true,actual_sdk_rejection:message});
}
save('SDK_Fidelity_v0_41_0.json',{sdk_version:require(path.join(repo,'package.json')).version,
 input_sha256:hash(fs.readFileSync(inputPath)),
 serialized_sha256:hash(one),elements:after.elements.length,event_ids:second.getEvents().map(e=>e.id),
 full_inventory_and_protected_fields_preserved:true,save_reload_byte_identical_after_normalization:true,
 original_bytes_identical:false,source_element_order_preserved:false,normalization_count:differences.length,
 incident_relations:target.incident_relation_ids.length,incident_ends:14,
 environment_fallback_used:fallbackUsed,upstream_source_modified:false,
 fidelity_controls:controls,schema_controls:schemaControls,
 scope:'Official SDK parse/schema/serialization and local fidelity guards; no official anti-pattern or Event identity reasoning is supplied by the SDK.'});
console.log(JSON.stringify({elements:after.elements.length,event_ids:second.getEvents().map(e=>e.id),normalizations:differences.length,controls:controls.length,schema_controls:schemaControls.length}));
