# Retained core regression

Eight stages were freshly executed in an isolated source copy. The frozen semantic source tree was not rewritten. All stages passed.

| Suite | Passed / expected |
| --- | ---: |
| Combined population, persistence and mapping | 42 / 42 |
| Revision, identity policy, occurrence and history | 146 / 146 |
| Static native structural reconciliation | 892 / 892 |
| Project rule controls | 80 / 80 |
| Exact-answer CQ comparisons | 374 / 374 |
| Retained HermiT consistency fixtures | 13 / 13 |

The upstream native SDK and native validator were not rerun here. Their original acceptance remains historical. The expanded HermiT/SHACL/CQ reports provide the new focused evidence; these overlapping counts must not be summed as independent coverage.

[Actual commands, exit statuses, dates and suite observations](core-regression.json.gz)
