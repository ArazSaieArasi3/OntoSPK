"""Record exact public payload hashes without importing private repository history."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[2]
copies={str(Path('semantic/product/v2/source')/p) for p in json.loads((ROOT/'semantic/product/v2/native-input-locations.json').read_text())}
def included(p):
 r=p.relative_to(ROOT)
 if any(part in ['.git','__pycache__','build','dist','.venv'] for part in r.parts):return False
 if p.suffix in ['.pyc','.sqlite','.sqlite-journal','.sqlite-wal','.sqlite-shm','.jar','.pdf','.docx']:return False
 if r.as_posix() in copies or r.as_posix()=='distribution-manifest.json':return False
 if 'results' in r.parts and r.parts[0]!='evaluation':return False
 if r.as_posix().startswith('semantic/product/v2/source/t52_formalization_v043/fixtures/') and p.suffix=='.owl':return False
 return True
tracked=subprocess.check_output(['git','ls-files','-z'],cwd=ROOT).decode().split('\0')
paths=sorted([ROOT/p for p in tracked if p and (ROOT/p).is_file() and included(ROOT/p)])
manifest={'schema_version':1,'distribution_version':'2.0.0','state':'public_core_v2.0.0_check_releases_for_publication','semantic_source_commit':'beb0194b23d5794307742f9214d780e823ff829f','native_version':'0.41.0','native_sha256':'b000749e658042c1af0fbcf5f034ee0659c046985547df31d490f4662f8a3aed','logical_profile':'0.43.0','logical_sha256':'153548613d6069742a10868c92f813229918038c03fa7e1efea6b8a7726edc12','assembly_provenance':'0.45.0','transformations':['selected public source; no private history imported','existing public semantic core retained when byte-identical','physical database payload removed from ontology-core tree','reader documentation and generated references synchronized with release scope','WebVOWL data uses a conservative URN-preserving adapter'],'licensing_state':'project-wide reuse licence not selected','files':[{'path':p.relative_to(ROOT).as_posix(),'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in paths],'manifest_self_inclusion':False}
(ROOT/'distribution-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(json.dumps({'payload_files':len(paths),'payload_bytes':sum(x['bytes'] for x in manifest['files'])}))
