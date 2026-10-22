# Rights readback for the public core candidate

Reviewed 22 October 2026 on the `migration/v2-ontology-core` branch. This is a file-level evidence and publication decision record, not a legal opinion.

## Disposition matrix

| Item | Evidence | Disposition |
| --- | --- | --- |
| Original OntoSPK native model, logical profile, original documentation and implementation | [LICENSING.md](../../../LICENSING.md) expressly records no project-wide reuse licence; no root LICENSE is present | Public inspection only; no MIT/Apache/CC or DOI claim is made for this original work. Any future reuse grant requires a separate rights-holder decision. |
| WebVOWL, D3 and Lodash | Existing individual notices in [THIRD_PARTY_NOTICES.md](../../../THIRD_PARTY_NOTICES.md) and `third-party-licenses/` | Existing attribution retained; no new claim about their terms. |
| WIDOCO-generated reference | Generator version, source and pinned JAR digest in [tool-provenance](../../tool-provenance.json) | Generator binary is not distributed. Generated text derives from OntoSPK source; WIDOCO static resources are accounted for below. |
| jQuery 1.6.2 and included Sizzle.js | Local copyright headers; identical Git blob for `jquery.js` in WIDOCO v1.4.25; [jQuery 1.6.2 MIT text](https://github.com/jquery/jquery/blob/1.6.2/MIT-LICENSE.txt) | MIT alternative selected for those bundled bytes; full terms and both copyright attributions are in `third-party-licenses/`. |
| marked | Local header says MIT, copyright Christopher Jeffrey 2011–2022; identical Git blob in WIDOCO v1.4.25 | Full upstream Marked/Markdown notices retained. Exact underlying Marked build version is not asserted. |
| Google dark mode module | Identical Git blob in WIDOCO v1.4.25, retained Google 2019 Apache 2.0 header | Full Apache 2.0 terms retained in `third-party-licenses/`. |
| W3C `rec.css` | Identical Git blob in WIDOCO v1.4.25; W3C 1997–2003 header | Full [dated historical W3C notice](https://www.w3.org/Consortium/Legal/copyright-software-19980720) retained locally. No local changes after the pinned WIDOCO resource were observed; WIDOCO's earlier adaptation history has not been independently established. |
| Historical Market owner snapshot | [Historical copy](https://github.com/ArazSaieArasi3/OntoSPK/blob/a2c2174adc6f34222a32fe932dc2515509b4f68d/semantic/product/v2/source/t39_review/Market_Owner_Locked.ttl) is reachable from public history. [Canonical owner file](https://github.com/ArazSaieArasi3/market-ontology/blob/e309f00adb812b37b6b6d64ec83a1db89cc80995/semantic/market/v1/market-v1.ttl) lives in the currently private `market-ontology` repository under the same GitHub account. File content differs only by one terminal newline. | **Decision pending from rights holder:** explicitly permit that exact historical snapshot to remain publicly readable, or remove it from reachable public Git history. Current-tree deletion alone does not resolve this. No owner-approved semantic equivalence, public owner release or broad reuse licence follows from either choice. |

## Exact source comparison

The four named WIDOCO resources in [THIRD_PARTY_NOTICES.md](../../../THIRD_PARTY_NOTICES.md) have identical Git blob SHAs to the indicated WIDOCO `v1.4.25` source paths. This binds the bundled bytes to a tagged upstream source without claiming that every underlying dependency version is known. Original resource headers were not changed. The full licence texts are stored separately, so regenerated WIDOCO output does not overwrite them.

The historical Market TTL is 3,730 characters in the public copy and 3,729 characters in the canonical private owner file. The entire common prefix is equal and the public copy adds one final newline. This is substantive content parity, **not** evidence that the owner intended public redistribution. Repository administration or matching GitHub account does not by itself settle rights or intended disclosure.

## Release gate

The third-party resource readback and the no-project-licence/no-DOI assertion are complete within this finite scope. The only outstanding publication decision in this issue is the historical Market owner snapshot. Record the rights-holder decision and evidence in #4 before treating this gate as accepted. If retention is authorized, state the exact file and historical scope without granting broader reuse. If not, a coordinated history-removal plan must identify affected refs, links and previously published copies; a force-push alone cannot guarantee retraction of existing clones or caches.

After that disposition, bind the final candidate and checks in #5, merge #1 through #6, then publish #7. The native and logical semantic digests are not changed by this rights documentation.
