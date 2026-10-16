# Reproduce the evaluation

Use Python 3.12, Java 17 and Node 22 or a compatible runtime recorded in your execution receipt. Install the pinned Python dependencies from the repository root:

```bash
python -m venv .venv
.venv/bin/python -m pip install -r tools/ontospk/requirements.txt
.venv/bin/python tools/ontospk/run_validation.py --output build/evaluation
.venv/bin/python tools/ontospk/build_reference.py
.venv/bin/python tools/ontospk/build_database.py
```

The first validation command runs the locally available structural, admission, revision, CQ and project-rule controls. It explicitly records omitted external-tool checks. It is not the full ten-stage execution.

For all ten stages, obtain the following public upstream tools outside this repository:

- OntoUML validator at commit `46f54c1a5225fc9ea74ac2256fd4a673e9101a40`: https://github.com/OntoUML/ontouml-validator
- OntoUML SDK at commit `a0e44530564331cf17c850d659fae4b6adad4415`: https://github.com/OntoUML/ontouml-js ; install dependencies and build that checkout.
- ROBOT 1.9.11: https://github.com/ontodev/robot/releases/tag/v1.9.11 ; expected JAR SHA-256 `53cd275c8e4c0dad1fc2c1c34174876795cd7d6b6926e1444adcbb0cb3c7ab26`.

```bash
.venv/bin/python tools/ontospk/run_validation.py   --robot /path/to/robot.jar   --validator /path/to/ontouml-validator   --sdk /path/to/ontouml-js   --output build/evaluation
```

The command returns a nonzero exit status for an executed failed stage and records skipped external tools explicitly. The recorded full execution passes ten stages; future runs should inspect their own receipt rather than inherit that status.

To rebuild the static reference and check the public distribution:

```bash
.venv/bin/python tools/publication/build_portal.py
.venv/bin/python tools/publication/check_publication.py
python -m http.server 8000 --directory docs
```

Open `http://localhost:8000` for the portal. Published sites require their own deployment and online checks. Tool version and input identity matter; a successful HTTP response is not semantic validation.

To regenerate WIDOCO 1.4.25, obtain the JDK-17 JAR identified in `docs/tool-provenance.json`, then run `python tools/publication/run_widoco.py --jar /path/to/widoco.jar`. The wrapper checks its recorded SHA-256 and applies the portal link adapter. Rebuild WebVOWL data with `python tools/publication/build_webvowl_data.py`; viewer build provenance and licences are retained separately.
