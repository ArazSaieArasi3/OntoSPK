# Synthetic relational reference implementation

The SQLite occurrence implementation contains 450 tables, 332 views and 782 triggers. The synthetic example has 46 asserted triples and 13 typed entities. It does not populate every local class or association.

- [Compressed synthetic database](OntoSPK-v2.0.0-rc.1-synthetic.sqlite.gz)
- [Full SQL schema](schema.sql)
- [Data dictionary](data-dictionary.csv)
- [Physical foreign keys](physical-foreign-keys.csv)
- [Build and integrity receipt](DATABASE_BUILD.json)
- [Architecture](ERD.md)
- [Class-to-table mapping](../../../semantic/product/v2/source/validation_v041/inputs/Class_Table_Mapping_v0_16_0.csv)
- [Relation/OWL/SQL crosswalk](../../../semantic/product/v2/source/validation_v041/inputs/Relation_OWL_SQL_Crosswalk_v0_16_0.csv)
- [RDF property mapping](../../../semantic/product/v2/source/validation_v041/inputs/Property_Table_Mapping_v0_16_0.csv)

Decompress the database before opening it. Rebuild with `python tools/ontospk/build_database.py` from the repository root. Close/reopen RDF reconstruction, foreign-key integrity and schema invariants are checked during the build. Admission receipts can change the database byte digest on a fresh build; inspect that build's own receipt.

See [Relational Implementation](../../../docs/guide/Relational-Implementation.md) for interpretation and [Reproduce](../../../docs/guide/Reproduce.md) for dependencies. Record keys do not establish real-world identity. No production or successor PostgreSQL claim is made.
