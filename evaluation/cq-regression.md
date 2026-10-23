# Competency-question replay and data mutation sensitivity

All 56 contracts and 187 fixtures passed 374 exact-answer comparisons, in fixture-only and fixture-plus-current-profile scopes with no inference. Each source query, fixture and expected answer matches its retained SHA-256.

9128 controlled single-triple deletions/reversals: 1314 changed the expected answer and 7814 survived. Each of the 56 CQs detects at least one data mutation. All 56 unrelated-fact stability controls passed.

Surviving mutations are explicitly retained per CQ and triple; not every stored fact affects every query. This is query sensitivity, not OWL entailment testing or independent domain validation. Source axioms and contracts were not edited to improve the score.

| CQ | Mutations | Detected | Survived |
| --- | ---: | ---: | ---: |
| CQ-D01-01 | 28 | 8 | 20 |
| CQ-D01-02 | 28 | 8 | 20 |
| CQ-D01-03 | 64 | 30 | 34 |
| CQ-D01-04 | 480 | 44 | 436 |
| CQ-D01-05 | 28 | 8 | 20 |
| CQ-D01-06 | 28 | 8 | 20 |
| CQ-D02-01 | 52 | 16 | 36 |
| CQ-D02-02 | 64 | 20 | 44 |
| CQ-D02-03 | 32 | 12 | 20 |
| CQ-D02-04 | 480 | 24 | 456 |
| CQ-D02-05 | 44 | 16 | 28 |
| CQ-D03-01 | 28 | 10 | 18 |
| CQ-D03-02 | 16 | 4 | 12 |
| CQ-D03-03 | 172 | 24 | 148 |
| CQ-D03-04 | 40 | 12 | 28 |
| CQ-D03-05 | 28 | 8 | 20 |
| CQ-D04-01 | 64 | 24 | 40 |
| CQ-D04-02 | 40 | 12 | 28 |
| CQ-D04-03 | 28 | 8 | 20 |
| CQ-D04-04 | 36 | 12 | 24 |
| CQ-D04-05 | 28 | 8 | 20 |
| CQ-D05-01 | 52 | 16 | 36 |
| CQ-D05-02 | 76 | 24 | 52 |
| CQ-D05-03 | 480 | 42 | 438 |
| CQ-D05-04 | 480 | 50 | 430 |
| CQ-D06-01 | 100 | 32 | 68 |
| CQ-D06-02 | 28 | 8 | 20 |
| CQ-D06-03 | 16 | 4 | 12 |
| CQ-D06-04 | 28 | 8 | 20 |
| CQ-D07-01 | 40 | 12 | 28 |
| CQ-D07-02 | 688 | 70 | 618 |
| CQ-D07-03 | 16 | 4 | 12 |
| CQ-D07-04 | 480 | 30 | 450 |
| CQ-D08-01 | 52 | 16 | 36 |
| CQ-D08-02 | 52 | 16 | 36 |
| CQ-D08-03 | 16 | 4 | 12 |
| CQ-D08-04 | 32 | 12 | 20 |
| CQ-D09-01 | 52 | 16 | 36 |
| CQ-D09-02 | 28 | 8 | 20 |
| CQ-D09-03 | 16 | 4 | 12 |
| CQ-D09-04 | 480 | 36 | 444 |
| CQ-D10-01 | 172 | 20 | 152 |
| CQ-D10-02 | 76 | 30 | 46 |
| CQ-D10-03 | 172 | 12 | 160 |
| CQ-D11-01 | 28 | 8 | 20 |
| CQ-D11-02 | 16 | 6 | 10 |
| CQ-D11-03 | 172 | 72 | 100 |
| CQ-D12-01 | 20 | 10 | 10 |
| CQ-D12-02 | 20 | 6 | 14 |
| CQ-D12-03 | 688 | 32 | 656 |
| CQ-L-01 | 688 | 60 | 628 |
| CQ-L-02 | 172 | 44 | 128 |
| CQ-L-03 | 688 | 212 | 476 |
| CQ-L-04 | 28 | 12 | 16 |
| CQ-L-05 | 688 | 30 | 658 |
| CQ-L-06 | 480 | 32 | 448 |

[All inputs, expected/actual answers and mutation observations](cq-regression.json.gz)
