from pathlib import Path
import hashlib,json

ROOT=Path(__file__).resolve().parents[2]
V=ROOT/'semantic/product/v2'
S=V/'source'
native=S/'formalization/Native_Model_v0_41_0.json'
expected='b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed'
assert hashlib.sha256(native.read_bytes()).hexdigest()==expected
for rel in json.loads((V/'native-input-locations.json').read_text()):
    p=S/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(native.read_bytes())
for rel in ['validation_v041/results','validation_v041/official_tools/results','t52_formalization_v043/results']:
    (S/rel).mkdir(parents=True,exist_ok=True)
print('Canonical native input verified and runtime copies materialized.')
