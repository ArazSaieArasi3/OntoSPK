# Source-backed concept reader

This directory is the authored editorial source for issue #37. The first increment (#63) contains six pilot manuscripts. The generated index accounts for all 128 native entries, without pretending that the remaining 122 have sourced explanations. Expansion is tracked in #64 (local concepts), #65 (external handles) and #66 (property/relation scope).

## Authority and source format

The frozen `semantic/product/v2/catalogue/Concept_Catalogue_v0_41_0.csv` supplies the native ID, label, domain, stereotype and canonical short definition. The native model remains the semantic authority. The renderer reads these fields directly; manuscripts must not redefine them. The native-to-OWL projection supplies the existing logical mapping, which is not a claim of full semantic equivalence.

Each `entries/*.md` file starts with a fenced JSON metadata block followed by ordinary English Markdown. Required metadata: `native_id`, `editorial_status`, `reviewed_on`, `evidence`, and `related_ids`. Required sections: Extended explanation, Distinctions, Illustrative example, Evidence gaps and lineage. Manuscripts have one authority; HTML is regenerated. Each evidence record has a page-local `id`, a bibliographic `source` key, `claim`, `support`, an exact `locator`, and `limitation`. A token such as `[@context]` cites that evidence record. The renderer assigns IEEE-style reference numbers in order of first use on each page. Never hand-maintain reference numbers.

`references.json` owns shared bibliographic metadata, original reading URLs, access scope and the precise sections inspected. It contains no copyrighted source copies. A source key is stable across pages; numbering is local to each page. `reviewed_sections` means the cited original passages were inspected; `abstract_only` means only the original abstract was inspected and can support only a claim actually present there. It does not authorize a claim about an unseen chapter. The pilot includes a book only for its inspected chapter abstract; its detailed definition remains an evidence-access gap.

## Scientific evidence policy

Search relevant scientific papers first, scholarly books second, then standards and other authoritative primary sources. Priority does not override relevance or access: a well-matched primary passage is better than an unrelated prestigious citation. Follow leads to the original work and verify authors, title, year, publication and DOI where available. Do not infer unread content from a title, a search snippet or another author's citation. Retain unsuccessful access as a gap rather than inventing a page-level reading.

Support values are `direct` (the limited stated claim is explicit in the passage), `adapted` (an acknowledged editorial adaptation), `partial` (only part of the proposed account is supported), and `contrast` (the source helps expose a difference). These classify a particular claim, never certify an entire concept. Exact model identity and independently accepted scientific adequacy are different questions. Same-name words do not establish equivalence.

Separate the quoted canonical definition, original editorial explanation, literature account and illustrative example. Do not silently improve the frozen definition. A semantic revision needs its own issue, evidence and release decision. Do not invent a discovery chronology; current source/commit history proves a recorded commitment, not its original intellectual discovery. Unavailable historical evidence is labelled explicitly.

External manuscripts explain the local reference-only boundary. They do not define another owner's ontology, assert imports/equivalence, access private sibling repositories or resolve #25–#27. PC-01's concrete-capability decision and reference deviation remain explicit. Class pages do not repair the 142 property descriptions or the 318 retained ROBOT findings.

## Review and publication

1. Select a native ID and read its canonical definition, identity commitment, incident relations and actual OWL projection.
2. Inspect original sources and record claim-specific locators and limits; write original prose and identify local synthesis.
3. Check the two explanatory paragraphs against the evidence, including negative examples and alternatives. The pilot's `editorial-source-checked` status records this editorial pass, not independent expert or owner equivalence review.
4. Run `build_portal.py`, `test_concept_pages.py`, existing documentation/link audits and versioned-site checks. CI regenerates and compares the complete checked-in projections. The focused test includes adverse citation, authority, duplicate-ID, coverage and destination cases.
5. Publish current Pages and the Wiki entry point; verify live bytes, rendered navigation and stable-ID search separately. Frozen releases and ontology sources remain unchanged. No new semantic release or DOI is implied.

Routes use reversible native-ID encoding (`ic--Product.html`, `ext--EvidenceLayer--Evidence.html`), preserve case, and are validated against collisions. Names can change without changing an ID-based route. The index has all twelve local domains, a separate external owner grouping, alphabetical access, and client-side label/ID filtering with a complete no-JavaScript list. Entries awaiting manuscripts link to their exact existing native-reference section; no placeholder definition page is generated. HTML pages bind the canonical catalogue and each manuscript by SHA-256 in `coverage.json`; deployed pages additionally carry the exact documentation-source commit.

The schema and six manuscripts are a first editorial increment. Scientific adequacy, full 101/27 coverage, property coverage and independent review remain separately measurable work.
