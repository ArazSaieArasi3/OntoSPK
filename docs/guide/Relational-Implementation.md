# Relational reference implementation

The current implementation uses SQLite and a synthetic occurrence population. Its physical schema contains 450 tables, 332 views and 782 triggers. The example has 46 asserted RDF triples and 13 typed entities across 13 populated classes.

The schema covers the declared local structural inventory; the example does not populate every native class or association. Table count is not a count of conceptual relations. The earlier combined-admission example has 440 tables and is a different bounded profile.

The [implementation guide](../../data-models/product/v2/README.md) links the full SQL schema, data dictionary, foreign-key inventory, class-to-table map, relation/OWL/SQL crosswalk and import/export functions. The [physical architecture](../../data-models/product/v2/ERD.md) explains representative patterns.

Raw import stores a draft population. Scoped acceptance requires the supported admission function and its receipt. Record identifiers do not establish real-world identity. The separate identity-transition policy has not been integrated as an end-to-end continuity guarantee.

No successor PostgreSQL implementation or production deployment is claimed by this distribution.
