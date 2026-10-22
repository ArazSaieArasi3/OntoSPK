"""Reject altered frozen routes and mismatched snapshot/source identities."""
import copy
import json
import unittest
from unittest.mock import patch
from build_versioned_site import guard,verify,REGISTRY,SEMANTIC
class PublicationIdentity(unittest.TestCase):
    def test_existing_mapping_is_immutable(self):
        old={'releases':{'v2.0.1':{'source_commit':'a'*40,'docs_tree':'b'*40}}}
        for changed in ({'releases':{}},{'releases':{'v2.0.1':{'source_commit':'c'*40,'docs_tree':'b'*40}}}):
            with self.assertRaises(ValueError):guard(old,changed)
        added=copy.deepcopy(old);added['releases']['v2.0.2']={};guard(old,added)
    def test_changed_docs_tree_is_rejected(self):
        with patch('build_versioned_site.git',return_value=b'b'*40):
            with self.assertRaisesRegex(ValueError,'tree changed'):verify({'source_commit':'a'*40,'docs_tree':'c'*40})
    def test_changed_semantics_is_rejected(self):
        with patch('build_versioned_site.git',side_effect=[b'b'*40,b'changed semantic source']):
            with self.assertRaisesRegex(ValueError,'semantic identity'):verify({'source_commit':'a'*40,'docs_tree':'b'*40})
    def test_registered_snapshot(self):
        for entry in json.loads(REGISTRY.read_text())['releases'].values():verify(entry)
if __name__=='__main__':unittest.main()
