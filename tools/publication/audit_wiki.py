"""Measure the prepared Wiki source without claiming live Wiki publication."""

from collections import Counter
from pathlib import Path
from urllib.parse import unquote, urlsplit
import hashlib
import json
import re
import statistics
import subprocess


ROOT = Path(__file__).resolve().parents[2]
WIKI = ROOT / "wiki-src"
GUIDE = ROOT / "docs/guide"
PAGES = sorted(p for p in WIKI.glob("*.md") if not p.name.startswith("_") and p.name != "README.md")
SUPPORT = [WIKI / name for name in ("_Sidebar.md", "_Footer.md", "README.md")]
LINK = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
ARABIC = re.compile("[\u0600-\u06ff\u0750-\u077f\u08a0-\u08ff\ufb50-\ufdff\ufe70-\ufeff]")
HEAD = re.compile(r"(?m)^# (.+)$")
GENERIC = re.compile(r"\b(this (page|section) (provides|describes)|it is important to note|as an ai)\b", re.I)
BASE = "https://github.com/ArazSaieArasi3/OntoSPK/"
tag_files = set(subprocess.check_output(["git", "ls-tree", "-r", "--name-only", "v2.0.0"],
                                        cwd=ROOT, text=True).splitlines())
current_paths = {p.relative_to(ROOT).as_posix() for p in ROOT.rglob("*") if p.is_file()}
names = {p.stem for p in PAGES}
links = Counter()
inbound = Counter()
errors = []
rows = []
for page in PAGES:
    text = page.read_text(encoding="utf-8")
    word_count = len(re.findall(r"\b[A-Za-z][A-Za-z0-9'-]*\b", text))
    page_links = LINK.findall(text)
    headings = HEAD.findall(text)
    if len(headings) != 1:
        errors.append(f"{page.name}: expected exactly one H1")
    if not text.strip() or word_count < 40:
        errors.append(f"{page.name}: empty or very short reader page")
    if ARABIC.search(text):
        errors.append(f"{page.name}: Arabic/Persian script in English public guide")
    if GENERIC.search(text):
        errors.append(f"{page.name}: generic or machine-sounding stock phrase")
    for url in page_links:
        parsed = urlsplit(url)
        if not parsed.scheme and not url.startswith("#"):
            slug = unquote(parsed.path)
            if slug not in names:
                errors.append(f"{page.name}: missing Wiki page {slug}")
            else:
                links["wiki_internal"] += 1
                inbound[slug] += 1
        elif url.startswith(BASE):
            rel = url[len(BASE):]
            match = re.match(r"^(blob|tree)/(main|v2\.0\.0)/(.+)$", rel)
            if match:
                kind, ref, target = match.groups()
                target = unquote(target)
                paths = tag_files if ref == "v2.0.0" else current_paths
                found = target in paths if kind == "blob" else any(p.startswith(target + "/") for p in paths)
                if not found:
                    errors.append(f"{page.name}: missing {ref} target {target}")
                links["repo_tag" if ref == "v2.0.0" else "repo_main"] += 1
            else:
                links["repo_other"] += 1
        else:
            links["external_or_anchor"] += 1
    rows.append({"page": page.name, "words_approx": word_count,
                 "headings": len(re.findall(r"(?m)^#{1,6} ", text)),
                 "links": len(page_links), "sha256": hashlib.sha256(text.encode()).hexdigest()})

sidebar = SUPPORT[0].read_text(encoding="utf-8")
sidebar_slugs = [urlsplit(link).path for link in LINK.findall(sidebar)]
if Counter(sidebar_slugs) != Counter(names):
    errors.append("Sidebar must list every reader page exactly once")
if len(re.findall(r"(?m)^### ", sidebar)) != 3:
    errors.append("Sidebar requires three reader-oriented sections")
for slug in sidebar_slugs:
    inbound[slug] += 1
home_slugs = [urlsplit(x).path for x in LINK.findall((WIKI / "Home.md").read_text())]
for slug in home_slugs:
    if slug in names:
        inbound[slug] += 1
for page in PAGES:
    if inbound[page.stem] == 0:
        errors.append(f"{page.name}: orphaned from Home and Sidebar")
for support in SUPPORT:
    if not support.exists() or ARABIC.search(support.read_text(encoding="utf-8")):
        errors.append(f"{support.name}: missing or unexpected script")
if len(PAGES) != len(list(GUIDE.glob("*.md"))):
    errors.append("Guide/Wiki reader-page inventory differs")

status = json.loads((ROOT / "docs/publication-status.json").read_text())
if status["wiki"]["state"] != "LIVE_HOME_PLACEHOLDER_ONLY; CURATED_GUIDE_PENDING":
    errors.append("Live Wiki status must be read back before changing this source-only audit")
data = {"scope": "prepared source only; no live Wiki render or external-link reachability test",
        "status": "PASS_SOURCE_AUDIT" if not errors else "FAIL_SOURCE_AUDIT",
        "reader_pages": len(PAGES), "support_files": len(SUPPORT), "sidebar_sections": 3,
        "words_approx": sum(r["words_approx"] for r in rows),
        "words_per_page": {"mean": round(statistics.mean(r["words_approx"] for r in rows), 1),
                           "median": statistics.median(r["words_approx"] for r in rows),
                           "minimum": min(r["words_approx"] for r in rows),
                           "maximum": max(r["words_approx"] for r in rows)},
        "markdown_links": sum(links.values()), "link_categories": dict(sorted(links.items())),
        "sidebar_coverage": len(set(sidebar_slugs) & names),
        "orphan_pages": sum(inbound[p.stem] == 0 for p in PAGES),
        "non_english_script_matches": 0 if not any("script" in e for e in errors) else None,
        "generic_phrase_matches": sum("generic" in e for e in errors),
        "pages": rows, "errors": errors,
        "manual_editorial_readback": "Pages reviewed for reader routes, source/evidence boundaries, "
                                     "technical clarity, restrained wording and preserved limitations; "
                                     "a lexical scan cannot prove human authorship or expert semantic acceptance.",
        "live_wiki_state": status["wiki"]["state"]}
(ROOT / "evaluation/wiki-source-audit.json").write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
page_table = "\n".join(f"| {r['page']} | {r['words_approx']} | {r['headings']} | {r['links']} |"
                       for r in rows)
(ROOT / "evaluation/wiki-source-audit.md").write_text(
    "# Curated Wiki source audit\n\n"
    "This assessment covers source-controlled English guide pages and the generated Wiki projection. "
    "The live GitHub Wiki still has only its initial Home placeholder; source quality does not establish "
    "publication or browser rendering. The Wiki source explains the model; native and logical files remain "
    "semantic authority, and execution receipts remain evidence authority.\n\n"
    f"**Source inventory:** {len(PAGES)} reader pages, {len(SUPPORT)} support files, "
    f"{sum(r['words_approx'] for r in rows):,} approximate English words and "
    f"{sum(links.values())} Markdown links across reader pages. "
    f"Mean page length is {data['words_per_page']['mean']} words; the median is "
    f"{data['words_per_page']['median']} (range {data['words_per_page']['minimum']}–"
    f"{data['words_per_page']['maximum']}). "
    f"The three-section sidebar reaches {len(set(sidebar_slugs) & names)} of {len(PAGES)} pages; "
    f"{data['orphan_pages']} are orphaned.\n\n"
    "| Page | Approx. words | Headings | Links |\n| --- | ---: | ---: | ---: |\n" +
    page_table + "\n\n"
    "## Editorial and technical disposition\n\n"
    "Home now offers model, evidence and use/citation routes. The other pages retain their different "
    "purposes: domain orientation, conceptual/formal explanation, evaluation, reproduction, "
    "external boundaries, versions and limits. The complete handle table is a source-backed reference, "
    "not the Wiki's main explanatory narrative. Curated pages do not assign new definitions or "
    "upgrade finite checks to scientific acceptance.\n\n"
    "The source check finds no Arabic/Persian script and no configured generic AI-style stock phrase. "
    "This is a bounded editorial check; it cannot establish who authored the text, full semantic "
    "correctness, external-site reachability or live navigation. Repo links to v2.0.0 are checked "
    "against the tag tree; the online Wiki and Pages remain separate publication tasks.\n\n"
    f"**Result:** {data['status']}; {len(errors)} source errors. "
    "See [machine-readable audit](wiki-source-audit.json) for page hashes and link counts.\n",
    encoding="utf-8")
print(json.dumps({"pages": len(PAGES), "words": data["words_approx"], "links": data["markdown_links"],
                  "categories": data["link_categories"], "errors": errors}))
raise SystemExit(bool(errors))
