# Visualization

The selected conceptual diagram and WebVOWL answer different questions. The conceptual diagram shows forty selected native concepts and declared relations. WebVOWL explores the bounded OWL profile.

The viewer uses WebVOWL 1.1.7 and a deterministic data adapter that preserves the source URN identifiers. It includes all 121 named OWL classes, 322 declared properties with exact single URI endpoints, and 34 URI subclass edges. Ten properties lacking a suitable declared endpoint are listed in the [coverage report](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/docs/webvowl/coverage.json), rather than supplied with invented domains or ranges. Anonymous expressions, disjointness and data/database policies remain in the formal reference.

The bundled WIDOCO converter produced an empty entity projection for the unchanged source and is not used as the published graph. Run `python tools/publication/build_webvowl_data.py` to regenerate the explicit exploratory projection. Viewer build and dependency provenance are recorded in [tool provenance](https://github.com/ArazSaieArasi3/OntoSPK/blob/main/docs/tool-provenance.json).

Online deployment and browser-rendered acceptance are separate from preparing valid viewer files.
