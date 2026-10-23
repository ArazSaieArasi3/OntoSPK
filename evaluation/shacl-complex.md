# Complex SHACL execution

All 113 components beyond the 1,864 simple components have executed source-bound positive/adverse controls. The source graphs are unchanged.

| Component | Source occurrences |
| --- | ---: |
| in | 6 |
| minLength | 33 |
| pattern | 21 |
| sparql | 49 |
| xone | 4 |

449 component observations include target-off controls. All finite selections of the four xone path sets are tested. 244 inverse property projections retain their actual class/cardinality checks. Three full source-graph positive populations and their single-triple deletion observations test interactions separately.

Expected ordinary nonconformance is matched to focus node, source shape and component; SPARQL cases also match the original source constraint. An intentionally invalid SPARQL expression is recorded as an execution error, not an accepted negative data result.

The fourth, native-contract source graph also passes all 42 retained positive/adverse event fixtures. Full reporting-graph validation uses the same retained ontology graph as the released runtime (inference=none); subclass lookup is not replaced by invented explicit types. Inverse paths whose targetObjectsOf condition supplies the very edge being tested have unreachable isolated missing-edge controls; those cases are explicitly marked, not counted as negative passes.

The machine-readable receipt includes unchanged source digests, exact source expressions, projected shapes, authored input data and expected/observed results. Component isolation does not establish correctness of every interaction or all possible RDF inputs.

[Detailed receipt](shacl-complex.json.gz)
