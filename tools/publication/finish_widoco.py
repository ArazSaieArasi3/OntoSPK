"""Bind WIDOCO's presentation and downloadable RDF to the released core."""
from pathlib import Path
import hashlib
import json
import shutil
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup
from rdflib import Graph, RDF, OWL, URIRef, BNode, Literal
from rdflib.namespace import split_uri
from rdflib.compare import isomorphic, to_canonical_graph

ROOT = Path(__file__).resolve().parents[2]
REPO = "https://github.com/ArazSaieArasi3/OntoSPK"
SOURCE = ROOT / "semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl"


def ordered_json(value, key=""):
    if isinstance(value, dict):
        return {k: ordered_json(v, k) for k, v in sorted(value.items())}
    if isinstance(value, list):
        items = [ordered_json(v) for v in value]
        return items if key == "@list" else sorted(items, key=lambda v: json.dumps(v, sort_keys=True))
    return value


def finish():
    folder = ROOT / "docs/widoco"
    path = folder / "index-en.html"
    soup = BeautifulSoup(path.read_text(), "html.parser")
    soup.html["lang"] = "en"
    if not soup.find("meta", attrs={"name": "viewport"}):
        soup.head.append(soup.new_tag("meta", attrs={"name": "viewport", "content": "width=device-width,initial-scale=1"}))
    if soup.find(id="ontospk-context"):
        soup.find(id="ontospk-context").decompose()
    banner = BeautifulSoup('''<aside id="ontospk-context" style="padding:14px;border-bottom:1px solid #9aa9b5;font:15px/1.6 system-ui,sans-serif">
<a href="../index.html">OntoSPK documentation</a> · <a href="../guide/Formalization.html">Formal interpretation</a> · <a href="../reference/native/index.html">Conceptual reference</a> · <a href="../explore/index.html">WebVOWL</a> · <a href="../downloads/index.html">Downloads</a>
<p>OWL reference for ontology core v2.0.0, logical profile 0.43.0. Definitions and asserted axioms are generated from the released source. Conceptual identity, SHACL checks and evaluation results have their own documented scope.</p></aside>''', "html.parser")
    soup.body.insert(0, banner)
    # WIDOCO omits some bare declarations from its generated presentation.
    # Retain them explicitly without adding unsupported definitions or axioms.
    supplemental = soup.find(id="ontospk-bare-declarations")
    if supplemental:
        supplemental.decompose()
    source_graph = Graph().parse(SOURCE)
    generated_text = str(soup)
    missing = sorted(str(s) for s in source_graph.subjects(RDF.type, OWL.ObjectProperty)
                     if isinstance(s, URIRef) and str(s) not in generated_text)
    if missing:
        section = soup.new_tag("section", id="ontospk-bare-declarations")
        heading = soup.new_tag("h2"); heading.string = "Additional object property declarations"
        section.append(heading)
        for iri in missing:
            p = soup.new_tag("p"); code = soup.new_tag("code"); code.string = iri
            p.append(code)
            p.append(" is declared as an owl:ObjectProperty in the released source. The source supplies no label, definition, domain or range for this declaration. Its use in restrictions is preserved in the downloadable RDF and the exhaustive OWL reference.")
            section.append(p)
        soup.body.append(section)
    # Replace upstream default dates and sample licensing with recorded facts.
    meta = soup.select_one(".head").find("dl")
    meta.clear()
    fields = [
        ("Ontology core", '<a href="'+REPO+'/releases/tag/v2.0.0">v2.0.0</a>'),
        ("Logical profile", "0.43.0"),
        ("Public core release date", "22 October 2026"),
        ("Creator recorded in CITATION.cff", "Araz Saie Arasi"),
        ("Ontology IRI", "<code>urn:productium:specification-profile:</code>"),
        ("Exact semantic source", '<a href="'+REPO+'/blob/v2.0.0/semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl">Released Turtle source</a>'),
        ("Source SHA-256", "<code>"+hashlib.sha256(SOURCE.read_bytes()).hexdigest()+"</code>"),
        ("Download serializations", '<a href="ontology.ttl">Turtle</a> · <a href="ontology.owl">RDF/XML</a> · <a href="ontology.jsonld">JSON-LD</a> · <a href="ontology.nt">N-Triples</a>'),
        ("Reuse", 'No project-wide reuse licence selected. <a href="'+REPO+'/blob/v2.0.0/LICENSING.md">Read the licensing statement</a>.'),
        ("Citation", '<a href="../guide/Citation.html">Cite the exact release and source</a>'),
    ]
    for label, value in fields:
        dt = soup.new_tag("dt"); dt.string = label
        dd = soup.new_tag("dd"); dd.append(BeautifulSoup(value, "html.parser"))
        meta.extend([dt, dd])
    status = soup.select_one(".status span")
    if status:
        status.string = "Ontology core v2.0.0"
    for script in soup.find_all("script", attrs={"type": "application/ld+json"}):
        data = json.loads(script.string)
        data.update({"version": "Ontology core v2.0.0; logical profile 0.43.0", "url": REPO+"/releases/tag/v2.0.0"})
        data.pop("dateReleased", None); data.pop("image", None)
        script.string = json.dumps(data, sort_keys=True)
    for script in soup.find_all('script'):
        if script.string and 'function loadHash()' in script.string:
            script.string = __import__('re').sub(
                r"\tvar hash = location.hash;[\s\S]*?\tloadTOC\(\);",
                "\tvar hash = location.hash.slice(1);\n\tvar target = document.getElementById(hash) || document.getElementById(decodeURIComponent(hash));\n\tif(target) target.scrollIntoView();\n\tloadTOC();",
                str(script.string))
    path.write_text(str(soup), encoding="utf-8")
    for html_path in folder.rglob("*.html"):
        text = html_path.read_text().replace('href="..\\index-en.html"', 'href="../index-en.html"')
        html_path.write_text("\n".join(line.rstrip() for line in text.splitlines())+"\n", encoding="utf-8")
    (folder / ".htaccess").unlink(missing_ok=True)

    # Export the original RDF graph directly. OWL API's reserialization can
    # reorder RDF lists; generated metadata must not replace the released core.
    graph = to_canonical_graph(Graph().parse(SOURCE))
    (folder / "ontology.ttl").write_text(SOURCE.read_text().rstrip()+"\n", encoding="utf-8")
    (folder / "ontology.nt").write_text("\n".join(sorted(graph.serialize(format="nt").splitlines()))+"\n", encoding="utf-8")
    payload = ordered_json(json.loads(graph.serialize(format="json-ld")))
    (folder / "ontology.jsonld").write_text(json.dumps(payload, sort_keys=True, indent=2)+"\n", encoding="utf-8")
    # Flat descriptions avoid RDF/XML serializer choices that depend on graph
    # iteration order (nested resources and tied property element ordering).
    rdf = str(RDF)
    xml = ET.Element('{'+rdf+'}RDF')
    for subject in sorted(set(graph.subjects()), key=lambda v: v.n3()):
        description = ET.SubElement(xml, '{'+rdf+'}Description',
                                    {'{'+rdf+('}nodeID' if isinstance(subject,BNode) else '}about'):str(subject)})
        for predicate, value in sorted(graph.predicate_objects(subject),key=lambda pair:(str(pair[0]),pair[1].n3())):
            namespace,local=split_uri(predicate)
            item=ET.SubElement(description,'{'+namespace+'}'+local)
            if isinstance(value,Literal):
                item.text=str(value)
                if value.language:item.set('{http://www.w3.org/XML/1998/namespace}lang',value.language)
                if value.datatype:item.set('{'+rdf+'}datatype',str(value.datatype))
            else:item.set('{'+rdf+('}nodeID' if isinstance(value,BNode) else '}resource'),str(value))
    (folder / "ontology.owl").write_text(ET.canonicalize(ET.tostring(xml, encoding="unicode"), rewrite_prefixes=True), encoding="utf-8")
    hashes = {}
    for name, fmt in (("ontology.ttl", "turtle"), ("ontology.owl", "xml"), ("ontology.jsonld", "json-ld"), ("ontology.nt", "nt")):
        target = folder / name
        assert isomorphic(graph, Graph().parse(target, format=fmt)), name
        hashes[name] = hashlib.sha256(target.read_bytes()).hexdigest()
    (folder / "serialization-receipt.json").write_text(json.dumps({"source_sha256": hashlib.sha256(SOURCE.read_bytes()).hexdigest(), "rdf_triples": len(graph), "graph_isomorphic_to_core": True, "files": hashes}, indent=2)+"\n")


if __name__ == "__main__":
    finish()
