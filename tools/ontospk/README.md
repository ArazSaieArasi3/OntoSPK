# OntoSPK execution tools

The complete instructions are in [Reproduce the evaluation](../../docs/guide/Reproduce.md). `bootstrap_inputs.py` verifies the canonical native digest and materializes runtime copies expected by retained contracts. `run_validation.py` records executed and omitted stages explicitly. The reference and database builders derive their outputs from the same public source tree.

Do not commit runtime native copies, temporary databases, external checkouts or downloaded JARs. Retain warnings and unsuccessful results when interpreting evidence.
