"""Regenerate WIDOCO reference with pinned tool bytes and explicit metadata."""
from pathlib import Path
import argparse,hashlib,subprocess,json
ROOT=Path(__file__).resolve().parents[2]
ap=argparse.ArgumentParser();ap.add_argument('--jar',type=Path,required=True);args=ap.parse_args()
receipt=json.loads((ROOT/'docs/tool-provenance.json').read_text())
assert hashlib.sha256(args.jar.read_bytes()).hexdigest()==receipt['widoco']['jar_sha256']
subprocess.run(['java','-jar',str(args.jar.resolve()),'-ontFile','semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl','-outFolder','docs/widoco','-confFile','tools/publication/widoco.properties','-rewriteAll','-includeAnnotationProperties','-uniteSections','-noPlaceHolderText','-lang','en'],cwd=ROOT,check=True)

from finish_widoco import finish
finish()
