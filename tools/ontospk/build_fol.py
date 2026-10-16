"""Generate a traceable FOL specification without changing its semantic sources.

Run from any directory with Python and the repository's rdflib dependency.
The two theories have separate signatures; their union is not asserted.
"""
from pathlib import Path
import hashlib
import itertools
import json
import re
from collections import Counter
from rdflib import Graph, RDF, RDFS, OWL, URIRef, BNode
from rdflib.collection import Collection

ROOT = Path(__file__).resolve().parents[2]
SRC = ROOT / 'semantic/product/v2/source'
OUT = ROOT / 'semantic/product/v2/formal-specification'
NATIVE = SRC / 'formalization/Native_Model_v0_41_0.json'
PROFILE = SRC / 't52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def walk(value):
    if isinstance(value, dict):
        if value.get('type') in {'Class', 'BinaryRelation', 'Generalization', 'GeneralizationSet', 'Property'}:
            yield value
        for child in value.values():
            yield from walk(child)
    elif isinstance(value, list):
        for child in value:
            yield from walk(child)


def atom(name, *args):
    return ('atom', name, *args)


def eq(x, y):
    return ('eq', x, y)


def both(a, b):
    return ('and', a, b)


def implies(a, b):
    return ('implies', a, b)


def all_(variables, body):
    return ('forall', tuple(variables), body)


def exists(variables, body):
    return ('exists', tuple(variables), body)


def exact_one(y_body, z_body):
    return exists(['Y'], both(y_body, all_(['Z'], implies(z_body, eq('Z', 'Y')))))


def bound(card, y_body, z_body):
    if card == '0..*':
        return ('true',)
    if card == '1..*':
        return exists(['Y'], y_body)
    if card == '0..1':
        return all_(['Y', 'Z'], implies(both(y_body, z_body), eq('Y', 'Z')))
    if card in {'1', '1..1'}:
        return exact_one(y_body, z_body)
    raise ValueError(f'Unsupported multiplicity: {card}')


def render(a):
    op = a[0]
    if op == 'atom':
        return a[1] + '(' + ','.join(a[2:]) + ')'
    if op == 'eq':
        return '(' + a[1] + ' = ' + a[2] + ')'
    if op == 'true':
        return '$true'
    if op == 'not':
        return '~(' + render(a[1]) + ')'
    if op in {'forall', 'exists'}:
        return '(' + ('!' if op == 'forall' else '?') + ' [' + ','.join(a[1]) + '] : ' + render(a[2]) + ')'
    symbols = {'and': '&', 'or': '|', 'implies': '=>', 'iff': '<=>'}
    return '(' + render(a[1]) + ' ' + symbols[op] + ' ' + render(a[2]) + ')'


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')


def generate():
    OUT.mkdir(parents=True, exist_ok=True)
    elements = list(walk(json.loads(NATIVE.read_text())))
    by_id = {e['id']: e for e in elements}
    classes = sorted((e for e in elements if e['type'] == 'Class'), key=lambda e: e['id'])
    relations = sorted((e for e in elements if e['type'] == 'BinaryRelation'), key=lambda e: e['id'])
    generalizations = sorted((e for e in elements if e['type'] == 'Generalization'), key=lambda e: e['id'])
    names = {e['id']: e['name']['en'] for e in classes}
    symbols = []

    def symbol(prefix, identifier, arity):
        # The full identifier is retained; the suffix prevents namespace collisions.
        stem = re.sub('[^a-z0-9_]', '_', re.split('[:/#]', identifier)[-1].lower()).strip('_')
        name = prefix + '_' + stem + '_' + hashlib.sha256(identifier.encode()).hexdigest()[:8]
        symbols.append({'symbol': name, 'source_identifier': identifier, 'arity': arity})
        return name

    cs = {e['id']: symbol('n', e['id'], 1) for e in classes}
    rs = {e['id']: symbol('n', e['id'], 2) for e in relations}
    native = []

    def add(target, source, kind, body):
        name = ('native' if target is native else 'profile') + '_' + str(len(target) + 1).zfill(4)
        target.append({'name': name, 'source': source, 'kind': kind, 'ast': body, 'formula': render(body)})

    rows = []
    for r in relations:
        left, right = (by_id[p] for p in r['properties'])
        # Native Property.propertyType identifies the class at that end.
        aid, bid = left['propertyType'], right['propertyType']
        lc, rc = str(left['cardinality']), str(right['cardinality'])
        pred = rs[r['id']]
        add(native, r['id'], 'typing', all_(['X','Y'], implies(atom(pred,'X','Y'), both(atom(cs[aid],'X'), atom(cs[bid],'Y')))))
        add(native, r['id'], 'right_end', all_(['X'], implies(atom(cs[aid],'X'), bound(rc, atom(pred,'X','Y'),atom(pred,'X','Z')))))
        add(native, r['id'], 'left_end', all_(['X'], implies(atom(cs[bid],'X'), bound(lc, atom(pred,'Y','X'),atom(pred,'Z','X')))))
        rows.append({'id':r['id'],'name':r['name']['en'],'source':aid,'target':bid,'targets_per_source':rc,'sources_per_target':lc,'predicate':pred})
    for ge in generalizations:
        add(native,ge['id'],'subclass',all_(['X'],implies(atom(cs[ge['specific']],'X'),atom(cs[ge['general']],'X'))))
    for gs in (e for e in elements if e['type']=='GeneralizationSet'):
        if gs['isDisjoint'] or gs['isComplete']:
            raise ValueError('New generalization-set commitments require an explicit translator extension')

    graph = Graph().parse(PROFILE)
    ps = {}

    def psym(iri, arity):
        key = (str(iri), arity)
        if key not in ps:
            ps[key] = symbol('o', str(iri), arity)
        return ps[key]

    def prop(p, x, y):
        if isinstance(p, URIRef):
            return atom(psym(p,2),x,y)
        inv = graph.value(p,OWL.inverseOf)
        if inv is not None:
            return prop(inv,y,x)
        raise ValueError(f'Unsupported property expression {p}')

    def expr(c, x):
        if c == OWL.Thing:
            return ('true',)
        if isinstance(c, URIRef):
            return atom(psym(c,1),x)
        union = graph.value(c,OWL.unionOf)
        if union is not None:
            members = [expr(q,x) for q in Collection(graph,union)]
            result = members[0]
            for member in members[1:]:
                result = ('or',result,member)
            return result
        if (c,RDF.type,OWL.Restriction) in graph:
            p = graph.value(c,OWL.onProperty)
            # Restrictions in this source are evaluated on X, without nesting.
            if x != 'X':
                raise ValueError('Nested class restriction requires variable renaming')
            py,pz = prop(p,x,'Y'),prop(p,x,'Z')
            qualifier = graph.value(c,OWL.onClass)
            if qualifier is not None:
                py,pz=both(py,expr(qualifier,'Y')),both(pz,expr(qualifier,'Z'))
            some = graph.value(c,OWL.someValuesFrom)
            if some is not None:
                return exists(['Y'],both(py,expr(some,'Y')))
            for key in [OWL.cardinality,OWL.qualifiedCardinality,OWL.minCardinality]:
                number = graph.value(c,key)
                if number is not None:
                    number=int(number)
                    if key==OWL.minCardinality and number==0:return ('true',)
                    if key==OWL.minCardinality and number==1:return exists(['Y'],py)
                    if key in {OWL.cardinality,OWL.qualifiedCardinality} and number==1:return exact_one(py,pz)
            raise ValueError('Unsupported restriction')
        raise ValueError(f'Unsupported class expression {c}')

    profile=[]
    # Sort by rendered formula, not RDF blank-node identifiers, for deterministic output.
    pending=[]
    def emit(source,kind,body):pending.append((source,kind,body))
    for a,b in graph.subject_objects(RDFS.subClassOf):emit(str(a),'subclass',all_(['X'],implies(expr(a,'X'),expr(b,'X'))))
    for a,b in graph.subject_objects(OWL.disjointWith):emit(str(a),'disjoint',all_(['X'],('not',both(expr(a,'X'),expr(b,'X')))))
    for node in graph.subjects(RDF.type,OWL.AllDisjointClasses):
        members=sorted(Collection(graph,graph.value(node,OWL.members)),key=str)
        for a,b in itertools.combinations(members,2):emit('owl:AllDisjointClasses','disjoint',all_(['X'],('not',both(expr(a,'X'),expr(b,'X')))))
    for p,c in graph.subject_objects(RDFS.domain):emit(str(p),'domain',all_(['X','Y'],implies(prop(p,'X','Y'),expr(c,'X'))))
    for p,c in graph.subject_objects(RDFS.range):emit(str(p),'range',all_(['X','Y'],implies(prop(p,'X','Y'),expr(c,'Y'))))
    for p,q in graph.subject_objects(RDFS.subPropertyOf):emit(str(p),'subproperty',all_(['X','Y'],implies(prop(p,'X','Y'),prop(q,'X','Y'))))
    for p,q in graph.subject_objects(OWL.inverseOf):
        if isinstance(p,URIRef):emit(str(p),'inverse',all_(['X','Y'],('iff',prop(p,'X','Y'),prop(q,'Y','X'))))
    for p,seq in graph.subject_objects(OWL.propertyChainAxiom):
        chain=list(Collection(graph,seq))
        if len(chain)!=2:raise ValueError('Unsupported chain length')
        emit(str(p),'chain',all_(['X','Y','Z'],implies(both(prop(chain[0],'X','Y'),prop(chain[1],'Y','Z')),prop(p,'X','Z'))))
    for p in graph.subjects(RDF.type,OWL.FunctionalProperty):emit(str(p),'functional',all_(['X','Y','Z'],implies(both(prop(p,'X','Y'),prop(p,'X','Z')),eq('Y','Z'))))
    for p in graph.subjects(RDF.type,OWL.InverseFunctionalProperty):emit(str(p),'inverse_functional',all_(['X','Y','Z'],implies(both(prop(p,'Y','X'),prop(p,'Z','X')),eq('Y','Z'))))
    for p in graph.subjects(RDF.type,OWL.IrreflexiveProperty):emit(str(p),'irreflexive',all_(['X'],('not',prop(p,'X','X'))))
    for p in graph.subjects(RDF.type,OWL.AsymmetricProperty):emit(str(p),'asymmetric',all_(['X','Y'],implies(prop(p,'X','Y'),('not',prop(p,'Y','X')))))
    known_predicates={RDF.type,RDF.first,RDF.rest,RDFS.label,RDFS.comment,RDFS.domain,RDFS.range,RDFS.subClassOf,RDFS.subPropertyOf,OWL.versionInfo,OWL.disjointWith,OWL.inverseOf,OWL.onProperty,OWL.minCardinality,OWL.cardinality,OWL.onClass,OWL.qualifiedCardinality,OWL.someValuesFrom,OWL.unionOf,OWL.members,OWL.propertyChainAxiom}
    unknown=set(graph.predicates())-known_predicates
    if unknown:raise ValueError(f'Unclassified RDF predicates: {unknown}')
    for source,kind,body in sorted(pending,key=lambda item:(item[1],render(item[2]),item[0])):add(profile,source,kind,body)
    symbols.sort(key=lambda v:v['symbol'])
    assert len({s['symbol'] for s in symbols})==len(symbols)
    for name,axioms in [('native-structure',native),('profile-projection',profile)]:
        header='% FOL projection; not a satisfiability result. See README.md for scope.\n'
        (OUT/(name+'.p')).write_text(header+'\n'.join('fof('+a['name']+',axiom,'+a['formula']+').' for a in axioms)+'\n')
    write_json(OUT/'symbols.json',symbols)
    write_json(OUT/'relation-signatures.json',rows)
    metadata={'native_source':NATIVE.relative_to(ROOT).as_posix(),'native_sha256':sha(NATIVE),'profile_source':PROFILE.relative_to(ROOT).as_posix(),'profile_sha256':sha(PROFILE),'classes':len(classes),'relations':len(relations),'generalizations':len(generalizations),'native_expressions':len(native),'profile_expressions':len(profile),'profile_scope':'Object-level FOL projection of explicit logical constructs; XSD datatype predicates are abstract, not a complete OWL 2 datatype or direct-semantics axiomatization.','theories_combined':False,'ontology_consistency_proved':False}
    metadata['profile_expression_families']=dict(sorted(Counter(a['kind'] for a in profile).items()))
    write_json(OUT/'source-bindings.json',metadata)

    lines=['# Native first-order specification','','This reference is generated directly from the pinned native model. Every row instantiates the formulas below. Full expansions are in [native-structure.p](native-structure.p); identifiers and arities are in [symbols.json](symbols.json).','','## Notation','','For each row `(A,R,B,m,n)`, assert:','','```text','forall X,Y: R(X,Y) -> (A(X) and B(Y))','forall X: A(X) -> bound(m, Y: R(X,Y))','forall X: B(X) -> bound(n, Y: R(Y,X))','```','','Here `m` counts targets per source and `n` counts sources per target. The bound macros expand to ordinary FOL with equality:','','```text','bound(0..*, Y: P(Y)) := true','bound(1..*, Y: P(Y)) := exists Y: P(Y)','bound(0..1, Y: P(Y)) := forall Y,Z: (P(Y) and P(Z)) -> Y=Z','bound(1, Y: P(Y)) := exists Y: P(Y) and forall Z: P(Z) -> Z=Y','```','','The JSON and TPTP expansions fix parentheses and scope explicitly. This is a finite axiom schema, not quantification over predicates. A class may be empty. The theory has no unique-name assumption and adds no global existence axiom. Unbounded multiplicities add no finite upper bound.','','## Class signature','','| Native identifier | Name | Domain | Stereotype | Predicate |','|---|---|---|---|---|']
    for c in classes:lines.append('| '+' | '.join([c['id'],names[c['id']],c.get('customProperties',{}).get('domain','External boundary'),str(c.get('stereotype') or 'not assigned'),cs[c['id']]])+' |')
    domains={c['id']:c.get('customProperties',{}).get('domain','External boundary') for c in classes}
    for domain in sorted(set(domains[r['source']] for r in rows)):
        lines+=['','## '+domain,'','| Native relation | Source A | Relation label | Target B | Targets per source m | Sources per target n |','|---|---|---|---|---|---|']
        for r in rows:
            if domains[r['source']]==domain:lines.append('| '+' | '.join([r['id'],r['source'],r['name'],r['target'],r['targets_per_source'],r['sources_per_target']])+' |')
    lines+=['','## Generalizations','','Each row asserts `forall X: specific(X) -> general(X)`.','','| Identifier | Specific | General |','|---|---|---|']
    for ge in generalizations:lines.append('| '+' | '.join([ge['id'],ge['specific'],ge['general']])+' |')
    lines+=['','The requirement content generalization set is neither disjoint nor complete. Neither condition is added. Stereotype labels remain annotations in this static theory; their full UFO modal semantics is not encoded.','']
    (OUT/'native-structure.md').write_text('\n'.join(lines))
    ptext=['# Explicit logical-profile projection','','This generated reference translates the logical constructs present in the pinned Turtle profile. It is separate from the native structural theory. It does not supply a complete OWL 2 datatype theory, a UFO modal theory, or operational history policies.','','The corresponding [TPTP file](profile-projection.p) contains expanded FOL. [Source bindings](source-bindings.json) identify the exact input; [symbols](symbols.json) map every predicate to its original IRI.','','RDF annotations and class/property declarations do not assert that instances exist. XSD range IRIs are represented as abstract unary datatype predicates. Their value spaces, lexical normalization and the OWL object/data-domain separation are not axiomatized here.','','## Expanded axioms','']
    ptext += ['The `owl:AllDisjointClasses` declaration expands pairwise in the TPTP file. Its class list is shown once here; it does not imply that all ontology classes are disjoint.','']
    for node in graph.subjects(RDF.type,OWL.AllDisjointClasses):
        ptext += ['```text']+[str(c) for c in sorted(Collection(graph,graph.value(node,OWL.members)),key=str)]+['```','']
    for a in profile:
        if a['source']!='owl:AllDisjointClasses':ptext+=['### '+a['name']+' — '+a['kind'],'','Source: `'+a['source']+'`','','```text',a['formula'],'```','']
    (OUT/'profile-projection.md').write_text('\n'.join(ptext))
    print(json.dumps(metadata))


if __name__=='__main__':
    generate()
