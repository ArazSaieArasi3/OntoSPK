# Third-party notices

The original OntoSPK model, documentation and code have no selected project-wide reuse licence; see [LICENSING.md](LICENSING.md). The notices below apply only to their identified third-party material. Original copyright headers remain in the bundled resources.

| Component | Included material and source identity | Retained licence text / notice |
| --- | --- | --- |
| WebVOWL | Static viewer assets; VisualDataWeb/WebVOWL v1.1.7, commit `28e7dd9540622e8cb723dc000824b5eef5ae775f` | [WebVOWL MIT](third-party-licenses/WebVOWL.txt) |
| D3 | Dependency included in the WebVOWL build | [D3 notice](third-party-licenses/d3.txt) |
| Lodash | Dependency included in the WebVOWL build | [Lodash notice](third-party-licenses/lodash.txt) |
| WIDOCO | Generated reference and static resources from [dgarijo/Widoco v1.4.25](https://github.com/dgarijo/Widoco/tree/v1.4.25); the pinned generator JAR is not distributed | [Upstream Apache 2.0 terms](https://github.com/dgarijo/Widoco/blob/v1.4.25/LICENSE), with a [local full Apache text](third-party-licenses/Apache-2.0-Google-dark-mode.txt); individual bundled resources below |

## WIDOCO resource-level readback

The following repository files match the indicated source files in WIDOCO `v1.4.25` by Git blob identity. The resource headers remain in place. Licence choices below do not grant any licence to OntoSPK's original material.

| Distributed resource | Source in WIDOCO v1.4.25 | Copyright and applicable notice |
| --- | --- | --- |
| [jquery.js](docs/widoco/resources/jquery.js) | [doc/bestPractices/resources/jquery.js](https://github.com/dgarijo/Widoco/blob/v1.4.25/doc/bestPractices/resources/jquery.js) | jQuery 1.6.2, © 2011 John Resig, offered under MIT or GPLv2; the MIT option is recorded [here](third-party-licenses/jquery-1.6.2-MIT.txt). Its bundled Sizzle.js header credits © 2011 The Dojo Foundation and offers MIT/BSD/GPL; the MIT option and original header are retained [here](third-party-licenses/Sizzle-2011-MIT.txt). |
| [marked.min.js](docs/widoco/resources/marked.min.js) | [src/main/resources/lode/marked.min.js](https://github.com/dgarijo/Widoco/blob/v1.4.25/src/main/resources/lode/marked.min.js) | Bundled header: © 2011–2022 Christopher Jeffrey, MIT. The [upstream Marked licence text](third-party-licenses/marked-v4-license.txt) includes the Marked and Markdown notices. The exact Marked build version is not established by the header; the source identity claimed here is WIDOCO's tagged resource. |
| [dark-mode-toggle.mjs](docs/widoco/resources/dark-mode-toggle.mjs) | [src/main/resources/darkmode/dark-mode-toggle.mjs](https://github.com/dgarijo/Widoco/blob/v1.4.25/src/main/resources/darkmode/dark-mode-toggle.mjs) | © 2019 Google LLC, [Apache License 2.0](third-party-licenses/Apache-2.0-Google-dark-mode.txt); embedded source notice is retained. |
| [rec.css](docs/widoco/resources/rec.css) | [src/main/resources/lode/rec.css](https://github.com/dgarijo/Widoco/blob/v1.4.25/src/main/resources/lode/rec.css) | Header credits W3C © 1997–2003 (MIT, ERCIM, Keio); the [full historically linked 1998 W3C software notice](third-party-licenses/W3C-software-1998.txt) is included. This copy was taken unchanged from the pinned WIDOCO tag; changes made within WIDOCO relative to earlier W3C CSS have not been independently reconstructed. |

The other ten files in `docs/widoco/resources/` (stylesheets, icons and display images) also have matching Git blob identities in WIDOCO `v1.4.25` under `src/main/resources/darkmode/`, `src/main/resources/lode/` or `src/main/resources/widoco/images/`. No additional copyright header is present in those bundled bytes; their upstream package source and Apache 2.0 terms are recorded in the WIDOCO row. This is a source-level attribution, not a claim that every earlier design contribution to those resources has been independently traced.

The W3C header uses `http://www.w3.org/Consortium/Legal/copyright-software`, a moving address that now points to a newer licence text. The dated historical notice linked from the old source family is retained above; no current-version substitution is asserted. The full WIDOCO output can be regenerated using the pinned tool receipt in [docs/tool-provenance.json](docs/tool-provenance.json).

ROBOT/HermiT, the OntoUML validator and SDK, RDFLib, pySHACL and the Python documentation tools are external execution dependencies. Their source/version references are recorded in the reproduction guide and execution receipt. External binaries and source checkouts are not copied into the ontology distribution.
