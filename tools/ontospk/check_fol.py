"""Check FOL transcription, not ontology consistency or domain validity.

An independent parser evaluates the emitted FOF formulas against native
endpoint constraints on all two-object interpretations for each relation.
"""
from pathlib import Path
import hashlib
import itertools
import json
import re
from collections import Counter
from rdflib import Graph, RDF, RDFS, OWL
from rdflib.collection import Collection

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'semantic/product/v2/formal-specification'
SRC=ROOT/'semantic/product/v2/source'


class Parser:
    def __init__(self,text):
        self.tokens=re.findall(r'<=>|=>|\$true|[A-Za-z][A-Za-z0-9_]*|[()\[\],:!?~&|=.]',text)
        assert ''.join(self.tokens)==re.sub(r'\s+','',text),'Unrecognized syntax'
        self.i=0

    def pop(self,expected=None):
        t=self.tokens[self.i];self.i+=1
        assert expected is None or t==expected,(t,expected)
        return t

    def formula(self):
        t=self.pop()
        if t=='$true':return ('true',)
        if t=='~':
            self.pop('(');child=self.formula();self.pop(')');return ('not',child)
        if t=='(':
            if self.tokens[self.i] in ['!','?']:
                op=self.pop();self.pop('[');variables=[self.pop()]
                while self.tokens[self.i]==',':self.pop(',');variables.append(self.pop())
                self.pop(']');self.pop(':');child=self.formula();self.pop(')')
                return ('forall' if op=='!' else 'exists',variables,child)
            if self.tokens[self.i][0].isupper():
                x=self.pop();self.pop('=');y=self.pop();self.pop(')');return ('eq',x,y)
            left=self.formula();op=self.pop();right=self.formula();self.pop(')')
            return ({'&':'and','|':'or','=>':'implies','<=>':'iff'}[op],left,right)
        assert t[0].islower(),t
        self.pop('(');args=[self.pop()]
        while self.tokens[self.i]==',':self.pop(',');args.append(self.pop())
        self.pop(')');return ('atom',t,*args)

    def statement(self):
        self.pop('fof');self.pop('(');name=self.pop();self.pop(',');self.pop('axiom');self.pop(',')
        result=self.formula();self.pop(')');self.pop('.')
        assert self.i==len(self.tokens)
        return name,result


def evaluate(a,env,interpretation):
    op=a[0]
    if op=='true':return True
    if op=='atom':return tuple(env[v] for v in a[2:]) in interpretation.get(a[1],set())
    if op=='eq':return env[a[1]]==env[a[2]]
    if op=='not':return not evaluate(a[1],env,interpretation)
    if op in ['forall','exists']:
        values=(evaluate(a[2],dict(env,**dict(zip(a[1],vs))),interpretation) for vs in itertools.product([0,1],repeat=len(a[1])))
        return all(values) if op=='forall' else any(values)
    left=evaluate(a[1],env,interpretation)
    right=evaluate(a[2],env,interpretation)
    return {'and':left and right,'or':left or right,'implies':not left or right,'iff':left==right}[op]


def well_formed(a,arities,bound=frozenset()):
    if a[0]=='atom':
        assert arities[a[1]]==len(a)-2
        assert set(a[2:])<=bound,('Free variables',a)
    elif a[0]=='eq':assert set(a[1:])<=bound
    elif a[0] in ['forall','exists']:
        assert len(a[1])==len(set(a[1])) and all(re.fullmatch('[A-Z][A-Za-z0-9_]*',v) for v in a[1])
        well_formed(a[2],arities,bound|set(a[1]))
    elif a[0]=='not':well_formed(a[1],arities,bound)
    elif a[0]!='true':
        well_formed(a[1],arities,bound);well_formed(a[2],arities,bound)


def subsets(items):
    items=list(items)
    return [{v for i,v in enumerate(items) if mask>>i&1} for mask in range(1<<len(items))]


def permitted(size,card):
    lo,hi=(card.split('..') if '..' in card else (card,card))
    return size>=int(lo) and (hi=='*' or size<=int(hi))


def main():
    symbols=json.loads((OUT/'symbols.json').read_text())
    arities={r['symbol']:r['arity'] for r in symbols}
    by_id={(r['source_identifier'],r['arity']):r['symbol'] for r in symbols}
    parsed={}
    for filename in ['native-structure.p','profile-projection.p']:
        statements=[]
        for line in (OUT/filename).read_text().splitlines():
            if not line or line.startswith('%'):continue
            name,a=Parser(line).statement();well_formed(a,arities);statements.append((name,a))
        assert len({n for n,a in statements})==len(statements)
        parsed[filename]=statements

    # Independently retained relation contracts provide the expected endpoints.
    contracts=sorted(json.loads((SRC/'formalization/Relation_Contracts_286.json').read_text()),key=lambda r:r['id'])
    signatures=json.loads((OUT/'relation-signatures.json').read_text())
    assert len(contracts)==len(signatures)==286
    native=[a for n,a in parsed['native-structure.p']]
    cases=0;valid=0;invalid=0
    for i,(r,sig) in enumerate(zip(contracts,signatures)):
        assert (r['id'],r['left_class'],r['right_class'],r['right_end_cardinality'],r['left_end_cardinality'])==(sig['id'],sig['source'],sig['target'],sig['targets_per_source'],sig['sources_per_target'])
        a=by_id[(r['left_class'],1)];b=by_id[(r['right_class'],1)];p=by_id[(r['id'],2)]
        for aset in subsets([0,1]):
            for bset in ([aset] if a==b else subsets([0,1])):
                for pairs in subsets(itertools.product([0,1],repeat=2)):
                    expected=all(x in aset and y in bset for x,y in pairs)
                    expected=expected and all(permitted(sum(xx==x for xx,yy in pairs),r['right_end_cardinality']) for x in aset)
                    expected=expected and all(permitted(sum(yy==y for xx,yy in pairs),r['left_end_cardinality']) for y in bset)
                    interp={a:{(x,) for x in aset},b:{(y,) for y in bset},p:pairs}
                    actual=all(evaluate(f,{},interp) for f in native[i*3:i*3+3])
                    assert actual==expected,('Multiplicity translation mismatch',r['id'],aset,bset,pairs)
                    cases+=1;valid+=expected;invalid+=not expected
    # All generalization formulas are checked against independent source records.
    register=json.loads((SRC/'formalization/Structural_Axioms_892.json').read_text())
    old_general=[a for a in register['axioms'] if a['kind'] not in ['TYPING','RIGHT_END','LEFT_END']]
    assert len(old_general)==34
    general_cases=0
    old_general=sorted(old_general,key=lambda row:row['native_id'])
    for (name,a),source in zip(parsed['native-structure.p'][858:],old_general):
        assert a[0]=='forall' and a[2][0]=='implies'
        c,d=a[2][1][1],a[2][2][1]
        ids=re.findall(r'C\["([^"]+)"\]',source['formula'])
        assert [c,d]==[by_id[(identifier,1)] for identifier in ids]
        for cset in subsets([0,1]):
            for dset in subsets([0,1]):
                assert evaluate(a,{}, {c:{(x,) for x in cset},d:{(x,) for x in dset}})==cset.issubset(dset)
                general_cases+=1
    graph=Graph().parse(SRC/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl')
    # Reconcile emitted family counts independently with the RDF source.
    expected_profile=Counter()
    for key,label in [(RDFS.subClassOf,'subclass'),(OWL.disjointWith,'disjoint'),(RDFS.domain,'domain'),(RDFS.range,'range'),(RDFS.subPropertyOf,'subproperty'),(OWL.propertyChainAxiom,'chain')]:expected_profile[label]=len(list(graph.subject_objects(key)))
    for d in graph.subjects(RDF.type,OWL.AllDisjointClasses):
        n=len(list(Collection(graph,graph.value(d,OWL.members))));expected_profile['disjoint']+=n*(n-1)//2
    for typ,label in [(OWL.FunctionalProperty,'functional'),(OWL.InverseFunctionalProperty,'inverse_functional'),(OWL.IrreflexiveProperty,'irreflexive'),(OWL.AsymmetricProperty,'asymmetric')]:expected_profile[label]=len(list(graph.subjects(RDF.type,typ)))
    from rdflib import URIRef
    expected_profile['inverse']=sum(isinstance(a,URIRef) for a,b in graph.subject_objects(OWL.inverseOf))
    assert sum(expected_profile.values())==len(parsed['profile-projection.p'])
    bindings=json.loads((OUT/'source-bindings.json').read_text())
    assert dict(expected_profile)==bindings['profile_expression_families']
    for label in ['native','profile']:assert hashlib.sha256((ROOT/bindings[label+'_source']).read_bytes()).hexdigest()==bindings[label+'_sha256']
    report={'status':'PASS','scope':'FOL transcription and finite translation checks; not ontology-wide satisfiability, full OWL equivalence or independent semantic validation.','native_sha256':bindings['native_sha256'],'profile_sha256':bindings['profile_sha256'],'parsed_native_formulas':len(parsed['native-structure.p']),'parsed_profile_formulas':len(parsed['profile-projection.p']),'all_formulas_closed_and_arity_correct':True,'relation_signatures_compared':len(contracts),'two_object_relation_interpretations':cases,'valid_interpretations':valid,'invalid_interpretations':invalid,'generalization_interpretations':general_cases,'profile_source_family_counts':dict(sorted(expected_profile.items())),'ontology_consistency_proved':False,'datatype_value_semantics_verified':False,'manuscript_changed':False,'formal_source_models_changed':False}
    report['checked_output_sha256']={n:hashlib.sha256((OUT/n).read_bytes()).hexdigest() for n in ['native-structure.p','profile-projection.p','symbols.json','relation-signatures.json']}
    (OUT/'transcription-review.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))


if __name__=='__main__':main()
