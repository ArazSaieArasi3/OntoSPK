"""Generate a current summary without guessing live publication or issue state."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
REPO = 'https://github.com/ArazSaieArasi3/OntoSPK'


def build():
    source = ROOT/'tools/publication/current-status.json'
    status = json.loads(source.read_text())
    (ROOT/'docs/current-status.json').write_text(json.dumps(status, indent=2)+'\n')
    core, version = status['ontology_core'], status['documentation_increment']
    summary = f'''The consolidated documentation/evidence increment is **{version}**, over unchanged ontology core **{core}**. It includes PC-01, corrected native-ID term search, reviewed diagrams and current metadata/DOI accounting. [GitHub Releases]({REPO}/releases) is the authority for actual release publication; the [deployment manifest](https://arazsaiearasi3.github.io/OntoSPK/publication-manifest.json) identifies the live current source. Increment identity alone does not assert that a tag or DOI has been published.'''
    rows = '\n'.join(f'| [#{number}]({REPO}/issues/{number}) | {reason} |' for number, reason in status['remaining_work'].items())
    page = f'''# Current release and work status

{summary}

## Version boundaries

| Object | Identity and interpretation |
| --- | --- |
| Ontology core | v2.0.0; all 543 semantic files and 27 external handles retained. |
| Original documentation snapshot | v2.0.1; preserved historical Pages route and exact source mapping. |
| Consolidated documentation/evidence | v2.0.8 source increment; its release record establishes publication. |
| Current Pages | Mutable reading route; the deployment manifest identifies its exact source commit. |
| New frozen Pages | The v2.0.8 registry entry binds a separately recorded accepted documentation commit/tree. It need not equal the later packaging commit. |
| PC-01 | Adopted concrete-capability project profile; included in v2.0.8 sources, absent from the earlier v2.0.7 archive. Strict reference-profile conformity is not claimed. |

## Accepted work and consolidation

The FOL pilot (#31), reader parity (#52), diagrams (#32), publication handoff (#30) and local capability decision (#48) have accepted prior closeouts. Issues #56–#61 track this consolidation's implementation, release and independent live acceptance. Their linked issue records determine final open/closed state; a prepared source summary does not close them.

The historical v2.0.5 metadata reports are replayed from their exact release context so that current README improvements do not silently alter their source hashes. The [residual account](../../evaluation/metadata-residual-review.md) retains all 318 findings and routes each to an explicit disposition; it is not a clean ROBOT report.

## Source-backed concept reader

The current reader adds a [six-page editorial pilot](../concepts/index.html) over the released v2.0.8 station: five of 101 local concepts and one of 27 external handles. All 128 entries are indexed; 122 still await manuscripts. The [source method](../concepts/method.html) distinguishes canonical definitions, local synthesis and claim-specific evidence. Issues #37 and #63–#66 track pilot acceptance, expansion and relation scope. No new release number, ontology migration or independent scientific approval is asserted.

## Remaining independent work

| Issue | Scope |
| --- | --- |
{rows}

No project-wide reuse licence or DOI is asserted. The [publication handoff](publication-handoff.md) describes citation and registration prerequisites. The manuscript and physical database are separately maintained; this documentation increment does not claim their release or verification.

## Read and reproduce

Use [the guide](../guide/Home.md), [formal verification method](formal-verification.md), [reviewed diagrams](diagram-provenance.md) and [current evaluation](../evaluation/index.html). The [machine-readable status](../current-status.json) is generated from one governed record. Frozen routes and release payloads remain immutable; current guide/Wiki projections can evolve together. Live Wiki and HTTP/browser checks are separate, source-bound acceptance records in #61.
'''
    (ROOT/'docs/handbook/current-status.md').write_text(page)
    readme = ROOT/'README.md'
    text = readme.read_text()
    start, end = '<!-- current-status:start -->', '<!-- current-status:end -->'
    block = start+'\n\n## Current documentation and evidence\n\n'+summary+'\n\n[Current status and remaining work](https://arazsaiearasi3.github.io/OntoSPK/current/status/index.html) · [Sourced concept pilot](https://arazsaiearasi3.github.io/OntoSPK/current/concepts/index.html) · [PC-01 decision](evaluation/capability-profile-review.md) · [FOL method](docs/handbook/formal-verification.md) · [Diagrams](docs/handbook/diagram-provenance.md) · [Residual ROBOT findings](evaluation/metadata-residual-review.md)\n\n'+end
    if start in text:
        text = text[:text.index(start)]+block+text[text.index(end)+len(end):]
    else:
        text = text.replace('# OntoSPK\n', '# OntoSPK\n\n'+block+'\n', 1)
    readme.write_text(text)
    print('Generated current-status JSON, handbook and README summary: '+version)


if __name__ == '__main__':
    build()
