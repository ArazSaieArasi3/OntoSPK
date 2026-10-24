"""Replay v2.0.5 metadata in its exact release context; retain every receipt."""
from pathlib import Path
import argparse
import hashlib
import io
import json
import shutil
import subprocess
import sys
import tarfile

ROOT = Path(__file__).resolve().parents[2]
REF = 'e730572055bb1eba54698d16b9498771cec81ea3'
FILES = ['evaluation/robot-metadata-review.json.gz', 'evaluation/robot-metadata-review.md',
         'docs/downloads/OntoSPK-v2.0.5-annotated.ttl']


def replay(robot=None):
    dest = ROOT/'build/metadata-baseline-v2.0.5'
    if dest.exists():
        shutil.rmtree(dest)
    dest.mkdir(parents=True)
    payload = subprocess.check_output(['git', 'archive', REF], cwd=ROOT)
    with tarfile.open(fileobj=io.BytesIO(payload)) as tar:
        for member in tar.getmembers():
            if not member.isfile():
                continue
            target = dest/member.name
            assert target.resolve().is_relative_to(dest.resolve())
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(tar.extractfile(member).read())
    subprocess.run([sys.executable, 'tools/publication/build_metadata_review.py'], cwd=dest, check=True)
    files = list(FILES)
    if robot:
        subprocess.run([sys.executable, 'tools/publication/test_metadata_view.py', '--robot', str(robot.resolve())], cwd=dest, check=True)
        files += ['evaluation/robot-metadata-tests.json.gz', 'evaluation/robot-metadata-tests.md']
    for name in files:
        released = subprocess.check_output(['git', 'show', REF+':'+name], cwd=ROOT)
        assert (dest/name).read_bytes() == released, 'Historical replay drift: '+name
        assert (ROOT/name).read_bytes() == released, 'Released receipt replaced: '+name
    # The receipt binds the replay context separately from the mutable README.
    result = {'status': 'PASS_EXACT_RELEASE_CONTEXT_REPLAY', 'source_commit': REF,
              'release': 'v2.0.5', 'files_checked': files, 'robot_executed': bool(robot),
              'released_readme_sha256': hashlib.sha256((dest/'README.md').read_bytes()).hexdigest(),
              'current_readme_sha256': hashlib.sha256((ROOT/'README.md').read_bytes()).hexdigest()}
    (ROOT/'build/metadata-baseline-replay.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result))


if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument('--robot', type=Path)
    replay(ap.parse_args().robot)
