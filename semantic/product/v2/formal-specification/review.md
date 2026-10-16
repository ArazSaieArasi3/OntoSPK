# Review of the FOL transcription

The review checks whether the published formulas faithfully transcribe their stated inputs. It does not run a new ontology-wide consistency proof or replace independent semantic review.

## Clarifications incorporated

| Point | Published treatment |
| --- | --- |
| Native structure and logical-profile commitments have different coverage. | Two separately named theories are published; their union or equivalence is not asserted. |
| Relation labels are not unique. | Every machine predicate has an identifier-derived unique symbol and a complete source dictionary. |
| Endpoint multiplicities can be reversed accidentally. | Both directions are extracted from the native endpoints and compared with the retained relation contracts. |
| A readable table is not itself an expanded logical file. | All structural macros are expanded into FOL with equality, and the emitted text is independently parsed. |
| Datatype ranges are not a complete datatype theory. | The profile export explicitly identifies its abstract datatype predicates and omitted datatype semantics. |
| A count of expressions can include tautologies or pairwise expansions. | Counts are reported as inventory, not as evidence of semantic strength. |
| Test-profile joins are not necessarily asserted OWL axioms. | EV10 and EV11 are documented as scoped graph/admission contracts in a separate reference. |
| Asymmetry is weaker than general acyclicity. | No unsupported cycle-freedom claim is made. |

## Executed checks

The [machine-readable report](transcription-review.json) records source and output hashes, syntax and binding checks, complete relation-signature comparison, all two-object interpretations of each native relation and source-based profile inventory reconciliation. Both satisfying and violating finite interpretations are included.

The parser accepts the generated function-free TPTP FOF subset. It is a transcription check, not a third-party theorem prover. The two-object evaluation is exhaustive within its declared bound; it is not exhaustive over arbitrary interpretations. The profile checks cover syntax, signatures and source-family counts and do not prove full semantic equivalence to OWL 2.

The model and logical-profile input bytes remain unchanged. Article files are outside this publication change. Ontology-wide satisfiability, temporal and modal adequacy, independent acceptance and datatype value-space verification remain separate questions.
