"""Authored positive/adverse witnesses for each released SPARQL rule.

These are synthetic tests, not new ontology axioms. Their expected outcomes
come from the stated domain rule; the runner uses the unchanged source query.
"""
from rdflib import Graph

PREFIXES = '''
@prefix u: <urn:ontospk:eval:> .
@prefix p: <urn:productium:specification-profile:> .
@prefix a: <urn:product-ontology:assessment-profile:0.4:> .
@prefix d: <urn:product-ontology:delivery-profile:0.5:> .
@prefix t: <urn:product-ontology:trace-profile:0.6:> .
@prefix q: <urn:ontospk:occurrence-profile:0.41:> .
@prefix c: <urn:product-ontology:event-contract:> .
@prefix r: <urn:product-ontology:relation-profile:0.7:> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
'''

def graph(text):
    return Graph().parse(data=PREFIXES + text.replace('.u:', '. u:'), format='turtle')

def witnesses(name):
    """Return a non-vacuous good case and one or more adverse cases."""
    fixed = {
      'CapabilityBinding': (
        'u:f a:claimRealization u:r; a:claimActualCapability u:cap; a:claimIntendedCapability u:spec; a:claimContext u:ctx. u:ctx a:contextVersion u:v. u:r p:bearsCapability u:cap; p:realizesVersion u:v. u:v p:specifiesCapability u:spec. u:cap p:evaluatedAgainst u:spec.',
        'u:f a:claimActualCapability u:cap.'),
      'RealizationContext': ('u:f a:claimRealization u:r; a:claimContext u:ctx. u:ctx a:contextVersion u:v. u:r p:realizesVersion u:v.', 'u:f a:claimRealization u:r; a:claimContext u:ctx. u:ctx a:contextVersion u:v.'),
      'ScopeContent': ('u:f a:includedStatement u:s.', ''),
      'ScopeCycle': ('u:f a:scopeSupersedes u:older.', 'u:f a:scopeSupersedes u:older. u:older a:scopeSupersedes u:f.'),
      'VersionContext': ('u:f a:claimVersion u:v; a:claimContext u:ctx. u:ctx a:contextVersion u:v.', 'u:f a:claimVersion u:v; a:claimContext u:ctx. u:ctx a:contextVersion u:other.'),
      'ReleaseVersionContext': ('u:f d:releaseStatusVersion u:v. u:release p:reportsStatus u:f. u:v p:r83_plannedForRelease u:release.', 'u:f d:releaseStatusVersion u:v. u:release p:reportsStatus u:f.'),
      'ResultClaimCoherence': ('u:f p:recordsCarrier u:result; p:recordsClaim u:claim. u:result a p:TestResult; p:recordsExecution u:run. u:run d:executionContext u:ctx; d:executionCriterion u:criterion; p:testsRealization u:r. u:claim a:claimContext u:ctx; a:claimCriterion u:criterion; a:claimRealization u:r.', 'u:f p:recordsCarrier u:result; p:recordsClaim u:claim. u:result a p:TestResult; p:recordsExecution u:run. u:run d:executionContext u:ctx; d:executionCriterion u:criterion; p:testsRealization u:r. u:claim a:claimContext u:ctx; a:claimCriterion u:criterion; a:claimRealization u:other.'),
      'ResultTime': ('u:f p:recordsExecution u:run; d:resultRecordedAt "2026-01-02T00:00:00Z"^^xsd:dateTime. u:run d:executionEndedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.', 'u:f p:recordsExecution u:run; d:resultRecordedAt "2026-01-01T00:00:00Z"^^xsd:dateTime. u:run d:executionEndedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.'),
      'ReviewTime': ('u:ref d:referenceReviewFinding u:f; d:referenceRecordedAt "2026-01-02T00:00:00Z"^^xsd:dateTime. u:f d:reviewRecordedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.', 'u:ref d:referenceReviewFinding u:f; d:referenceRecordedAt "2026-01-02T00:00:00Z"^^xsd:dateTime. u:f d:reviewRecordedAt "2026-01-01T00:00:00Z"^^xsd:dateTime.'),
      'RevisionCycle': ('u:f d:referenceSupersedes u:old.', 'u:f d:referenceSupersedes u:old. u:old d:referenceSupersedes u:f.'),
      'RevisionTime': ('u:f d:referenceSupersedes u:old; d:referenceRecordedAt "2026-01-02T00:00:00Z"^^xsd:dateTime. u:old d:referenceRecordedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.', 'u:f d:referenceSupersedes u:old; d:referenceRecordedAt "2026-01-01T00:00:00Z"^^xsd:dateTime. u:old d:referenceRecordedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.'),
      'RunVersionContext': ('u:f p:testsRealization u:r; d:executionContext u:ctx. u:ctx a:contextVersion u:v. u:r p:realizesVersion u:v.', 'u:f p:testsRealization u:r; d:executionContext u:ctx. u:ctx a:contextVersion u:v.'),
      'suite_case_trace': ('u:f p:r147_hasRecordedExecution u:run; p:containsCase u:case. u:run p:executes u:case.', 'u:f p:r147_hasRecordedExecution u:run; p:containsCase u:other. u:run p:executes u:case.'),
      'version_same_product': ('u:f p:r8_supersedes u:old. u:product a p:Product; p:hasVersion u:f,u:old.', 'u:f p:r8_supersedes u:old. u:product a p:Product; p:hasVersion u:f. u:other a p:Product; p:hasVersion u:old.'),
      'HistoricalEvidenceIndexConstraint': ('u:f p:recordedAttributionTo u:claim. u:record a p:EvidenceAttributionRecord; p:recordsCarrier u:f; p:recordsClaim u:claim.', 'u:f p:recordedAttributionTo u:claim. u:record a p:EvidenceAttributionRecord; p:recordsCarrier u:f; p:recordsClaim u:other.'),
      'ProductContextConstraint': ('u:f a:claimProduct u:product; a:claimContext u:ctx. u:ctx a:contextVersion u:v. u:product p:hasVersion u:v.', 'u:f a:claimProduct u:product; a:claimContext u:ctx. u:ctx a:contextVersion u:v.'),
      'ActualTargetBearer': ('u:f t:dependencyActualCapabilityTarget u:cap. u:r a p:ProductRealization; p:bearsCapability u:cap.', 'u:f t:dependencyActualCapabilityTarget u:cap. u:r p:bearsCapability u:cap.'),
      'OrderFlow': ('u:f t:stepPrecedes u:later. u:flow p:r56_specifiesStep u:f,u:later.', 'u:f t:stepPrecedes u:later. u:flow p:r56_specifiesStep u:f. u:other p:r56_specifiesStep u:later.'),
      'ProposalRecordedSubject': ('u:f p:r79_proposesRecordedChange u:change; t:proposalScope u:scope. u:change t:changeScope u:scope.', 'u:f p:r79_proposesRecordedChange u:change; t:proposalScope u:scope. u:change t:changeScope u:other.'),
      'SelectedConsidered': ('u:f t:decisionSelectsSolution u:s; t:decisionConsidersSolution u:s.', 'u:f t:decisionSelectsSolution u:s; t:decisionConsidersSolution u:other.'),
      'SelectionCriterion': ('u:f t:decisionSelectsSolution u:s; p:recordsCriterion u:c.', 'u:f t:decisionSelectsSolution u:s.'),
      'UsabilityConstitutiveAnchor': ('u:f p:r60_reportsOnFlow u:flow.', ''),
      'UsabilityStepFlow': ('u:f t:usabilityStep u:step; p:r60_reportsOnFlow u:flow. u:flow p:r56_specifiesStep u:step.', 'u:f t:usabilityStep u:step; p:r60_reportsOnFlow u:flow. u:other p:r56_specifiesStep u:step.'),
      'An exercised test needs supported participation.': ('u:f q:executionStage "test_exercised"^^xsd:string; q:targetParticipation "supported"^^xsd:string.', 'u:f q:executionStage "test_exercised"^^xsd:string; q:targetParticipation "unestablished"^^xsd:string.'),
      'Code-use sources require a code target.': ('u:f q:codeUseSource "urn:source"; q:executionCode "urn:code".', 'u:f q:codeUseSource "urn:source".'),
      'Known start requires one start; unknown start requires none.': ('u:f q:startTimeKnowledge "known"; q:executionStartedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.', ['u:f q:startTimeKnowledge "known".', 'u:f q:startTimeKnowledge "unknown"; q:executionStartedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.']),
      'Observed start must not follow observed end.': ('u:f q:executionStartedAt "2026-01-02T00:00:00Z"^^xsd:dateTime; d:executionEndedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.', 'u:f q:executionStartedAt "2026-01-03T00:00:00Z"^^xsd:dateTime; d:executionEndedAt "2026-01-02T00:00:00Z"^^xsd:dateTime.'),
      'Setup-only attempts must be aborted and have unestablished target participation.': ('u:f q:executionStage "setup_only"^^xsd:string; q:targetParticipation "unestablished"^^xsd:string. u:r p:recordsExecution u:f; d:resultOutcome "aborted".', ['u:f q:executionStage "setup_only"^^xsd:string; q:targetParticipation "supported"^^xsd:string. u:r p:recordsExecution u:f; d:resultOutcome "aborted".', 'u:f q:executionStage "setup_only"^^xsd:string; q:targetParticipation "unestablished"^^xsd:string. u:r p:recordsExecution u:f; d:resultOutcome "passed".']),
      'Supported participation requires a source; unestablished participation has no positive source.': ('u:f q:targetParticipation "supported"; q:participationSource "urn:source".', ['u:f q:targetParticipation "supported".', 'u:f q:targetParticipation "unestablished"; q:participationSource "urn:source".']),
      'Assessed capability specification must be linked to the version of the tested realization.': ('u:f c:ICREL%3ACP%3AassessesSpecification u:cap; c:ICREL%3ACP%3AtestsRealization u:r. u:r c:ICREL%3ACP%3ArealizesVersion u:v. u:v c:ICREL%3ACP%3AspecifiesCapability u:cap.', 'u:f c:ICREL%3ACP%3AassessesSpecification u:cap; c:ICREL%3ACP%3AtestsRealization u:r. u:r c:ICREL%3ACP%3ArealizesVersion u:v. u:v c:ICREL%3ACP%3AspecifiesCapability u:other.'),
      'Recorded execution must execute a case explicitly contained in the indexing suite.': ('u:f c:REL%3AW2%3A147 u:e; c:REL%3AW2%3A088 u:case. u:e c:REL%3AW2%3A090 u:case.', 'u:f c:REL%3AW2%3A147 u:e; c:REL%3AW2%3A088 u:other. u:e c:REL%3AW2%3A090 u:case.'),
    }
    if name in fixed:
        good, bad = fixed[name]
        return graph(good), [graph(x) for x in (bad if isinstance(bad, list) else [bad])]
    if name in {'authority_changed', 'target_changed'}:
        old, observed = ('canonicalOwner', 'observedAuthority') if name == 'authority_changed' else ('referenceTarget', 'observedTarget')
        common = f'u:f d:reviewReason "{name}". u:ref d:referenceReviewFinding u:f; p:{old} u:old.'
        return graph(common + f'u:f d:{observed} u:new.'), [graph(common), graph(common + f'u:f d:{observed} u:old.')]
    no_self = {'FeatureDependencyNoSelf': 'p:dependsOnEnablerSpecification', 'HypothesisMotivationNoSelf': 'p:motivatesSolutionHypothesis', 'ScenarioRefinementNoSelf': 'p:r87_refinesTestScenario'}
    if name in no_self:
        pred = no_self[name]
        return graph(f'u:f {pred} u:other.'), [graph(f'u:f {pred} u:f.')]
    cycles = {'PlanningAcyclic': 'p:r74_hasPlanningDependency', 'version_acyclic': 'p:r8_supersedes', 'OrderCycle': 't:stepPrecedes'}
    if name in cycles:
        pred = cycles[name]
        return graph(f'u:f {pred} u:other.'), [graph(f'u:f {pred} u:f.'), graph(f'u:f {pred} u:other. u:other {pred} u:f.')]
    if name.startswith('Subset'):
        num = int(name[6:8])
        first, second, inverse = {
          1: ('r:r224_evidencedBy','r:r160_evidencedBy',False),
          2: ('r:r226_evidencedBy','r:r160_evidencedBy',False),
          3: ('p:r92_hasVerificationEvidenceRecord','p:recordsCarrier',True),
          4: ('p:r93_hasValidationEvidenceRecord','p:recordsCarrier',True),
          5: ('p:solutionHypothesizesAboutProblem','p:hypothesizesAboutProblem',False),
          6: ('p:r181_hypothesizesAcquisitionForProblem','p:hypothesizesAboutProblem',False),
          7: ('p:r183_hypothesizesAdoptionForProblem','p:hypothesizesAboutProblem',False),
          8: ('p:r178_referencesMetric','p:r156_referencesMetric',False),
          9: ('p:solutionPredictsOutcome','p:predictsOutcome',False),
        }[num]
        first_triple = f'u:f {first} u:target.'
        correct = f'u:target {second} u:f.' if inverse else f'u:f {second} u:target.'
        return graph(first_triple + correct), [graph(first_triple)]
    if name == 'ROoST candidate requires exercised code and causal evidence.':
        parts = ['q:executionStage "test_exercised"^^xsd:string', 'q:targetParticipation "supported"^^xsd:string', 'q:executionCode "urn:code"', 'q:codeUseSource "urn:source"']
        text = lambda ps: 'u:f q:roostCandidate true; ' + '; '.join(ps) + '.'
        return graph(text(parts)), [graph(text(parts[:i]+parts[i+1:])) for i in range(len(parts))]
    raise AssertionError('No authored witness for ' + name)
