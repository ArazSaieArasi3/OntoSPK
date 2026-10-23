# Business reference contract tests

All 198 reference cases and three CLI exit-status controls pass. The reviewed source inventory contains exactly five Business handles, eight incident native relations and four existing logical boundary proxies.

The tests cover all five valid kinds; required target/source/version fields; malformed and multi-valued IRIs; cross-family and wrong-kind substitutions; unreviewed class locators; forbidden equivalence/owner-acceptance flags; unknown payload keys; and out-of-scope handles. Inputs are not mutated. Even a syntactically conforming synthetic source/version returns false for owner acceptance, semantic equivalence, verified target membership, source truth and online access.

The service alias remains a candidate; the stable Business handle and its Business Service display are preserved. The adapter is a separate gate and does not assert that the frozen legacy runtime already implements these Business contracts.

[Exact inputs and expected/observed outcomes](business-boundary-tests.json) · [Policy and source traceability](business-boundary-review.md)
