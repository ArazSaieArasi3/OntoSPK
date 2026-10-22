# Live Wiki publication verification

The repository owner published the reviewed source, and the resulting GitHub Wiki was read back on 22 October 2026. This receipt accepts the Wiki publication work item (#9); it does not accept the separate Pages, WIDOCO hosting, WebVOWL or ontology-evaluation work.

- Live Wiki: https://github.com/ArazSaieArasi3/OntoSPK/wiki
- Wiki commit: `24bc0b25f935a639e9ee247f07a601baf243365d`.
- Reviewed repository source: `a1da92ddfe23f2d4fbde88de942315fdeeb6675d`, `wiki-src/`.
- Result: **PASS_LIVE_WIKI_READBACK**.

| Check | Observed result |
| --- | --- |
| Published files | 17: 15 reader pages, sidebar and footer; no repository README |
| File identity | All 17 files match the reviewed and current source byte for byte |
| Browser page readback | All 15 pages load with their expected titles and content |
| Sidebar | Three reader sections; all 15 destinations present on every page |
| Footer | Present on all 15 pages, with the v2.0.0 release link |
| Internal navigation | Home-to-Overview click succeeds; rendered internal destinations resolve to the 15 verified pages |
| Rendering | Five tables and four code blocks observed in their intended pages |
| Release reference | Footer link opens v2.0.0 at `ccea141bcc238a4aae47e631cadc1809b738bc73`, with four uploaded assets |
| Source links | 73 reader Markdown links; 29 internal links and 27 pinned tag paths checked by the source audit |

## Scope and limits

The source inventory contains about 3,611 English words. It has no orphan pages, configured missing paths or detected Arabic/Persian script. These bounded checks do not establish human authorship or full semantic correctness. Third-party website availability and external-owner equivalence were not accepted by this check. The live Wiki can change after this dated receipt.

The native and logical sources and the v2.0.0 release are unchanged. Pages remains unpublished pending design and versioned-route acceptance. WIDOCO and WebVOWL remain prepared source outputs.

[File hashes and per-page browser receipt](wiki-publication-verification.json) · [Source audit](wiki-source-audit.md)
