# Competency questions

The competency-question suite tests whether a declared graph supports expected answers under explicit query and inference assumptions. It contains 56 contracts and 187 finite fixtures, with 374 recorded comparisons. Positive populations and negative or incomplete variants exercise query direction, missing relations, unknown values and boundary cases.

Each contract identifies its question, query, fixture inputs and expected answer. The [contract register](https://github.com/ArazSaieArasi3/OntoSPK/blob/v2.0.0/semantic/product/v2/source/validation_v041/cq_replay/CQ_Contracts_v0_24_0.csv) and [query fixtures](https://github.com/ArazSaieArasi3/OntoSPK/tree/v2.0.0/semantic/product/v2/source/validation_v041/cq_replay/cq) are executable sources. Their historical contract revision does not replace the current model revision.

The suite reports explicit exact-answer comparisons; results must be interpreted with the stated inference configuration. It is not a survey of user satisfaction, proof of every domain requirement or an industrial benchmark.
