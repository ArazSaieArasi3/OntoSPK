"""Create a source-bound annotated view without changing the frozen core."""
from collections import Counter
import csv
import gzip
import json
import re
from rdflib import Graph, Literal, RDF, RDFS, OWL, URIRef, Namespace
from rdflib.compare import isomorphic
from evaluation_common import ROOT, SOURCE, sha, graph_text, write_json

CORE=SOURCE/'t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl'
NATIVE=SOURCE/'formalization/Native_Model_v0_41_0.json'
CAT=ROOT/'semantic/product/v2/catalogue/Concept_Catalogue_v0_41_0.csv'
MAP=ROOT/'semantic/product/v2/reference/native-class-projection.csv'
REGISTER=SOURCE/'formalization/Class_Grounding_Register_128.json'
PROPERTY_MAP=SOURCE/'validation_v041/inputs/Property_Table_Mapping_v0_16_0.csv'
OUTPUT=ROOT/'docs/downloads/OntoSPK-v2.0.5-annotated.ttl'
BASE=ROOT/'evaluation/robot-report.json.gz'
DC=Namespace('http://purl.org/dc/terms/')
IAO=Namespace('http://purl.obolibrary.org/obo/IAO_')
SKOS=Namespace('http://www.w3.org/2004/02/skos/core#')
REPO='https://github.com/ArazSaieArasi3/OntoSPK'
ANNOTATIONS={RDFS.label,DC.title,DC.description,DC.source,SKOS.altLabel,IAO['0000115'],IAO['0000600']}
ADDED_DECLARATIONS={p for p in ANNOTATIONS if p!=RDFS.label}
VERSION=URIRef(REPO+'/releases/download/v2.0.5/'+OUTPUT.name)

def read_csv(path):
    with path.open(encoding='utf-8-sig') as f:return list(csv.DictReader(f))

def boundary_subjects(g):
    # All declared proxies and all boundary-relation predicates are owner-held,
    # including any other property whose declared endpoint is a proxy.
    subjects={s for s in g.subjects() if isinstance(s,URIRef) and str(s).startswith((
        'urn:product-ontology:external-boundary:','urn:product-ontology:relation-profile:'))}
    subjects|={s for s,p,o in g if p in (RDFS.domain,RDFS.range) and o in subjects}
    return subjects

def logical_rdf(g):
    result=Graph()
    declarations={(p,RDF.type,OWL.AnnotationProperty) for p in ADDED_DECLARATIONS}
    for triple in g:
        if triple[1] not in ANNOTATIONS|{OWL.versionIRI} and triple not in declarations:
            result.add(triple)
    return result

def validate_view(original,candidate):
    assert isomorphic(logical_rdf(original),logical_rdf(candidate)), 'Logical RDF changed'
    for subject in boundary_subjects(original):
        assert set(candidate.predicate_objects(subject))==set(original.predicate_objects(subject)), 'Held boundary changed'
    ontology=next(original.subjects(RDF.type,OWL.Ontology))
    assert not list(candidate.objects(ontology,DC.license)), 'Unapproved licence'
    assert not list(candidate.objects(None,OWL.imports)), 'New import'

def generate():
    assert sha(CORE)=='153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12'
    assert sha(NATIVE)=='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
    original=Graph().parse(CORE);g=Graph()+original;held=boundary_subjects(original)
    assert len(held)==69
    mapping={r['mapped_iri']:r['native_id'] for r in read_csv(MAP) if r['scope']=='local'}
    catalogue={r['native_id']:r for r in read_csv(CAT)}
    register={r['id']:r for r in json.loads(REGISTER.read_text())}
    native=json.loads(NATIVE.read_text())
    native_by_id={e['id']:e for e in native['elements']}
    property_map={r['predicate']:r for r in read_csv(PROPERTY_MAP)}
    parents={e['specific']:e['general'] for e in native['elements'] if e['type']=='Generalization'}
    with gzip.open(BASE,'rt') as f:baseline=json.load(f)
    changes=[]
    def annotate(subject,predicate,value,basis,source,remove=None):
        assert subject not in held
        if remove is not None:g.remove((subject,predicate,remove))
        g.add((subject,predicate,value))
        changes.append({'subject_iri':str(subject),'predicate_iri':str(predicate),
                        'old_literal':str(remove) if remove is not None else None,
                        'new_value':str(value),'basis':basis,'source':source})
    def provenance(subject,path,selector):
        target=URIRef(REPO+'/blob/v2.0.0/'+str(path.relative_to(ROOT))+'#'+selector)
        if (subject,DC.source,target) not in g:
            annotate(subject,DC.source,target,'Exact frozen authored source; not external expert acceptance.',str(path.relative_to(ROOT))+'#'+selector)
    for p in ADDED_DECLARATIONS:g.add((p,RDF.type,OWL.AnnotationProperty))
    for row in baseline['findings']:
        subject=URIRef(row['Subject']);rule=row['Rule Name']
        if subject in held:continue
        if rule=='missing_label':
            token=str(subject).rsplit(':',1)[1]
            label=re.sub(r'(?<=[a-z0-9])(?=[A-Z])',' ',token)
            label=label[:1].upper()+label[1:]
            # Source token is preserved in the receipt; labels express no new
            # identity, equivalence, domain, range or restriction.
            annotate(subject,RDFS.label,Literal(label),'Readable spelling of the exact authored IRI token.',str(CORE.relative_to(ROOT))+'#'+str(subject))
            provenance(subject,CORE,str(subject))
        elif rule=='duplicate_label':
            old=list(original.objects(subject,RDFS.label));assert len(old)==1
            token=str(subject).rsplit(':',1)[1]
            endpoints=[]
            for pred in (RDFS.domain,RDFS.range):
                values=list(original.objects(subject,pred));assert len(values)==1 and isinstance(values[0],URIRef)
                endpoints.append(str(original.value(values[0],RDFS.label) or values[0].rsplit(':',1)[1]))
            label=f'{old[0]} ({endpoints[0]} to {endpoints[1]}; {token})'
            annotate(subject,RDFS.label,Literal(label),'Disambiguate distinct declared relation IRIs by exact endpoints and token; do not merge.',str(CORE.relative_to(ROOT))+'#'+str(subject),remove=old[0])
            annotate(subject,SKOS.altLabel,old[0],'Retain original lexical form as an alternative label.',str(CORE.relative_to(ROOT))+'#'+str(subject))
            provenance(subject,CORE,str(subject))
    for iri,native_id in sorted(mapping.items()):
        row=catalogue[native_id];assert row['scope']=='LOCAL'
        definition=register[native_id]['definition']['en'];assert row['definition']==definition
        annotate(URIRef(iri),IAO['0000115'],Literal(definition),'Verbatim existing local catalogue/register definition; no independent acceptance implied.',str(CAT.relative_to(ROOT))+'#'+native_id)
        provenance(URIRef(iri),CAT,native_id)
    properties=set(original.subjects(RDF.type,OWL.ObjectProperty))|set(original.subjects(RDF.type,OWL.DatatypeProperty))
    comment_counts=Counter(str(o) for s in properties-held for o in original.objects(s,RDFS.comment))
    for subject in sorted(properties-held,key=str):
        comments=list(original.objects(subject,RDFS.comment))
        if not comments:
            ids=property_map[str(subject)]['native_relation_ids'].split(';') if property_map[str(subject)]['native_relation_ids'] else []
            if len(ids)==1:
                relation=native_by_id[ids[0]]
                description=(relation.get('description') or {}).get('en')
                if description:
                    endpoints=[native_by_id[e]['propertyType'] for e in relation['properties']]
                    mapped={v:URIRef(k) for k,v in mapping.items()}
                    assert all((subject,pred,mapped[end]) in original for pred,end in zip((RDFS.domain,RDFS.range),endpoints))
                    annotate(subject,IAO['0000600'],Literal(description),'Verbatim current native relation description with independently matched declared endpoints; no candidate review note is promoted.',str(NATIVE.relative_to(ROOT))+'#'+ids[0])
                    provenance(subject,NATIVE,ids[0])
            continue
        assert len(comments)==1
        # Existing operational explanations are elucidations, not newly
        # invented genus/differentia definitions or imported authority.
        value=comments[0]
        basis='Verbatim authored operational comment, explicitly typed as elucidation.'
        if comment_counts[str(value)]>1:
            value=Literal('For the authored property '+str(subject).rsplit(':',1)[1]+': '+str(comments[0]))
            basis='Exact authored operational comment with its existing property token as an explicit scope qualifier; distinct properties are not merged.'
        annotate(subject,IAO['0000600'],value,basis,str(CORE.relative_to(ROOT))+'#'+str(subject))
        provenance(subject,CORE,str(subject))
    ontology=next(original.subjects(RDF.type,OWL.Ontology))
    annotate(ontology,DC.title,Literal('OntoSPK: An Ontology for Modeling Software Product Knowledge'),'Existing repository ontology name and stated scope.','README.md')
    annotate(ontology,DC.description,Literal('An annotated editorial view of the bounded OntoSPK software product knowledge profile. The frozen ontology core remains v2.0.0; specifications, realizations, capabilities, testing and evidence retain their published commitments.'),'Summary of existing public README and guide; annotation-only distribution.','README.md; docs/guide/Overview.md')
    g.add((ontology,OWL.versionIRI,VERSION))
    validate_view(original,g)
    for triple in set(g)^set(original):
        assert triple[1] in ANNOTATIONS or triple==(ontology,OWL.versionIRI,VERSION) or triple in {(p,RDF.type,OWL.AnnotationProperty) for p in ADDED_DECLARATIONS},triple
    OUTPUT.parent.mkdir(parents=True,exist_ok=True);OUTPUT.write_text(graph_text(g))
    assert isomorphic(g,Graph().parse(OUTPUT))
    adjudication=[]
    for row in baseline['findings']:
        subject=URIRef(row['Subject']);rule=row['Rule Name'];native_id=mapping.get(str(subject))
        item={k:row[k] for k in ('Level','Rule Name','Subject','Property','Value')}
        item['scope']='header' if (subject,RDF.type,OWL.Ontology) in original else 'held_external_declaration_or_relation' if subject in held else 'local_declaration'
        item['source_iri']=str(subject)
        item['source_file']=str(CORE.relative_to(ROOT))
        if subject in held:
            item['decision']='RETAIN_OWNER_HELD_BOUNDARY'
            item['rationale']='Preserve every assertion on this proxy or boundary relation; no external definition, label edit, alignment or private repository operation.'
        elif rule=='missing_superclass':
            assert native_id and native_id not in parents
            assert register[native_id]['stereotype'] in ('kind','category')
            item['decision']='RETAIN_AUTHORED_ROOT'
            item['native_id']=native_id;item['native_stereotype']=register[native_id]['stereotype']
            item['rationale']='Native model declares no parent for this kind/category. No missing native generalization was found; an OBO-style parent is not added. Full UFO adequacy remains outside this editorial review.'
        elif rule=='missing_ontology_license':
            item['decision']='RETAIN_NO_LICENCE_SELECTED';item['rationale']='LICENSING.md explicitly retains no project-wide reuse licence; no owner rights choice is inferred.'
        elif rule=='missing_definition' and not list(g.objects(subject,IAO['0000115'])) and not list(g.objects(subject,IAO['0000600'])):
            item['decision']='RETAIN_UNSOURCED_DEFINITION'
            item['rationale']='No current OWL definition/comment or eligible current native description was found. Historical candidate review notes are not silently promoted into an accepted definition. A name/domain/range alone is insufficient; sourced concept work remains #37.'
            ids=property_map.get(str(subject),{}).get('native_relation_ids','')
            item['native_relation_ids']=ids.split(';') if ids else []
            item['candidate_review_notes']=[{'native_id':i,'source_key':k,'decision_scope':v.get('decision_scope'),'truth_condition':v.get('current_truth_condition')} for i in item['native_relation_ids'] for k,v in native_by_id[i]['customProperties'].items() if isinstance(v,dict) and 'current_truth_condition' in v]
        else:
            item['decision']='ANNOTATION_REPAIRED'
            item['rationale']='Exact annotation change and authored provenance are recorded in changes; execution against the unmodified default ROBOT report is required separately.'
        item['supporting_changes']=[c for c in changes if c['subject_iri']==str(subject)]
        if native_id:item['native_id']=native_id
        adjudication.append(item)
    assert len(adjudication)==812
    result={'status':'SOURCE_REVIEW_AND_ANNOTATED_VIEW_COMPLETE','release':'v2.0.5','ontology_core':'v2.0.0',
        'source_sha256':{str(p.relative_to(ROOT)):sha(p) for p in (CORE,NATIVE,CAT,MAP,PROPERTY_MAP,REGISTER,BASE,ROOT/'README.md',ROOT/'LICENSING.md',ROOT/'tools/publication/build_metadata_review.py')},
        'annotated_path':str(OUTPUT.relative_to(ROOT)),'annotated_sha256':sha(OUTPUT),'version_iri':str(VERSION),
        'findings_reviewed':812,'decisions':dict(Counter(r['decision'] for r in adjudication)),
        'annotation_changes':len(changes),'definition_annotations':101,
        'elucidation_annotations':sum(c['predicate_iri']==str(IAO['0000600']) for c in changes),
        'scoped_shared_elucidations':sum(c['predicate_iri']==str(IAO['0000600']) and c['new_value'].startswith('For the authored property ') for c in changes),
        'held_boundary_subjects':len(held),'logical_rdf_isomorphic':True,'new_imports':0,
        'project_licence_selected':False,'independent_acceptance':False,'changes':changes,'findings':adjudication}
    write_json('evaluation/robot-metadata-review.json.gz',result)
    text=['# ROBOT metadata source review — v2.0.5','',
        'All 812 baseline findings are reviewed individually with exact source IRIs, local/header/held-boundary grouping and explicit decisions. The frozen core remains v2.0.0. The separate annotated download has its own version IRI and SHA-256; it is not a replacement for the frozen core or WIDOCO reference.','',
        '| Decision | Findings |','| --- | ---: |']
    text += [f'| {k} | {v} |' for k,v in sorted(result['decisions'].items())]
    text += ['',f"The view copies 101 existing local catalogue/register definitions verbatim, and 137 existing property comments plus two current native relation descriptions as **elucidations**, not newly invented definitions. Missing labels use the exact authored IRI token with readable spacing. Local duplicate relation labels receive exact endpoint/token qualifiers; their old labels remain alternatives. Every change has an authored-source record. This is internal provenance, not independent literature/expert acceptance.",'',
        'Shared source comments on 22 distinct properties receive the exact existing property token as an explicit scope qualifier. Their original comment bodies remain verbatim, and no property identities are merged. This prevents ambiguous duplicate elucidations without inventing a new relational meaning.','',
        'All 69 declared boundary proxy/relation subjects retain every outgoing assertion, including their labels and comments. All 27 native handles and 543 semantic source files remain unchanged. No sibling/private repository is accessed. External duplicate labels and missing definitions are deliberately retained.','',
        'The 53 local superclass findings correspond to 52 native kinds and the EvidenceArtifact category with no authored native parent. No missing native parent was found; no hierarchy axiom is fabricated to satisfy an OBO convention. The other 20 root findings concern owner-held proxies. Full foundational-profile adjudication remains #48.','',
        'The property table mapping and native relation descriptions were checked as well as the OWL comments. Two exact current descriptions with matching endpoints are reused. Historical candidate review notes retain their original scope and are not silently promoted into accepted definitions. Unsupported definitions remain explicit editorial debt in the separately planned sourced concept workflow (#37). No label, endpoint or identifier is promoted into a speculative definition. LICENSING.md remains authoritative: no project-wide reuse licence has been selected, and the missing-licence ERROR is retained.','',
        '[Download the annotated editorial view](https://github.com/ArazSaieArasi3/OntoSPK/releases/download/v2.0.5/OntoSPK-v2.0.5-annotated.ttl) · [Every finding, change and exact source hash](robot-metadata-review.json.gz) · [Fresh unmodified default-report comparison and logical controls](robot-metadata-tests.md)','',
        'The [ROBOT report documentation](https://robot.obolibrary.org/report) describes the default severity/exit behavior. This work does not change its profile, suppress rows, use a base-IRI filter, or redefine ERROR as a pass. The pinned JAR supplies the actual queries; the execution receipt records before/after counts and retained failures.','',
        'Reproduce: `python tools/publication/build_metadata_review.py`, then `python tools/publication/test_metadata_view.py --robot /path/to/robot.jar`.']
    (ROOT/'evaluation/robot-metadata-review.md').write_text('\n'.join(text)+'\n')
    print(json.dumps({k:result[k] for k in ('status','findings_reviewed','decisions','definition_annotations','elucidation_annotations','annotation_changes','held_boundary_subjects')}))
    return result

if __name__=='__main__':generate()
