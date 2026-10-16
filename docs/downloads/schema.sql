-- Generated SQLite schema including the bounded admission/occurrence profile.
PRAGMA foreign_keys=ON;
CREATE TABLE admission_receipt(
      snapshot_id TEXT PRIMARY KEY NOT NULL REFERENCES snapshot(snapshot_id),
      profile TEXT NOT NULL, graph_sha256 TEXT NOT NULL, triple_count INTEGER NOT NULL);
CREATE TABLE asserted_type(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,class_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,entity_id,class_id),FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_bundle_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_dependency_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_lifecycle_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_lifecycle_stage_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_offering_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_portfolio_entry(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_product(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_product_portfolio(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_product_status_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d01_product_version(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_decision_criterion_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_decision_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_goal_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_hypothesis_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_initiative_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_opportunity_statement(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_outcome_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_problem_solution_fit_assessment(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_problem_statement(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_product_market_fit_assessment(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_solution_hypothesis_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d02_vision_statement(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_capability_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_condition_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_enabler_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_feature_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_scenario_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_scope_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_solution_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d03_vertical_slice_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_acceptance_criterion_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_constraint_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_functional_requirement_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_quality_requirement_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_requirement_rationale_statement(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_requirement_scenario_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_requirement_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_user_story_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d04_validation_finding_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_information_architecture_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_interaction_step_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_journey_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_journey_stage_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_persona_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_screen_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_touchpoint_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_uistate_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_usability_finding_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_user_flow_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d05_user_role_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_commitment_level_definition(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_confidence_assessment(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_milestone_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_planning_horizon_definition(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_prioritization_criterion_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_priority_assessment(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_roadmap(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_roadmap_entry(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d06_target_window_assignment(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d07_change_proposal_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d07_change_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d07_delivery_status_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d07_delivery_work_item(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d07_delivery_work_item_status_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d07_feature_flag_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d07_release_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d08_test_case(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d08_test_execution(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d08_test_result(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d08_test_scenario(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d08_test_suite_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_acquisition_hypothesis_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_adoption_hypothesis_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_competitive_narrative(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_go_to_market_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_launch_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_marketing_goal_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_messaging_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d09_positioning_statement(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_assessment_claim(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_assessment_context_specification(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_evidence_artifact(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_evidence_attribution_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_finding_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_release_evidence_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_validation_evidence_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d10_verification_evidence_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d11_product_capability(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d11_product_realization(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_business_rule_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_external_reference_record(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_marketing_insight_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_product_family_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_product_line_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_product_metric_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_product_variant_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_requirement_source_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_target_market_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_target_segment_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_task_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE d12_test_data_reference(snapshot_id TEXT NOT NULL,entity_id INTEGER NOT NULL,
 asserted INTEGER NOT NULL CHECK(asserted IN(0,1)),PRIMARY KEY(snapshot_id,entity_id),
 FOREIGN KEY(snapshot_id,entity_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE entity(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),term_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,term_id));
CREATE TABLE historical_binding(
      kind TEXT NOT NULL, iri TEXT NOT NULL, binding TEXT NOT NULL,
      first_snapshot TEXT NOT NULL REFERENCES admission_receipt(snapshot_id),
      PRIMARY KEY(kind,iri));
CREATE TABLE link_acquisition_cites_evidence(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_acquisition_cites_insight(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_adoption_cites_evidence(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_adoption_cites_insight(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_architecture_intended_realized_by_component(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_architecture_intended_realized_by_service(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_architecture_intended_satisfied_by_architecture_element(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_architecture_intended_satisfied_by_interface(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_architecture_intended_supported_by_architecture_element(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_assesses_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_assesses_product(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_assesses_solution(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_assesses_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_bears_capability(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_canonical_owner(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_change_decision(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_change_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_change_scope(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_change_task(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_actual_capability(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_context(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_criterion(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_intended_capability(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_product(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_realization(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_subject(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_claim_version(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_concerns_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_condition_context(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_constrains_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_contains_case(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_contains_product(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_contains_stage(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_context_scenario(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_context_version(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_decision_considers_solution(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_decision_evidence(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_decision_selects_solution(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_defines_lifecycle_stage(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_dependency_actual_capability_target(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_dependency_capability_specification_target(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_dependency_condition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_dependency_external_target(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_dependency_product_target(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_depends_on_enabler_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_evaluated_against(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_executes(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_execution_context(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_execution_criterion(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_exemplified_by_scenario(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_expected_enabled_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_dependency_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_feature_criterion(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_product_status_record(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_proposed_solution(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_scope_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_story_criterion(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_story_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_version(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_has_vision_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_hypothesizes_about_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_implements_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_informs_initiative(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_intended_to_enable_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_intends_capability(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_intends_to_address_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_intends_to_contribute_to_outcome(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_intends_to_support_goal(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_is_carrier_in_record(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_item_status(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_item_status_change(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_item_status_version(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_justifies_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_motivates_goal(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_motivates_hypothesis(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_motivates_solution_hypothesis(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_narrative_cites_evidence(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_narrative_cites_insight(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_offering_of(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_operationalized_by_criterion(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_organizes_entry(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_persona_context(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_predicts_outcome(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_proposal_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_proposal_scope(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_proposes_capability(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_proposes_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r100_uses_positioning_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r101_plans_launch(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r102_targets_marketing_goal(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r103_informs_positioning_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r104_informs_go_to_market_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r105_informs_go_to_market_from_acquisition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r106_informs_go_to_market_from_adoption(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r107_intended_to_support(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r116_references(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r117_tracks_initiative(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r118_tracks_release_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r119_tracks_milestone_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r120_references_product_line(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r121_has_portfolio_confidence_assessment(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r122_targets_persona(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r123_frames_journey(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r125_frames_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r127_tracks_initiative_release_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r133_supported_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r135_records_resolution_change(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r136_includes(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r137_includes_screen(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r138_preceded_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r139_intends_to_support_goal(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r140_plans_entry_release(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r141_milestone_for_release_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r142_groups_planned_initiative(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r143_uses_window_horizon_definition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r144_targets_release_goal(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r145_concerns_delivery_work_item(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r146_specifies_requirement_verification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r147_has_recorded_execution(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r148_references_journey_stage(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r149_targets_launch_persona(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r150_uses_launch_positioning(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r151_uses_launch_messaging(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r154_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r155_addresses(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r156_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r157_evidenced_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r158_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r160_evidenced_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r162_evidenced_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r164_intends_to_address_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r165_specifies_beneficiary_persona(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r166_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r167_supports(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r168_identifies_opportunity(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r169_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r170_identifies_opportunity(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r171_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r172_addresses_problem_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r173_claims_differentiation_through(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r174_targets_message_persona(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r175_references_message_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r176_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r177_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r178_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r179_addresses_narrative_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r180_claims_differentiation_through(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r181_hypothesizes_acquisition_for_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r182_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r183_hypothesizes_adoption_for_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r184_references_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r185_references_value_proposition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r186_targets(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r187_includes_service(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r188_references_variant_configuration(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r189_targets(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r190_references_value_proposition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r192_references(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r194_references_mental_model(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r195_uses_script(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r196_reported_under_test_plan(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r197_cites_execution_script(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r198_cites_supporting_evidence(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r199_references_dataset_configuration(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r200_targets(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r201_targets(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r202_references_value_proposition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r203_targets(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r204_targets(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r207_cites_insight_evidence(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r208_addresses_need(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r209_informed_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r210_assesses_need(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r211_assesses_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r212_intends_to_address_need(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r213_addresses_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r214_describes_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r215_describes_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r216_intends_to_address_need(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r217_describes_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r218_cites_supporting_evidence(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r219_addresses_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r220_addresses_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r221_supported_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r222_differentiates_from(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r223_supported_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r224_evidenced_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r225_addresses_pain(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r226_evidenced_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r22_motivates_opportunity(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r51_describes_user_role(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r52_represented_in_journey(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r54_includes(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r55_described_by_flow(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r56_specifies_step(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r57_references_screen(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r58_organizes_screen_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r59_defines_uistate(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r60_reports_on_flow(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r61_reports_on_screen(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r63_supported_by(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r64_organizes_roadmap_entry(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r65_plans_initiative(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r66_plans_feature_delivery(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r67_targets_milestone(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r68_has_priority_assessment(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r69_uses_ranking_criterion(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r70_uses_horizon_definition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r71_has_target_window_assignment(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r72_has_entry_confidence_assessment(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r73_uses_commitment_level_definition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r74_has_planning_dependency(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r75_plans_delivery_item(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r76_references_change_record(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r78_has_release_evidence_record(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r79_proposes_recorded_change(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r80_plans_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r81_intended_to_contribute_to_work(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r82_specifies_feature_activation_control(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r83_planned_for_release(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r84_covers(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r85_specifies_requirement_verification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r86_specifies_criterion_verification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r87_refines_test_scenario(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r89_references_test_data(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r8_supersedes(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r92_has_verification_evidence_record(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r93_has_validation_evidence_record(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r94_has_positioning_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r95_positioned_by_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r96_references_target_market(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r97_references_target_segment(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r98_references_competitive_narrative(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_r99_expresses_positioning(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_realizes_version(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_recorded_attribution_to(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_records_affected_initiative(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_records_carrier(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_records_claim(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_records_criterion(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_records_execution(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_reference_context(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_reference_provenance(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_reference_review_finding(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_reference_supersedes(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_reference_target(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_references_offering(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_references_product(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_references_product_family(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_references_product_line(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_references_product_variant(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_references_rule_for_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_refined_by_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_release_status_change(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_release_status_version(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_reports_status(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_represented_by_story(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_scenario_context(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_scope_change_record(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_scope_supersedes(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_solution_hypothesizes_about_problem(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_solution_predicts_outcome(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_sources_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specification_provenance(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specified_by_requirement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specified_through_feature(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specifies_capability(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specifies_expected_condition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specifies_outcome_metric(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specifies_persona_context(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_specifies_slice(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_step_precedes(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_targets_outcome(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_targets_outcome_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_tests_realization(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_information_architecture(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_journey(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_journey_stage(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_persona(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_step(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_touchpoint(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_uistate(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_usability_user_role(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_uses_lifecycle_specification(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE link_version_scope(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 ,FOREIGN KEY(snapshot_id,object_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE occurrence_observation(
  observation_id TEXT PRIMARY KEY,event_iri TEXT NOT NULL,field TEXT NOT NULL,
  assertion TEXT NOT NULL,source TEXT NOT NULL,recorded_at TEXT NOT NULL,
  supersedes TEXT REFERENCES occurrence_observation(observation_id));
CREATE TABLE profile041_value_0(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_1(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_2(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_3(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_4(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_5(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_6(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_7(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE profile041_value_8(snapshot_id TEXT NOT NULL REFERENCES snapshot(snapshot_id),subject_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),PRIMARY KEY(snapshot_id,subject_id,object_id));
CREATE TABLE residual_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,predicate_id INTEGER NOT NULL REFERENCES term(term_id),object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,predicate_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id));
CREATE TABLE snapshot(snapshot_id TEXT PRIMARY KEY, source_path TEXT NOT NULL, source_sha256 TEXT NOT NULL,
 status TEXT NOT NULL DEFAULT 'draft' CHECK(status='draft'));
CREATE TABLE term(term_id INTEGER PRIMARY KEY,kind TEXT NOT NULL CHECK(kind IN ('IRI','BNODE','LITERAL')),
 lexical TEXT NOT NULL,datatype TEXT NOT NULL DEFAULT '',language TEXT NOT NULL DEFAULT '',blank_scope TEXT NOT NULL DEFAULT '',
 CHECK(kind='LITERAL' OR (datatype='' AND language='')),
 CHECK((kind='BNODE' AND blank_scope<>'') OR (kind<>'BNODE' AND blank_scope='')),
 CHECK(language='' OR datatype IN ('','http://www.w3.org/1999/02/22-rdf-syntax-ns#langString')),
 UNIQUE(kind,lexical,datatype,language,blank_scope));
CREATE TABLE value_attribution_agent(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_attribution_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_attribution_stance(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_attribution_timestamp(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_change_occurrence_reference(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_change_recorded_at(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_change_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_change_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_claim_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_condition_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_context_description(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_context_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_decision_rationale(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_decision_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_deferred_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_dependency_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_excluded_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_execution_ended_at(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_finding_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_finding_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_included_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_item_status_code(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_item_status_reported_at(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_item_status_scheme(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_item_status_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_observed_authority(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_observed_target(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_persona_description(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_proposal_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_proposal_statement(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_reference_purpose(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_reference_recorded_at(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_reference_revision_label(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_release_status_code(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_release_status_reported_at(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_release_status_scheme(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_release_status_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_result_outcome(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_result_recorded_at(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_result_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_review_reason(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_review_recorded_at(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_scenario_actions(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_scenario_precondition(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_scope_source(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE TABLE value_usability_recommendation(snapshot_id TEXT NOT NULL,subject_id INTEGER NOT NULL,object_id INTEGER NOT NULL REFERENCES term(term_id),
 PRIMARY KEY(snapshot_id,subject_id,object_id),FOREIGN KEY(snapshot_id,subject_id) REFERENCES entity(snapshot_id,term_id)
 );
CREATE INDEX link_acquisition_cites_evidence_inverse ON link_acquisition_cites_evidence(snapshot_id,object_id,subject_id);
CREATE INDEX link_acquisition_cites_insight_inverse ON link_acquisition_cites_insight(snapshot_id,object_id,subject_id);
CREATE INDEX link_adoption_cites_evidence_inverse ON link_adoption_cites_evidence(snapshot_id,object_id,subject_id);
CREATE INDEX link_adoption_cites_insight_inverse ON link_adoption_cites_insight(snapshot_id,object_id,subject_id);
CREATE INDEX link_architecture_intended_realized_by_component_inverse ON link_architecture_intended_realized_by_component(snapshot_id,object_id,subject_id);
CREATE INDEX link_architecture_intended_realized_by_service_inverse ON link_architecture_intended_realized_by_service(snapshot_id,object_id,subject_id);
CREATE INDEX link_architecture_intended_satisfied_by_architecture_element_inverse ON link_architecture_intended_satisfied_by_architecture_element(snapshot_id,object_id,subject_id);
CREATE INDEX link_architecture_intended_satisfied_by_interface_inverse ON link_architecture_intended_satisfied_by_interface(snapshot_id,object_id,subject_id);
CREATE INDEX link_architecture_intended_supported_by_architecture_element_inverse ON link_architecture_intended_supported_by_architecture_element(snapshot_id,object_id,subject_id);
CREATE INDEX link_assesses_problem_inverse ON link_assesses_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_assesses_product_inverse ON link_assesses_product(snapshot_id,object_id,subject_id);
CREATE INDEX link_assesses_solution_inverse ON link_assesses_solution(snapshot_id,object_id,subject_id);
CREATE INDEX link_assesses_specification_inverse ON link_assesses_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_bears_capability_inverse ON link_bears_capability(snapshot_id,object_id,subject_id);
CREATE INDEX link_canonical_owner_inverse ON link_canonical_owner(snapshot_id,object_id,subject_id);
CREATE INDEX link_change_decision_inverse ON link_change_decision(snapshot_id,object_id,subject_id);
CREATE INDEX link_change_feature_inverse ON link_change_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_change_scope_inverse ON link_change_scope(snapshot_id,object_id,subject_id);
CREATE INDEX link_change_task_inverse ON link_change_task(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_actual_capability_inverse ON link_claim_actual_capability(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_context_inverse ON link_claim_context(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_criterion_inverse ON link_claim_criterion(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_intended_capability_inverse ON link_claim_intended_capability(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_product_inverse ON link_claim_product(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_realization_inverse ON link_claim_realization(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_requirement_inverse ON link_claim_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_subject_inverse ON link_claim_subject(snapshot_id,object_id,subject_id);
CREATE INDEX link_claim_version_inverse ON link_claim_version(snapshot_id,object_id,subject_id);
CREATE INDEX link_concerns_requirement_inverse ON link_concerns_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_condition_context_inverse ON link_condition_context(snapshot_id,object_id,subject_id);
CREATE INDEX link_constrains_requirement_inverse ON link_constrains_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_contains_case_inverse ON link_contains_case(snapshot_id,object_id,subject_id);
CREATE INDEX link_contains_product_inverse ON link_contains_product(snapshot_id,object_id,subject_id);
CREATE INDEX link_contains_stage_inverse ON link_contains_stage(snapshot_id,object_id,subject_id);
CREATE INDEX link_context_scenario_inverse ON link_context_scenario(snapshot_id,object_id,subject_id);
CREATE INDEX link_context_version_inverse ON link_context_version(snapshot_id,object_id,subject_id);
CREATE INDEX link_decision_considers_solution_inverse ON link_decision_considers_solution(snapshot_id,object_id,subject_id);
CREATE INDEX link_decision_evidence_inverse ON link_decision_evidence(snapshot_id,object_id,subject_id);
CREATE INDEX link_decision_selects_solution_inverse ON link_decision_selects_solution(snapshot_id,object_id,subject_id);
CREATE INDEX link_defines_lifecycle_stage_inverse ON link_defines_lifecycle_stage(snapshot_id,object_id,subject_id);
CREATE INDEX link_dependency_actual_capability_target_inverse ON link_dependency_actual_capability_target(snapshot_id,object_id,subject_id);
CREATE INDEX link_dependency_capability_specification_target_inverse ON link_dependency_capability_specification_target(snapshot_id,object_id,subject_id);
CREATE INDEX link_dependency_condition_inverse ON link_dependency_condition(snapshot_id,object_id,subject_id);
CREATE INDEX link_dependency_external_target_inverse ON link_dependency_external_target(snapshot_id,object_id,subject_id);
CREATE INDEX link_dependency_product_target_inverse ON link_dependency_product_target(snapshot_id,object_id,subject_id);
CREATE INDEX link_depends_on_enabler_specification_inverse ON link_depends_on_enabler_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_evaluated_against_inverse ON link_evaluated_against(snapshot_id,object_id,subject_id);
CREATE INDEX link_executes_inverse ON link_executes(snapshot_id,object_id,subject_id);
CREATE INDEX link_execution_context_inverse ON link_execution_context(snapshot_id,object_id,subject_id);
CREATE INDEX link_execution_criterion_inverse ON link_execution_criterion(snapshot_id,object_id,subject_id);
CREATE INDEX link_exemplified_by_scenario_inverse ON link_exemplified_by_scenario(snapshot_id,object_id,subject_id);
CREATE INDEX link_expected_enabled_by_inverse ON link_expected_enabled_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_dependency_specification_inverse ON link_has_dependency_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_feature_criterion_inverse ON link_has_feature_criterion(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_product_status_record_inverse ON link_has_product_status_record(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_proposed_solution_inverse ON link_has_proposed_solution(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_scope_specification_inverse ON link_has_scope_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_story_criterion_inverse ON link_has_story_criterion(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_story_specification_inverse ON link_has_story_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_version_inverse ON link_has_version(snapshot_id,object_id,subject_id);
CREATE INDEX link_has_vision_statement_inverse ON link_has_vision_statement(snapshot_id,object_id,subject_id);
CREATE INDEX link_hypothesizes_about_problem_inverse ON link_hypothesizes_about_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_implements_feature_inverse ON link_implements_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_informs_initiative_inverse ON link_informs_initiative(snapshot_id,object_id,subject_id);
CREATE INDEX link_intended_to_enable_feature_inverse ON link_intended_to_enable_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_intends_capability_inverse ON link_intends_capability(snapshot_id,object_id,subject_id);
CREATE INDEX link_intends_to_address_problem_inverse ON link_intends_to_address_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_intends_to_contribute_to_outcome_inverse ON link_intends_to_contribute_to_outcome(snapshot_id,object_id,subject_id);
CREATE INDEX link_intends_to_support_goal_inverse ON link_intends_to_support_goal(snapshot_id,object_id,subject_id);
CREATE INDEX link_is_carrier_in_record_inverse ON link_is_carrier_in_record(snapshot_id,object_id,subject_id);
CREATE INDEX link_item_status_change_inverse ON link_item_status_change(snapshot_id,object_id,subject_id);
CREATE INDEX link_item_status_inverse ON link_item_status(snapshot_id,object_id,subject_id);
CREATE INDEX link_item_status_version_inverse ON link_item_status_version(snapshot_id,object_id,subject_id);
CREATE INDEX link_justifies_requirement_inverse ON link_justifies_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_motivates_goal_inverse ON link_motivates_goal(snapshot_id,object_id,subject_id);
CREATE INDEX link_motivates_hypothesis_inverse ON link_motivates_hypothesis(snapshot_id,object_id,subject_id);
CREATE INDEX link_motivates_solution_hypothesis_inverse ON link_motivates_solution_hypothesis(snapshot_id,object_id,subject_id);
CREATE INDEX link_narrative_cites_evidence_inverse ON link_narrative_cites_evidence(snapshot_id,object_id,subject_id);
CREATE INDEX link_narrative_cites_insight_inverse ON link_narrative_cites_insight(snapshot_id,object_id,subject_id);
CREATE INDEX link_offering_of_inverse ON link_offering_of(snapshot_id,object_id,subject_id);
CREATE INDEX link_operationalized_by_criterion_inverse ON link_operationalized_by_criterion(snapshot_id,object_id,subject_id);
CREATE INDEX link_organizes_entry_inverse ON link_organizes_entry(snapshot_id,object_id,subject_id);
CREATE INDEX link_persona_context_inverse ON link_persona_context(snapshot_id,object_id,subject_id);
CREATE INDEX link_predicts_outcome_inverse ON link_predicts_outcome(snapshot_id,object_id,subject_id);
CREATE INDEX link_proposal_feature_inverse ON link_proposal_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_proposal_scope_inverse ON link_proposal_scope(snapshot_id,object_id,subject_id);
CREATE INDEX link_proposes_capability_inverse ON link_proposes_capability(snapshot_id,object_id,subject_id);
CREATE INDEX link_proposes_feature_inverse ON link_proposes_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_r100_uses_positioning_statement_inverse ON link_r100_uses_positioning_statement(snapshot_id,object_id,subject_id);
CREATE INDEX link_r101_plans_launch_inverse ON link_r101_plans_launch(snapshot_id,object_id,subject_id);
CREATE INDEX link_r102_targets_marketing_goal_inverse ON link_r102_targets_marketing_goal(snapshot_id,object_id,subject_id);
CREATE INDEX link_r103_informs_positioning_statement_inverse ON link_r103_informs_positioning_statement(snapshot_id,object_id,subject_id);
CREATE INDEX link_r104_informs_go_to_market_specification_inverse ON link_r104_informs_go_to_market_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r105_informs_go_to_market_from_acquisition_inverse ON link_r105_informs_go_to_market_from_acquisition(snapshot_id,object_id,subject_id);
CREATE INDEX link_r106_informs_go_to_market_from_adoption_inverse ON link_r106_informs_go_to_market_from_adoption(snapshot_id,object_id,subject_id);
CREATE INDEX link_r107_intended_to_support_inverse ON link_r107_intended_to_support(snapshot_id,object_id,subject_id);
CREATE INDEX link_r116_references_inverse ON link_r116_references(snapshot_id,object_id,subject_id);
CREATE INDEX link_r117_tracks_initiative_inverse ON link_r117_tracks_initiative(snapshot_id,object_id,subject_id);
CREATE INDEX link_r118_tracks_release_specification_inverse ON link_r118_tracks_release_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r119_tracks_milestone_specification_inverse ON link_r119_tracks_milestone_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r120_references_product_line_inverse ON link_r120_references_product_line(snapshot_id,object_id,subject_id);
CREATE INDEX link_r121_has_portfolio_confidence_assessment_inverse ON link_r121_has_portfolio_confidence_assessment(snapshot_id,object_id,subject_id);
CREATE INDEX link_r122_targets_persona_inverse ON link_r122_targets_persona(snapshot_id,object_id,subject_id);
CREATE INDEX link_r123_frames_journey_inverse ON link_r123_frames_journey(snapshot_id,object_id,subject_id);
CREATE INDEX link_r125_frames_feature_inverse ON link_r125_frames_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_r127_tracks_initiative_release_specification_inverse ON link_r127_tracks_initiative_release_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r133_supported_by_inverse ON link_r133_supported_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r135_records_resolution_change_inverse ON link_r135_records_resolution_change(snapshot_id,object_id,subject_id);
CREATE INDEX link_r136_includes_inverse ON link_r136_includes(snapshot_id,object_id,subject_id);
CREATE INDEX link_r137_includes_screen_inverse ON link_r137_includes_screen(snapshot_id,object_id,subject_id);
CREATE INDEX link_r138_preceded_by_inverse ON link_r138_preceded_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r139_intends_to_support_goal_inverse ON link_r139_intends_to_support_goal(snapshot_id,object_id,subject_id);
CREATE INDEX link_r140_plans_entry_release_inverse ON link_r140_plans_entry_release(snapshot_id,object_id,subject_id);
CREATE INDEX link_r141_milestone_for_release_specification_inverse ON link_r141_milestone_for_release_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r142_groups_planned_initiative_inverse ON link_r142_groups_planned_initiative(snapshot_id,object_id,subject_id);
CREATE INDEX link_r143_uses_window_horizon_definition_inverse ON link_r143_uses_window_horizon_definition(snapshot_id,object_id,subject_id);
CREATE INDEX link_r144_targets_release_goal_inverse ON link_r144_targets_release_goal(snapshot_id,object_id,subject_id);
CREATE INDEX link_r145_concerns_delivery_work_item_inverse ON link_r145_concerns_delivery_work_item(snapshot_id,object_id,subject_id);
CREATE INDEX link_r146_specifies_requirement_verification_inverse ON link_r146_specifies_requirement_verification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r147_has_recorded_execution_inverse ON link_r147_has_recorded_execution(snapshot_id,object_id,subject_id);
CREATE INDEX link_r148_references_journey_stage_inverse ON link_r148_references_journey_stage(snapshot_id,object_id,subject_id);
CREATE INDEX link_r149_targets_launch_persona_inverse ON link_r149_targets_launch_persona(snapshot_id,object_id,subject_id);
CREATE INDEX link_r150_uses_launch_positioning_inverse ON link_r150_uses_launch_positioning(snapshot_id,object_id,subject_id);
CREATE INDEX link_r151_uses_launch_messaging_inverse ON link_r151_uses_launch_messaging(snapshot_id,object_id,subject_id);
CREATE INDEX link_r154_references_metric_inverse ON link_r154_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r155_addresses_inverse ON link_r155_addresses(snapshot_id,object_id,subject_id);
CREATE INDEX link_r156_references_metric_inverse ON link_r156_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r157_evidenced_by_inverse ON link_r157_evidenced_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r158_references_metric_inverse ON link_r158_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r160_evidenced_by_inverse ON link_r160_evidenced_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r162_evidenced_by_inverse ON link_r162_evidenced_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r164_intends_to_address_problem_inverse ON link_r164_intends_to_address_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_r165_specifies_beneficiary_persona_inverse ON link_r165_specifies_beneficiary_persona(snapshot_id,object_id,subject_id);
CREATE INDEX link_r166_references_metric_inverse ON link_r166_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r167_supports_inverse ON link_r167_supports(snapshot_id,object_id,subject_id);
CREATE INDEX link_r168_identifies_opportunity_inverse ON link_r168_identifies_opportunity(snapshot_id,object_id,subject_id);
CREATE INDEX link_r169_references_metric_inverse ON link_r169_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r170_identifies_opportunity_inverse ON link_r170_identifies_opportunity(snapshot_id,object_id,subject_id);
CREATE INDEX link_r171_references_metric_inverse ON link_r171_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r172_addresses_problem_statement_inverse ON link_r172_addresses_problem_statement(snapshot_id,object_id,subject_id);
CREATE INDEX link_r173_claims_differentiation_through_inverse ON link_r173_claims_differentiation_through(snapshot_id,object_id,subject_id);
CREATE INDEX link_r174_targets_message_persona_inverse ON link_r174_targets_message_persona(snapshot_id,object_id,subject_id);
CREATE INDEX link_r175_references_message_feature_inverse ON link_r175_references_message_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_r176_references_metric_inverse ON link_r176_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r177_references_metric_inverse ON link_r177_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r178_references_metric_inverse ON link_r178_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r179_addresses_narrative_problem_inverse ON link_r179_addresses_narrative_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_r180_claims_differentiation_through_inverse ON link_r180_claims_differentiation_through(snapshot_id,object_id,subject_id);
CREATE INDEX link_r181_hypothesizes_acquisition_for_problem_inverse ON link_r181_hypothesizes_acquisition_for_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_r182_references_metric_inverse ON link_r182_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r183_hypothesizes_adoption_for_problem_inverse ON link_r183_hypothesizes_adoption_for_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_r184_references_metric_inverse ON link_r184_references_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_r185_references_value_proposition_inverse ON link_r185_references_value_proposition(snapshot_id,object_id,subject_id);
CREATE INDEX link_r186_targets_inverse ON link_r186_targets(snapshot_id,object_id,subject_id);
CREATE INDEX link_r187_includes_service_inverse ON link_r187_includes_service(snapshot_id,object_id,subject_id);
CREATE INDEX link_r188_references_variant_configuration_inverse ON link_r188_references_variant_configuration(snapshot_id,object_id,subject_id);
CREATE INDEX link_r189_targets_inverse ON link_r189_targets(snapshot_id,object_id,subject_id);
CREATE INDEX link_r190_references_value_proposition_inverse ON link_r190_references_value_proposition(snapshot_id,object_id,subject_id);
CREATE INDEX link_r192_references_inverse ON link_r192_references(snapshot_id,object_id,subject_id);
CREATE INDEX link_r194_references_mental_model_inverse ON link_r194_references_mental_model(snapshot_id,object_id,subject_id);
CREATE INDEX link_r195_uses_script_inverse ON link_r195_uses_script(snapshot_id,object_id,subject_id);
CREATE INDEX link_r196_reported_under_test_plan_inverse ON link_r196_reported_under_test_plan(snapshot_id,object_id,subject_id);
CREATE INDEX link_r197_cites_execution_script_inverse ON link_r197_cites_execution_script(snapshot_id,object_id,subject_id);
CREATE INDEX link_r198_cites_supporting_evidence_inverse ON link_r198_cites_supporting_evidence(snapshot_id,object_id,subject_id);
CREATE INDEX link_r199_references_dataset_configuration_inverse ON link_r199_references_dataset_configuration(snapshot_id,object_id,subject_id);
CREATE INDEX link_r200_targets_inverse ON link_r200_targets(snapshot_id,object_id,subject_id);
CREATE INDEX link_r201_targets_inverse ON link_r201_targets(snapshot_id,object_id,subject_id);
CREATE INDEX link_r202_references_value_proposition_inverse ON link_r202_references_value_proposition(snapshot_id,object_id,subject_id);
CREATE INDEX link_r203_targets_inverse ON link_r203_targets(snapshot_id,object_id,subject_id);
CREATE INDEX link_r204_targets_inverse ON link_r204_targets(snapshot_id,object_id,subject_id);
CREATE INDEX link_r207_cites_insight_evidence_inverse ON link_r207_cites_insight_evidence(snapshot_id,object_id,subject_id);
CREATE INDEX link_r208_addresses_need_inverse ON link_r208_addresses_need(snapshot_id,object_id,subject_id);
CREATE INDEX link_r209_informed_by_inverse ON link_r209_informed_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r210_assesses_need_inverse ON link_r210_assesses_need(snapshot_id,object_id,subject_id);
CREATE INDEX link_r211_assesses_pain_inverse ON link_r211_assesses_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r212_intends_to_address_need_inverse ON link_r212_intends_to_address_need(snapshot_id,object_id,subject_id);
CREATE INDEX link_r213_addresses_pain_inverse ON link_r213_addresses_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r214_describes_pain_inverse ON link_r214_describes_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r215_describes_pain_inverse ON link_r215_describes_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r216_intends_to_address_need_inverse ON link_r216_intends_to_address_need(snapshot_id,object_id,subject_id);
CREATE INDEX link_r217_describes_pain_inverse ON link_r217_describes_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r218_cites_supporting_evidence_inverse ON link_r218_cites_supporting_evidence(snapshot_id,object_id,subject_id);
CREATE INDEX link_r219_addresses_pain_inverse ON link_r219_addresses_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r220_addresses_pain_inverse ON link_r220_addresses_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r221_supported_by_inverse ON link_r221_supported_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r222_differentiates_from_inverse ON link_r222_differentiates_from(snapshot_id,object_id,subject_id);
CREATE INDEX link_r223_supported_by_inverse ON link_r223_supported_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r224_evidenced_by_inverse ON link_r224_evidenced_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r225_addresses_pain_inverse ON link_r225_addresses_pain(snapshot_id,object_id,subject_id);
CREATE INDEX link_r226_evidenced_by_inverse ON link_r226_evidenced_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r22_motivates_opportunity_inverse ON link_r22_motivates_opportunity(snapshot_id,object_id,subject_id);
CREATE INDEX link_r51_describes_user_role_inverse ON link_r51_describes_user_role(snapshot_id,object_id,subject_id);
CREATE INDEX link_r52_represented_in_journey_inverse ON link_r52_represented_in_journey(snapshot_id,object_id,subject_id);
CREATE INDEX link_r54_includes_inverse ON link_r54_includes(snapshot_id,object_id,subject_id);
CREATE INDEX link_r55_described_by_flow_inverse ON link_r55_described_by_flow(snapshot_id,object_id,subject_id);
CREATE INDEX link_r56_specifies_step_inverse ON link_r56_specifies_step(snapshot_id,object_id,subject_id);
CREATE INDEX link_r57_references_screen_inverse ON link_r57_references_screen(snapshot_id,object_id,subject_id);
CREATE INDEX link_r58_organizes_screen_specification_inverse ON link_r58_organizes_screen_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r59_defines_uistate_inverse ON link_r59_defines_uistate(snapshot_id,object_id,subject_id);
CREATE INDEX link_r60_reports_on_flow_inverse ON link_r60_reports_on_flow(snapshot_id,object_id,subject_id);
CREATE INDEX link_r61_reports_on_screen_inverse ON link_r61_reports_on_screen(snapshot_id,object_id,subject_id);
CREATE INDEX link_r63_supported_by_inverse ON link_r63_supported_by(snapshot_id,object_id,subject_id);
CREATE INDEX link_r64_organizes_roadmap_entry_inverse ON link_r64_organizes_roadmap_entry(snapshot_id,object_id,subject_id);
CREATE INDEX link_r65_plans_initiative_inverse ON link_r65_plans_initiative(snapshot_id,object_id,subject_id);
CREATE INDEX link_r66_plans_feature_delivery_inverse ON link_r66_plans_feature_delivery(snapshot_id,object_id,subject_id);
CREATE INDEX link_r67_targets_milestone_inverse ON link_r67_targets_milestone(snapshot_id,object_id,subject_id);
CREATE INDEX link_r68_has_priority_assessment_inverse ON link_r68_has_priority_assessment(snapshot_id,object_id,subject_id);
CREATE INDEX link_r69_uses_ranking_criterion_inverse ON link_r69_uses_ranking_criterion(snapshot_id,object_id,subject_id);
CREATE INDEX link_r70_uses_horizon_definition_inverse ON link_r70_uses_horizon_definition(snapshot_id,object_id,subject_id);
CREATE INDEX link_r71_has_target_window_assignment_inverse ON link_r71_has_target_window_assignment(snapshot_id,object_id,subject_id);
CREATE INDEX link_r72_has_entry_confidence_assessment_inverse ON link_r72_has_entry_confidence_assessment(snapshot_id,object_id,subject_id);
CREATE INDEX link_r73_uses_commitment_level_definition_inverse ON link_r73_uses_commitment_level_definition(snapshot_id,object_id,subject_id);
CREATE INDEX link_r74_has_planning_dependency_inverse ON link_r74_has_planning_dependency(snapshot_id,object_id,subject_id);
CREATE INDEX link_r75_plans_delivery_item_inverse ON link_r75_plans_delivery_item(snapshot_id,object_id,subject_id);
CREATE INDEX link_r76_references_change_record_inverse ON link_r76_references_change_record(snapshot_id,object_id,subject_id);
CREATE INDEX link_r78_has_release_evidence_record_inverse ON link_r78_has_release_evidence_record(snapshot_id,object_id,subject_id);
CREATE INDEX link_r79_proposes_recorded_change_inverse ON link_r79_proposes_recorded_change(snapshot_id,object_id,subject_id);
CREATE INDEX link_r80_plans_feature_inverse ON link_r80_plans_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_r81_intended_to_contribute_to_work_inverse ON link_r81_intended_to_contribute_to_work(snapshot_id,object_id,subject_id);
CREATE INDEX link_r82_specifies_feature_activation_control_inverse ON link_r82_specifies_feature_activation_control(snapshot_id,object_id,subject_id);
CREATE INDEX link_r83_planned_for_release_inverse ON link_r83_planned_for_release(snapshot_id,object_id,subject_id);
CREATE INDEX link_r84_covers_inverse ON link_r84_covers(snapshot_id,object_id,subject_id);
CREATE INDEX link_r85_specifies_requirement_verification_inverse ON link_r85_specifies_requirement_verification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r86_specifies_criterion_verification_inverse ON link_r86_specifies_criterion_verification(snapshot_id,object_id,subject_id);
CREATE INDEX link_r87_refines_test_scenario_inverse ON link_r87_refines_test_scenario(snapshot_id,object_id,subject_id);
CREATE INDEX link_r89_references_test_data_inverse ON link_r89_references_test_data(snapshot_id,object_id,subject_id);
CREATE INDEX link_r8_supersedes_inverse ON link_r8_supersedes(snapshot_id,object_id,subject_id);
CREATE INDEX link_r92_has_verification_evidence_record_inverse ON link_r92_has_verification_evidence_record(snapshot_id,object_id,subject_id);
CREATE INDEX link_r93_has_validation_evidence_record_inverse ON link_r93_has_validation_evidence_record(snapshot_id,object_id,subject_id);
CREATE INDEX link_r94_has_positioning_statement_inverse ON link_r94_has_positioning_statement(snapshot_id,object_id,subject_id);
CREATE INDEX link_r95_positioned_by_statement_inverse ON link_r95_positioned_by_statement(snapshot_id,object_id,subject_id);
CREATE INDEX link_r96_references_target_market_inverse ON link_r96_references_target_market(snapshot_id,object_id,subject_id);
CREATE INDEX link_r97_references_target_segment_inverse ON link_r97_references_target_segment(snapshot_id,object_id,subject_id);
CREATE INDEX link_r98_references_competitive_narrative_inverse ON link_r98_references_competitive_narrative(snapshot_id,object_id,subject_id);
CREATE INDEX link_r99_expresses_positioning_inverse ON link_r99_expresses_positioning(snapshot_id,object_id,subject_id);
CREATE INDEX link_realizes_version_inverse ON link_realizes_version(snapshot_id,object_id,subject_id);
CREATE INDEX link_recorded_attribution_to_inverse ON link_recorded_attribution_to(snapshot_id,object_id,subject_id);
CREATE INDEX link_records_affected_initiative_inverse ON link_records_affected_initiative(snapshot_id,object_id,subject_id);
CREATE INDEX link_records_carrier_inverse ON link_records_carrier(snapshot_id,object_id,subject_id);
CREATE INDEX link_records_claim_inverse ON link_records_claim(snapshot_id,object_id,subject_id);
CREATE INDEX link_records_criterion_inverse ON link_records_criterion(snapshot_id,object_id,subject_id);
CREATE INDEX link_records_execution_inverse ON link_records_execution(snapshot_id,object_id,subject_id);
CREATE INDEX link_reference_context_inverse ON link_reference_context(snapshot_id,object_id,subject_id);
CREATE INDEX link_reference_provenance_inverse ON link_reference_provenance(snapshot_id,object_id,subject_id);
CREATE INDEX link_reference_review_finding_inverse ON link_reference_review_finding(snapshot_id,object_id,subject_id);
CREATE INDEX link_reference_supersedes_inverse ON link_reference_supersedes(snapshot_id,object_id,subject_id);
CREATE INDEX link_reference_target_inverse ON link_reference_target(snapshot_id,object_id,subject_id);
CREATE INDEX link_references_offering_inverse ON link_references_offering(snapshot_id,object_id,subject_id);
CREATE INDEX link_references_product_family_inverse ON link_references_product_family(snapshot_id,object_id,subject_id);
CREATE INDEX link_references_product_inverse ON link_references_product(snapshot_id,object_id,subject_id);
CREATE INDEX link_references_product_line_inverse ON link_references_product_line(snapshot_id,object_id,subject_id);
CREATE INDEX link_references_product_variant_inverse ON link_references_product_variant(snapshot_id,object_id,subject_id);
CREATE INDEX link_references_rule_for_requirement_inverse ON link_references_rule_for_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_refined_by_requirement_inverse ON link_refined_by_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_release_status_change_inverse ON link_release_status_change(snapshot_id,object_id,subject_id);
CREATE INDEX link_release_status_version_inverse ON link_release_status_version(snapshot_id,object_id,subject_id);
CREATE INDEX link_reports_status_inverse ON link_reports_status(snapshot_id,object_id,subject_id);
CREATE INDEX link_represented_by_story_inverse ON link_represented_by_story(snapshot_id,object_id,subject_id);
CREATE INDEX link_scenario_context_inverse ON link_scenario_context(snapshot_id,object_id,subject_id);
CREATE INDEX link_scope_change_record_inverse ON link_scope_change_record(snapshot_id,object_id,subject_id);
CREATE INDEX link_scope_supersedes_inverse ON link_scope_supersedes(snapshot_id,object_id,subject_id);
CREATE INDEX link_solution_hypothesizes_about_problem_inverse ON link_solution_hypothesizes_about_problem(snapshot_id,object_id,subject_id);
CREATE INDEX link_solution_predicts_outcome_inverse ON link_solution_predicts_outcome(snapshot_id,object_id,subject_id);
CREATE INDEX link_sources_requirement_inverse ON link_sources_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_specification_provenance_inverse ON link_specification_provenance(snapshot_id,object_id,subject_id);
CREATE INDEX link_specified_by_requirement_inverse ON link_specified_by_requirement(snapshot_id,object_id,subject_id);
CREATE INDEX link_specified_through_feature_inverse ON link_specified_through_feature(snapshot_id,object_id,subject_id);
CREATE INDEX link_specifies_capability_inverse ON link_specifies_capability(snapshot_id,object_id,subject_id);
CREATE INDEX link_specifies_expected_condition_inverse ON link_specifies_expected_condition(snapshot_id,object_id,subject_id);
CREATE INDEX link_specifies_outcome_metric_inverse ON link_specifies_outcome_metric(snapshot_id,object_id,subject_id);
CREATE INDEX link_specifies_persona_context_inverse ON link_specifies_persona_context(snapshot_id,object_id,subject_id);
CREATE INDEX link_specifies_slice_inverse ON link_specifies_slice(snapshot_id,object_id,subject_id);
CREATE INDEX link_step_precedes_inverse ON link_step_precedes(snapshot_id,object_id,subject_id);
CREATE INDEX link_targets_outcome_inverse ON link_targets_outcome(snapshot_id,object_id,subject_id);
CREATE INDEX link_targets_outcome_specification_inverse ON link_targets_outcome_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_tests_realization_inverse ON link_tests_realization(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_information_architecture_inverse ON link_usability_information_architecture(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_journey_inverse ON link_usability_journey(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_journey_stage_inverse ON link_usability_journey_stage(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_persona_inverse ON link_usability_persona(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_step_inverse ON link_usability_step(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_touchpoint_inverse ON link_usability_touchpoint(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_uistate_inverse ON link_usability_uistate(snapshot_id,object_id,subject_id);
CREATE INDEX link_usability_user_role_inverse ON link_usability_user_role(snapshot_id,object_id,subject_id);
CREATE INDEX link_uses_lifecycle_specification_inverse ON link_uses_lifecycle_specification(snapshot_id,object_id,subject_id);
CREATE INDEX link_version_scope_inverse ON link_version_scope(snapshot_id,object_id,subject_id);
CREATE INDEX value_attribution_agent_inverse ON value_attribution_agent(snapshot_id,object_id,subject_id);
CREATE INDEX value_attribution_source_inverse ON value_attribution_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_attribution_stance_inverse ON value_attribution_stance(snapshot_id,object_id,subject_id);
CREATE INDEX value_attribution_timestamp_inverse ON value_attribution_timestamp(snapshot_id,object_id,subject_id);
CREATE INDEX value_change_occurrence_reference_inverse ON value_change_occurrence_reference(snapshot_id,object_id,subject_id);
CREATE INDEX value_change_recorded_at_inverse ON value_change_recorded_at(snapshot_id,object_id,subject_id);
CREATE INDEX value_change_source_inverse ON value_change_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_change_statement_inverse ON value_change_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_claim_statement_inverse ON value_claim_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_condition_statement_inverse ON value_condition_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_context_description_inverse ON value_context_description(snapshot_id,object_id,subject_id);
CREATE INDEX value_context_source_inverse ON value_context_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_decision_rationale_inverse ON value_decision_rationale(snapshot_id,object_id,subject_id);
CREATE INDEX value_decision_source_inverse ON value_decision_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_deferred_statement_inverse ON value_deferred_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_dependency_source_inverse ON value_dependency_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_excluded_statement_inverse ON value_excluded_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_execution_ended_at_inverse ON value_execution_ended_at(snapshot_id,object_id,subject_id);
CREATE INDEX value_finding_source_inverse ON value_finding_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_finding_statement_inverse ON value_finding_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_included_statement_inverse ON value_included_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_item_status_code_inverse ON value_item_status_code(snapshot_id,object_id,subject_id);
CREATE INDEX value_item_status_reported_at_inverse ON value_item_status_reported_at(snapshot_id,object_id,subject_id);
CREATE INDEX value_item_status_scheme_inverse ON value_item_status_scheme(snapshot_id,object_id,subject_id);
CREATE INDEX value_item_status_source_inverse ON value_item_status_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_observed_authority_inverse ON value_observed_authority(snapshot_id,object_id,subject_id);
CREATE INDEX value_observed_target_inverse ON value_observed_target(snapshot_id,object_id,subject_id);
CREATE INDEX value_persona_description_inverse ON value_persona_description(snapshot_id,object_id,subject_id);
CREATE INDEX value_proposal_source_inverse ON value_proposal_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_proposal_statement_inverse ON value_proposal_statement(snapshot_id,object_id,subject_id);
CREATE INDEX value_reference_purpose_inverse ON value_reference_purpose(snapshot_id,object_id,subject_id);
CREATE INDEX value_reference_recorded_at_inverse ON value_reference_recorded_at(snapshot_id,object_id,subject_id);
CREATE INDEX value_reference_revision_label_inverse ON value_reference_revision_label(snapshot_id,object_id,subject_id);
CREATE INDEX value_release_status_code_inverse ON value_release_status_code(snapshot_id,object_id,subject_id);
CREATE INDEX value_release_status_reported_at_inverse ON value_release_status_reported_at(snapshot_id,object_id,subject_id);
CREATE INDEX value_release_status_scheme_inverse ON value_release_status_scheme(snapshot_id,object_id,subject_id);
CREATE INDEX value_release_status_source_inverse ON value_release_status_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_result_outcome_inverse ON value_result_outcome(snapshot_id,object_id,subject_id);
CREATE INDEX value_result_recorded_at_inverse ON value_result_recorded_at(snapshot_id,object_id,subject_id);
CREATE INDEX value_result_source_inverse ON value_result_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_review_reason_inverse ON value_review_reason(snapshot_id,object_id,subject_id);
CREATE INDEX value_review_recorded_at_inverse ON value_review_recorded_at(snapshot_id,object_id,subject_id);
CREATE INDEX value_scenario_actions_inverse ON value_scenario_actions(snapshot_id,object_id,subject_id);
CREATE INDEX value_scenario_precondition_inverse ON value_scenario_precondition(snapshot_id,object_id,subject_id);
CREATE INDEX value_scope_source_inverse ON value_scope_source(snapshot_id,object_id,subject_id);
CREATE INDEX value_usability_recommendation_inverse ON value_usability_recommendation(snapshot_id,object_id,subject_id);
CREATE TRIGGER asserted_type_immutable BEFORE UPDATE ON asserted_type BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER binding_no_delete BEFORE DELETE ON historical_binding
      BEGIN SELECT RAISE(ABORT,'HISTORY_DELETE_FORBIDDEN'); END;
CREATE TRIGGER binding_no_replace BEFORE INSERT ON historical_binding
      WHEN EXISTS(SELECT 1 FROM historical_binding WHERE kind=NEW.kind AND iri=NEW.iri)
      BEGIN SELECT RAISE(ABORT,'HISTORY_BINDING_ALREADY_EXISTS'); END;
CREATE TRIGGER binding_no_update BEFORE UPDATE ON historical_binding
      BEGIN SELECT RAISE(ABORT,'IMMUTABLE_HISTORY_BINDING'); END;
CREATE TRIGGER class_iri BEFORE INSERT ON asserted_type BEGIN
 SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.class_id)<>'IRI' THEN RAISE(ABORT,'Class must be an IRI') END;
END;
CREATE TRIGGER d01_bundle_specification_immutable BEFORE UPDATE ON d01_bundle_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_dependency_specification_immutable BEFORE UPDATE ON d01_dependency_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_lifecycle_specification_immutable BEFORE UPDATE ON d01_lifecycle_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_lifecycle_stage_specification_immutable BEFORE UPDATE ON d01_lifecycle_stage_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_offering_specification_immutable BEFORE UPDATE ON d01_offering_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_portfolio_entry_immutable BEFORE UPDATE ON d01_portfolio_entry BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_product_immutable BEFORE UPDATE ON d01_product BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_product_portfolio_immutable BEFORE UPDATE ON d01_product_portfolio BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_product_status_record_immutable BEFORE UPDATE ON d01_product_status_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d01_product_version_immutable BEFORE UPDATE ON d01_product_version BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_decision_criterion_specification_immutable BEFORE UPDATE ON d02_decision_criterion_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_decision_record_immutable BEFORE UPDATE ON d02_decision_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_goal_specification_immutable BEFORE UPDATE ON d02_goal_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_hypothesis_specification_immutable BEFORE UPDATE ON d02_hypothesis_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_initiative_specification_immutable BEFORE UPDATE ON d02_initiative_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_opportunity_statement_immutable BEFORE UPDATE ON d02_opportunity_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_outcome_specification_immutable BEFORE UPDATE ON d02_outcome_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_problem_solution_fit_assessment_immutable BEFORE UPDATE ON d02_problem_solution_fit_assessment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_problem_statement_immutable BEFORE UPDATE ON d02_problem_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_product_market_fit_assessment_immutable BEFORE UPDATE ON d02_product_market_fit_assessment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_solution_hypothesis_specification_immutable BEFORE UPDATE ON d02_solution_hypothesis_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d02_vision_statement_immutable BEFORE UPDATE ON d02_vision_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_capability_specification_immutable BEFORE UPDATE ON d03_capability_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_condition_specification_immutable BEFORE UPDATE ON d03_condition_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_enabler_specification_immutable BEFORE UPDATE ON d03_enabler_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_feature_specification_immutable BEFORE UPDATE ON d03_feature_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_scenario_specification_immutable BEFORE UPDATE ON d03_scenario_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_scope_specification_immutable BEFORE UPDATE ON d03_scope_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_solution_specification_immutable BEFORE UPDATE ON d03_solution_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d03_vertical_slice_specification_immutable BEFORE UPDATE ON d03_vertical_slice_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_acceptance_criterion_specification_immutable BEFORE UPDATE ON d04_acceptance_criterion_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_constraint_specification_immutable BEFORE UPDATE ON d04_constraint_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_functional_requirement_specification_immutable BEFORE UPDATE ON d04_functional_requirement_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_quality_requirement_specification_immutable BEFORE UPDATE ON d04_quality_requirement_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_requirement_rationale_statement_immutable BEFORE UPDATE ON d04_requirement_rationale_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_requirement_scenario_specification_immutable BEFORE UPDATE ON d04_requirement_scenario_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_requirement_specification_immutable BEFORE UPDATE ON d04_requirement_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_user_story_specification_immutable BEFORE UPDATE ON d04_user_story_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d04_validation_finding_record_immutable BEFORE UPDATE ON d04_validation_finding_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_information_architecture_specification_immutable BEFORE UPDATE ON d05_information_architecture_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_interaction_step_specification_immutable BEFORE UPDATE ON d05_interaction_step_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_journey_specification_immutable BEFORE UPDATE ON d05_journey_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_journey_stage_specification_immutable BEFORE UPDATE ON d05_journey_stage_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_persona_specification_immutable BEFORE UPDATE ON d05_persona_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_screen_specification_immutable BEFORE UPDATE ON d05_screen_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_touchpoint_specification_immutable BEFORE UPDATE ON d05_touchpoint_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_uistate_specification_immutable BEFORE UPDATE ON d05_uistate_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_usability_finding_record_immutable BEFORE UPDATE ON d05_usability_finding_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_user_flow_specification_immutable BEFORE UPDATE ON d05_user_flow_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d05_user_role_specification_immutable BEFORE UPDATE ON d05_user_role_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_commitment_level_definition_immutable BEFORE UPDATE ON d06_commitment_level_definition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_confidence_assessment_immutable BEFORE UPDATE ON d06_confidence_assessment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_milestone_specification_immutable BEFORE UPDATE ON d06_milestone_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_planning_horizon_definition_immutable BEFORE UPDATE ON d06_planning_horizon_definition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_prioritization_criterion_specification_immutable BEFORE UPDATE ON d06_prioritization_criterion_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_priority_assessment_immutable BEFORE UPDATE ON d06_priority_assessment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_roadmap_entry_immutable BEFORE UPDATE ON d06_roadmap_entry BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_roadmap_immutable BEFORE UPDATE ON d06_roadmap BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d06_target_window_assignment_immutable BEFORE UPDATE ON d06_target_window_assignment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d07_change_proposal_specification_immutable BEFORE UPDATE ON d07_change_proposal_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d07_change_record_immutable BEFORE UPDATE ON d07_change_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d07_delivery_status_record_immutable BEFORE UPDATE ON d07_delivery_status_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d07_delivery_work_item_immutable BEFORE UPDATE ON d07_delivery_work_item BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d07_delivery_work_item_status_record_immutable BEFORE UPDATE ON d07_delivery_work_item_status_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d07_feature_flag_specification_immutable BEFORE UPDATE ON d07_feature_flag_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d07_release_specification_immutable BEFORE UPDATE ON d07_release_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d08_test_case_immutable BEFORE UPDATE ON d08_test_case BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d08_test_execution_immutable BEFORE UPDATE ON d08_test_execution BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d08_test_result_immutable BEFORE UPDATE ON d08_test_result BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d08_test_scenario_immutable BEFORE UPDATE ON d08_test_scenario BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d08_test_suite_specification_immutable BEFORE UPDATE ON d08_test_suite_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_acquisition_hypothesis_specification_immutable BEFORE UPDATE ON d09_acquisition_hypothesis_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_adoption_hypothesis_specification_immutable BEFORE UPDATE ON d09_adoption_hypothesis_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_competitive_narrative_immutable BEFORE UPDATE ON d09_competitive_narrative BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_go_to_market_specification_immutable BEFORE UPDATE ON d09_go_to_market_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_launch_specification_immutable BEFORE UPDATE ON d09_launch_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_marketing_goal_specification_immutable BEFORE UPDATE ON d09_marketing_goal_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_messaging_specification_immutable BEFORE UPDATE ON d09_messaging_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d09_positioning_statement_immutable BEFORE UPDATE ON d09_positioning_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_assessment_claim_immutable BEFORE UPDATE ON d10_assessment_claim BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_assessment_context_specification_immutable BEFORE UPDATE ON d10_assessment_context_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_evidence_artifact_immutable BEFORE UPDATE ON d10_evidence_artifact BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_evidence_attribution_record_immutable BEFORE UPDATE ON d10_evidence_attribution_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_finding_record_immutable BEFORE UPDATE ON d10_finding_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_release_evidence_record_immutable BEFORE UPDATE ON d10_release_evidence_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_validation_evidence_record_immutable BEFORE UPDATE ON d10_validation_evidence_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d10_verification_evidence_record_immutable BEFORE UPDATE ON d10_verification_evidence_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d11_product_capability_immutable BEFORE UPDATE ON d11_product_capability BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d11_product_realization_immutable BEFORE UPDATE ON d11_product_realization BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_business_rule_reference_immutable BEFORE UPDATE ON d12_business_rule_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_external_reference_record_immutable BEFORE UPDATE ON d12_external_reference_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_marketing_insight_reference_immutable BEFORE UPDATE ON d12_marketing_insight_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_product_family_reference_immutable BEFORE UPDATE ON d12_product_family_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_product_line_reference_immutable BEFORE UPDATE ON d12_product_line_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_product_metric_reference_immutable BEFORE UPDATE ON d12_product_metric_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_product_variant_reference_immutable BEFORE UPDATE ON d12_product_variant_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_requirement_source_reference_immutable BEFORE UPDATE ON d12_requirement_source_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_target_market_reference_immutable BEFORE UPDATE ON d12_target_market_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_target_segment_reference_immutable BEFORE UPDATE ON d12_target_segment_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_task_reference_immutable BEFORE UPDATE ON d12_task_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER d12_test_data_reference_immutable BEFORE UPDATE ON d12_test_data_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER entity_immutable BEFORE UPDATE ON entity BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER entity_resource BEFORE INSERT ON entity BEGIN
 SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.term_id)='LITERAL' THEN RAISE(ABORT,'Entity must be a resource') END;
 SELECT CASE WHEN EXISTS(SELECT 1 FROM term WHERE term_id=NEW.term_id AND kind='BNODE' AND blank_scope<>NEW.snapshot_id) THEN RAISE(ABORT,'Cross-snapshot blank node') END;
END;
CREATE TRIGGER link_acquisition_cites_evidence_immutable BEFORE UPDATE ON link_acquisition_cites_evidence BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_acquisition_cites_evidence_insert BEFORE INSERT ON link_acquisition_cites_evidence BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_acquisition_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:acquisitionCitesEvidence IC:AcquisitionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:acquisitionCitesEvidence IC:EvidenceAttributionRecord') END;
END;
CREATE TRIGGER link_acquisition_cites_insight_immutable BEFORE UPDATE ON link_acquisition_cites_insight BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_acquisition_cites_insight_insert BEFORE INSERT ON link_acquisition_cites_insight BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_acquisition_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:acquisitionCitesInsight IC:AcquisitionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_marketing_insight_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:acquisitionCitesInsight IC:MarketingInsightReference') END;
END;
CREATE TRIGGER link_adoption_cites_evidence_immutable BEFORE UPDATE ON link_adoption_cites_evidence BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_adoption_cites_evidence_insert BEFORE INSERT ON link_adoption_cites_evidence BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_adoption_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:adoptionCitesEvidence IC:AdoptionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:adoptionCitesEvidence IC:EvidenceAttributionRecord') END;
END;
CREATE TRIGGER link_adoption_cites_insight_immutable BEFORE UPDATE ON link_adoption_cites_insight BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_adoption_cites_insight_insert BEFORE INSERT ON link_adoption_cites_insight BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_adoption_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:adoptionCitesInsight IC:AdoptionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_marketing_insight_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:adoptionCitesInsight IC:MarketingInsightReference') END;
END;
CREATE TRIGGER link_architecture_intended_realized_by_component_immutable BEFORE UPDATE ON link_architecture_intended_realized_by_component BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_architecture_intended_realized_by_component_insert BEFORE INSERT ON link_architecture_intended_realized_by_component BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:ARCH:realizedByComponent IC:FeatureSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_architecture_intended_realized_by_service_immutable BEFORE UPDATE ON link_architecture_intended_realized_by_service BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_architecture_intended_realized_by_service_insert BEFORE INSERT ON link_architecture_intended_realized_by_service BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:ARCH:realizedByService IC:FeatureSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_architecture_intended_satisfied_by_architecture_element_immutable BEFORE UPDATE ON link_architecture_intended_satisfied_by_architecture_element BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_architecture_intended_satisfied_by_architecture_element_insert BEFORE INSERT ON link_architecture_intended_satisfied_by_architecture_element BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:ARCH:satisfiedByArchitectureElement IC:RequirementSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_architecture_intended_satisfied_by_interface_immutable BEFORE UPDATE ON link_architecture_intended_satisfied_by_interface BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_architecture_intended_satisfied_by_interface_insert BEFORE INSERT ON link_architecture_intended_satisfied_by_interface BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:ARCH:satisfiedByInterface IC:RequirementSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_architecture_intended_supported_by_architecture_element_immutable BEFORE UPDATE ON link_architecture_intended_supported_by_architecture_element BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_architecture_intended_supported_by_architecture_element_insert BEFORE INSERT ON link_architecture_intended_supported_by_architecture_element BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:ARCH:supportedByArchitectureElement IC:CapabilitySpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_assesses_problem_immutable BEFORE UPDATE ON link_assesses_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_assesses_problem_insert BEFORE INSERT ON link_assesses_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_solution_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:028 IC:ProblemSolutionFitAssessment') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:028 IC:ProblemStatement') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d02_problem_solution_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_assesses_problem WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:028 maximum 1') END;
END;
CREATE TRIGGER link_assesses_product_immutable BEFORE UPDATE ON link_assesses_product BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_assesses_product_insert BEFORE INSERT ON link_assesses_product BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_product_market_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:030 IC:ProductMarketFitAssessment') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:030 IC:Product') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d02_product_market_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_assesses_product WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:030 maximum 1') END;
END;
CREATE TRIGGER link_assesses_solution_immutable BEFORE UPDATE ON link_assesses_solution BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_assesses_solution_insert BEFORE INSERT ON link_assesses_solution BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_solution_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:029 IC:ProblemSolutionFitAssessment') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:029 IC:SolutionSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d02_problem_solution_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_assesses_solution WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:029 maximum 1') END;
END;
CREATE TRIGGER link_assesses_specification_immutable BEFORE UPDATE ON link_assesses_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_assesses_specification_insert BEFORE INSERT ON link_assesses_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:assessesSpecification IC:TestExecution') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:assessesSpecification IC:CapabilitySpecification') END;
END;
CREATE TRIGGER link_bears_capability_immutable BEFORE UPDATE ON link_bears_capability BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_bears_capability_insert BEFORE INSERT ON link_bears_capability BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_realization c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:bearsCapability IC:ProductRealization') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_capability c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:bearsCapability IC:ProductCapability') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d11_product_capability c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_bears_capability WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'ICREL:CP:bearsCapability maximum 1') END;
END;
CREATE TRIGGER link_canonical_owner_immutable BEFORE UPDATE ON link_canonical_owner BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_canonical_owner_insert BEFORE INSERT ON link_canonical_owner BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
END;
CREATE TRIGGER link_change_decision_immutable BEFORE UPDATE ON link_change_decision BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_change_decision_insert BEFORE INSERT ON link_change_decision BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeDecision IC:ChangeRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeDecision IC:DecisionRecord') END;
END;
CREATE TRIGGER link_change_feature_immutable BEFORE UPDATE ON link_change_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_change_feature_insert BEFORE INSERT ON link_change_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeFeature IC:ChangeRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeFeature IC:FeatureSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_change_feature WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:changeFeature maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_change_feature WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_change_scope_immutable BEFORE UPDATE ON link_change_scope BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_change_scope_insert BEFORE INSERT ON link_change_scope BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeScope IC:ChangeRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeScope IC:ScopeSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_change_scope WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:changeScope maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_change_scope WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_change_task_immutable BEFORE UPDATE ON link_change_task BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_change_task_insert BEFORE INSERT ON link_change_task BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeTask IC:ChangeRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_task_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:changeTask IC:TaskReference') END;
END;
CREATE TRIGGER link_claim_actual_capability_immutable BEFORE UPDATE ON link_claim_actual_capability BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_actual_capability_insert BEFORE INSERT ON link_claim_actual_capability BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimActualCapability IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_capability c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimActualCapability IC:ProductCapability') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_actual_capability WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimActualCapability maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_actual_capability WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_context_immutable BEFORE UPDATE ON link_claim_context BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_context_insert BEFORE INSERT ON link_claim_context BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimContext IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_context_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimContext IC:AssessmentContextSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_context WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimContext maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_context WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_criterion_immutable BEFORE UPDATE ON link_claim_criterion BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_criterion_insert BEFORE INSERT ON link_claim_criterion BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimCriterion IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_condition_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimCriterion IC:ConditionSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_criterion WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimCriterion maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_criterion WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_intended_capability_immutable BEFORE UPDATE ON link_claim_intended_capability BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_intended_capability_insert BEFORE INSERT ON link_claim_intended_capability BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimIntendedCapability IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimIntendedCapability IC:CapabilitySpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_intended_capability WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimIntendedCapability maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_intended_capability WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_product_immutable BEFORE UPDATE ON link_claim_product BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_product_insert BEFORE INSERT ON link_claim_product BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimProduct IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimProduct IC:Product') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_product WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimProduct maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_product WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_realization_immutable BEFORE UPDATE ON link_claim_realization BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_realization_insert BEFORE INSERT ON link_claim_realization BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimRealization IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_realization c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimRealization IC:ProductRealization') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_realization WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimRealization maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_realization WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_requirement_immutable BEFORE UPDATE ON link_claim_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_requirement_insert BEFORE INSERT ON link_claim_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimRequirement IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimRequirement IC:RequirementSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_requirement WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimRequirement maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_requirement WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_subject_immutable BEFORE UPDATE ON link_claim_subject BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_subject_insert BEFORE INSERT ON link_claim_subject BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_subject WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_claim_version_immutable BEFORE UPDATE ON link_claim_version BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_claim_version_insert BEFORE INSERT ON link_claim_version BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimVersion IC:AssessmentClaim') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:claimVersion IC:ProductVersion') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_claim_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:claimVersion maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_claim_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_concerns_requirement_immutable BEFORE UPDATE ON link_concerns_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_concerns_requirement_insert BEFORE INSERT ON link_concerns_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_validation_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:050 IC:ValidationFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:050 IC:RequirementSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d04_validation_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_concerns_requirement WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:050 maximum 1') END;
END;
CREATE TRIGGER link_condition_context_immutable BEFORE UPDATE ON link_condition_context BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_condition_context_insert BEFORE INSERT ON link_condition_context BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_condition_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
END;
CREATE TRIGGER link_constrains_requirement_immutable BEFORE UPDATE ON link_constrains_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_constrains_requirement_insert BEFORE INSERT ON link_constrains_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_constraint_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:046 IC:ConstraintSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:046 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_contains_case_immutable BEFORE UPDATE ON link_contains_case BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_contains_case_insert BEFORE INSERT ON link_contains_case BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_suite_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:088 IC:TestSuiteSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_case c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:088 IC:TestCase') END;
END;
CREATE TRIGGER link_contains_product_immutable BEFORE UPDATE ON link_contains_product BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_contains_product_insert BEFORE INSERT ON link_contains_product BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:002 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:002 IC:Product') END;
END;
CREATE TRIGGER link_contains_stage_immutable BEFORE UPDATE ON link_contains_stage BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_contains_stage_insert BEFORE INSERT ON link_contains_stage BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:053 IC:JourneySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:053 IC:JourneyStageSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_contains_stage WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:053 maximum 1') END;
END;
CREATE TRIGGER link_context_scenario_immutable BEFORE UPDATE ON link_context_scenario BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_context_scenario_insert BEFORE INSERT ON link_context_scenario BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_context_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:contextScenario IC:AssessmentContextSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scenario_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:contextScenario IC:ScenarioSpecification') END;
END;
CREATE TRIGGER link_context_version_immutable BEFORE UPDATE ON link_context_version BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_context_version_insert BEFORE INSERT ON link_context_version BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_context_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:contextVersion IC:AssessmentContextSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:contextVersion IC:ProductVersion') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_assessment_context_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_context_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:contextVersion maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_context_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_decision_considers_solution_immutable BEFORE UPDATE ON link_decision_considers_solution BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_decision_considers_solution_insert BEFORE INSERT ON link_decision_considers_solution BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:decisionConsidersSolution IC:DecisionRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:decisionConsidersSolution IC:SolutionSpecification') END;
END;
CREATE TRIGGER link_decision_evidence_immutable BEFORE UPDATE ON link_decision_evidence BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_decision_evidence_insert BEFORE INSERT ON link_decision_evidence BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:decisionEvidence IC:DecisionRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:decisionEvidence IC:EvidenceAttributionRecord') END;
END;
CREATE TRIGGER link_decision_selects_solution_immutable BEFORE UPDATE ON link_decision_selects_solution BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_decision_selects_solution_insert BEFORE INSERT ON link_decision_selects_solution BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:decisionSelectsSolution IC:DecisionRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:decisionSelectsSolution IC:SolutionSpecification') END;
END;
CREATE TRIGGER link_defines_lifecycle_stage_immutable BEFORE UPDATE ON link_defines_lifecycle_stage BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_defines_lifecycle_stage_insert BEFORE INSERT ON link_defines_lifecycle_stage BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_lifecycle_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:010 IC:LifecycleSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_lifecycle_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:010 IC:LifecycleStageSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_lifecycle_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_defines_lifecycle_stage WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:010 maximum 1') END;
END;
CREATE TRIGGER link_dependency_actual_capability_target_immutable BEFORE UPDATE ON link_dependency_actual_capability_target BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_dependency_actual_capability_target_insert BEFORE INSERT ON link_dependency_actual_capability_target BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyActualCapabilityTarget IC:DependencySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_capability c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyActualCapabilityTarget IC:ProductCapability') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_dependency_actual_capability_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:dependencyActualCapabilityTarget maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_dependency_actual_capability_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_dependency_capability_specification_target_immutable BEFORE UPDATE ON link_dependency_capability_specification_target BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_dependency_capability_specification_target_insert BEFORE INSERT ON link_dependency_capability_specification_target BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyCapabilitySpecificationTarget IC:DependencySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyCapabilitySpecificationTarget IC:CapabilitySpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_dependency_capability_specification_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:dependencyCapabilitySpecificationTarget maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_dependency_capability_specification_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_dependency_condition_immutable BEFORE UPDATE ON link_dependency_condition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_dependency_condition_insert BEFORE INSERT ON link_dependency_condition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyCondition IC:DependencySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_condition_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyCondition IC:ConditionSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_dependency_condition WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:dependencyCondition maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_dependency_condition WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_dependency_external_target_immutable BEFORE UPDATE ON link_dependency_external_target BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_dependency_external_target_insert BEFORE INSERT ON link_dependency_external_target BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyExternalTarget IC:DependencySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyExternalTarget IC:ExternalReferenceRecord') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_dependency_external_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:dependencyExternalTarget maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_dependency_external_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_dependency_product_target_immutable BEFORE UPDATE ON link_dependency_product_target BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_dependency_product_target_insert BEFORE INSERT ON link_dependency_product_target BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyProductTarget IC:DependencySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:dependencyProductTarget IC:Product') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_dependency_product_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:dependencyProductTarget maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_dependency_product_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_depends_on_enabler_specification_immutable BEFORE UPDATE ON link_depends_on_enabler_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_depends_on_enabler_specification_insert BEFORE INSERT ON link_depends_on_enabler_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:040 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:040 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_evaluated_against_immutable BEFORE UPDATE ON link_evaluated_against BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_evaluated_against_insert BEFORE INSERT ON link_evaluated_against BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_capability c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:evaluatedAgainst IC:ProductCapability') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:evaluatedAgainst IC:CapabilitySpecification') END;
END;
CREATE TRIGGER link_executes_immutable BEFORE UPDATE ON link_executes BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_executes_insert BEFORE INSERT ON link_executes BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:090 IC:TestExecution') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_case c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:090 IC:TestCase') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_executes WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:090 maximum 1') END;
END;
CREATE TRIGGER link_execution_context_immutable BEFORE UPDATE ON link_execution_context BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_execution_context_insert BEFORE INSERT ON link_execution_context BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:executionContext IC:TestExecution') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_context_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:executionContext IC:AssessmentContextSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_execution_context WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD05:executionContext maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_execution_context WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_execution_criterion_immutable BEFORE UPDATE ON link_execution_criterion BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_execution_criterion_insert BEFORE INSERT ON link_execution_criterion BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:executionCriterion IC:TestExecution') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_condition_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:executionCriterion IC:ConditionSpecification') END;
END;
CREATE TRIGGER link_exemplified_by_scenario_immutable BEFORE UPDATE ON link_exemplified_by_scenario BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_exemplified_by_scenario_insert BEFORE INSERT ON link_exemplified_by_scenario BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_acceptance_criterion_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:045 IC:AcceptanceCriterionSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_scenario_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:045 IC:RequirementScenarioSpecification') END;
END;
CREATE TRIGGER link_expected_enabled_by_immutable BEFORE UPDATE ON link_expected_enabled_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_expected_enabled_by_insert BEFORE INSERT ON link_expected_enabled_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_outcome_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:033 IC:OutcomeSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:033 IC:CapabilitySpecification') END;
END;
CREATE TRIGGER link_has_dependency_specification_immutable BEFORE UPDATE ON link_has_dependency_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_dependency_specification_insert BEFORE INSERT ON link_has_dependency_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:012 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:012 IC:DependencySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:013 IC:DependencySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:013 IC:Product') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_has_dependency_specification WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:012 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_has_dependency_specification WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:013 maximum 1') END;
END;
CREATE TRIGGER link_has_feature_criterion_immutable BEFORE UPDATE ON link_has_feature_criterion BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_feature_criterion_insert BEFORE INSERT ON link_has_feature_criterion BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:132 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_acceptance_criterion_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:132 IC:AcceptanceCriterionSpecification') END;
END;
CREATE TRIGGER link_has_product_status_record_immutable BEFORE UPDATE ON link_has_product_status_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_product_status_record_insert BEFORE INSERT ON link_has_product_status_record BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:011 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:011 IC:ProductStatusRecord') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_product_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_has_product_status_record WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:011 maximum 1') END;
END;
CREATE TRIGGER link_has_proposed_solution_immutable BEFORE UPDATE ON link_has_proposed_solution BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_proposed_solution_insert BEFORE INSERT ON link_has_proposed_solution BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_opportunity_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:035 IC:OpportunityStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:035 IC:SolutionSpecification') END;
END;
CREATE TRIGGER link_has_scope_specification_immutable BEFORE UPDATE ON link_has_scope_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_scope_specification_insert BEFORE INSERT ON link_has_scope_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:031 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:031 IC:ScopeSpecification') END;
END;
CREATE TRIGGER link_has_story_criterion_immutable BEFORE UPDATE ON link_has_story_criterion BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_story_criterion_insert BEFORE INSERT ON link_has_story_criterion BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_user_story_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:134 IC:UserStorySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_acceptance_criterion_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:134 IC:AcceptanceCriterionSpecification') END;
END;
CREATE TRIGGER link_has_story_specification_immutable BEFORE UPDATE ON link_has_story_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_story_specification_insert BEFORE INSERT ON link_has_story_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:042 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_user_story_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:042 IC:UserStorySpecification') END;
END;
CREATE TRIGGER link_has_version_immutable BEFORE UPDATE ON link_has_version BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_version_insert BEFORE INSERT ON link_has_version BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:007 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:007 IC:ProductVersion') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_has_version WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:007 maximum 1') END;
END;
CREATE TRIGGER link_has_vision_statement_immutable BEFORE UPDATE ON link_has_vision_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_has_vision_statement_insert BEFORE INSERT ON link_has_vision_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:017 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_vision_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:017 IC:VisionStatement') END;
END;
CREATE TRIGGER link_hypothesizes_about_problem_immutable BEFORE UPDATE ON link_hypothesizes_about_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_hypothesizes_about_problem_insert BEFORE INSERT ON link_hypothesizes_about_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:128 IC:HypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:128 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_implements_feature_immutable BEFORE UPDATE ON link_implements_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_implements_feature_insert BEFORE INSERT ON link_implements_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_realization c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:implementsFeature IC:ProductRealization') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:implementsFeature IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_informs_initiative_immutable BEFORE UPDATE ON link_informs_initiative BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_informs_initiative_insert BEFORE INSERT ON link_informs_initiative BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_solution_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:025 IC:SolutionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:025 IC:InitiativeSpecification') END;
END;
CREATE TRIGGER link_intended_to_enable_feature_immutable BEFORE UPDATE ON link_intended_to_enable_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_intended_to_enable_feature_insert BEFORE INSERT ON link_intended_to_enable_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_enabler_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:039 IC:EnablerSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:039 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_intends_capability_immutable BEFORE UPDATE ON link_intends_capability BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_intends_capability_insert BEFORE INSERT ON link_intends_capability BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:032 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:032 IC:CapabilitySpecification') END;
END;
CREATE TRIGGER link_intends_to_address_problem_immutable BEFORE UPDATE ON link_intends_to_address_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_intends_to_address_problem_insert BEFORE INSERT ON link_intends_to_address_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:130 IC:SolutionSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:130 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_intends_to_contribute_to_outcome_immutable BEFORE UPDATE ON link_intends_to_contribute_to_outcome BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_intends_to_contribute_to_outcome_insert BEFORE INSERT ON link_intends_to_contribute_to_outcome BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:163 IC:SolutionSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_outcome_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:163 IC:OutcomeSpecification') END;
END;
CREATE TRIGGER link_intends_to_support_goal_immutable BEFORE UPDATE ON link_intends_to_support_goal BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_intends_to_support_goal_insert BEFORE INSERT ON link_intends_to_support_goal BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:126 IC:InitiativeSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:126 IC:GoalSpecification') END;
END;
CREATE TRIGGER link_is_carrier_in_record_immutable BEFORE UPDATE ON link_is_carrier_in_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_is_carrier_in_record_insert BEFORE INSERT ON link_is_carrier_in_record BEGIN
SELECT 1;
END;
CREATE TRIGGER link_item_status_change_immutable BEFORE UPDATE ON link_item_status_change BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_item_status_change_insert BEFORE INSERT ON link_item_status_change BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:itemStatusChange IC:DeliveryWorkItemStatusRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:itemStatusChange IC:ChangeRecord') END;
END;
CREATE TRIGGER link_item_status_immutable BEFORE UPDATE ON link_item_status BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_item_status_insert BEFORE INSERT ON link_item_status BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:itemStatus IC:DeliveryWorkItem') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:itemStatus IC:DeliveryWorkItemStatusRecord') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_item_status WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:ORSD05:itemStatus maximum 1') END;
END;
CREATE TRIGGER link_item_status_version_immutable BEFORE UPDATE ON link_item_status_version BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_item_status_version_insert BEFORE INSERT ON link_item_status_version BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:itemStatusVersion IC:DeliveryWorkItemStatusRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:itemStatusVersion IC:ProductVersion') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_item_status_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD05:itemStatusVersion maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_item_status_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_justifies_requirement_immutable BEFORE UPDATE ON link_justifies_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_justifies_requirement_insert BEFORE INSERT ON link_justifies_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_rationale_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:049 IC:RequirementRationaleStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:049 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_motivates_goal_immutable BEFORE UPDATE ON link_motivates_goal BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_motivates_goal_insert BEFORE INSERT ON link_motivates_goal BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_vision_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:018 IC:VisionStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:018 IC:GoalSpecification') END;
END;
CREATE TRIGGER link_motivates_hypothesis_immutable BEFORE UPDATE ON link_motivates_hypothesis BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_motivates_hypothesis_insert BEFORE INSERT ON link_motivates_hypothesis BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_opportunity_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:023 IC:OpportunityStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:023 IC:HypothesisSpecification') END;
END;
CREATE TRIGGER link_motivates_solution_hypothesis_immutable BEFORE UPDATE ON link_motivates_solution_hypothesis BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_motivates_solution_hypothesis_insert BEFORE INSERT ON link_motivates_solution_hypothesis BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:024 IC:HypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_solution_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:024 IC:SolutionHypothesisSpecification') END;
END;
CREATE TRIGGER link_narrative_cites_evidence_immutable BEFORE UPDATE ON link_narrative_cites_evidence BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_narrative_cites_evidence_insert BEFORE INSERT ON link_narrative_cites_evidence BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_competitive_narrative c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:narrativeCitesEvidence IC:CompetitiveNarrative') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:narrativeCitesEvidence IC:EvidenceAttributionRecord') END;
END;
CREATE TRIGGER link_narrative_cites_insight_immutable BEFORE UPDATE ON link_narrative_cites_insight BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_narrative_cites_insight_insert BEFORE INSERT ON link_narrative_cites_insight BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_competitive_narrative c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:narrativeCitesInsight IC:CompetitiveNarrative') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_marketing_insight_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:narrativeCitesInsight IC:MarketingInsightReference') END;
END;
CREATE TRIGGER link_offering_of_immutable BEFORE UPDATE ON link_offering_of BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_offering_of_insert BEFORE INSERT ON link_offering_of BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_offering_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:005 IC:OfferingSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:005 IC:Product') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_offering_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_offering_of WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:005 maximum 1') END;
END;
CREATE TRIGGER link_operationalized_by_criterion_immutable BEFORE UPDATE ON link_operationalized_by_criterion BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_operationalized_by_criterion_insert BEFORE INSERT ON link_operationalized_by_criterion BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:044 IC:RequirementSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_acceptance_criterion_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:044 IC:AcceptanceCriterionSpecification') END;
END;
CREATE TRIGGER link_organizes_entry_immutable BEFORE UPDATE ON link_organizes_entry BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_organizes_entry_insert BEFORE INSERT ON link_organizes_entry BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_portfolio_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:004 IC:PortfolioEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:004 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:003 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_portfolio_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:003 IC:PortfolioEntry') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_portfolio_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_organizes_entry WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:004 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_portfolio_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_organizes_entry WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:003 maximum 1') END;
END;
CREATE TRIGGER link_persona_context_immutable BEFORE UPDATE ON link_persona_context BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_persona_context_insert BEFORE INSERT ON link_persona_context BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
END;
CREATE TRIGGER link_predicts_outcome_immutable BEFORE UPDATE ON link_predicts_outcome BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_predicts_outcome_insert BEFORE INSERT ON link_predicts_outcome BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:159 IC:HypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_outcome_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:159 IC:OutcomeSpecification') END;
END;
CREATE TRIGGER link_proposal_feature_immutable BEFORE UPDATE ON link_proposal_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_proposal_feature_insert BEFORE INSERT ON link_proposal_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_proposal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:proposalFeature IC:ChangeProposalSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:proposalFeature IC:FeatureSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_change_proposal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_proposal_feature WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:proposalFeature maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_proposal_feature WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_proposal_scope_immutable BEFORE UPDATE ON link_proposal_scope BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_proposal_scope_insert BEFORE INSERT ON link_proposal_scope BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_proposal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:proposalScope IC:ChangeProposalSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:proposalScope IC:ScopeSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_change_proposal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_proposal_scope WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD06:proposalScope maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_proposal_scope WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_proposes_capability_immutable BEFORE UPDATE ON link_proposes_capability BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_proposes_capability_insert BEFORE INSERT ON link_proposes_capability BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:036 IC:SolutionSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:036 IC:CapabilitySpecification') END;
END;
CREATE TRIGGER link_proposes_feature_immutable BEFORE UPDATE ON link_proposes_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_proposes_feature_insert BEFORE INSERT ON link_proposes_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_solution_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:037 IC:SolutionSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:037 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_r100_uses_positioning_statement_immutable BEFORE UPDATE ON link_r100_uses_positioning_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r100_uses_positioning_statement_insert BEFORE INSERT ON link_r100_uses_positioning_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:100 IC:GoToMarketSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:100 IC:PositioningStatement') END;
END;
CREATE TRIGGER link_r101_plans_launch_immutable BEFORE UPDATE ON link_r101_plans_launch BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r101_plans_launch_insert BEFORE INSERT ON link_r101_plans_launch BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:101 IC:GoToMarketSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_launch_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:101 IC:LaunchSpecification') END;
END;
CREATE TRIGGER link_r102_targets_marketing_goal_immutable BEFORE UPDATE ON link_r102_targets_marketing_goal BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r102_targets_marketing_goal_insert BEFORE INSERT ON link_r102_targets_marketing_goal BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:102 IC:GoToMarketSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_marketing_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:102 IC:MarketingGoalSpecification') END;
END;
CREATE TRIGGER link_r103_informs_positioning_statement_immutable BEFORE UPDATE ON link_r103_informs_positioning_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r103_informs_positioning_statement_insert BEFORE INSERT ON link_r103_informs_positioning_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_marketing_insight_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:103 IC:MarketingInsightReference') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:103 IC:PositioningStatement') END;
END;
CREATE TRIGGER link_r104_informs_go_to_market_specification_immutable BEFORE UPDATE ON link_r104_informs_go_to_market_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r104_informs_go_to_market_specification_insert BEFORE INSERT ON link_r104_informs_go_to_market_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_marketing_insight_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:104 IC:MarketingInsightReference') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:104 IC:GoToMarketSpecification') END;
END;
CREATE TRIGGER link_r105_informs_go_to_market_from_acquisition_immutable BEFORE UPDATE ON link_r105_informs_go_to_market_from_acquisition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r105_informs_go_to_market_from_acquisition_insert BEFORE INSERT ON link_r105_informs_go_to_market_from_acquisition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_acquisition_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:105 IC:AcquisitionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:105 IC:GoToMarketSpecification') END;
END;
CREATE TRIGGER link_r106_informs_go_to_market_from_adoption_immutable BEFORE UPDATE ON link_r106_informs_go_to_market_from_adoption BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r106_informs_go_to_market_from_adoption_insert BEFORE INSERT ON link_r106_informs_go_to_market_from_adoption BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_adoption_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:106 IC:AdoptionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:106 IC:GoToMarketSpecification') END;
END;
CREATE TRIGGER link_r107_intended_to_support_immutable BEFORE UPDATE ON link_r107_intended_to_support BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r107_intended_to_support_insert BEFORE INSERT ON link_r107_intended_to_support BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:107 IC:CapabilitySpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r116_references_immutable BEFORE UPDATE ON link_r116_references BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r116_references_insert BEFORE INSERT ON link_r116_references BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:116 IC:PositioningStatement') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r117_tracks_initiative_immutable BEFORE UPDATE ON link_r117_tracks_initiative BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r117_tracks_initiative_insert BEFORE INSERT ON link_r117_tracks_initiative BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:117 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:117 IC:InitiativeSpecification') END;
END;
CREATE TRIGGER link_r118_tracks_release_specification_immutable BEFORE UPDATE ON link_r118_tracks_release_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r118_tracks_release_specification_insert BEFORE INSERT ON link_r118_tracks_release_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:118 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:118 IC:ReleaseSpecification') END;
END;
CREATE TRIGGER link_r119_tracks_milestone_specification_immutable BEFORE UPDATE ON link_r119_tracks_milestone_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r119_tracks_milestone_specification_insert BEFORE INSERT ON link_r119_tracks_milestone_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:119 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_milestone_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:119 IC:MilestoneSpecification') END;
END;
CREATE TRIGGER link_r120_references_product_line_immutable BEFORE UPDATE ON link_r120_references_product_line BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r120_references_product_line_insert BEFORE INSERT ON link_r120_references_product_line BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:120 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_line_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:120 IC:ProductLineReference') END;
END;
CREATE TRIGGER link_r121_has_portfolio_confidence_assessment_immutable BEFORE UPDATE ON link_r121_has_portfolio_confidence_assessment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r121_has_portfolio_confidence_assessment_insert BEFORE INSERT ON link_r121_has_portfolio_confidence_assessment BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_portfolio c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:121 IC:ProductPortfolio') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_confidence_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:121 IC:ConfidenceAssessment') END;
END;
CREATE TRIGGER link_r122_targets_persona_immutable BEFORE UPDATE ON link_r122_targets_persona BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r122_targets_persona_insert BEFORE INSERT ON link_r122_targets_persona BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:122 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:122 IC:PersonaSpecification') END;
END;
CREATE TRIGGER link_r123_frames_journey_immutable BEFORE UPDATE ON link_r123_frames_journey BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r123_frames_journey_insert BEFORE INSERT ON link_r123_frames_journey BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:123 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:123 IC:JourneySpecification') END;
END;
CREATE TRIGGER link_r125_frames_feature_immutable BEFORE UPDATE ON link_r125_frames_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r125_frames_feature_insert BEFORE INSERT ON link_r125_frames_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_vision_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:125 IC:VisionStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:125 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_r127_tracks_initiative_release_specification_immutable BEFORE UPDATE ON link_r127_tracks_initiative_release_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r127_tracks_initiative_release_specification_insert BEFORE INSERT ON link_r127_tracks_initiative_release_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:127 IC:InitiativeSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:127 IC:ReleaseSpecification') END;
END;
CREATE TRIGGER link_r133_supported_by_immutable BEFORE UPDATE ON link_r133_supported_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r133_supported_by_insert BEFORE INSERT ON link_r133_supported_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:133 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_flow_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:133 IC:UserFlowSpecification') END;
END;
CREATE TRIGGER link_r135_records_resolution_change_immutable BEFORE UPDATE ON link_r135_records_resolution_change BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r135_records_resolution_change_insert BEFORE INSERT ON link_r135_records_resolution_change BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_validation_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:135 IC:ValidationFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:135 IC:ChangeRecord') END;
END;
CREATE TRIGGER link_r136_includes_immutable BEFORE UPDATE ON link_r136_includes BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r136_includes_insert BEFORE INSERT ON link_r136_includes BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:136 IC:JourneySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_touchpoint_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:136 IC:TouchpointSpecification') END;
END;
CREATE TRIGGER link_r137_includes_screen_immutable BEFORE UPDATE ON link_r137_includes_screen BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r137_includes_screen_insert BEFORE INSERT ON link_r137_includes_screen BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_flow_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:137 IC:UserFlowSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_screen_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:137 IC:ScreenSpecification') END;
END;
CREATE TRIGGER link_r138_preceded_by_immutable BEFORE UPDATE ON link_r138_preceded_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r138_preceded_by_insert BEFORE INSERT ON link_r138_preceded_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_screen_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:138 IC:ScreenSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_screen_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:138 IC:ScreenSpecification') END;
END;
CREATE TRIGGER link_r139_intends_to_support_goal_immutable BEFORE UPDATE ON link_r139_intends_to_support_goal BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r139_intends_to_support_goal_insert BEFORE INSERT ON link_r139_intends_to_support_goal BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:139 IC:Roadmap') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:139 IC:GoalSpecification') END;
END;
CREATE TRIGGER link_r140_plans_entry_release_immutable BEFORE UPDATE ON link_r140_plans_entry_release BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r140_plans_entry_release_insert BEFORE INSERT ON link_r140_plans_entry_release BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:140 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:140 IC:ReleaseSpecification') END;
END;
CREATE TRIGGER link_r141_milestone_for_release_specification_immutable BEFORE UPDATE ON link_r141_milestone_for_release_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r141_milestone_for_release_specification_insert BEFORE INSERT ON link_r141_milestone_for_release_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_milestone_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:141 IC:MilestoneSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:141 IC:ReleaseSpecification') END;
END;
CREATE TRIGGER link_r142_groups_planned_initiative_immutable BEFORE UPDATE ON link_r142_groups_planned_initiative BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r142_groups_planned_initiative_insert BEFORE INSERT ON link_r142_groups_planned_initiative BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_planning_horizon_definition c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:142 IC:PlanningHorizonDefinition') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:142 IC:InitiativeSpecification') END;
END;
CREATE TRIGGER link_r143_uses_window_horizon_definition_immutable BEFORE UPDATE ON link_r143_uses_window_horizon_definition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r143_uses_window_horizon_definition_insert BEFORE INSERT ON link_r143_uses_window_horizon_definition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_target_window_assignment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:143 IC:TargetWindowAssignment') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_planning_horizon_definition c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:143 IC:PlanningHorizonDefinition') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d06_target_window_assignment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_r143_uses_window_horizon_definition WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:143 maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_r143_uses_window_horizon_definition WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_r144_targets_release_goal_immutable BEFORE UPDATE ON link_r144_targets_release_goal BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r144_targets_release_goal_insert BEFORE INSERT ON link_r144_targets_release_goal BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:144 IC:ReleaseSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:144 IC:GoalSpecification') END;
END;
CREATE TRIGGER link_r145_concerns_delivery_work_item_immutable BEFORE UPDATE ON link_r145_concerns_delivery_work_item BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r145_concerns_delivery_work_item_insert BEFORE INSERT ON link_r145_concerns_delivery_work_item BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_release_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:145 IC:ReleaseEvidenceRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:145 IC:DeliveryWorkItem') END;
END;
CREATE TRIGGER link_r146_specifies_requirement_verification_immutable BEFORE UPDATE ON link_r146_specifies_requirement_verification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r146_specifies_requirement_verification_insert BEFORE INSERT ON link_r146_specifies_requirement_verification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_case c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:146 IC:TestCase') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:146 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_r147_has_recorded_execution_immutable BEFORE UPDATE ON link_r147_has_recorded_execution BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r147_has_recorded_execution_insert BEFORE INSERT ON link_r147_has_recorded_execution BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_suite_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:147 IC:TestSuiteSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:147 IC:TestExecution') END;
END;
CREATE TRIGGER link_r148_references_journey_stage_immutable BEFORE UPDATE ON link_r148_references_journey_stage BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r148_references_journey_stage_insert BEFORE INSERT ON link_r148_references_journey_stage BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:148 IC:GoToMarketSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:148 IC:JourneyStageSpecification') END;
END;
CREATE TRIGGER link_r149_targets_launch_persona_immutable BEFORE UPDATE ON link_r149_targets_launch_persona BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r149_targets_launch_persona_insert BEFORE INSERT ON link_r149_targets_launch_persona BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_launch_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:149 IC:LaunchSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:149 IC:PersonaSpecification') END;
END;
CREATE TRIGGER link_r150_uses_launch_positioning_immutable BEFORE UPDATE ON link_r150_uses_launch_positioning BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r150_uses_launch_positioning_insert BEFORE INSERT ON link_r150_uses_launch_positioning BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_launch_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:150 IC:LaunchSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:150 IC:PositioningStatement') END;
END;
CREATE TRIGGER link_r151_uses_launch_messaging_immutable BEFORE UPDATE ON link_r151_uses_launch_messaging BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r151_uses_launch_messaging_insert BEFORE INSERT ON link_r151_uses_launch_messaging BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_launch_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:151 IC:LaunchSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_messaging_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:151 IC:MessagingSpecification') END;
END;
CREATE TRIGGER link_r154_references_metric_immutable BEFORE UPDATE ON link_r154_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r154_references_metric_insert BEFORE INSERT ON link_r154_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:154 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:154 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r155_addresses_immutable BEFORE UPDATE ON link_r155_addresses BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r155_addresses_insert BEFORE INSERT ON link_r155_addresses BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_vision_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:155 IC:VisionStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:155 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_r156_references_metric_immutable BEFORE UPDATE ON link_r156_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r156_references_metric_insert BEFORE INSERT ON link_r156_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:156 IC:GoalSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:156 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r157_evidenced_by_immutable BEFORE UPDATE ON link_r157_evidenced_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r157_evidenced_by_insert BEFORE INSERT ON link_r157_evidenced_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:157 IC:ProblemStatement') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r158_references_metric_immutable BEFORE UPDATE ON link_r158_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r158_references_metric_insert BEFORE INSERT ON link_r158_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_opportunity_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:158 IC:OpportunityStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:158 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r160_evidenced_by_immutable BEFORE UPDATE ON link_r160_evidenced_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r160_evidenced_by_insert BEFORE INSERT ON link_r160_evidenced_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:160 IC:HypothesisSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r162_evidenced_by_immutable BEFORE UPDATE ON link_r162_evidenced_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r162_evidenced_by_insert BEFORE INSERT ON link_r162_evidenced_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_product_market_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:162 IC:ProductMarketFitAssessment') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r164_intends_to_address_problem_immutable BEFORE UPDATE ON link_r164_intends_to_address_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r164_intends_to_address_problem_insert BEFORE INSERT ON link_r164_intends_to_address_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:164 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:164 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_r165_specifies_beneficiary_persona_immutable BEFORE UPDATE ON link_r165_specifies_beneficiary_persona BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r165_specifies_beneficiary_persona_insert BEFORE INSERT ON link_r165_specifies_beneficiary_persona BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:165 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:165 IC:PersonaSpecification') END;
END;
CREATE TRIGGER link_r166_references_metric_immutable BEFORE UPDATE ON link_r166_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r166_references_metric_insert BEFORE INSERT ON link_r166_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:166 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:166 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r167_supports_immutable BEFORE UPDATE ON link_r167_supports BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r167_supports_insert BEFORE INSERT ON link_r167_supports BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_quality_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:167 IC:QualityRequirementSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r168_identifies_opportunity_immutable BEFORE UPDATE ON link_r168_identifies_opportunity BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r168_identifies_opportunity_insert BEFORE INSERT ON link_r168_identifies_opportunity BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:168 IC:JourneySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_opportunity_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:168 IC:OpportunityStatement') END;
END;
CREATE TRIGGER link_r169_references_metric_immutable BEFORE UPDATE ON link_r169_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r169_references_metric_insert BEFORE INSERT ON link_r169_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:169 IC:JourneySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:169 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r170_identifies_opportunity_immutable BEFORE UPDATE ON link_r170_identifies_opportunity BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r170_identifies_opportunity_insert BEFORE INSERT ON link_r170_identifies_opportunity BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:170 IC:JourneyStageSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_opportunity_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:170 IC:OpportunityStatement') END;
END;
CREATE TRIGGER link_r171_references_metric_immutable BEFORE UPDATE ON link_r171_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r171_references_metric_insert BEFORE INSERT ON link_r171_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:171 IC:JourneyStageSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:171 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r172_addresses_problem_statement_immutable BEFORE UPDATE ON link_r172_addresses_problem_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r172_addresses_problem_statement_insert BEFORE INSERT ON link_r172_addresses_problem_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:172 IC:PositioningStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:172 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_r173_claims_differentiation_through_immutable BEFORE UPDATE ON link_r173_claims_differentiation_through BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r173_claims_differentiation_through_insert BEFORE INSERT ON link_r173_claims_differentiation_through BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:173 IC:PositioningStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:173 IC:CapabilitySpecification') END;
END;
CREATE TRIGGER link_r174_targets_message_persona_immutable BEFORE UPDATE ON link_r174_targets_message_persona BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r174_targets_message_persona_insert BEFORE INSERT ON link_r174_targets_message_persona BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_messaging_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:174 IC:MessagingSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:174 IC:PersonaSpecification') END;
END;
CREATE TRIGGER link_r175_references_message_feature_immutable BEFORE UPDATE ON link_r175_references_message_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r175_references_message_feature_insert BEFORE INSERT ON link_r175_references_message_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_messaging_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:175 IC:MessagingSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:175 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_r176_references_metric_immutable BEFORE UPDATE ON link_r176_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r176_references_metric_insert BEFORE INSERT ON link_r176_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:176 IC:GoToMarketSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:176 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r177_references_metric_immutable BEFORE UPDATE ON link_r177_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r177_references_metric_insert BEFORE INSERT ON link_r177_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_launch_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:177 IC:LaunchSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:177 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r178_references_metric_immutable BEFORE UPDATE ON link_r178_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r178_references_metric_insert BEFORE INSERT ON link_r178_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_marketing_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:178 IC:MarketingGoalSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:178 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r179_addresses_narrative_problem_immutable BEFORE UPDATE ON link_r179_addresses_narrative_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r179_addresses_narrative_problem_insert BEFORE INSERT ON link_r179_addresses_narrative_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_competitive_narrative c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:179 IC:CompetitiveNarrative') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:179 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_r180_claims_differentiation_through_immutable BEFORE UPDATE ON link_r180_claims_differentiation_through BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r180_claims_differentiation_through_insert BEFORE INSERT ON link_r180_claims_differentiation_through BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_competitive_narrative c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:180 IC:CompetitiveNarrative') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:180 IC:CapabilitySpecification') END;
END;
CREATE TRIGGER link_r181_hypothesizes_acquisition_for_problem_immutable BEFORE UPDATE ON link_r181_hypothesizes_acquisition_for_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r181_hypothesizes_acquisition_for_problem_insert BEFORE INSERT ON link_r181_hypothesizes_acquisition_for_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_acquisition_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:181 IC:AcquisitionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:181 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_r182_references_metric_immutable BEFORE UPDATE ON link_r182_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r182_references_metric_insert BEFORE INSERT ON link_r182_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_acquisition_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:182 IC:AcquisitionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:182 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r183_hypothesizes_adoption_for_problem_immutable BEFORE UPDATE ON link_r183_hypothesizes_adoption_for_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r183_hypothesizes_adoption_for_problem_insert BEFORE INSERT ON link_r183_hypothesizes_adoption_for_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_adoption_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:183 IC:AdoptionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:183 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_r184_references_metric_immutable BEFORE UPDATE ON link_r184_references_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r184_references_metric_insert BEFORE INSERT ON link_r184_references_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_adoption_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:184 IC:AdoptionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:184 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_r185_references_value_proposition_immutable BEFORE UPDATE ON link_r185_references_value_proposition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r185_references_value_proposition_insert BEFORE INSERT ON link_r185_references_value_proposition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:185 IC:Product') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r186_targets_immutable BEFORE UPDATE ON link_r186_targets BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r186_targets_insert BEFORE INSERT ON link_r186_targets BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_offering_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:186 IC:OfferingSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r187_includes_service_immutable BEFORE UPDATE ON link_r187_includes_service BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r187_includes_service_insert BEFORE INSERT ON link_r187_includes_service BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_offering_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:187 IC:OfferingSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r188_references_variant_configuration_immutable BEFORE UPDATE ON link_r188_references_variant_configuration BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r188_references_variant_configuration_insert BEFORE INSERT ON link_r188_references_variant_configuration BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_variant_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:188 IC:ProductVariantReference') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r189_targets_immutable BEFORE UPDATE ON link_r189_targets BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r189_targets_insert BEFORE INSERT ON link_r189_targets BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_vision_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:189 IC:VisionStatement') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r190_references_value_proposition_immutable BEFORE UPDATE ON link_r190_references_value_proposition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r190_references_value_proposition_insert BEFORE INSERT ON link_r190_references_value_proposition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_vision_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:190 IC:VisionStatement') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r192_references_immutable BEFORE UPDATE ON link_r192_references BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r192_references_insert BEFORE INSERT ON link_r192_references BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_solution_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:192 IC:ProblemSolutionFitAssessment') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r194_references_mental_model_immutable BEFORE UPDATE ON link_r194_references_mental_model BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r194_references_mental_model_insert BEFORE INSERT ON link_r194_references_mental_model BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_information_architecture_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:194 IC:InformationArchitectureSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r195_uses_script_immutable BEFORE UPDATE ON link_r195_uses_script BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r195_uses_script_insert BEFORE INSERT ON link_r195_uses_script BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_case c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:195 IC:TestCase') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r196_reported_under_test_plan_immutable BEFORE UPDATE ON link_r196_reported_under_test_plan BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r196_reported_under_test_plan_insert BEFORE INSERT ON link_r196_reported_under_test_plan BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:196 IC:TestResult') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r197_cites_execution_script_immutable BEFORE UPDATE ON link_r197_cites_execution_script BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r197_cites_execution_script_insert BEFORE INSERT ON link_r197_cites_execution_script BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:197 IC:TestResult') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r198_cites_supporting_evidence_immutable BEFORE UPDATE ON link_r198_cites_supporting_evidence BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r198_cites_supporting_evidence_insert BEFORE INSERT ON link_r198_cites_supporting_evidence BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_validation_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:198 IC:ValidationEvidenceRecord') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r199_references_dataset_configuration_immutable BEFORE UPDATE ON link_r199_references_dataset_configuration BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r199_references_dataset_configuration_insert BEFORE INSERT ON link_r199_references_dataset_configuration BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_test_data_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:199 IC:TestDataReference') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r200_targets_immutable BEFORE UPDATE ON link_r200_targets BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r200_targets_insert BEFORE INSERT ON link_r200_targets BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:200 IC:GoToMarketSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r201_targets_immutable BEFORE UPDATE ON link_r201_targets BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r201_targets_insert BEFORE INSERT ON link_r201_targets BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:201 IC:GoToMarketSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r202_references_value_proposition_immutable BEFORE UPDATE ON link_r202_references_value_proposition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r202_references_value_proposition_insert BEFORE INSERT ON link_r202_references_value_proposition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_go_to_market_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:202 IC:GoToMarketSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r203_targets_immutable BEFORE UPDATE ON link_r203_targets BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r203_targets_insert BEFORE INSERT ON link_r203_targets BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_launch_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:203 IC:LaunchSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r204_targets_immutable BEFORE UPDATE ON link_r204_targets BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r204_targets_insert BEFORE INSERT ON link_r204_targets BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_marketing_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:204 IC:MarketingGoalSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r207_cites_insight_evidence_immutable BEFORE UPDATE ON link_r207_cites_insight_evidence BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r207_cites_insight_evidence_insert BEFORE INSERT ON link_r207_cites_insight_evidence BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_marketing_insight_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:207 IC:MarketingInsightReference') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r208_addresses_need_immutable BEFORE UPDATE ON link_r208_addresses_need BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r208_addresses_need_insert BEFORE INSERT ON link_r208_addresses_need BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_offering_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:208 IC:OfferingSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r209_informed_by_immutable BEFORE UPDATE ON link_r209_informed_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r209_informed_by_insert BEFORE INSERT ON link_r209_informed_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_vision_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:209 IC:VisionStatement') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r210_assesses_need_immutable BEFORE UPDATE ON link_r210_assesses_need BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r210_assesses_need_insert BEFORE INSERT ON link_r210_assesses_need BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_product_market_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:210 IC:ProductMarketFitAssessment') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r211_assesses_pain_immutable BEFORE UPDATE ON link_r211_assesses_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r211_assesses_pain_insert BEFORE INSERT ON link_r211_assesses_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_product_market_fit_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:211 IC:ProductMarketFitAssessment') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r212_intends_to_address_need_immutable BEFORE UPDATE ON link_r212_intends_to_address_need BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r212_intends_to_address_need_insert BEFORE INSERT ON link_r212_intends_to_address_need BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:212 IC:FeatureSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r213_addresses_pain_immutable BEFORE UPDATE ON link_r213_addresses_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r213_addresses_pain_insert BEFORE INSERT ON link_r213_addresses_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_user_story_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:213 IC:UserStorySpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r214_describes_pain_immutable BEFORE UPDATE ON link_r214_describes_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r214_describes_pain_insert BEFORE INSERT ON link_r214_describes_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:214 IC:JourneySpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r215_describes_pain_immutable BEFORE UPDATE ON link_r215_describes_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r215_describes_pain_insert BEFORE INSERT ON link_r215_describes_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:215 IC:JourneyStageSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r216_intends_to_address_need_immutable BEFORE UPDATE ON link_r216_intends_to_address_need BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r216_intends_to_address_need_insert BEFORE INSERT ON link_r216_intends_to_address_need BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_touchpoint_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:216 IC:TouchpointSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r217_describes_pain_immutable BEFORE UPDATE ON link_r217_describes_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r217_describes_pain_insert BEFORE INSERT ON link_r217_describes_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_touchpoint_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:217 IC:TouchpointSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r218_cites_supporting_evidence_immutable BEFORE UPDATE ON link_r218_cites_supporting_evidence BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r218_cites_supporting_evidence_insert BEFORE INSERT ON link_r218_cites_supporting_evidence BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_release_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:218 IC:ReleaseEvidenceRecord') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r219_addresses_pain_immutable BEFORE UPDATE ON link_r219_addresses_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r219_addresses_pain_insert BEFORE INSERT ON link_r219_addresses_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:219 IC:PositioningStatement') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r220_addresses_pain_immutable BEFORE UPDATE ON link_r220_addresses_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r220_addresses_pain_insert BEFORE INSERT ON link_r220_addresses_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_messaging_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:220 IC:MessagingSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r221_supported_by_immutable BEFORE UPDATE ON link_r221_supported_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r221_supported_by_insert BEFORE INSERT ON link_r221_supported_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_messaging_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:221 IC:MessagingSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r222_differentiates_from_immutable BEFORE UPDATE ON link_r222_differentiates_from BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r222_differentiates_from_insert BEFORE INSERT ON link_r222_differentiates_from BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_competitive_narrative c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:222 IC:CompetitiveNarrative') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r223_supported_by_immutable BEFORE UPDATE ON link_r223_supported_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r223_supported_by_insert BEFORE INSERT ON link_r223_supported_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_competitive_narrative c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:223 IC:CompetitiveNarrative') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r224_evidenced_by_immutable BEFORE UPDATE ON link_r224_evidenced_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r224_evidenced_by_insert BEFORE INSERT ON link_r224_evidenced_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_acquisition_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:224 IC:AcquisitionHypothesisSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r225_addresses_pain_immutable BEFORE UPDATE ON link_r225_addresses_pain BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r225_addresses_pain_insert BEFORE INSERT ON link_r225_addresses_pain BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_adoption_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:225 IC:AdoptionHypothesisSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r226_evidenced_by_immutable BEFORE UPDATE ON link_r226_evidenced_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r226_evidenced_by_insert BEFORE INSERT ON link_r226_evidenced_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_adoption_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:226 IC:AdoptionHypothesisSpecification') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External boundary must use IRI') END;
END;
CREATE TRIGGER link_r22_motivates_opportunity_immutable BEFORE UPDATE ON link_r22_motivates_opportunity BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r22_motivates_opportunity_insert BEFORE INSERT ON link_r22_motivates_opportunity BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:022 IC:ProblemStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_opportunity_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:022 IC:OpportunityStatement') END;
END;
CREATE TRIGGER link_r51_describes_user_role_immutable BEFORE UPDATE ON link_r51_describes_user_role BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r51_describes_user_role_insert BEFORE INSERT ON link_r51_describes_user_role BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:051 IC:PersonaSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_role_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:051 IC:UserRoleSpecification') END;
END;
CREATE TRIGGER link_r52_represented_in_journey_immutable BEFORE UPDATE ON link_r52_represented_in_journey BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r52_represented_in_journey_insert BEFORE INSERT ON link_r52_represented_in_journey BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:052 IC:PersonaSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:052 IC:JourneySpecification') END;
END;
CREATE TRIGGER link_r54_includes_immutable BEFORE UPDATE ON link_r54_includes BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r54_includes_insert BEFORE INSERT ON link_r54_includes BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:054 IC:JourneyStageSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_touchpoint_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:054 IC:TouchpointSpecification') END;
END;
CREATE TRIGGER link_r55_described_by_flow_immutable BEFORE UPDATE ON link_r55_described_by_flow BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r55_described_by_flow_insert BEFORE INSERT ON link_r55_described_by_flow BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:055 IC:JourneyStageSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_flow_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:055 IC:UserFlowSpecification') END;
END;
CREATE TRIGGER link_r56_specifies_step_immutable BEFORE UPDATE ON link_r56_specifies_step BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r56_specifies_step_insert BEFORE INSERT ON link_r56_specifies_step BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_flow_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:056 IC:UserFlowSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_interaction_step_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:056 IC:InteractionStepSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d05_interaction_step_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_r56_specifies_step WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:056 maximum 1') END;
END;
CREATE TRIGGER link_r57_references_screen_immutable BEFORE UPDATE ON link_r57_references_screen BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r57_references_screen_insert BEFORE INSERT ON link_r57_references_screen BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_interaction_step_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:057 IC:InteractionStepSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_screen_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:057 IC:ScreenSpecification') END;
END;
CREATE TRIGGER link_r58_organizes_screen_specification_immutable BEFORE UPDATE ON link_r58_organizes_screen_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r58_organizes_screen_specification_insert BEFORE INSERT ON link_r58_organizes_screen_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_information_architecture_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:058 IC:InformationArchitectureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_screen_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:058 IC:ScreenSpecification') END;
END;
CREATE TRIGGER link_r59_defines_uistate_immutable BEFORE UPDATE ON link_r59_defines_uistate BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r59_defines_uistate_insert BEFORE INSERT ON link_r59_defines_uistate BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_screen_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:059 IC:ScreenSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_uistate_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:059 IC:UIStateSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d05_uistate_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_r59_defines_uistate WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:059 maximum 1') END;
END;
CREATE TRIGGER link_r60_reports_on_flow_immutable BEFORE UPDATE ON link_r60_reports_on_flow BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r60_reports_on_flow_insert BEFORE INSERT ON link_r60_reports_on_flow BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:060 IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_flow_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:060 IC:UserFlowSpecification') END;
END;
CREATE TRIGGER link_r61_reports_on_screen_immutable BEFORE UPDATE ON link_r61_reports_on_screen BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r61_reports_on_screen_insert BEFORE INSERT ON link_r61_reports_on_screen BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:061 IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_screen_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:061 IC:ScreenSpecification') END;
END;
CREATE TRIGGER link_r63_supported_by_immutable BEFORE UPDATE ON link_r63_supported_by BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r63_supported_by_insert BEFORE INSERT ON link_r63_supported_by BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_user_story_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:063 IC:UserStorySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_flow_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:063 IC:UserFlowSpecification') END;
END;
CREATE TRIGGER link_r64_organizes_roadmap_entry_immutable BEFORE UPDATE ON link_r64_organizes_roadmap_entry BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r64_organizes_roadmap_entry_insert BEFORE INSERT ON link_r64_organizes_roadmap_entry BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:064 IC:Roadmap') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:064 IC:RoadmapEntry') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_r64_organizes_roadmap_entry WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:064 maximum 1') END;
END;
CREATE TRIGGER link_r65_plans_initiative_immutable BEFORE UPDATE ON link_r65_plans_initiative BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r65_plans_initiative_insert BEFORE INSERT ON link_r65_plans_initiative BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:065 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:065 IC:InitiativeSpecification') END;
END;
CREATE TRIGGER link_r66_plans_feature_delivery_immutable BEFORE UPDATE ON link_r66_plans_feature_delivery BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r66_plans_feature_delivery_insert BEFORE INSERT ON link_r66_plans_feature_delivery BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:066 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:066 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_r67_targets_milestone_immutable BEFORE UPDATE ON link_r67_targets_milestone BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r67_targets_milestone_insert BEFORE INSERT ON link_r67_targets_milestone BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:067 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_milestone_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:067 IC:MilestoneSpecification') END;
END;
CREATE TRIGGER link_r68_has_priority_assessment_immutable BEFORE UPDATE ON link_r68_has_priority_assessment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r68_has_priority_assessment_insert BEFORE INSERT ON link_r68_has_priority_assessment BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:068 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_priority_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:068 IC:PriorityAssessment') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d06_priority_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_r68_has_priority_assessment WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:068 maximum 1') END;
END;
CREATE TRIGGER link_r69_uses_ranking_criterion_immutable BEFORE UPDATE ON link_r69_uses_ranking_criterion BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r69_uses_ranking_criterion_insert BEFORE INSERT ON link_r69_uses_ranking_criterion BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_priority_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:069 IC:PriorityAssessment') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_prioritization_criterion_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:069 IC:PrioritizationCriterionSpecification') END;
END;
CREATE TRIGGER link_r70_uses_horizon_definition_immutable BEFORE UPDATE ON link_r70_uses_horizon_definition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r70_uses_horizon_definition_insert BEFORE INSERT ON link_r70_uses_horizon_definition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:070 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_planning_horizon_definition c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:070 IC:PlanningHorizonDefinition') END;
END;
CREATE TRIGGER link_r71_has_target_window_assignment_immutable BEFORE UPDATE ON link_r71_has_target_window_assignment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r71_has_target_window_assignment_insert BEFORE INSERT ON link_r71_has_target_window_assignment BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:071 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_target_window_assignment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:071 IC:TargetWindowAssignment') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d06_target_window_assignment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_r71_has_target_window_assignment WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:071 maximum 1') END;
END;
CREATE TRIGGER link_r72_has_entry_confidence_assessment_immutable BEFORE UPDATE ON link_r72_has_entry_confidence_assessment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r72_has_entry_confidence_assessment_insert BEFORE INSERT ON link_r72_has_entry_confidence_assessment BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:072 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_confidence_assessment c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:072 IC:ConfidenceAssessment') END;
END;
CREATE TRIGGER link_r73_uses_commitment_level_definition_immutable BEFORE UPDATE ON link_r73_uses_commitment_level_definition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r73_uses_commitment_level_definition_insert BEFORE INSERT ON link_r73_uses_commitment_level_definition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:073 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_commitment_level_definition c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:073 IC:CommitmentLevelDefinition') END;
END;
CREATE TRIGGER link_r74_has_planning_dependency_immutable BEFORE UPDATE ON link_r74_has_planning_dependency BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r74_has_planning_dependency_insert BEFORE INSERT ON link_r74_has_planning_dependency BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:074 IC:RoadmapEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d06_roadmap_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:074 IC:RoadmapEntry') END;
END;
CREATE TRIGGER link_r75_plans_delivery_item_immutable BEFORE UPDATE ON link_r75_plans_delivery_item BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r75_plans_delivery_item_insert BEFORE INSERT ON link_r75_plans_delivery_item BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:075 IC:ReleaseSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:075 IC:DeliveryWorkItem') END;
END;
CREATE TRIGGER link_r76_references_change_record_immutable BEFORE UPDATE ON link_r76_references_change_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r76_references_change_record_insert BEFORE INSERT ON link_r76_references_change_record BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:076 IC:ReleaseSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:076 IC:ChangeRecord') END;
END;
CREATE TRIGGER link_r78_has_release_evidence_record_immutable BEFORE UPDATE ON link_r78_has_release_evidence_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r78_has_release_evidence_record_insert BEFORE INSERT ON link_r78_has_release_evidence_record BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:078 IC:ReleaseSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_release_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:078 IC:ReleaseEvidenceRecord') END;
END;
CREATE TRIGGER link_r79_proposes_recorded_change_immutable BEFORE UPDATE ON link_r79_proposes_recorded_change BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r79_proposes_recorded_change_insert BEFORE INSERT ON link_r79_proposes_recorded_change BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_proposal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:079 IC:ChangeProposalSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:079 IC:ChangeRecord') END;
END;
CREATE TRIGGER link_r80_plans_feature_immutable BEFORE UPDATE ON link_r80_plans_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r80_plans_feature_insert BEFORE INSERT ON link_r80_plans_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:080 IC:DeliveryWorkItem') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:080 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_r81_intended_to_contribute_to_work_immutable BEFORE UPDATE ON link_r81_intended_to_contribute_to_work BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r81_intended_to_contribute_to_work_insert BEFORE INSERT ON link_r81_intended_to_contribute_to_work BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_task_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:081 IC:TaskReference') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:081 IC:DeliveryWorkItem') END;
END;
CREATE TRIGGER link_r82_specifies_feature_activation_control_immutable BEFORE UPDATE ON link_r82_specifies_feature_activation_control BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r82_specifies_feature_activation_control_insert BEFORE INSERT ON link_r82_specifies_feature_activation_control BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_feature_flag_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:082 IC:FeatureFlagSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:082 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_r83_planned_for_release_immutable BEFORE UPDATE ON link_r83_planned_for_release BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r83_planned_for_release_insert BEFORE INSERT ON link_r83_planned_for_release BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:083 IC:ProductVersion') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:083 IC:ReleaseSpecification') END;
END;
CREATE TRIGGER link_r84_covers_immutable BEFORE UPDATE ON link_r84_covers BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r84_covers_insert BEFORE INSERT ON link_r84_covers BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_scenario c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:084 IC:TestScenario') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:084 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_r85_specifies_requirement_verification_immutable BEFORE UPDATE ON link_r85_specifies_requirement_verification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r85_specifies_requirement_verification_insert BEFORE INSERT ON link_r85_specifies_requirement_verification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_scenario c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:085 IC:TestScenario') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:085 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_r86_specifies_criterion_verification_immutable BEFORE UPDATE ON link_r86_specifies_criterion_verification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r86_specifies_criterion_verification_insert BEFORE INSERT ON link_r86_specifies_criterion_verification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_scenario c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:086 IC:TestScenario') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_acceptance_criterion_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:086 IC:AcceptanceCriterionSpecification') END;
END;
CREATE TRIGGER link_r87_refines_test_scenario_immutable BEFORE UPDATE ON link_r87_refines_test_scenario BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r87_refines_test_scenario_insert BEFORE INSERT ON link_r87_refines_test_scenario BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_case c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:087 IC:TestCase') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_scenario c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:087 IC:TestScenario') END;
END;
CREATE TRIGGER link_r89_references_test_data_immutable BEFORE UPDATE ON link_r89_references_test_data BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r89_references_test_data_insert BEFORE INSERT ON link_r89_references_test_data BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_case c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:089 IC:TestCase') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_test_data_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:089 IC:TestDataReference') END;
END;
CREATE TRIGGER link_r8_supersedes_immutable BEFORE UPDATE ON link_r8_supersedes BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r8_supersedes_insert BEFORE INSERT ON link_r8_supersedes BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:008 IC:ProductVersion') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:008 IC:ProductVersion') END;
END;
CREATE TRIGGER link_r92_has_verification_evidence_record_immutable BEFORE UPDATE ON link_r92_has_verification_evidence_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r92_has_verification_evidence_record_insert BEFORE INSERT ON link_r92_has_verification_evidence_record BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:092 IC:TestResult') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_verification_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:092 IC:VerificationEvidenceRecord') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_verification_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_r92_has_verification_evidence_record WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:092 maximum 0..1') END;
END;
CREATE TRIGGER link_r93_has_validation_evidence_record_immutable BEFORE UPDATE ON link_r93_has_validation_evidence_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r93_has_validation_evidence_record_insert BEFORE INSERT ON link_r93_has_validation_evidence_record BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:093 IC:TestResult') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_validation_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:093 IC:ValidationEvidenceRecord') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_validation_evidence_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_r93_has_validation_evidence_record WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:093 maximum 0..1') END;
END;
CREATE TRIGGER link_r94_has_positioning_statement_immutable BEFORE UPDATE ON link_r94_has_positioning_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r94_has_positioning_statement_insert BEFORE INSERT ON link_r94_has_positioning_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:094 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:094 IC:PositioningStatement') END;
END;
CREATE TRIGGER link_r95_positioned_by_statement_immutable BEFORE UPDATE ON link_r95_positioned_by_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r95_positioned_by_statement_insert BEFORE INSERT ON link_r95_positioned_by_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_offering_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:095 IC:OfferingSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:095 IC:PositioningStatement') END;
END;
CREATE TRIGGER link_r96_references_target_market_immutable BEFORE UPDATE ON link_r96_references_target_market BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r96_references_target_market_insert BEFORE INSERT ON link_r96_references_target_market BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:096 IC:PositioningStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_target_market_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:096 IC:TargetMarketReference') END;
END;
CREATE TRIGGER link_r97_references_target_segment_immutable BEFORE UPDATE ON link_r97_references_target_segment BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r97_references_target_segment_insert BEFORE INSERT ON link_r97_references_target_segment BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:097 IC:PositioningStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_target_segment_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:097 IC:TargetSegmentReference') END;
END;
CREATE TRIGGER link_r98_references_competitive_narrative_immutable BEFORE UPDATE ON link_r98_references_competitive_narrative BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r98_references_competitive_narrative_insert BEFORE INSERT ON link_r98_references_competitive_narrative BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:098 IC:PositioningStatement') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_competitive_narrative c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:098 IC:CompetitiveNarrative') END;
END;
CREATE TRIGGER link_r99_expresses_positioning_immutable BEFORE UPDATE ON link_r99_expresses_positioning BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_r99_expresses_positioning_insert BEFORE INSERT ON link_r99_expresses_positioning BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_messaging_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:099 IC:MessagingSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d09_positioning_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:099 IC:PositioningStatement') END;
END;
CREATE TRIGGER link_realizes_version_immutable BEFORE UPDATE ON link_realizes_version BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_realizes_version_insert BEFORE INSERT ON link_realizes_version BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_realization c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:realizesVersion IC:ProductRealization') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:realizesVersion IC:ProductVersion') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d11_product_realization c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_realizes_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'ICREL:CP:realizesVersion maximum 1') END;
END;
CREATE TRIGGER link_recorded_attribution_to_immutable BEFORE UPDATE ON link_recorded_attribution_to BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_recorded_attribution_to_insert BEFORE INSERT ON link_recorded_attribution_to BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_artifact c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:EU:attributedTo IC:EvidenceArtifact') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:EU:attributedTo IC:AssessmentClaim') END;
END;
CREATE TRIGGER link_records_affected_initiative_immutable BEFORE UPDATE ON link_records_affected_initiative BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_records_affected_initiative_insert BEFORE INSERT ON link_records_affected_initiative BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:027 IC:DecisionRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:027 IC:InitiativeSpecification') END;
END;
CREATE TRIGGER link_records_carrier_immutable BEFORE UPDATE ON link_records_carrier BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_records_carrier_insert BEFORE INSERT ON link_records_carrier BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:EU:usesEvidence IC:EvidenceAttributionRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_artifact c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:EU:usesEvidence IC:EvidenceArtifact') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_records_carrier WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'ICREL:EU:usesEvidence maximum 1') END;
END;
CREATE TRIGGER link_records_claim_immutable BEFORE UPDATE ON link_records_claim BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_records_claim_insert BEFORE INSERT ON link_records_claim BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:EU:assertsClaim IC:EvidenceAttributionRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:EU:assertsClaim IC:AssessmentClaim') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_records_claim WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'ICREL:EU:assertsClaim maximum 1') END;
END;
CREATE TRIGGER link_records_criterion_immutable BEFORE UPDATE ON link_records_criterion BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_records_criterion_insert BEFORE INSERT ON link_records_criterion BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:026 IC:DecisionRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_criterion_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:026 IC:DecisionCriterionSpecification') END;
END;
CREATE TRIGGER link_records_execution_immutable BEFORE UPDATE ON link_records_execution BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_records_execution_insert BEFORE INSERT ON link_records_execution BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:091 IC:TestExecution') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:091 IC:TestResult') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_records_execution WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:091 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_records_execution WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:091 maximum 1') END;
END;
CREATE TRIGGER link_reference_context_immutable BEFORE UPDATE ON link_reference_context BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_reference_context_insert BEFORE INSERT ON link_reference_context BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
END;
CREATE TRIGGER link_reference_provenance_immutable BEFORE UPDATE ON link_reference_provenance BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_reference_provenance_insert BEFORE INSERT ON link_reference_provenance BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
END;
CREATE TRIGGER link_reference_review_finding_immutable BEFORE UPDATE ON link_reference_review_finding BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_reference_review_finding_insert BEFORE INSERT ON link_reference_review_finding BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:referenceReviewFinding IC:ExternalReferenceRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:referenceReviewFinding IC:FindingRecord') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_reference_review_finding WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:ORSD05:referenceReviewFinding maximum 0..1') END;
END;
CREATE TRIGGER link_reference_supersedes_immutable BEFORE UPDATE ON link_reference_supersedes BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_reference_supersedes_insert BEFORE INSERT ON link_reference_supersedes BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:referenceSupersedes IC:ExternalReferenceRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:referenceSupersedes IC:ExternalReferenceRecord') END;
END;
CREATE TRIGGER link_reference_target_immutable BEFORE UPDATE ON link_reference_target BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_reference_target_insert BEFORE INSERT ON link_reference_target BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'External reference subject type required') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'IRI' THEN RAISE(ABORT,'External reference target must be an IRI') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_product_family_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:108 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_product_line_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:109 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_product_variant_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:110 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_business_rule_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:111 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:112 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_target_market_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:113 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_target_segment_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:114 maximum 1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d12_marketing_insight_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_reference_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:115 maximum 1') END;
END;
CREATE TRIGGER link_references_offering_immutable BEFORE UPDATE ON link_references_offering BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_references_offering_insert BEFORE INSERT ON link_references_offering BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_bundle_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:006 IC:BundleSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_offering_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:006 IC:OfferingSpecification') END;
END;
CREATE TRIGGER link_references_product_family_immutable BEFORE UPDATE ON link_references_product_family BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_references_product_family_insert BEFORE INSERT ON link_references_product_family BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:014 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_family_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:014 IC:ProductFamilyReference') END;
END;
CREATE TRIGGER link_references_product_immutable BEFORE UPDATE ON link_references_product BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_references_product_insert BEFORE INSERT ON link_references_product BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_portfolio_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:124 IC:PortfolioEntry') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:124 IC:Product') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_portfolio_entry c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_references_product WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:W2:124 maximum 0..1') END;
END;
CREATE TRIGGER link_references_product_line_immutable BEFORE UPDATE ON link_references_product_line BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_references_product_line_insert BEFORE INSERT ON link_references_product_line BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:015 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_line_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:015 IC:ProductLineReference') END;
END;
CREATE TRIGGER link_references_product_variant_immutable BEFORE UPDATE ON link_references_product_variant BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_references_product_variant_insert BEFORE INSERT ON link_references_product_variant BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:016 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_variant_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:016 IC:ProductVariantReference') END;
END;
CREATE TRIGGER link_references_rule_for_requirement_immutable BEFORE UPDATE ON link_references_rule_for_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_references_rule_for_requirement_insert BEFORE INSERT ON link_references_rule_for_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_business_rule_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:047 IC:BusinessRuleReference') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:047 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_refined_by_requirement_immutable BEFORE UPDATE ON link_refined_by_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_refined_by_requirement_insert BEFORE INSERT ON link_refined_by_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_user_story_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:043 IC:UserStorySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:043 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_release_status_change_immutable BEFORE UPDATE ON link_release_status_change BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_release_status_change_insert BEFORE INSERT ON link_release_status_change BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:releaseStatusChange IC:DeliveryStatusRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:releaseStatusChange IC:ChangeRecord') END;
END;
CREATE TRIGGER link_release_status_version_immutable BEFORE UPDATE ON link_release_status_version BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_release_status_version_insert BEFORE INSERT ON link_release_status_version BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:releaseStatusVersion IC:DeliveryStatusRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD05:releaseStatusVersion IC:ProductVersion') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_release_status_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD05:releaseStatusVersion maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_release_status_version WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER link_reports_status_immutable BEFORE UPDATE ON link_reports_status BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_reports_status_insert BEFORE INSERT ON link_reports_status BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_release_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:077 IC:ReleaseSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:077 IC:DeliveryStatusRecord') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_reports_status WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'REL:W2:077 maximum 1') END;
END;
CREATE TRIGGER link_represented_by_story_immutable BEFORE UPDATE ON link_represented_by_story BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_represented_by_story_insert BEFORE INSERT ON link_represented_by_story BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_vertical_slice_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:041 IC:VerticalSliceSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_user_story_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:041 IC:UserStorySpecification') END;
END;
CREATE TRIGGER link_scenario_context_immutable BEFORE UPDATE ON link_scenario_context BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_scenario_context_insert BEFORE INSERT ON link_scenario_context BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scenario_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
END;
CREATE TRIGGER link_scope_change_record_immutable BEFORE UPDATE ON link_scope_change_record BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_scope_change_record_insert BEFORE INSERT ON link_scope_change_record BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:scopeChangeRecord IC:ScopeSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:scopeChangeRecord IC:ChangeRecord') END;
END;
CREATE TRIGGER link_scope_supersedes_immutable BEFORE UPDATE ON link_scope_supersedes BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_scope_supersedes_insert BEFORE INSERT ON link_scope_supersedes BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:scopeSupersedes IC:ScopeSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:scopeSupersedes IC:ScopeSpecification') END;
END;
CREATE TRIGGER link_solution_hypothesizes_about_problem_immutable BEFORE UPDATE ON link_solution_hypothesizes_about_problem BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_solution_hypothesizes_about_problem_insert BEFORE INSERT ON link_solution_hypothesizes_about_problem BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_solution_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:129 IC:SolutionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_problem_statement c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:129 IC:ProblemStatement') END;
END;
CREATE TRIGGER link_solution_predicts_outcome_immutable BEFORE UPDATE ON link_solution_predicts_outcome BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_solution_predicts_outcome_insert BEFORE INSERT ON link_solution_predicts_outcome BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_solution_hypothesis_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:161 IC:SolutionHypothesisSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_outcome_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:161 IC:OutcomeSpecification') END;
END;
CREATE TRIGGER link_sources_requirement_immutable BEFORE UPDATE ON link_sources_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_sources_requirement_insert BEFORE INSERT ON link_sources_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_requirement_source_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:048 IC:RequirementSourceReference') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:048 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_specification_provenance_immutable BEFORE UPDATE ON link_specification_provenance BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specification_provenance_insert BEFORE INSERT ON link_specification_provenance BEGIN
SELECT 1;
END;
CREATE TRIGGER link_specified_by_requirement_immutable BEFORE UPDATE ON link_specified_by_requirement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specified_by_requirement_insert BEFORE INSERT ON link_specified_by_requirement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:131 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_requirement_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:131 IC:RequirementSpecification') END;
END;
CREATE TRIGGER link_specified_through_feature_immutable BEFORE UPDATE ON link_specified_through_feature BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specified_through_feature_insert BEFORE INSERT ON link_specified_through_feature BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:034 IC:CapabilitySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:034 IC:FeatureSpecification') END;
END;
CREATE TRIGGER link_specifies_capability_immutable BEFORE UPDATE ON link_specifies_capability BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specifies_capability_insert BEFORE INSERT ON link_specifies_capability BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:specifiesCapability IC:ProductVersion') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:specifiesCapability IC:CapabilitySpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d03_capability_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) AND (SELECT count(*) FROM link_specifies_capability WHERE snapshot_id=NEW.snapshot_id AND object_id=NEW.object_id)>=1 THEN RAISE(ABORT,'ICREL:CP:specifiesCapability maximum 1') END;
END;
CREATE TRIGGER link_specifies_expected_condition_immutable BEFORE UPDATE ON link_specifies_expected_condition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specifies_expected_condition_insert BEFORE INSERT ON link_specifies_expected_condition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scenario_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:SP:expectedCondition IC:ScenarioSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_condition_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:SP:expectedCondition IC:ConditionSpecification') END;
END;
CREATE TRIGGER link_specifies_outcome_metric_immutable BEFORE UPDATE ON link_specifies_outcome_metric BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specifies_outcome_metric_insert BEFORE INSERT ON link_specifies_outcome_metric BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_outcome_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:020 IC:OutcomeSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_product_metric_reference c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:020 IC:ProductMetricReference') END;
END;
CREATE TRIGGER link_specifies_persona_context_immutable BEFORE UPDATE ON link_specifies_persona_context BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specifies_persona_context_insert BEFORE INSERT ON link_specifies_persona_context BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d04_user_story_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:062 IC:UserStorySpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:062 IC:PersonaSpecification') END;
END;
CREATE TRIGGER link_specifies_slice_immutable BEFORE UPDATE ON link_specifies_slice BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_specifies_slice_insert BEFORE INSERT ON link_specifies_slice BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_feature_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:038 IC:FeatureSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_vertical_slice_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:038 IC:VerticalSliceSpecification') END;
END;
CREATE TRIGGER link_step_precedes_immutable BEFORE UPDATE ON link_step_precedes BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_step_precedes_insert BEFORE INSERT ON link_step_precedes BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_interaction_step_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:stepPrecedes IC:InteractionStepSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_interaction_step_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:stepPrecedes IC:InteractionStepSpecification') END;
END;
CREATE TRIGGER link_targets_outcome_immutable BEFORE UPDATE ON link_targets_outcome BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_targets_outcome_insert BEFORE INSERT ON link_targets_outcome BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_initiative_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:021 IC:InitiativeSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_outcome_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:021 IC:OutcomeSpecification') END;
END;
CREATE TRIGGER link_targets_outcome_specification_immutable BEFORE UPDATE ON link_targets_outcome_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_targets_outcome_specification_insert BEFORE INSERT ON link_targets_outcome_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_goal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:019 IC:GoalSpecification') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_outcome_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:019 IC:OutcomeSpecification') END;
END;
CREATE TRIGGER link_tests_realization_immutable BEFORE UPDATE ON link_tests_realization BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_tests_realization_insert BEFORE INSERT ON link_tests_realization BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:testsRealization IC:TestExecution') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d11_product_realization c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: ICREL:CP:testsRealization IC:ProductRealization') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_tests_realization WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'ICREL:CP:testsRealization maximum 1') END;
END;
CREATE TRIGGER link_usability_information_architecture_immutable BEFORE UPDATE ON link_usability_information_architecture BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_information_architecture_insert BEFORE INSERT ON link_usability_information_architecture BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityInformationArchitecture IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_information_architecture_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityInformationArchitecture IC:InformationArchitectureSpecification') END;
END;
CREATE TRIGGER link_usability_journey_immutable BEFORE UPDATE ON link_usability_journey BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_journey_insert BEFORE INSERT ON link_usability_journey BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityJourney IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityJourney IC:JourneySpecification') END;
END;
CREATE TRIGGER link_usability_journey_stage_immutable BEFORE UPDATE ON link_usability_journey_stage BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_journey_stage_insert BEFORE INSERT ON link_usability_journey_stage BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityJourneyStage IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_journey_stage_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityJourneyStage IC:JourneyStageSpecification') END;
END;
CREATE TRIGGER link_usability_persona_immutable BEFORE UPDATE ON link_usability_persona BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_persona_insert BEFORE INSERT ON link_usability_persona BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityPersona IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityPersona IC:PersonaSpecification') END;
END;
CREATE TRIGGER link_usability_step_immutable BEFORE UPDATE ON link_usability_step BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_step_insert BEFORE INSERT ON link_usability_step BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityStep IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_interaction_step_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityStep IC:InteractionStepSpecification') END;
END;
CREATE TRIGGER link_usability_touchpoint_immutable BEFORE UPDATE ON link_usability_touchpoint BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_touchpoint_insert BEFORE INSERT ON link_usability_touchpoint BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityTouchpoint IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_touchpoint_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityTouchpoint IC:TouchpointSpecification') END;
END;
CREATE TRIGGER link_usability_uistate_immutable BEFORE UPDATE ON link_usability_uistate BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_uistate_insert BEFORE INSERT ON link_usability_uistate BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityUIState IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_uistate_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityUIState IC:UIStateSpecification') END;
END;
CREATE TRIGGER link_usability_user_role_immutable BEFORE UPDATE ON link_usability_user_role BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_usability_user_role_insert BEFORE INSERT ON link_usability_user_role BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityUserRole IC:UsabilityFindingRecord') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_user_role_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD06:usabilityUserRole IC:UserRoleSpecification') END;
END;
CREATE TRIGGER link_uses_lifecycle_specification_immutable BEFORE UPDATE ON link_uses_lifecycle_specification BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_uses_lifecycle_specification_insert BEFORE INSERT ON link_uses_lifecycle_specification BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:009 IC:Product') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_lifecycle_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:W2:009 IC:LifecycleSpecification') END;
END;
CREATE TRIGGER link_version_scope_immutable BEFORE UPDATE ON link_version_scope BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER link_version_scope_insert BEFORE INSERT ON link_version_scope BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:versionScope IC:ProductVersion') END;
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.object_id) THEN RAISE(ABORT,'Endpoint type: REL:ORSD04:versionScope IC:ScopeSpecification') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM d01_product_version c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) AND (SELECT count(*) FROM link_version_scope WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id)>=1 THEN RAISE(ABORT,'REL:ORSD04:versionScope maximum 0..1') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM link_version_scope WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER observation_no_delete BEFORE DELETE ON occurrence_observation BEGIN SELECT RAISE(ABORT,'IMMUTABLE_OBSERVATION'); END;
CREATE TRIGGER observation_no_replace BEFORE INSERT ON occurrence_observation WHEN EXISTS(SELECT 1 FROM occurrence_observation WHERE observation_id=NEW.observation_id) BEGIN SELECT RAISE(ABORT,'IMMUTABLE_OBSERVATION'); END;
CREATE TRIGGER observation_no_update BEFORE UPDATE ON occurrence_observation BEGIN SELECT RAISE(ABORT,'IMMUTABLE_OBSERVATION'); END;
CREATE TRIGGER receipt_no_delete BEFORE DELETE ON admission_receipt
      BEGIN SELECT RAISE(ABORT,'RECEIPT_DELETE_FORBIDDEN'); END;
CREATE TRIGGER receipt_no_replace BEFORE INSERT ON admission_receipt
      WHEN EXISTS(SELECT 1 FROM admission_receipt WHERE snapshot_id=NEW.snapshot_id)
      BEGIN SELECT RAISE(ABORT,'RECEIPT_ALREADY_EXISTS'); END;
CREATE TRIGGER receipt_no_update BEFORE UPDATE ON admission_receipt
      BEGIN SELECT RAISE(ABORT,'IMMUTABLE_RECEIPT'); END;
CREATE TRIGGER residual_statement_immutable BEFORE UPDATE ON residual_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER residual_valid BEFORE INSERT ON residual_statement BEGIN
 SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.predicate_id)<>'IRI' THEN RAISE(ABORT,'Predicate must be IRI') END;
 SELECT CASE WHEN EXISTS(SELECT 1 FROM term WHERE term_id=NEW.object_id AND kind='BNODE' AND blank_scope<>NEW.snapshot_id) THEN RAISE(ABORT,'Cross-snapshot blank node') END;
END;
CREATE TRIGGER snapshot_immutable BEFORE UPDATE ON snapshot BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER term_immutable BEFORE UPDATE ON term BEGIN SELECT RAISE(ABORT,'Term identity is immutable'); END;
CREATE TRIGGER value_attribution_agent_immutable BEFORE UPDATE ON value_attribution_agent BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_attribution_agent_insert BEFORE INSERT ON value_attribution_agent BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_attribution_agent WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_attribution_source_immutable BEFORE UPDATE ON value_attribution_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_attribution_source_insert BEFORE INSERT ON value_attribution_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_attribution_stance_immutable BEFORE UPDATE ON value_attribution_stance BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_attribution_stance_insert BEFORE INSERT ON value_attribution_stance BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_attribution_stance WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_attribution_timestamp_immutable BEFORE UPDATE ON value_attribution_timestamp BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_attribution_timestamp_insert BEFORE INSERT ON value_attribution_timestamp BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_evidence_attribution_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_attribution_timestamp WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_change_occurrence_reference_immutable BEFORE UPDATE ON value_change_occurrence_reference BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_change_occurrence_reference_insert BEFORE INSERT ON value_change_occurrence_reference BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_change_occurrence_reference WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_change_recorded_at_immutable BEFORE UPDATE ON value_change_recorded_at BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_change_recorded_at_insert BEFORE INSERT ON value_change_recorded_at BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_change_recorded_at WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_change_source_immutable BEFORE UPDATE ON value_change_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_change_source_insert BEFORE INSERT ON value_change_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_change_statement_immutable BEFORE UPDATE ON value_change_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_change_statement_insert BEFORE INSERT ON value_change_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_change_statement WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_claim_statement_immutable BEFORE UPDATE ON value_claim_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_claim_statement_insert BEFORE INSERT ON value_claim_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_claim c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_claim_statement WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_condition_statement_immutable BEFORE UPDATE ON value_condition_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_condition_statement_insert BEFORE INSERT ON value_condition_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_condition_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_context_description_immutable BEFORE UPDATE ON value_context_description BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_context_description_insert BEFORE INSERT ON value_context_description BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_context_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_context_description WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_context_source_immutable BEFORE UPDATE ON value_context_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_context_source_insert BEFORE INSERT ON value_context_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_assessment_context_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_decision_rationale_immutable BEFORE UPDATE ON value_decision_rationale BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_decision_rationale_insert BEFORE INSERT ON value_decision_rationale BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_decision_rationale WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_decision_source_immutable BEFORE UPDATE ON value_decision_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_decision_source_insert BEFORE INSERT ON value_decision_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d02_decision_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_deferred_statement_immutable BEFORE UPDATE ON value_deferred_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_deferred_statement_insert BEFORE INSERT ON value_deferred_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_dependency_source_immutable BEFORE UPDATE ON value_dependency_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_dependency_source_insert BEFORE INSERT ON value_dependency_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d01_dependency_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_excluded_statement_immutable BEFORE UPDATE ON value_excluded_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_excluded_statement_insert BEFORE INSERT ON value_excluded_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_execution_ended_at_immutable BEFORE UPDATE ON value_execution_ended_at BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_execution_ended_at_insert BEFORE INSERT ON value_execution_ended_at BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_execution c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_execution_ended_at WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_finding_source_immutable BEFORE UPDATE ON value_finding_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_finding_source_insert BEFORE INSERT ON value_finding_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_finding_statement_immutable BEFORE UPDATE ON value_finding_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_finding_statement_insert BEFORE INSERT ON value_finding_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_finding_statement WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_included_statement_immutable BEFORE UPDATE ON value_included_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_included_statement_insert BEFORE INSERT ON value_included_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_item_status_code_immutable BEFORE UPDATE ON value_item_status_code BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_item_status_code_insert BEFORE INSERT ON value_item_status_code BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_item_status_code WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_item_status_reported_at_immutable BEFORE UPDATE ON value_item_status_reported_at BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_item_status_reported_at_insert BEFORE INSERT ON value_item_status_reported_at BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_item_status_reported_at WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_item_status_scheme_immutable BEFORE UPDATE ON value_item_status_scheme BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_item_status_scheme_insert BEFORE INSERT ON value_item_status_scheme BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_item_status_scheme WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_item_status_source_immutable BEFORE UPDATE ON value_item_status_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_item_status_source_insert BEFORE INSERT ON value_item_status_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_work_item_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_observed_authority_immutable BEFORE UPDATE ON value_observed_authority BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_observed_authority_insert BEFORE INSERT ON value_observed_authority BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_observed_authority WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_observed_target_immutable BEFORE UPDATE ON value_observed_target BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_observed_target_insert BEFORE INSERT ON value_observed_target BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_observed_target WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_persona_description_immutable BEFORE UPDATE ON value_persona_description BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_persona_description_insert BEFORE INSERT ON value_persona_description BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_persona_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_proposal_source_immutable BEFORE UPDATE ON value_proposal_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_proposal_source_insert BEFORE INSERT ON value_proposal_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_proposal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_proposal_statement_immutable BEFORE UPDATE ON value_proposal_statement BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_proposal_statement_insert BEFORE INSERT ON value_proposal_statement BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_change_proposal_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_proposal_statement WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_reference_purpose_immutable BEFORE UPDATE ON value_reference_purpose BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_reference_purpose_insert BEFORE INSERT ON value_reference_purpose BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_reference_recorded_at_immutable BEFORE UPDATE ON value_reference_recorded_at BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_reference_recorded_at_insert BEFORE INSERT ON value_reference_recorded_at BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_reference_recorded_at WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_reference_revision_label_immutable BEFORE UPDATE ON value_reference_revision_label BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_reference_revision_label_insert BEFORE INSERT ON value_reference_revision_label BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d12_external_reference_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_reference_revision_label WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_release_status_code_immutable BEFORE UPDATE ON value_release_status_code BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_release_status_code_insert BEFORE INSERT ON value_release_status_code BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_release_status_code WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_release_status_reported_at_immutable BEFORE UPDATE ON value_release_status_reported_at BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_release_status_reported_at_insert BEFORE INSERT ON value_release_status_reported_at BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_release_status_reported_at WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_release_status_scheme_immutable BEFORE UPDATE ON value_release_status_scheme BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_release_status_scheme_insert BEFORE INSERT ON value_release_status_scheme BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_release_status_scheme WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_release_status_source_immutable BEFORE UPDATE ON value_release_status_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_release_status_source_insert BEFORE INSERT ON value_release_status_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d07_delivery_status_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_result_outcome_immutable BEFORE UPDATE ON value_result_outcome BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_result_outcome_insert BEFORE INSERT ON value_result_outcome BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_result_outcome WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_result_recorded_at_immutable BEFORE UPDATE ON value_result_recorded_at BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_result_recorded_at_insert BEFORE INSERT ON value_result_recorded_at BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_result_recorded_at WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_result_source_immutable BEFORE UPDATE ON value_result_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_result_source_insert BEFORE INSERT ON value_result_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d08_test_result c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_review_reason_immutable BEFORE UPDATE ON value_review_reason BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_review_reason_insert BEFORE INSERT ON value_review_reason BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_review_reason WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_review_recorded_at_immutable BEFORE UPDATE ON value_review_recorded_at BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_review_recorded_at_insert BEFORE INSERT ON value_review_recorded_at BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d10_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#dateTime') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
SELECT CASE WHEN EXISTS(SELECT 1 FROM value_review_recorded_at WHERE snapshot_id=NEW.snapshot_id AND subject_id=NEW.subject_id) THEN RAISE(ABORT,'Functional property maximum') END;
END;
CREATE TRIGGER value_scenario_actions_immutable BEFORE UPDATE ON value_scenario_actions BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_scenario_actions_insert BEFORE INSERT ON value_scenario_actions BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scenario_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_scenario_precondition_immutable BEFORE UPDATE ON value_scenario_precondition BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_scenario_precondition_insert BEFORE INSERT ON value_scenario_precondition BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scenario_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_scope_source_immutable BEFORE UPDATE ON value_scope_source BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_scope_source_insert BEFORE INSERT ON value_scope_source BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d03_scope_specification c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#anyURI') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE TRIGGER value_usability_recommendation_immutable BEFORE UPDATE ON value_usability_recommendation BEGIN SELECT RAISE(ABORT,'Replace the snapshot; in-place updates are unsupported'); END;
CREATE TRIGGER value_usability_recommendation_insert BEFORE INSERT ON value_usability_recommendation BEGIN
SELECT CASE WHEN NOT EXISTS(SELECT 1 FROM d05_usability_finding_record c WHERE c.snapshot_id=NEW.snapshot_id AND c.entity_id=NEW.subject_id) THEN RAISE(ABORT,'Property subject type') END;
SELECT CASE WHEN (SELECT kind FROM term WHERE term_id=NEW.object_id)<>'LITERAL' THEN RAISE(ABORT,'Datatype property requires literal') END;
SELECT CASE WHEN (SELECT datatype FROM term WHERE term_id=NEW.object_id) NOT IN ('http://www.w3.org/2001/XMLSchema#string','') OR (SELECT language FROM term WHERE term_id=NEW.object_id)<>'' THEN RAISE(ABORT,'Datatype range') END;
END;
CREATE VIEW q_link_acquisition_cites_evidence AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_acquisition_cites_evidence l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_acquisition_cites_insight AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_acquisition_cites_insight l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_adoption_cites_evidence AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_adoption_cites_evidence l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_adoption_cites_insight AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_adoption_cites_insight l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_architecture_intended_realized_by_component AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_architecture_intended_realized_by_component l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_architecture_intended_realized_by_service AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_architecture_intended_realized_by_service l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_architecture_intended_satisfied_by_architecture_element AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_architecture_intended_satisfied_by_architecture_element l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_architecture_intended_satisfied_by_interface AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_architecture_intended_satisfied_by_interface l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_architecture_intended_supported_by_architecture_element AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_architecture_intended_supported_by_architecture_element l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_assesses_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_assesses_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_assesses_product AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_assesses_product l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_assesses_solution AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_assesses_solution l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_assesses_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_assesses_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_bears_capability AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_bears_capability l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_canonical_owner AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_canonical_owner l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_change_decision AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_change_decision l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_change_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_change_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_change_scope AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_change_scope l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_change_task AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_change_task l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_actual_capability AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_actual_capability l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_context AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_context l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_criterion AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_criterion l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_intended_capability AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_intended_capability l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_product AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_product l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_realization AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_realization l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_subject AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_subject l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_claim_version AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_claim_version l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_concerns_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_concerns_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_condition_context AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_condition_context l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_constrains_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_constrains_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_contains_case AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_contains_case l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_contains_product AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_contains_product l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_contains_stage AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_contains_stage l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_context_scenario AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_context_scenario l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_context_version AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_context_version l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_decision_considers_solution AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_decision_considers_solution l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_decision_evidence AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_decision_evidence l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_decision_selects_solution AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_decision_selects_solution l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_defines_lifecycle_stage AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_defines_lifecycle_stage l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_dependency_actual_capability_target AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_dependency_actual_capability_target l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_dependency_capability_specification_target AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_dependency_capability_specification_target l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_dependency_condition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_dependency_condition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_dependency_external_target AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_dependency_external_target l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_dependency_product_target AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_dependency_product_target l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_depends_on_enabler_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_depends_on_enabler_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_evaluated_against AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_evaluated_against l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_executes AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_executes l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_execution_context AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_execution_context l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_execution_criterion AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_execution_criterion l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_exemplified_by_scenario AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_exemplified_by_scenario l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_expected_enabled_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_expected_enabled_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_dependency_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_dependency_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_feature_criterion AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_feature_criterion l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_product_status_record AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_product_status_record l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_proposed_solution AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_proposed_solution l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_scope_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_scope_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_story_criterion AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_story_criterion l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_story_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_story_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_version AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_version l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_has_vision_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_has_vision_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_hypothesizes_about_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_hypothesizes_about_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_implements_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_implements_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_informs_initiative AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_informs_initiative l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_intended_to_enable_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_intended_to_enable_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_intends_capability AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_intends_capability l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_intends_to_address_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_intends_to_address_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_intends_to_contribute_to_outcome AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_intends_to_contribute_to_outcome l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_intends_to_support_goal AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_intends_to_support_goal l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_is_carrier_in_record AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_is_carrier_in_record l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_item_status AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_item_status l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_item_status_change AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_item_status_change l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_item_status_version AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_item_status_version l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_justifies_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_justifies_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_motivates_goal AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_motivates_goal l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_motivates_hypothesis AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_motivates_hypothesis l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_motivates_solution_hypothesis AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_motivates_solution_hypothesis l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_narrative_cites_evidence AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_narrative_cites_evidence l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_narrative_cites_insight AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_narrative_cites_insight l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_offering_of AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_offering_of l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_operationalized_by_criterion AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_operationalized_by_criterion l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_organizes_entry AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_organizes_entry l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_persona_context AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_persona_context l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_predicts_outcome AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_predicts_outcome l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_proposal_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_proposal_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_proposal_scope AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_proposal_scope l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_proposes_capability AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_proposes_capability l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_proposes_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_proposes_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r100_uses_positioning_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r100_uses_positioning_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r101_plans_launch AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r101_plans_launch l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r102_targets_marketing_goal AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r102_targets_marketing_goal l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r103_informs_positioning_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r103_informs_positioning_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r104_informs_go_to_market_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r104_informs_go_to_market_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r105_informs_go_to_market_from_acquisition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r105_informs_go_to_market_from_acquisition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r106_informs_go_to_market_from_adoption AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r106_informs_go_to_market_from_adoption l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r107_intended_to_support AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r107_intended_to_support l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r116_references AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r116_references l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r117_tracks_initiative AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r117_tracks_initiative l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r118_tracks_release_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r118_tracks_release_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r119_tracks_milestone_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r119_tracks_milestone_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r120_references_product_line AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r120_references_product_line l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r121_has_portfolio_confidence_assessment AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r121_has_portfolio_confidence_assessment l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r122_targets_persona AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r122_targets_persona l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r123_frames_journey AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r123_frames_journey l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r125_frames_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r125_frames_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r127_tracks_initiative_release_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r127_tracks_initiative_release_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r133_supported_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r133_supported_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r135_records_resolution_change AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r135_records_resolution_change l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r136_includes AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r136_includes l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r137_includes_screen AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r137_includes_screen l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r138_preceded_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r138_preceded_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r139_intends_to_support_goal AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r139_intends_to_support_goal l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r140_plans_entry_release AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r140_plans_entry_release l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r141_milestone_for_release_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r141_milestone_for_release_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r142_groups_planned_initiative AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r142_groups_planned_initiative l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r143_uses_window_horizon_definition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r143_uses_window_horizon_definition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r144_targets_release_goal AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r144_targets_release_goal l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r145_concerns_delivery_work_item AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r145_concerns_delivery_work_item l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r146_specifies_requirement_verification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r146_specifies_requirement_verification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r147_has_recorded_execution AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r147_has_recorded_execution l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r148_references_journey_stage AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r148_references_journey_stage l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r149_targets_launch_persona AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r149_targets_launch_persona l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r150_uses_launch_positioning AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r150_uses_launch_positioning l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r151_uses_launch_messaging AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r151_uses_launch_messaging l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r154_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r154_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r155_addresses AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r155_addresses l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r156_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r156_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r157_evidenced_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r157_evidenced_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r158_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r158_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r160_evidenced_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r160_evidenced_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r162_evidenced_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r162_evidenced_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r164_intends_to_address_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r164_intends_to_address_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r165_specifies_beneficiary_persona AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r165_specifies_beneficiary_persona l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r166_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r166_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r167_supports AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r167_supports l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r168_identifies_opportunity AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r168_identifies_opportunity l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r169_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r169_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r170_identifies_opportunity AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r170_identifies_opportunity l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r171_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r171_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r172_addresses_problem_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r172_addresses_problem_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r173_claims_differentiation_through AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r173_claims_differentiation_through l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r174_targets_message_persona AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r174_targets_message_persona l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r175_references_message_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r175_references_message_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r176_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r176_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r177_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r177_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r178_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r178_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r179_addresses_narrative_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r179_addresses_narrative_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r180_claims_differentiation_through AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r180_claims_differentiation_through l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r181_hypothesizes_acquisition_for_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r181_hypothesizes_acquisition_for_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r182_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r182_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r183_hypothesizes_adoption_for_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r183_hypothesizes_adoption_for_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r184_references_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r184_references_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r185_references_value_proposition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r185_references_value_proposition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r186_targets AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r186_targets l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r187_includes_service AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r187_includes_service l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r188_references_variant_configuration AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r188_references_variant_configuration l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r189_targets AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r189_targets l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r190_references_value_proposition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r190_references_value_proposition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r192_references AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r192_references l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r194_references_mental_model AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r194_references_mental_model l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r195_uses_script AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r195_uses_script l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r196_reported_under_test_plan AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r196_reported_under_test_plan l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r197_cites_execution_script AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r197_cites_execution_script l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r198_cites_supporting_evidence AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r198_cites_supporting_evidence l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r199_references_dataset_configuration AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r199_references_dataset_configuration l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r200_targets AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r200_targets l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r201_targets AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r201_targets l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r202_references_value_proposition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r202_references_value_proposition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r203_targets AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r203_targets l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r204_targets AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r204_targets l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r207_cites_insight_evidence AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r207_cites_insight_evidence l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r208_addresses_need AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r208_addresses_need l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r209_informed_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r209_informed_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r210_assesses_need AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r210_assesses_need l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r211_assesses_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r211_assesses_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r212_intends_to_address_need AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r212_intends_to_address_need l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r213_addresses_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r213_addresses_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r214_describes_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r214_describes_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r215_describes_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r215_describes_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r216_intends_to_address_need AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r216_intends_to_address_need l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r217_describes_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r217_describes_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r218_cites_supporting_evidence AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r218_cites_supporting_evidence l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r219_addresses_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r219_addresses_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r220_addresses_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r220_addresses_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r221_supported_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r221_supported_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r222_differentiates_from AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r222_differentiates_from l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r223_supported_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r223_supported_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r224_evidenced_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r224_evidenced_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r225_addresses_pain AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r225_addresses_pain l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r226_evidenced_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r226_evidenced_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r22_motivates_opportunity AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r22_motivates_opportunity l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r51_describes_user_role AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r51_describes_user_role l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r52_represented_in_journey AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r52_represented_in_journey l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r54_includes AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r54_includes l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r55_described_by_flow AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r55_described_by_flow l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r56_specifies_step AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r56_specifies_step l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r57_references_screen AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r57_references_screen l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r58_organizes_screen_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r58_organizes_screen_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r59_defines_uistate AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r59_defines_uistate l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r60_reports_on_flow AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r60_reports_on_flow l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r61_reports_on_screen AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r61_reports_on_screen l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r63_supported_by AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r63_supported_by l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r64_organizes_roadmap_entry AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r64_organizes_roadmap_entry l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r65_plans_initiative AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r65_plans_initiative l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r66_plans_feature_delivery AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r66_plans_feature_delivery l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r67_targets_milestone AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r67_targets_milestone l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r68_has_priority_assessment AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r68_has_priority_assessment l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r69_uses_ranking_criterion AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r69_uses_ranking_criterion l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r70_uses_horizon_definition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r70_uses_horizon_definition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r71_has_target_window_assignment AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r71_has_target_window_assignment l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r72_has_entry_confidence_assessment AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r72_has_entry_confidence_assessment l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r73_uses_commitment_level_definition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r73_uses_commitment_level_definition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r74_has_planning_dependency AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r74_has_planning_dependency l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r75_plans_delivery_item AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r75_plans_delivery_item l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r76_references_change_record AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r76_references_change_record l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r78_has_release_evidence_record AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r78_has_release_evidence_record l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r79_proposes_recorded_change AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r79_proposes_recorded_change l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r80_plans_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r80_plans_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r81_intended_to_contribute_to_work AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r81_intended_to_contribute_to_work l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r82_specifies_feature_activation_control AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r82_specifies_feature_activation_control l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r83_planned_for_release AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r83_planned_for_release l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r84_covers AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r84_covers l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r85_specifies_requirement_verification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r85_specifies_requirement_verification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r86_specifies_criterion_verification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r86_specifies_criterion_verification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r87_refines_test_scenario AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r87_refines_test_scenario l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r89_references_test_data AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r89_references_test_data l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r8_supersedes AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r8_supersedes l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r92_has_verification_evidence_record AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r92_has_verification_evidence_record l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r93_has_validation_evidence_record AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r93_has_validation_evidence_record l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r94_has_positioning_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r94_has_positioning_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r95_positioned_by_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r95_positioned_by_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r96_references_target_market AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r96_references_target_market l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r97_references_target_segment AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r97_references_target_segment l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r98_references_competitive_narrative AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r98_references_competitive_narrative l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_r99_expresses_positioning AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_r99_expresses_positioning l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_realizes_version AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_realizes_version l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_recorded_attribution_to AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_recorded_attribution_to l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_records_affected_initiative AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_records_affected_initiative l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_records_carrier AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_records_carrier l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_records_claim AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_records_claim l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_records_criterion AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_records_criterion l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_records_execution AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_records_execution l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_reference_context AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_reference_context l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_reference_provenance AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_reference_provenance l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_reference_review_finding AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_reference_review_finding l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_reference_supersedes AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_reference_supersedes l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_reference_target AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_reference_target l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_references_offering AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_references_offering l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_references_product AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_references_product l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_references_product_family AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_references_product_family l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_references_product_line AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_references_product_line l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_references_product_variant AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_references_product_variant l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_references_rule_for_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_references_rule_for_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_refined_by_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_refined_by_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_release_status_change AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_release_status_change l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_release_status_version AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_release_status_version l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_reports_status AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_reports_status l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_represented_by_story AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_represented_by_story l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_scenario_context AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_scenario_context l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_scope_change_record AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_scope_change_record l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_scope_supersedes AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_scope_supersedes l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_solution_hypothesizes_about_problem AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_solution_hypothesizes_about_problem l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_solution_predicts_outcome AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_solution_predicts_outcome l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_sources_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_sources_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specification_provenance AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specification_provenance l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specified_by_requirement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specified_by_requirement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specified_through_feature AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specified_through_feature l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specifies_capability AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specifies_capability l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specifies_expected_condition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specifies_expected_condition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specifies_outcome_metric AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specifies_outcome_metric l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specifies_persona_context AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specifies_persona_context l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_specifies_slice AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_specifies_slice l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_step_precedes AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_step_precedes l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_targets_outcome AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_targets_outcome l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_targets_outcome_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_targets_outcome_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_tests_realization AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_tests_realization l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_information_architecture AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_information_architecture l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_journey AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_journey l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_journey_stage AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_journey_stage l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_persona AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_persona l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_step AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_step l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_touchpoint AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_touchpoint l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_uistate AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_uistate l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_usability_user_role AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_usability_user_role l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_uses_lifecycle_specification AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_uses_lifecycle_specification l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_link_version_scope AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM link_version_scope l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_attribution_agent AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_attribution_agent l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_attribution_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_attribution_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_attribution_stance AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_attribution_stance l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_attribution_timestamp AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_attribution_timestamp l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_change_occurrence_reference AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_change_occurrence_reference l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_change_recorded_at AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_change_recorded_at l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_change_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_change_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_change_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_change_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_claim_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_claim_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_condition_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_condition_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_context_description AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_context_description l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_context_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_context_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_decision_rationale AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_decision_rationale l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_decision_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_decision_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_deferred_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_deferred_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_dependency_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_dependency_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_excluded_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_excluded_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_execution_ended_at AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_execution_ended_at l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_finding_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_finding_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_finding_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_finding_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_included_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_included_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_item_status_code AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_item_status_code l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_item_status_reported_at AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_item_status_reported_at l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_item_status_scheme AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_item_status_scheme l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_item_status_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_item_status_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_observed_authority AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_observed_authority l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_observed_target AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_observed_target l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_persona_description AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_persona_description l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_proposal_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_proposal_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_proposal_statement AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_proposal_statement l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_reference_purpose AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_reference_purpose l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_reference_recorded_at AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_reference_recorded_at l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_reference_revision_label AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_reference_revision_label l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_release_status_code AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_release_status_code l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_release_status_reported_at AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_release_status_reported_at l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_release_status_scheme AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_release_status_scheme l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_release_status_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_release_status_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_result_outcome AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_result_outcome l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_result_recorded_at AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_result_recorded_at l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_result_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_result_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_review_reason AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_review_reason l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_review_recorded_at AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_review_recorded_at l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_scenario_actions AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_scenario_actions l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_scenario_precondition AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_scenario_precondition l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_scope_source AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_scope_source l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
CREATE VIEW q_value_usability_recommendation AS SELECT l.snapshot_id,l.subject_id,l.object_id,s.lexical AS subject,o.lexical AS object,o.kind AS object_kind,o.datatype,o.language FROM value_usability_recommendation l JOIN term s ON s.term_id=l.subject_id JOIN term o ON o.term_id=l.object_id;
