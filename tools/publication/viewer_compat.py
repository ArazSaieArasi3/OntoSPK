"""Keep the pinned WebVOWL runtime's required view-mode DOM controls.

The original preset-menu reduction removed #emptyContainer and #empty.
WebVOWL 1.1.7 reads both while initializing view mode, even when editing
is unavailable. Retain inert hidden controls and hide the editing option.
This publication-only adaptation changes no RDF or graph JSON.
"""

def prepare_viewer(text):
    if 'id="empty"' not in text:
        marker='<ul class="toolTipMenu noselect" id="m_select">'
        if text.count(marker)!=1:raise ValueError('Expected one pinned WebVOWL ontology menu')
        control='<li id="emptyContainer" hidden style="display:none"><input id="empty" type="checkbox" disabled aria-label="Unavailable ontology creation control"></li>'
        text=text.replace(marker,marker+control,1)
    text=text.replace('<li class="toggleOption" id="editMode">','<li class="toggleOption" id="editMode" hidden style="display:none">')
    if 'aria-label="Search ontology terms"' not in text:
        text=text.replace('id="search-input-text"','id="search-input-text" aria-label="Search ontology terms"')
    text=text.replace('position:fixed;left:10px;top:6px;z-index:10000;background:white;padding:6px;font:12px/1.4 system-ui,sans-serif;color:#173b54;max-width:75%', 'position:fixed;left:180px;top:6px;z-index:10000;background:white;padding:6px;font:12px/1.4 system-ui,sans-serif;color:#173b54;max-width:calc(100% - 200px)')
    return text


def prepare_explorer(text):
    """Explain the observed upstream collapsing filter beside the graph."""
    if 'id="viewer-filter-instructions"' in text:return text
    marker='<iframe class="explorer-frame"'
    if text.count(marker)!=1:raise ValueError('Expected one embedded viewer')
    note='<p class="note" id="viewer-filter-instructions">WebVOWL may start with an automatic collapsing filter. To inspect every loaded class, open <strong>Filter</strong> and set <strong>Degree of collapsing</strong> to <strong>0</strong>; use <strong>Pause</strong> for steady labels. This changes visible elements, while the ten-property adapter omission register stays the same. The <a href="../reference/search.html">complete term search</a> also works when graph elements are collapsed.</p>'
    return text.replace(marker,note+marker,1)
