"""Generate an exhaustive structural reference and explicit projection inventories."""
from pathlib import Path
import collections,csv,hashlib,html,json,sqlite3,sys
from urllib.parse import quote
from rdflib import Graph,RDF,RDFS,OWL,URIRef

ROOT=Path(__file__).resolve().parents[2];V=ROOT/'semantic/product/v2';S=V/'source';OUT=V/'reference';OUT.mkdir(parents=True,exist_ok=True)
model=json.loads((S/'formalization/Native_Model_v0_41_0.json').read_text());es={e['id']:e for e in model['elements']}
classes=[e for e in es.values() if e['type']=='Class'];rels=[e for e in es.values() if e['type']=='BinaryRelation'];gens=[e for e in es.values() if e['type']=='Generalization']
axioms=json.loads((S/'formalization/Structural_Axioms_892.json').read_text())['axioms']
byaxiom=collections.defaultdict(list)
for a in axioms:byaxiom[a['native_id']].append(a['formula'])
ground={x['id']:x for x in json.loads((S/'formalization/Class_Grounding_Register_128.json').read_text())}
matrix=json.loads((S/'t52_formalization_v043/Commitment_Matrix_22_v0_43_0.json').read_text())['rows']
def name(e):return (e.get('name') or {}).get('en',e['id'])
def desc(e):return (e.get('description') or {}).get('en','')
def write(n,t):(OUT/n).write_text(t,encoding='utf-8')
def field(v):return str(v or '').replace('|','\\|').replace('\n',' ')
def formulas(i):return '\n'.join('```text\n'+a+'\n```\n' for a in byaxiom[i])
rows=['# Class catalogue\n','All 128 native classes are listed: 101 local classes and 27 externally governed handles. External handle names do not assert imported-class equivalence. Independent acceptance remains open.\n','Read the [external-reference register](../../../../docs/guide/External-References.md) before interpreting preserved owner locators or declaration-verification fields. They do not establish public resolvability or accepted semantic equivalence.\n']
for e in classes:
    g=ground.get(e['id'],{});cp=e.get('customProperties') or {}
    rows += [f"## {name(e)}\n",f"- Native identifier: `{e['id']}`\n- Scope: {'external handle' if e['id'].startswith('EXT:') else 'local'}\n- Domain: {g.get('domain','not locally assigned')}\n- Declared stereotype: {e.get('stereotype') or 'uncommitted'}\n- Nature: {', '.join(e.get('restrictedTo') or []) or 'uncommitted'}\n",desc(e)+'\n',f"Identity commitment: {g.get('identity_commitment') or 'See the native contract; no independent identity acceptance asserted.'}\n",'Native contract fields:\n```json\n'+json.dumps(cp,ensure_ascii=False,indent=2)+'\n```\n']
write('classes.md','\n'.join(rows))
rows=['# Association catalogue\n','The 286 associations follow `properties[0]` to `properties[1]`. An end cardinality constrains the instances at that end for each opposite-end instance. The static formulas are not modal or causal proofs.\n']
for e in rels:
    a,b=[es[i] for i in e['properties']]
    rows += [f"## {name(e)} — `{e['id']}`\n",f"| End | Class | Multiplicity | Read-only |\n| --- | --- | --- | --- |\n| Source | `{a['propertyType']}` | `{a['cardinality']}` | `{a.get('isReadOnly')}` |\n| Target | `{b['propertyType']}` | `{b['cardinality']}` | `{b.get('isReadOnly')}` |\n",f"Stereotype: {e.get('stereotype') or 'plain association'}. {desc(e)}\n",formulas(e['id']), 'Native contract fields:\n```json\n'+json.dumps(e.get('customProperties'),ensure_ascii=False,indent=2)+'\n```\n']
write('associations.md','\n'.join(rows))
rows=['# Generalizations and sets\n']
for e in gens:rows.extend([f"## `{e['id']}`\n",f"`{e['specific']}` specializes `{e['general']}`.\n",formulas(e['id'])])
for e in es.values():
    if e['type']=='GeneralizationSet':rows.append('```json\n'+json.dumps(e,indent=2)+'\n```\n')
write('generalizations.md','\n'.join(rows))
rows=['# Bounded commitments\n','OWL uses open-world semantics with no unique-name assumption. SHACL, SQL and admission policies assess supplied finite records. Operational policies are identified separately from logical axioms.\n']
for c in matrix:
    rows += [f"## {c['id']} — {c['commitment']}\n"]
    for k in ['formulas','static_native_formulas']:
        for f in c.get(k,[]):rows.append('```text\n'+f+'\n```\n')
    rows += ['| Mechanism | Scope |\n| --- | --- |\n'+'\n'.join(f"| {label} | {field(c[k])} |" for label,k in [('OWL','owl'),('SHACL','shacl'),('SQL','sql'),('History/policy','history')])+'\n',f"Example: {c['positive']}\n\nCounterexample: {c['negative']}\n\nLimit: {c['limit']}\n"]
write('commitments.md','\n'.join(rows))
g=Graph().parse(S/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl')
owlclasses={str(x) for x in g.subjects(RDF.type,OWL.Class) if isinstance(x,URIRef)}
with (S/'validation_v041/inputs/Class_Table_Mapping_v0_16_0.csv').open(encoding='utf-8-sig') as f:mapping={r['native_id']:r for r in csv.DictReader(f)}
with (OUT/'native-class-projection.csv').open('w',newline='',encoding='utf-8') as f:
    w=csv.writer(f);w.writerow(['native_id','label','scope','mapped_iri','declared_owl_class','mapping_basis'])
    for e in classes:
        iri=mapping.get(e['id'],{}).get('iri','')
        w.writerow([e['id'],name(e),'external' if e['id'].startswith('EXT:') else 'local',iri,str(iri in owlclasses) if iri else '', 'class-table map' if iri else 'no mapping asserted by this register'])
with (OUT/'owl-class-inventory.csv').open('w',newline='',encoding='utf-8') as f:
    w=csv.writer(f);w.writerow(['owl_class_iri','mapped_native_id'])
    rev={r['iri']:i for i,r in mapping.items()}
    for iri in sorted(owlclasses):w.writerow([iri,rev.get(iri,'bounded-profile proxy; no exact native-handle mapping asserted here')])
inventory={'native_elements':len(es),'native_class_count':len(classes),'local_class_count':sum(not e['id'].startswith('EXT:') for e in classes),'external_handles':sum(e['id'].startswith('EXT:') for e in classes),'associations':len(rels),'association_ends':sum(e['type']=='Property' for e in es.values()),'generalizations':len(gens),'structural_expressions':len(axioms),'commitments':len(matrix),'owl_named_classes':len(owlclasses),'owl_anonymous_classes':sum(not isinstance(x,URIRef) for x in g.subjects(RDF.type,OWL.Class)),'owl_triples':len(g),'mapped_local_classes_declared_in_owl':sum(r['iri'] in owlclasses for r in mapping.values())}
assert (inventory['local_class_count'],len(rels),len(axioms),len(matrix))==(101,286,892,22)
write('inventory.json',json.dumps(inventory,indent=2)+'\n')
write('README.md','''# OntoSPK conceptual and formal reference

This reference covers every native class, association, end and generalization, the complete 892-expression structural register and the 22 scoped commitments. It distinguishes authored conceptual commitments, OWL restrictions, finite-data checks and operational history policies.

- [Class definitions, identities, domains and native contract fields](classes.md)
- [Associations, both ends, multiplicities and all static formulas](associations.md)
- [Generalizations and generalization sets](generalizations.md)
- [Commitments, enforcing mechanisms, examples and limits](commitments.md)
- [Native-class projection coverage](native-class-projection.csv)
- [OWL class inventory](owl-class-inventory.csv)
- [Machine-readable inventory](inventory.json)
- [Distribution scope and evaluation](../../../../docs/releases/v2.0.0/README.md)
- [Complete source model](../source/formalization/Native_Model_v0_41_0.json)

Native classes (128 including 27 external handles), named OWL classes (121) and physical SQL predicate tables are different inventories. Counts must not be substituted for one another. Fifty-eight upstream rules are unimplemented in the pinned validator; the independent acceptance and scientific-follow-up register remains open. The formal specification does not claim complete UFO modal, counterfactual or causal semantics.
''')
sections=[]
for n in ['classes.md','associations.md','generalizations.md','commitments.md']:
    sections.append('<section><h2>'+html.escape(n)+'</h2><pre>'+html.escape((OUT/n).read_text())+'</pre></section>')
write('complete-reference.html','<!doctype html><html lang="en"><meta charset="utf-8"><title>OntoSPK complete structural and formal reference</title><style>body{font-family:serif;max-width:1100px;margin:2rem auto;padding:1rem}pre{white-space:pre-wrap;overflow-wrap:anywhere;font-family:monospace;font-size:.85rem}section{margin-top:3rem}</style><h1>OntoSPK complete structural and formal reference</h1><p>Public distribution 2.0.0 in preparation. Native 0.41.0; logical profile 0.43.0. All formulas and native contract fields are displayed; operational policies retain their stated limits.</p>'+''.join(sections)+'</html>')
print(json.dumps(inventory,indent=2))
