"""Apply reproducible portal links to the generated WIDOCO output."""
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
def finish():
 p=ROOT/'docs/widoco/index-en.html';s=p.read_text()
 s=s.replace('distribution 2.0.0-rc.1 is an unreleased candidate','public distribution 2.0.0 is in preparation').replace('distribution candidate 2.0.0-rc.1','public distribution 2.0.0 in preparation')
 s=__import__('re').sub(r',?\s*"dateReleased":"[^"]*"', '', s)
 if 'id="ontospk-context"' not in s:
  start=s.find('>',s.find('<body'))+1
  banner='<aside id="ontospk-context" style="padding:12px;border-bottom:1px solid #aaa"><a href="../index.html">OntoSPK documentation</a> | <a href="../guide/Formalization.html">Formal interpretation</a> | <a href="../webvowl/index.html#ontospk">WebVOWL</a> | <a href="https://github.com/ArazSaieArasi3/OntoSPK/blob/main/semantic/product/v2/source/t52_formalization_v043/Current_Logical_Profile_v0_43_0.ttl">Source</a><p>Generated OWL lookup for logical profile 0.43.0; public distribution 2.0.0 is in preparation. See the curated guide for constraints and limitations.</p></aside>'
  s=s[:start]+banner+s[start:]
 p.write_text(s)
 for p in (ROOT/'docs/widoco').rglob('*.html'):
  s=p.read_text();s=s.replace('href="..\\index-en.html"','href="../index-en.html"');p.write_text(s)
 (ROOT/'docs/widoco/.htaccess').unlink(missing_ok=True)
if __name__=='__main__':finish()
