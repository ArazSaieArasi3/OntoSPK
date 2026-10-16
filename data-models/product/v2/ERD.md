# Physical projection architecture

The full foreign-key inventory is [physical-foreign-keys.csv](physical-foreign-keys.csv); every table, view and column is in [data-dictionary.csv](data-dictionary.csv). This diagram shows representative physical patterns, not all hundreds of tables.

```mermaid
erDiagram
    SNAPSHOT ||--o{ ENTITY : scopes
    TERM ||--o{ ENTITY : identifies
    ENTITY ||--o{ CLASS_MEMBERSHIP : types
    ENTITY ||--o{ PREDICATE_TABLE : subjects
    TERM ||--o{ PREDICATE_TABLE : values
    SNAPSHOT ||--o| ADMISSION_RECEIPT : qualifies
    SNAPSHOT ||--o{ HISTORY_BINDING : records
```

The native-to-class and relation-to-predicate mappings are explicit source CSV files. A physical predicate table may represent an inverse or retained profile helper; its count is not an independent association count. The occurrence profile adds append-only provenance and binding controls to the retained 438-table schema and two base admission tables. Record keys do not prove real-world identity.
