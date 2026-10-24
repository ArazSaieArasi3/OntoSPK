"""Source contrasts and controlled diagram faults for the bounded figure review."""
import copy
import hashlib
import json
import struct
import xml.etree.ElementTree as ET
from build_diagram_review import ROOT,NATIVE,MANIFEST,FIGURE,OUT,NS,review,domains

native=json.loads(NATIVE.read_text());manifest=json.loads(MANIFEST.read_text());svg=ET.parse(FIGURE).getroot()
baseline=review(native,manifest,svg);assert not baseline['errors'],baseline['errors']
def variant(id,change):
    modified=copy.deepcopy(svg)
    change(next(x for x in modified.iter() if x.get('id')==id))
    return modified
faults={
    'wrong endpoint cardinality':variant('R01',lambda g:g.set('data-target-cardinality','1')),
    'reversed generalization target':variant('G01',lambda g:g.set('data-target',g.get('data-source'))),
    'filled generalization triangle':variant('G01',lambda g:list(g.iter(NS+'path'))[1].set('fill','#222222')),
    'missing visible stereotype':variant('C01',lambda g:setattr(next(g.iter(NS+'text')),'text','kind')),
    'displaced head':variant('R01',lambda g:list(g.iter(NS+'path'))[1].set('d','M 0 0 L 1 1 L 2 0')),
}
for label,modified in faults.items():assert review(native,manifest,modified)['errors'],label
data=domains(native,baseline['domain_colors'])
assert len(data['associations'])==286 and sum(row['count'] for row in data['matrix'])==286
assert len(data['domains'])==12 and sum(d['classes'] for d in data['domains'])==101
assert data['boundary_bucket']['classes']==27 and not data['boundary_bucket']['is_domain']
chosen={e['representative']['native_id'] for e in data['backbone']}
all_ids={e['native_id'] for e in data['associations']}
assert len(chosen)==11 and chosen|set(data['backbone_omitted_native_associations'])==all_ids
assert not chosen & set(data['backbone_omitted_native_associations'])
rendered=ET.parse(OUT/'domain-backbone.svg').getroot()
assert {g.get('data-native-id') for g in rendered.iter() if g.get('data-native-id')}==chosen
assert len([g for g in rendered.iter() if g.get('data-domain')])==12
for stem in ('domain-matrix','domain-backbone'):
    raw=(OUT/(stem+'.png')).read_bytes();assert raw[:8]==b'\x89PNG\r\n\x1a\n'
    offset=8;metadata={};size=None
    while offset<len(raw):
        length=struct.unpack('>I',raw[offset:offset+4])[0];kind=raw[offset+4:offset+8];payload=raw[offset+8:offset+8+length];offset+=length+12
        if kind==b'IHDR':size=struct.unpack('>II',payload[:8])
        if kind==b'tEXt':key,value=payload.split(b'\0',1);metadata[key.decode()]=value.decode()
    source=OUT/(stem+'.svg');root=ET.parse(source).getroot()
    assert size==(2*int(root.get('width')),2*int(root.get('height')))
    assert metadata['SourceSVG_SHA256']==hashlib.sha256(source.read_bytes()).hexdigest()
print('PASS: 40 classes, 59 displayed relations, 286 aggregated associations, 12 domains, 5 rejected faults, 2 source-bound PNG exports')
