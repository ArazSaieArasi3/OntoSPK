# Coverage plan for the public ontology core

This is a planned evaluation extension, not an execution report. It starts after the core migration has been reconciled. Current finite results remain in [Quality](../docs/guide/Quality.md).

## What counts as comprehensive

Coverage is measured against **declared commitments in the released scope**, not against every possible statement about software products. The register must enumerate the 22 scoped commitments, named declarations of the bounded OWL profile, active SHACL constraints, 56 competency-question contracts, native structural signatures and the 27 external boundary handles. Each row identifies its source, expression, test oracle, applicable method, positive/negative fixture, observed result and limitation. Different denominators are reported separately.

## SHACL

Inventory all active shapes, targets, property paths, cardinalities, classes, node kinds, datatypes and SPARQL constraints from the published shapes graphs. Establish that each selected shape graph is well formed, each intended target is activated and no validation failure is confused with an ordinary nonconformance. For each distinct material constraint, supply valid, violating and boundary data; assert the expected focus node, source shape and constraint component. Include inverse paths, missing values, extra values, wrong targets and cross-record conditions. A generated shape may share a test pattern, but its target and constraint must remain individually traceable. Report unused, duplicate and out-of-scope shapes instead of counting them as covered.

## OWL and HermiT

Check OWL 2 DL profile, baseline TBox consistency and satisfiability of every named class in the *bounded logical profile*. For every declared logical commitment, test supported entailment and, where scientifically relevant, a counterexample or non-entailment. Positive ABox scenarios must remain consistent; isolated negative scenarios should be inconsistent only under the specified axiom. Test the open-world and absent unique-name assumptions explicitly, including pairs that add `owl:differentFrom`. Domain/range inference and cardinality must not be described as closed-world rejection rules.

## Other evidence and acceptance

Preserve the structural register and exact-answer competency-question regression. Use controlled mutations of source axioms or graph data to check whether relevant tests detect a defect. Record complete input hashes, tool pins, commands, expected/observed result and method-specific reports in human-readable Markdown and machine-readable form. Zero unexplained critical errors in positive baseline and full traceability of in-scope formal claims are the proposed release gates. Unsupported temporal, modal and causal statements, independent expert assessment and external-owner mappings remain explicit separate decisions.

The final case count will follow the deduplicated constraint and commitment inventory. The earlier 13 HermiT cases and four SHACL negative contrasts are a baseline, not the denominator for this extension.
