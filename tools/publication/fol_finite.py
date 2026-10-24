"""Finite FOF grounding and a separate source-side cardinality/RDF encoder.

No quantified SMT formula is used: all quantifiers range over an explicit,
nonempty finite object domain. Native and profile signatures stay separate.
"""
from functools import lru_cache
import itertools
import json
from pathlib import Path
import sys
import z3
from rdflib import Graph, URIRef, RDF, RDFS, OWL
from rdflib.collection import Collection

ROOT=Path(__file__).resolve().parents[2]
SPEC=ROOT/'semantic/product/v2/formal-specification'
SOURCE=ROOT/'semantic/product/v2/source'
sys.path.insert(0,str(ROOT/'tools/ontospk'))
from check_fol import Parser,well_formed

def frozen(value):return tuple(frozen(v) for v in value) if isinstance(value,(tuple,list)) else value

def load():
    rows=json.loads((SPEC/'symbols.json').read_text());arity={r['symbol']:r['arity'] for r in rows}
    symbols={(r['source_identifier'],r['arity']):r['symbol'] for r in rows}
    theories={}
    for theory,file in [('native','native-structure.p'),('profile','profile-projection.p')]:
        parsed=[]
        for line in (SPEC/file).read_text().splitlines():
            if not line or line.startswith('%'):continue
            name,ast=Parser(line).statement();well_formed(ast,arity);parsed.append((name,frozen(ast)))
        assert len({n for n,a in parsed})==len(parsed)
        theories[theory]=parsed
    assert len(theories['native'])==892 and len(theories['profile'])==3038
    return symbols,theories

class Finite:
    def __init__(self,size,symbols):
        assert isinstance(size,int) and size>=1
        self.size=size;self.objects=tuple(range(size));self.symbols=symbols;self.variables={}
    def atom(self,symbol,*values):
        assert all(isinstance(v,int) and 0<=v<self.size for v in values)
        key=(symbol,*values)
        if key not in self.variables:self.variables[key]=z3.Bool(symbol+'__'+'_'.join(map(str,values)))
        return self.variables[key]
    def source(self,identifier,*values):return self.atom(self.symbols[(str(identifier),len(values))],*values)
    @lru_cache(maxsize=None)
    def ground(self,ast,bindings=()):
        op=ast[0];env=dict(bindings)
        value=lambda v:v if isinstance(v,int) else env[v]
        if op=='true':return z3.BoolVal(True)
        if op=='atom':return self.atom(ast[1],*(value(v) for v in ast[2:]))
        if op=='eq':return z3.BoolVal(value(ast[1])==value(ast[2]))
        if op=='not':return z3.Not(self.ground(ast[1],bindings))
        if op in ('forall','exists'):
            children=[]
            for vals in itertools.product(self.objects,repeat=len(ast[1])):
                local=dict(env);local.update(zip(ast[1],vals))
                children.append(self.ground(ast[2],tuple(sorted(local.items()))))
            return z3.And(children) if op=='forall' else z3.Or(children)
        a=self.ground(ast[1],bindings);b=self.ground(ast[2],bindings)
        return {'and':lambda:z3.And(a,b),'or':lambda:z3.Or(a,b),'implies':lambda:z3.Implies(a,b),'iff':lambda:a==b}[op]()
    def count(self,terms,card):
        lo,hi=card.split('..') if '..' in card else (card,card)
        count=z3.Sum([z3.If(t,1,0) for t in terms])
        return z3.And(count>=int(lo),z3.BoolVal(True) if hi=='*' else count<=int(hi))
    def native_source(self):
        native=json.loads((SOURCE/'formalization/Native_Model_v0_41_0.json').read_text())
        by_id={e['id']:e for e in native['elements']};out=[]
        for r in sorted((e for e in native['elements'] if e['type']=='BinaryRelation'),key=lambda e:e['id']):
            left,right=[by_id[p] for p in r['properties']];a=left['propertyType'];b=right['propertyType']
            edge=lambda x,y:self.source(r['id'],x,y)
            out.append((r['id'],'typing',z3.And([z3.Implies(edge(x,y),z3.And(self.source(a,x),self.source(b,y))) for x in self.objects for y in self.objects])))
            out.append((r['id'],'right_end',z3.And([z3.Implies(self.source(a,x),self.count([edge(x,y) for y in self.objects],str(right['cardinality']))) for x in self.objects])))
            out.append((r['id'],'left_end',z3.And([z3.Implies(self.source(b,y),self.count([edge(x,y) for x in self.objects],str(left['cardinality']))) for y in self.objects])))
        for g in sorted((e for e in native['elements'] if e['type']=='Generalization'),key=lambda e:e['id']):
            out.append((g['id'],'subclass',z3.And([z3.Implies(self.source(g['specific'],x),self.source(g['general'],x)) for x in self.objects])))
        assert len(out)==892;return out
    def profile_source(self):
        g=Graph().parse(SOURCE/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl');out={};descriptions={}
        def prop(p,x,y):
            if isinstance(p,URIRef):return self.source(p,x,y)
            inv=g.value(p,OWL.inverseOf);assert isinstance(inv,URIRef)
            return self.source(inv,y,x)
        def cls(c,x):
            if c==OWL.Thing:return z3.BoolVal(True)
            if c==OWL.Nothing:return z3.BoolVal(False)
            if isinstance(c,URIRef):return self.source(c,x)
            union=g.value(c,OWL.unionOf)
            if union is not None:return z3.Or([cls(member,x) for member in Collection(g,union)])
            assert (c,RDF.type,OWL.Restriction) in g
            p=g.value(c,OWL.onProperty);qualifier=g.value(c,OWL.onClass)
            terms=[z3.And(prop(p,x,y),cls(qualifier,y)) if qualifier is not None else prop(p,x,y) for y in self.objects]
            some=g.value(c,OWL.someValuesFrom)
            if some is not None:return z3.Or([z3.And(prop(p,x,y),cls(some,y)) for y in self.objects])
            for pred,operator in [(OWL.cardinality,'='),(OWL.qualifiedCardinality,'='),(OWL.minCardinality,'>=')]:
                cardinality=g.value(c,pred)
                if cardinality is not None:
                    count=z3.Sum([z3.If(t,1,0) for t in terms]);number=int(cardinality)
                    return count==number if operator=='=' else count>=number
            raise ValueError('Unclassified source restriction')
        def add(kind,source,body):out.setdefault(kind,[]).append(body);descriptions.setdefault(kind,[]).append(source)
        for a,b in g.subject_objects(RDFS.subClassOf):add('subclass',str(a),z3.And([z3.Implies(cls(a,x),cls(b,x)) for x in self.objects]))
        for a,b in g.subject_objects(OWL.disjointWith):add('disjoint',[str(a),str(b)],z3.And([z3.Not(z3.And(cls(a,x),cls(b,x))) for x in self.objects]))
        for node in g.subjects(RDF.type,OWL.AllDisjointClasses):
            members=sorted(Collection(g,g.value(node,OWL.members)),key=str)
            for a,b in itertools.combinations(members,2):add('disjoint',[str(a),str(b)],z3.And([z3.Not(z3.And(cls(a,x),cls(b,x))) for x in self.objects]))
        for p,c in g.subject_objects(RDFS.domain):add('domain',[str(p),str(c)],z3.And([z3.Implies(prop(p,x,y),cls(c,x)) for x in self.objects for y in self.objects]))
        for p,c in g.subject_objects(RDFS.range):add('range',[str(p),str(c)],z3.And([z3.Implies(prop(p,x,y),cls(c,y)) for x in self.objects for y in self.objects]))
        for p,q in g.subject_objects(RDFS.subPropertyOf):add('subproperty',[str(p),str(q)],z3.And([z3.Implies(prop(p,x,y),prop(q,x,y)) for x in self.objects for y in self.objects]))
        for p,q in g.subject_objects(OWL.inverseOf):
            if isinstance(p,URIRef):add('inverse',[str(p),str(q)],z3.And([prop(p,x,y)==prop(q,y,x) for x in self.objects for y in self.objects]))
        for p,head in g.subject_objects(OWL.propertyChainAxiom):
            chain=list(Collection(g,head));assert len(chain)==2
            add('chain',[str(p),*map(str,chain)],z3.And([z3.Implies(z3.And(prop(chain[0],x,y),prop(chain[1],y,z)),prop(p,x,z)) for x in self.objects for y in self.objects for z in self.objects]))
        for p in g.subjects(RDF.type,OWL.FunctionalProperty):add('functional',str(p),z3.And([self.count([prop(p,x,y) for y in self.objects],'0..1') for x in self.objects]))
        for p in g.subjects(RDF.type,OWL.InverseFunctionalProperty):add('inverse_functional',str(p),z3.And([self.count([prop(p,y,x) for y in self.objects],'0..1') for x in self.objects]))
        for p in g.subjects(RDF.type,OWL.IrreflexiveProperty):add('irreflexive',str(p),z3.And([z3.Not(prop(p,x,x)) for x in self.objects]))
        for p in g.subjects(RDF.type,OWL.AsymmetricProperty):add('asymmetric',str(p),z3.And([z3.Not(z3.And(prop(p,x,y),prop(p,y,x))) for x in self.objects for y in self.objects]))
        return out,descriptions

def evaluate(ast,model,size,env=None):
    env={} if env is None else env;op=ast[0]
    value=lambda v:v if isinstance(v,int) else env[v]
    if op=='true':return True
    if op=='atom':return tuple(value(v) for v in ast[2:]) in model.get(ast[1],set())
    if op=='eq':return value(ast[1])==value(ast[2])
    if op=='not':return not evaluate(ast[1],model,size,env)
    if op in ('forall','exists'):
        def values():
            for vals in itertools.product(range(size),repeat=len(ast[1])):
                local=dict(env);local.update(zip(ast[1],vals));yield evaluate(ast[2],model,size,local)
        return all(values()) if op=='forall' else any(values())
    left=evaluate(ast[1],model,size,env)
    if op=='implies':return not left or evaluate(ast[2],model,size,env)
    if op=='and':return left and evaluate(ast[2],model,size,env)
    if op=='or':return left or evaluate(ast[2],model,size,env)
    if op=='iff':return left==evaluate(ast[2],model,size,env)
    raise ValueError(op)

def witness(finite,model):
    out={}
    for key,var in finite.variables.items():
        if z3.is_true(model.eval(var,model_completion=True)):out.setdefault(key[0],[]).append(list(key[1:]))
    return {name:sorted(rows) for name,rows in sorted(out.items())}

def restore(rows):return {name:{tuple(v) for v in values} for name,values in rows.items()}
