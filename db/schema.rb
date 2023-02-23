# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_02_22_171923) do

  create_table "community_program_demographic_groups", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "demographic_group_id"
    t.integer "attributable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attributable_type", default: "CommunityProgram"
    t.index ["attributable_id", "demographic_group_id"], name: "cpdg_cpid_dgid"
    t.index ["demographic_group_id", "attributable_id"], name: "cpdg_dgid_cpid"
  end

  create_table "community_program_ethnicity_culture_groups", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "attributable_id"
    t.integer "ethnicity_culture_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attributable_type", default: "CommunityProgram"
    t.index ["attributable_id", "ethnicity_culture_group_id"], name: "cpecg_cpid_ecgid"
    t.index ["ethnicity_culture_group_id", "attributable_id"], name: "cpecg_ecgid_cpid"
  end

  create_table "community_program_grade_levels", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "grade_level_id"
    t.integer "attributable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attributable_type", default: "CommunityProgram"
    t.index ["attributable_id", "grade_level_id"], name: "cpgl_cpid_glid"
    t.index ["grade_level_id", "attributable_id"], name: "cpgl_glid_cpid"
  end

  create_table "community_program_quality_element_service_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "community_program_quality_element_id"
    t.integer "service_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["community_program_quality_element_id", "service_type_id"], name: "cpqest_cpqeid_stid"
    t.index ["service_type_id", "community_program_quality_element_id"], name: "cpqest_stid_cpqeid"
  end

  create_table "community_program_quality_elements", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "community_program_id"
    t.integer "quality_element_id"
    t.string "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["community_program_id", "quality_element_id"], name: "cpqe_cpi_qei"
    t.index ["community_program_id", "type"], name: "cpqe_cpi_type"
    t.index ["quality_element_id", "community_program_id"], name: "cpqe_qei_cpi"
    t.index ["type", "community_program_id"], name: "cpqe_type_cpi"
  end

  create_table "community_program_service_days", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "attributable_id"
    t.integer "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attributable_type", default: "CommunityProgram"
    t.index ["attributable_id", "day_id"], name: "cpsd_cpid_did"
    t.index ["day_id", "attributable_id"], name: "cpsd_did_cpid"
  end

  create_table "community_program_service_times", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "attributable_id"
    t.integer "service_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attributable_type", default: "CommunityProgram"
    t.index ["attributable_id", "service_time_id"], name: "cpst_cpid_stid"
    t.index ["service_time_id", "attributable_id"], name: "cpst_stid_cpid"
  end

  create_table "community_programs", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "school_id"
    t.integer "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "notes"
    t.integer "user_id"
    t.integer "school_user_id"
    t.text "service_description"
    t.boolean "site_agreement_on_file"
    t.boolean "mou_on_file"
    t.integer "student_population_id"
    t.string "name"
    t.string "legislative_file_number"
    t.datetime "last_verified_at"
    t.boolean "active", default: false
    t.integer "active_changed_by"
    t.datetime "active_changed_on"
    t.integer "last_verified_by"
    t.float "completion_rate", default: 0.0
    t.boolean "receives_district_funding"
    t.string "missing_fields", limit: 15000, default: "[]"
    t.boolean "approved_for_public", default: false
    t.datetime "approved_for_public_on"
    t.integer "approved_for_public_by"
    t.boolean "personal_services_contract", default: false
    t.boolean "memorandum_of_understanding", default: false
    t.boolean "alignment_agreement", default: false
    t.boolean "data_sharing_agreement", default: false
    t.boolean "levy_funded"
    t.boolean "creative_advantage_roster"
    t.boolean "youth_services_programming_roster"
    t.string "url"
    t.index ["active"], name: "index_community_programs_on_active"
    t.index ["last_verified_by"], name: "index_community_programs_on_last_verified_by"
    t.index ["organization_id"], name: "index_community_programs_on_organization_id"
    t.index ["school_id"], name: "index_community_programs_on_school_id"
    t.index ["school_user_id"], name: "index_community_programs_on_school_user_id"
    t.index ["user_id"], name: "index_community_programs_on_user_id"
  end

  create_table "cte_event_type_organizations", charset: "utf8", force: :cascade do |t|
    t.integer "cte_event_type_id"
    t.integer "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cte_event_types", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "days", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographic_groups", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", charset: "latin1", force: :cascade do |t|
    t.integer "school_program_id"
    t.integer "student_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_program_id", "student_id"], name: "index_enrollments_on_school_program_id_and_student_id"
    t.index ["student_id", "school_program_id"], name: "index_enrollments_on_student_id_and_school_program_id"
  end

  create_table "ethnicity_culture_groups", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_levels", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legal_statuses", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.integer "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state_code"
    t.boolean "active", default: true
    t.string "site_code"
    t.string "site_type"
    t.string "site_type_norm"
    t.string "address"
    t.string "city"
    t.string "zip_code"
    t.string "grades_served"
    t.string "low_grade"
    t.string "high_grade"
    t.float "lat"
    t.float "lng"
    t.string "type", default: "School"
    t.index ["active"], name: "index_schools_on_active_and_direct_funded_charter_school"
    t.index ["active"], name: "index_schools_on_direct_funded_charter_school_and_active"
    t.index ["site_code"], name: "index_locations_on_site_code", unique: true
    t.index ["state_code"], name: "index_locations_on_state_code", unique: true
  end
    t.integer "organization_quality_element_id"
    t.integer "service_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organization_quality_elements", charset: "utf8", force: :cascade do |t|
    t.integer "organization_id"
    t.integer "quality_element_id"
    t.string "element_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizations", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url"
    t.string "address"
    t.string "city"
    t.string "zip_code"
    t.string "phone_number"
    t.text "notes"
    t.boolean "board_approved_contract"
    t.string "legislative_file_number"
    t.datetime "last_verified_at"
    t.text "mission_statement"
    t.text "services_description"
    t.text "program_impact"
    t.text "total_cost"
    t.integer "legal_status_id"
    t.integer "last_verified_by"
    t.float "completion_rate", default: 0.0
    t.integer "user_id"
    t.boolean "receives_district_funding"
    t.boolean "subcontractor_with_lead_agency", default: false
    t.string "missing_fields", limit: 15000, default: "[]"
    t.boolean "approved_for_public", default: false
    t.datetime "approved_for_public_on"
    t.integer "approved_for_public_by"
    t.boolean "personal_services_contract"
    t.boolean "memorandum_of_understanding"
    t.boolean "alignment_agreement"
    t.boolean "data_sharing_agreement"
    t.boolean "participates_in_cte", default: false
    t.text "cte_notes"
    t.index ["last_verified_by"], name: "index_organizations_on_last_verified_by"
    t.index ["legal_status_id"], name: "index_organizations_on_legal_status_id"
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "page_views", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "method"
    t.boolean "xhr"
    t.string "url", limit: 5000
    t.string "referer", limit: 5000
    t.string "remote_ip"
    t.string "user_agent"
    t.integer "completed_in"
    t.string "controller"
    t.string "action"
    t.string "id_parameter"
    t.integer "status"
    t.integer "pid"
    t.datetime "created_at"
    t.index ["user_id"], name: "index_page_views_on_user_id"
  end

  create_table "quality_element_service_types", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "quality_element_id"
    t.integer "service_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["quality_element_id", "service_type_id"], name: "qest_qe_id_st_id"
    t.index ["service_type_id", "quality_element_id"], name: "qest_st_id_qe_id"
  end

  create_table "quality_elements", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "element_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "identifier"
    t.index ["element_type"], name: "index_quality_elements_on_element_type"
  end

  create_table "regions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["identifier"], name: "index_roles_on_identifier"
  end

  create_table "school_free_reduced_meal_data", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "school_id"
    t.datetime "date"
    t.string "school_year"
    t.boolean "provision_two_three_school"
    t.string "data_source"
    t.string "low_grade"
    t.string "high_grade"
    t.integer "enrollment_k_12"
    t.integer "free_meal_count_k_12"
    t.float "percent_eligible_free_k_12"
    t.integer "frpm_total_undup_count_k_12"
    t.float "frpm_percent_eligible_k_12"
    t.integer "enrollment_5_17"
    t.integer "free_meal_count_5_17"
    t.float "percent_eligible_5_17"
    t.integer "frpm_total_undup_count_5_17"
    t.float "frpm_percent_eligible_5_17"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["date"], name: "index_school_free_reduced_meal_data_on_date"
    t.index ["school_id"], name: "index_school_free_reduced_meal_data_on_school_id"
  end

  create_table "school_programs", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "school_id"
    t.integer "community_program_id"
    t.integer "user_id"
    t.integer "student_population_id"
    t.boolean "site_agreement_on_file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_verified_at"
    t.boolean "active", default: true
    t.integer "active_changed_by"
    t.datetime "active_changed_on"
    t.float "completion_rate", default: 0.0
    t.string "missing_fields", limit: 15000, default: "[]"
    t.index ["active", "community_program_id"], name: "index_school_programs_on_active_and_community_program_id"
    t.index ["community_program_id", "active"], name: "index_school_programs_on_community_program_id_and_active"
    t.index ["community_program_id", "school_id"], name: "sp_cpid_sid"
    t.index ["school_id", "community_program_id"], name: "sp_sid_cpid"
    t.index ["student_population_id"], name: "index_school_programs_on_student_population_id"
    t.index ["user_id"], name: "index_school_programs_on_user_id"
  end

  create_table "school_quality_indicator_sub_areas", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_times", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_types", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_populations", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position", default: 1
    t.index ["position"], name: "index_user_roles_on_position"
    t.index ["role_id", "user_id"], name: "index_user_roles_on_role_id_and_user_id"
    t.index ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id"
  end

  create_table "user_schools", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "school_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["school_id", "user_id"], name: "us_s_id_u_id"
    t.index ["user_id", "school_id"], name: "us_u_id_s_id"
  end

  create_table "users", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "phone_number"
    t.integer "organization_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.boolean "active", default: false
    t.string "title"
    t.date "attended_orientation_at"
    t.integer "orientation_type_id"
    t.index ["active"], name: "index_users_on_active"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token"
    t.index ["invited_by_id", "invited_by_type"], name: "u_ib_id_ib_type"
    t.index ["invited_by_type", "invited_by_id"], name: "u_ib_type_ib_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.text "associations"
    t.integer "current_user_id"
    t.datetime "created_at"
    t.index ["current_user_id"], name: "index_versions_on_current_user_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
