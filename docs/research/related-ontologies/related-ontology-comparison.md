# OntoSPK: bounded comparison with related ontologies

**Conceptual comparison · evidence assessed 15 October 2026 · native model 0.41.0**

This page records a source-backed conceptual comparison. The underlying 23-entry bibliography was screened for relevance: four primary families cover five references, and five references support complementary comparisons. Selected full-text sections and official specifications informed the comparisons; this does not mean that every bibliography entry received a fresh full-text review. This is not a systematic literature review, executable alignment, or superiority benchmark.

**Repository boundary.** The concepts compared here belong to the OntoSPK manuscript companion v0.44.0 (native model v0.41.0). This record does not silently equate that model with, or modify, the repository’s frozen Product Ontology v1.5 baseline. No third-party models or papers are redistributed.

## Comparison selection and dimensions

| Family | References | Why selected |
| --- | --- | --- |
| CPM / CPM2 | [10](#ref-10), [11](#ref-11) | Engineering-product representation and design specifications. |
| OntoProd | [12](#ref-12) | Product-information lifecycle and implementation deposit. |
| Software product-management ontology | [1](#ref-1) | Direct management-vocabulary prior art; a direct management-vocabulary comparison. |
| SwO / RSRO / RRO | [14](#ref-14) | Software identity, requirements and execution foundations. |


Dimensions: domain scope; representation unit; formalization; identity/category boundaries; reported evidence; relation to OntoSPK; and the resulting correspondence decision. No numeric ranking is assigned.

## Primary comparisons

### CPM / CPM2

[10](#ref-10) [CPM DOI](https://doi.org/10.6028/NIST.IR.6736) · [official CPM PDF, p.11](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir6736.pdf#page=11) (PDF pp.11–19, §§4–6). [11](#ref-11) [CPM2 DOI](https://doi.org/10.6028/NIST.IR.7185) · [official CPM2 PDF, p.9](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir7185.pdf#page=9) (§§2–3, PDF pp.9–23); [Appendix A, PDF p.26](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir7185.pdf#page=26). PDF page numbers are one-based viewer pages.

| Dimension | Observation / comparison |
| --- | --- |
| Scope | Engineering product design and artifact descriptions. |
| Representation unit | Artifact; Feature; Function; Specification; Behavior. |
| Formalization | UML object/relationship model; Java/XML illustrations. |
| Identity/category boundary | Design specification and intended function are explicit; no software-realization identity equivalence follows. |
| Source-reported evidence | Worked engineering example; appendix Java is explicitly illustrative and incomplete. |
| OntoSPK relation | Our emphasis is governed software-product knowledge, version-bound bearer wholes and assessment records. |
| Decision | Use CPM as a design-description precedent. Intended Function is not an automatic match for actual ProductCapability. |


**Repository/artifact check:** No author/NIST-linked GitHub repository verified in targeted searches. Selected report and appendix content inspected; no CPM software executed.

### OntoProd

[12](#ref-12) [article DOI](https://doi.org/10.1016/j.jii.2025.100820) · [author-uploaded full text](https://www.researchgate.net/publication/389772670_Managing_lifecycle_of_product_information_with_an_ontology-based_knowledge_framework) · [official Zenodo deposit](https://zenodo.org/records/15005493). Article §§4.1–4.2 (pp.6–8), §5 (pp.8–11), Table 2 (p.12), and conclusions/data availability (p.13). The DOI currently resolves to unavailable publisher content in this client; the deposit and author copy are separate access routes.

| Dimension | Observation / comparison |
| --- | --- |
| Scope | Part-based product knowledge and information lifecycle in engineer-to-order settings. |
| Representation unit | Part; Feature; Datum; DatumInstance; configuration templates/project graphs. |
| Formalization | OWL restrictions, SWRL rules and SPARQL; reported Fuseki/Pellet/C# prototype. |
| Identity/category boundary | Template/project-instance cloning is not automatically our version-bound configured realization. |
| Source-reported evidence | Industrial examples and descriptive capability table; no matched OntoSPK benchmark. |
| OntoSPK relation | Our FeatureSpecification is a description artifact; actual capability and report attribution have their own contracts. |
| Decision | Compare lifecycle structure and data provenance; require explicit correspondence for Feature, project instance and DatumInstance. |


**Repository/artifact check:** No author-linked public GitHub repository verified. Do not substitute Ontop, a different platform. Official file inventory/ZIP preview inspected. Root ontology file contents and application were not inspected or executed; downloads returned HTTP 403. The separate 2.5 kB TTL is service configuration according to retained inspection, not the 20.4 kB root file listed inside ZIP.

### Botzenhardt et al. SPM ontology

[1](#ref-1) [article DOI](https://doi.org/10.1109/IWSPM.2011.6046207) · [KIT institutional record](https://publikationen.bibliothek.kit.edu/1000052295). Supplied 10-page PDF: pp.2–5 (method), p.7 (Table IV and relations), p.8 (Figure 2), pp.8–9 (limits/future evaluation). The supplied PDF matches the previously inspected copy and is not a new distinct reference. The old RDF address is unavailable and is retained only as a historical entry in the link audit.

| Dimension | Observation / comparison |
| --- | --- |
| Scope | Shared software product-management vocabulary. |
| Representation unit | Activity; Artifact; Role; Organization, including Product, Specification and Roadmap. |
| Formalization | Literature/text extraction and an RDFS vocabulary. |
| Identity/category boundary | Shared labels require semantic correspondence; role and artifact categories are not OntoUML stereotypes. |
| Source-reported evidence | 66 articles and five books support construction; expert interviews are future work. |
| OntoSPK relation | Shared management vocabulary is direct prior art; OntoSPK focuses its explicit contracts on identity, specifications, realizations and assessment records. |
| Decision | Retain as direct prior art. Do not claim the first ontology of software product management. |


**Repository/artifact check:** No author-linked GitHub repository verified in targeted searches. Paper Figure 2, Table IV and relations inspected; current RDF download did not succeed, and no RDF model execution is claimed.

### SwO / RSRO / RRO

[14](#ref-14) [article DOI](https://doi.org/10.3233/AO-180197) · [publisher record](https://journals.sagepub.com/doi/10.3233/AO-180197) · [author manuscript, PDF p.15](https://www.inf.ufes.br/~gguizzardi/appliedOntologyRunTime.pdf#page=15) · [official SwO specification](https://dev.nemo.inf.ufes.br/seon/SwO.html). Author PDF §5, pp.15–18; §6, pp.18–20; §8 and Tables 2–7, pp.22–25. This draft’s pagination differs from journal pp.73–105.

| Dimension | Observation / comparison |
| --- | --- |
| Scope | Software nature, requirements and requirements at runtime. |
| Representation unit | Program; specification; Loaded Program Copy; Software Function; execution. |
| Formalization | SABiO/UFO reference ontologies with explicit conceptual axioms. |
| Identity/category boundary | Loaded Program Copy is a disposition; Requirement is an intention, distinct from Requirement Artifact. |
| Source-reported evidence | Expert CQ verification, instantiation and test-case designs; operational implementation/execution is outside that paper’s scope. |
| OntoSPK relation | OntoSPK models a configured realization as a bearer whole, with ProductCapability as its disposition, and uses requirement specifications as artifacts. |
| Decision | This is the closest foundational comparison. The distinctions are precedents; whole-bearer and loaded-copy correspondences remain candidates. |


**Repository/artifact check:** No GitHub repository tied to this exact paper/version verified. allysonlister/swo is a different ontology and was excluded. Paper and official specification inspected. Website version 1.0.5 (2017) is not assumed identical to the 2018 paper; any downloaded OWL is only a static snapshot.

The [official SEON site](https://dev.nemo.inf.ufes.br/seon/menu.html) offers an [operational OWL snapshot](https://dev.nemo.inf.ufes.br/seon/SEON.owl). The inspected site version is 1.0.5 (2017); it is not assumed identical to the 2018 article. Relative/base-IRI issues in the downloaded XML prevent treating parser-generated local-file IRIs as authoritative class identities.

## Twelve selected correspondence decisions

These are candidate analogies or non-equivalence boundaries, not a complete mapping. No `owl:equivalentClass`, automated import, or executable integration is asserted. Each location below links to the inspected source.

| # | Family | Source concept | OntoSPK candidate | Decision | Evidence location |
| --- | --- | --- | --- | --- | --- |
| 1 | CPM | Artifact | ProductRealization | Candidate analogy only; check whether an engineering entity and a configured computing whole have matching identity conditions. | [CPM2 Section 2.2, PDF p.10](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir7185.pdf#page=10) |
| 2 | CPM | Specification | CapabilitySpecification / RequirementSpecification | Specification aggregates design requirements; matching a specific local description requires decomposition and scope. | [CPM2 PDF p.11](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir7185.pdf#page=11) |
| 3 | CPM | Function | ProductCapability / CapabilitySpecification | Function denotes what an artifact is supposed to do. Do not collapse intended function and actual disposition. | [CPM2 PDF p.12](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir7185.pdf#page=12) |
| 4 | OntoProd | Feature | FeatureSpecification | A characteristic of a Part and a description artifact are not established as the same category. | [Section 4.1.1, article p.6](https://www.researchgate.net/publication/389772670_Managing_lifecycle_of_product_information_with_an_ontology-based_knowledge_framework) |
| 5 | OntoProd | Project-instance graph | ProductRealization | Cloning a template graph does not establish identity of a configured bearer whole. | [Section 5, article pp.9-11](https://www.researchgate.net/publication/389772670_Managing_lifecycle_of_product_information_with_an_ontology-based_knowledge_framework) |
| 6 | OntoProd | DatumInstance | TestResult / EvidenceArtifact | Information-lifecycle records may be related, but no evidence or result class equivalence is established. | [Sections 4.1.1 and 5, article pp.6,10](https://www.researchgate.net/publication/389772670_Managing_lifecycle_of_product_information_with_an_ontology-based_knowledge_framework) |
| 7 | SPM | Product / Specification | Product / specification classes | Shared terminology is a correspondence lead, not proof of matching identity, typing or cardinality. | [Table IV and Figure 2, supplied PDF pp.7-8; institutional identity record, PDF supplied privately](https://publikationen.bibliothek.kit.edu/1000052295) |
| 8 | SPM | Roadmap | Roadmap | Compare intended description and governance before any import or identity merge. | [Table IV, supplied PDF p.7; institutional identity record, PDF supplied privately](https://publikationen.bibliothek.kit.edu/1000052295) |
| 9 | SwO | Loaded Program Copy | ProductCapability / ProductRealization | Source copy is a complex disposition. OntoSPK capability is a disposition and realization is its bearer whole; explicit bearer analysis is needed. | [Section 5, author PDF p.17](https://www.inf.ufes.br/~gguizzardi/appliedOntologyRunTime.pdf#page=17) |
| 10 | SwO | Requirement / Requirement Artifact | RequirementSpecification | The local specification is an information artifact; do not map it to a stakeholder intention. | [Section 6, author PDF pp.18-19](https://www.inf.ufes.br/~gguizzardi/appliedOntologyRunTime.pdf#page=18) |
| 11 | SwO | Program Copy Execution | TestExecution | A general program execution is broader than a concluded test attempt; a setup-only abort may lack target participation. | [Section 5 and existing occurrence profile](https://www.inf.ufes.br/~gguizzardi/appliedOntologyRunTime.pdf#page=15) |
| 12 | ROoST | Test Execution / Test Script / creates | TestExecution / external script / hasResult | Only evidenced exercised-code attempts are candidates; manual procedures and report documentation do not match code or creation automatically. | [Official ROoST definitions and retained ROoST_Correspondence_v0_41_0.json](https://dev.nemo.inf.ufes.br/seon/ROoST.html) |


## Complementary comparisons

| Source | Role and comparison boundary | Direct source |
| --- | --- | --- |
| SEON [13](#ref-13) | Network architecture, shared foundations and integration boundaries; not a whole-network superiority test. | [publisher / official / institutional source](https://link.springer.com/chapter/10.1007/978-3-319-49004-5_34) |
| Requirements/test ontology [15](#ref-15) | Artifact traceability; do not equate a trace link with established assessment truth. | [publisher / official / institutional source](https://ejbeta.clei.org/cleiej/article/view/341) |
| OntoTrace [16](#ref-16) | Human-task evidence; its reported results are not transferred to OntoSPK. | [publisher / official / institutional source](https://doi.org/10.1007/s00766-025-00447-4) |
| ONTO-PDM [17](#ref-17) | Formal interoperability and standards correspondences; not a matched software-product benchmark. | [publisher / official / institutional source](https://iris.poliba.it/handle/11589/5202) |
| ROoST [23](#ref-23) | Targeted testing semantics; reuse the existing conditional correspondence matrix without claiming full integration. | [publisher / official / institutional source](https://dev.nemo.inf.ufes.br/seon/ROoST.html) |


ROoST is considered only for conditional testing correspondences. An attempt that never exercises target code, a manual procedure, or a report documenting a result does not automatically satisfy ROoST’s code execution or result-creation semantics. A full integration remains future work.

## Overall conclusion and manuscript use

The supported emphasis is the organization of portfolio and strategy knowledge together with version-bound realizations and attributable assessment records. The sources already supply important product, management, software and testing distinctions. Shared labels establish neither identical identity conditions nor formal equivalence. This comparison supports scoped positioning; it establishes neither exhaustive novelty nor measured superiority.

The concise comparison is reflected in the v0.44.0 manuscript’s literature-review method, Table I and comparative discussion. The detailed decisions and access boundaries are retained here. No third-party implementation was executed. The OntoProd archive download remains blocked; inventory inspection is not model-content verification.

## Screening of all 23 manuscript references

| Reference | Selection | Reason |
| --- | --- | --- |
| [1](#ref-1) | primary comparison | SPM vocabulary directly adjacent to product knowledge |
| [2](#ref-2) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [3](#ref-3) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [4](#ref-4) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [5](#ref-5) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [6](#ref-6) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [7](#ref-7) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [8](#ref-8) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [9](#ref-9) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [10](#ref-10) | primary comparison | Core engineering-product representation |
| [11](#ref-11) | primary comparison | Revised CPM with specifications, function and implementation examples |
| [12](#ref-12) | primary comparison | Product knowledge and lifecycle model with a published artifact deposit |
| [13](#ref-13) | complementary comparison | Network architecture and reuse |
| [14](#ref-14) | primary comparison | Closest software identity, requirements and execution precedent |
| [15](#ref-15) | complementary comparison | Requirements/test traceability |
| [16](#ref-16) | complementary comparison | Human-task evaluation precedent |
| [17](#ref-17) | complementary comparison | Standards interoperability and formal correspondences |
| [18](#ref-18) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [19](#ref-19) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [20](#ref-20) | method foundation standard or tool | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [21](#ref-21) | case or data source | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [22](#ref-22) | case or data source | Supports method, foundation, notation, validation tooling, demonstration or data; not a competing product-knowledge model. |
| [23](#ref-23) | complementary comparison | Testing concepts and conditional reuse boundary |


## References and exact access links

Reference numbers match manuscript v0.44.0. DOI identifiers are retained even when a publisher blocks automated access. For compared sources with access failures, use the explicit alternate source above. An accessible landing page does not imply freely downloadable full text.

<a id="ref-1"></a>

**[1]** A. Botzenhardt, A. Mädche, and J. Wiesner, “Developing a domain ontology for software product management,” in Proc. 5th Int. Workshop Software Product Management (IWSPM), 2011, pp. 7–16. doi: 10.1109/IWSPM.2011.6046207. [DOI](https://doi.org/10.1109/IWSPM.2011.6046207)

<a id="ref-2"></a>

**[2]** K. Peffers, T. Tuunanen, M. A. Rothenberger, and S. Chatterjee, “A Design Science Research Methodology for Information Systems Research,” J. Manage. Inf. Syst., vol. 24, no. 3, pp. 45–77, 2007. doi: 10.2753/MIS0742-1222240302. [DOI](https://doi.org/10.2753/MIS0742-1222240302)

<a id="ref-3"></a>

**[3]** R. de Almeida Falbo, “SABiO: Systematic Approach for Building Ontologies,” in Proc. ONTO.COM/ODISE, CEUR Workshop Proceedings, vol. 1301, 2014. [official source](https://ceur-ws.org/Vol-1301/ontocomodise2014_2.pdf)

<a id="ref-4"></a>

**[4]** M. C. Suárez-Figueroa, A. Gómez-Pérez, and B. Villazón-Terrazas, “How to Write and Use the Ontology Requirements Specification Document,” in On the Move to Meaningful Internet Systems: OTM 2009, LNCS 5871, pp. 966–982, 2009. doi: 10.1007/978-3-642-05151-7_16. [DOI](https://doi.org/10.1007/978-3-642-05151-7_16)

<a id="ref-5"></a>

**[5]** P. C. Barbosa Fernandes, R. S. S. Guizzardi, and G. Guizzardi, “Using Goal Modeling to Capture Competency Questions in Ontology-based Systems,” Journal of Information and Data Management, vol. 2, no. 3, 2011. [official source](https://periodicos.ufmg.br/index.php/jidm/article/view/124)

<a id="ref-6"></a>

**[6]** A. Fernández-Izquierdo, “Ontology testing based on requirements formalization in collaborative development environments,” CEUR Workshop Proceedings, vol. 1962, 2017. [official source](https://ceur-ws.org/Vol-1962/paper_8.pdf)

<a id="ref-7"></a>

**[7]** V. Braun and V. Clarke, “Using thematic analysis in psychology,” Qualitative Research in Psychology, vol. 3, no. 2, pp. 77–101, 2006. doi: 10.1191/1478088706qp063oa. [DOI](https://doi.org/10.1191/1478088706qp063oa)

<a id="ref-8"></a>

**[8]** G. Guizzardi, G. Wagner, J. P. A. Almeida, and R. S. S. Guizzardi, “Towards ontological foundations for conceptual modeling: The unified foundational ontology (UFO) story,” Applied Ontology, vol. 10, nos. 3–4, pp. 259–271, 2015. doi: 10.3233/AO-150157. [DOI](https://doi.org/10.3233/AO-150157)

<a id="ref-9"></a>

**[9]** OntoUML, “OntoUML specification: Classes, relationships and anti-pattern catalogue.” Accessed: Oct. 14, 2026. [official source](https://ontouml.readthedocs.io/en/latest/)

<a id="ref-10"></a>

**[10]** S. J. Fenves, A Core Product Model for Representing Design Information, NISTIR 6736. Gaithersburg, MD, USA: NIST, 2002. doi: 10.6028/NIST.IR.6736. [DOI](https://doi.org/10.6028/NIST.IR.6736)

<a id="ref-11"></a>

**[11]** S. J. Fenves, S. Foufou, C. Bock, R. Sudarsan, N. Bouillon, and R. D. Sriram, CPM 2: A Revised Core Product Model for Representing Design Information, NISTIR 7185, Oct. 2004. doi: 10.6028/NIST.IR.7185. [DOI](https://doi.org/10.6028/NIST.IR.7185)

<a id="ref-12"></a>

**[12]** L. Failla, M. Rossoni, M. Quirini, and G. Colombo, “Managing lifecycle of product information with an ontology-based knowledge framework,” J. Ind. Inf. Integr., vol. 45, Art. no. 100820, 2025. doi: 10.1016/j.jii.2025.100820. [DOI](https://doi.org/10.1016/j.jii.2025.100820)

<a id="ref-13"></a>

**[13]** F. B. Ruy, R. A. Falbo, M. P. Barcellos, S. D. Costa, and G. Guizzardi, “SEON: A Software Engineering Ontology Network,” in EKAW 2016, LNCS 10024, pp. 527–542, 2016. doi: 10.1007/978-3-319-49004-5_34. [DOI](https://doi.org/10.1007/978-3-319-49004-5_34)

<a id="ref-14"></a>

**[14]** B. B. Duarte et al., “Ontological foundations for software requirements with a focus on requirements at runtime,” Applied Ontology, vol. 13, no. 2, pp. 73–105, 2018. doi: 10.3233/AO-180197. [DOI](https://doi.org/10.3233/AO-180197)

<a id="ref-15"></a>

**[15]** M. L. Roldán, M. Vegetti, S. Gonnet, M. Marciszack, and H. Leone, “An Ontology for Specifying and Tracing Requirements Engineering Artifacts and Test Artifacts,” CLEI Electron. J., vol. 22, no. 1, 2019. doi: 10.19153/cleiej.22.1.2. [DOI](https://doi.org/10.19153/cleiej.22.1.2)

<a id="ref-16"></a>

**[16]** D. Mosquera, M. Ruiz, and O. Pastor, “Ontology-based NLP tool for tracing software requirements and conceptual models: an empirical study,” Requirements Eng., vol. 30, pp. 341–369, 2025. doi: 10.1007/s00766-025-00447-4. [DOI](https://doi.org/10.1007/s00766-025-00447-4)

<a id="ref-17"></a>

**[17]** H. Panetto, M. Dassisti, and A. Tursi, “ONTO-PDM: Product-driven ONTOlogy for Product Data Management interoperability within manufacturing process environment,” Adv. Eng. Inform., vol. 26, no. 2, pp. 334–348, 2012. doi: 10.1016/j.aei.2011.12.002. [DOI](https://doi.org/10.1016/j.aei.2011.12.002)

<a id="ref-18"></a>

**[18]** H. Knublauch and D. Kontokostas, Eds., “Shapes Constraint Language (SHACL),” W3C Recommendation, Jul. 20, 2017. [official source](https://www.w3.org/TR/2017/REC-shacl-20170720/)

<a id="ref-19"></a>

**[19]** ROBOT, “Reason” and “Validate Profile,” documentation. and  Accessed: Oct. 12, 2026. [official reason](https://robot.obolibrary.org/reason) · [official validate-profile](https://robot.obolibrary.org/validate-profile)

<a id="ref-20"></a>

**[20]** OntoUML, “OntoUML Graph Validator,” source code, ver. 1.0.0a0. Accessed: Oct. 14, 2026. [official source](https://github.com/OntoUML/ontouml-validator)

<a id="ref-21"></a>

**[21]** A. Saie Arasi, H. Haghighi, and H. Azgomi, “CM-PharmE ver.1: Towards a Conceptual Model for Pharmaceutical Ecosystem with a Business-Architecture Perspective,” in Proc. 2025 9th Iranian Conf. Advances in Enterprise Architecture (ICAEA), 2025. doi: 10.1109/ICAEA69058.2025.11301544. [DOI](https://doi.org/10.1109/ICAEA69058.2025.11301544)

<a id="ref-22"></a>

**[22]** U.S. Food and Drug Administration, “openFDA Drug NDC API.” Accessed: Oct. 12, 2026. [official source](https://open.fda.gov/apis/drug/ndc/)

<a id="ref-23"></a>

**[23]** NEMO, “Reference Ontology on Software Testing (ROoST),” SEON ontology specification, 2017. Accessed: Oct. 15, 2026. [official source](https://dev.nemo.inf.ufes.br/seon/ROoST.html)

## Link and identity verification — 15 October 2026

The checks separate (1) DOI/title identity, (2) HTTP transport and (3) access to the expected content. DOI metadata were retrieved from Crossref where possible; primary publisher/institutional pages supplement unavailable registry responses. A successful response containing “Site Unavailable” is recorded as a content error. The IEEE HTTP 202 response verifies a redirect, not an article body. Failures in one client are not erased by successful independent retrieval.

The audit covers 39 source/access URLs (including one historical endpoint) and 14 DOI-metadata lookups. The machine-readable [link audit](link-audit-2026-10-15.json) records canonical URLs, outcomes and timestamps. The unavailable historical endpoint is not an active navigation link below.

| ID | Exact URL | HTTP result | Interpretation |
| --- | --- | --- | --- |
| R01 | [source](https://doi.org/10.1109/IWSPM.2011.6046207) | 202 | resolver_redirect_only_no_article_body_verified; registered DOI/title retrieved |
| R02 | [source](https://doi.org/10.2753/MIS0742-1222240302) | 403 | access_blocked; registered DOI/title retrieved |
| R03 | [source](https://ceur-ws.org/Vol-1301/ontocomodise2014_2.pdf) | 200 | reachable |
| R04 | [source](https://doi.org/10.1007/978-3-642-05151-7_16) | 200 | reachable |
| R05 | [source](https://periodicos.ufmg.br/index.php/jidm/article/view/124) | 200 | reachable; primary-page identity matched independently |
| R06 | [source](https://ceur-ws.org/Vol-1962/paper_8.pdf) | 200 | reachable |
| R07 | [source](https://doi.org/10.1191/1478088706qp063oa) | 403 | access_blocked; registered DOI/title retrieved |
| R08 | [source](https://doi.org/10.3233/AO-150157) | 403 | access_blocked; primary-page identity matched independently |
| R09 | [source](https://ontouml.readthedocs.io/en/latest/) | 200 | reachable |
| R10 | [source](https://doi.org/10.6028/NIST.IR.6736) | 200 | reachable; registered DOI/title retrieved |
| R11 | [source](https://doi.org/10.6028/NIST.IR.7185) | 200 | reachable; registered DOI/title retrieved |
| R12 | [source](https://doi.org/10.1016/j.jii.2025.100820) | 200 | soft_error_content_unavailable; registered DOI/title retrieved |
| R13 | [source](https://doi.org/10.1007/978-3-319-49004-5_34) | 200 | reachable |
| R14 | [source](https://doi.org/10.3233/AO-180197) | 403 | access_blocked; registered DOI/title retrieved |
| R15 | [source](https://doi.org/10.19153/cleiej.22.1.2) | 500 | http_error; registered DOI/title retrieved |
| R16 | [source](https://doi.org/10.1007/s00766-025-00447-4) | 200 | reachable; primary-page identity matched independently; registered DOI/title retrieved |
| R17 | [source](https://doi.org/10.1016/j.aei.2011.12.002) | 200 | soft_error_content_unavailable; registered DOI/title retrieved |
| R18 | [source](https://www.w3.org/TR/2017/REC-shacl-20170720/) | 200 | reachable |
| R19 | [source](https://robot.obolibrary.org/reason) | 200 | reachable |
| R19 | [source](https://robot.obolibrary.org/validate-profile) | 200 | reachable |
| R20 | [source](https://github.com/OntoUML/ontouml-validator) | 200 | reachable |
| R21 | [source](https://doi.org/10.1109/ICAEA69058.2025.11301544) | 202 | resolver_redirect_only_no_article_body_verified; registered DOI/title retrieved |
| R22 | [source](https://open.fda.gov/apis/drug/ndc/) | 200 | reachable |
| R23 | [source](https://dev.nemo.inf.ufes.br/seon/ROoST.html) | 200 | reachable; primary-page identity matched independently |
| CPM-PDF | [source](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir6736.pdf) | 200 | reachable; primary-page identity matched independently |
| CPM2-PDF | [source](https://nvlpubs.nist.gov/nistpubs/Legacy/IR/nistir7185.pdf) | 200 | reachable; primary-page identity matched independently |
| ONTOPROD-INSTITUTION | [source](https://re.public.polimi.it/handle/11311/1286998) | 403 | access_blocked |
| ONTOPROD-DEPOSIT | [source](https://zenodo.org/records/15005493) | 200 | reachable; primary-page identity matched independently |
| ONTOPROD-AUTHOR | [source](https://www.researchgate.net/publication/389772670_Managing_lifecycle_of_product_information_with_an_ontology-based_knowledge_framework) | 200 | reachable |
| SPM-INSTITUTION | [source](https://publikationen.bibliothek.kit.edu/1000052295) | 502 | http_error; primary-page identity matched independently |
| SWO-PDF | [source](https://www.inf.ufes.br/~gguizzardi/appliedOntologyRunTime.pdf) | 200 | reachable; primary-page identity matched independently |
| SEON-SPEC | [source](https://dev.nemo.inf.ufes.br/seon/menu.html) | 200 | reachable |
| SWO-SPEC | [source](https://dev.nemo.inf.ufes.br/seon/SwO.html) | 200 | reachable; primary-page identity matched independently |
| SEON-OWL | [source](https://dev.nemo.inf.ufes.br/seon/SEON.owl) | 200 | reachable |
| SPM-RDF-HISTORICAL | Historical address retained in JSON; HTTP 502 | 502 | http_error |
| R15-PUBLISHER | [source](https://ejbeta.clei.org/cleiej/article/view/341) | 200 | reachable; primary-page identity matched independently |
| R17-INSTITUTION | [source](https://iris.poliba.it/handle/11589/5202) | 403 | access_blocked; primary-page identity matched independently |
| R13-PUBLISHER | [source](https://link.springer.com/chapter/10.1007/978-3-319-49004-5_34) | 200 | reachable; primary-page identity matched independently |
| R14-PUBLISHER | [source](https://journals.sagepub.com/doi/10.3233/AO-180197) | 403 | access_blocked; primary-page identity matched independently |


## Structured evidence

- [Screening of 23 references](reference-screening.json)
- [Four primary families](primary-comparisons.json)
- [Five complementary comparisons](complementary-comparisons.json)
- [Twelve selected correspondence decisions](selected-correspondences.json)
- [Link audit](link-audit-2026-10-15.json)

The structured observations preserve the manuscript comparison. Their historical access statements are contextualized by the newer dated link audit above. No unavailable property is inferred to be absent, and a repository not verified in targeted searches is not declared nonexistent.
