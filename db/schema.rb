# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170607001626) do

  create_table "community_program_demographic_groups", force: :cascade do |t|
    t.integer  "demographic_group_id", limit: 4
    t.integer  "attributable_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attributable_type",    limit: 255, default: "CommunityProgram"
  end

  add_index "community_program_demographic_groups", ["attributable_id", "demographic_group_id"], name: "cpdg_cpid_dgid", using: :btree
  add_index "community_program_demographic_groups", ["demographic_group_id", "attributable_id"], name: "cpdg_dgid_cpid", using: :btree

  create_table "community_program_ethnicity_culture_groups", force: :cascade do |t|
    t.integer  "attributable_id",            limit: 4
    t.integer  "ethnicity_culture_group_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attributable_type",          limit: 255, default: "CommunityProgram"
  end

  add_index "community_program_ethnicity_culture_groups", ["attributable_id", "ethnicity_culture_group_id"], name: "cpecg_cpid_ecgid", using: :btree
  add_index "community_program_ethnicity_culture_groups", ["ethnicity_culture_group_id", "attributable_id"], name: "cpecg_ecgid_cpid", using: :btree

  create_table "community_program_grade_levels", force: :cascade do |t|
    t.integer  "grade_level_id",    limit: 4
    t.integer  "attributable_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attributable_type", limit: 255, default: "CommunityProgram"
  end

  add_index "community_program_grade_levels", ["attributable_id", "grade_level_id"], name: "cpgl_cpid_glid", using: :btree
  add_index "community_program_grade_levels", ["grade_level_id", "attributable_id"], name: "cpgl_glid_cpid", using: :btree

  create_table "community_program_quality_element_service_types", force: :cascade do |t|
    t.integer  "community_program_quality_element_id", limit: 4
    t.integer  "service_type_id",                      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_program_quality_element_service_types", ["community_program_quality_element_id", "service_type_id"], name: "cpqest_cpqeid_stid", using: :btree
  add_index "community_program_quality_element_service_types", ["service_type_id", "community_program_quality_element_id"], name: "cpqest_stid_cpqeid", using: :btree

  create_table "community_program_quality_elements", force: :cascade do |t|
    t.integer  "community_program_id", limit: 4
    t.integer  "quality_element_id",   limit: 4
    t.string   "type",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_program_quality_elements", ["community_program_id", "quality_element_id"], name: "cpqe_cpi_qei", using: :btree
  add_index "community_program_quality_elements", ["community_program_id", "type"], name: "cpqe_cpi_type", using: :btree
  add_index "community_program_quality_elements", ["quality_element_id", "community_program_id"], name: "cpqe_qei_cpi", using: :btree
  add_index "community_program_quality_elements", ["type", "community_program_id"], name: "cpqe_type_cpi", using: :btree

  create_table "community_program_service_days", force: :cascade do |t|
    t.integer  "attributable_id",   limit: 4
    t.integer  "day_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attributable_type", limit: 255, default: "CommunityProgram"
  end

  add_index "community_program_service_days", ["attributable_id", "day_id"], name: "cpsd_cpid_did", using: :btree
  add_index "community_program_service_days", ["day_id", "attributable_id"], name: "cpsd_did_cpid", using: :btree

  create_table "community_program_service_times", force: :cascade do |t|
    t.integer  "attributable_id",   limit: 4
    t.integer  "service_time_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attributable_type", limit: 255, default: "CommunityProgram"
  end

  add_index "community_program_service_times", ["attributable_id", "service_time_id"], name: "cpst_cpid_stid", using: :btree
  add_index "community_program_service_times", ["service_time_id", "attributable_id"], name: "cpst_stid_cpid", using: :btree

  create_table "community_programs", force: :cascade do |t|
    t.integer  "school_id",                 limit: 4
    t.integer  "organization_id",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes",                     limit: 65535
    t.integer  "user_id",                   limit: 4
    t.integer  "school_user_id",            limit: 4
    t.text     "service_description",       limit: 65535
    t.boolean  "site_agreement_on_file"
    t.boolean  "mou_on_file"
    t.integer  "student_population_id",     limit: 4
    t.string   "name",                      limit: 255
    t.string   "legislative_file_number",   limit: 255
    t.datetime "last_verified_at"
    t.boolean  "active",                                  default: false
    t.integer  "active_changed_by",         limit: 4
    t.datetime "active_changed_on"
    t.integer  "last_verified_by",          limit: 4
    t.float    "completion_rate",           limit: 24,    default: 0.0
    t.boolean  "receives_district_funding"
    t.string   "missing_fields",            limit: 15000, default: "[]"
    t.boolean  "approved_for_public",                     default: false
    t.datetime "approved_for_public_on"
    t.integer  "approved_for_public_by",    limit: 4
  end

  add_index "community_programs", ["active"], name: "index_community_programs_on_active", using: :btree
  add_index "community_programs", ["last_verified_by"], name: "index_community_programs_on_last_verified_by", using: :btree
  add_index "community_programs", ["organization_id"], name: "index_community_programs_on_organization_id", using: :btree
  add_index "community_programs", ["school_id"], name: "index_community_programs_on_school_id", using: :btree
  add_index "community_programs", ["school_user_id"], name: "index_community_programs_on_school_user_id", using: :btree
  add_index "community_programs", ["user_id"], name: "index_community_programs_on_user_id", using: :btree

  create_table "days", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographic_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ethnicity_culture_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_levels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legal_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",                           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",                            limit: 255
    t.string   "address",                        limit: 255
    t.string   "city",                           limit: 255
    t.string   "zip_code",                       limit: 255
    t.string   "phone_number",                   limit: 255
    t.text     "notes",                          limit: 65535
    t.boolean  "board_approved_contract"
    t.string   "legislative_file_number",        limit: 255
    t.datetime "last_verified_at"
    t.text     "mission_statement",              limit: 65535
    t.text     "services_description",           limit: 65535
    t.text     "program_impact",                 limit: 65535
    t.text     "total_cost",                     limit: 65535
    t.integer  "legal_status_id",                limit: 4
    t.integer  "last_verified_by",               limit: 4
    t.float    "completion_rate",                limit: 24,    default: 0.0
    t.boolean  "receives_district_funding"
    t.boolean  "subcontractor_with_lead_agency",               default: false
    t.string   "missing_fields",                 limit: 15000, default: "[]"
    t.integer  "user_id",                        limit: 4
    t.boolean  "approved_for_public",                          default: false
    t.datetime "approved_for_public_on"
    t.integer  "approved_for_public_by",         limit: 4
  end

  add_index "organizations", ["last_verified_by"], name: "index_organizations_on_last_verified_by", using: :btree
  add_index "organizations", ["legal_status_id"], name: "index_organizations_on_legal_status_id", using: :btree
  add_index "organizations", ["user_id"], name: "index_organizations_on_user_id", using: :btree

  create_table "page_views", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "method",       limit: 255
    t.boolean  "xhr"
    t.string   "url",          limit: 5000
    t.string   "referer",      limit: 5000
    t.string   "remote_ip",    limit: 255
    t.string   "user_agent",   limit: 255
    t.integer  "completed_in", limit: 4
    t.string   "controller",   limit: 255
    t.string   "action",       limit: 255
    t.string   "id_parameter", limit: 255
    t.integer  "status",       limit: 4
    t.integer  "pid",          limit: 4
    t.datetime "created_at"
  end

  add_index "page_views", ["user_id"], name: "index_page_views_on_user_id", using: :btree

  create_table "quality_element_service_types", force: :cascade do |t|
    t.integer  "quality_element_id", limit: 4
    t.integer  "service_type_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quality_element_service_types", ["quality_element_id", "service_type_id"], name: "qest_qe_id_st_id", using: :btree
  add_index "quality_element_service_types", ["service_type_id", "quality_element_id"], name: "qest_st_id_qe_id", using: :btree

  create_table "quality_elements", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "element_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier",   limit: 255
  end

  add_index "quality_elements", ["element_type"], name: "index_quality_elements_on_element_type", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "identifier", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["identifier"], name: "index_roles_on_identifier", using: :btree

  create_table "school_free_reduced_meal_data", force: :cascade do |t|
    t.integer  "school_id",                   limit: 4
    t.datetime "date"
    t.string   "school_year",                 limit: 255
    t.boolean  "provision_two_three_school"
    t.string   "data_source",                 limit: 255
    t.string   "low_grade",                   limit: 255
    t.string   "high_grade",                  limit: 255
    t.integer  "enrollment_k_12",             limit: 4
    t.integer  "free_meal_count_k_12",        limit: 4
    t.float    "percent_eligible_free_k_12",  limit: 24
    t.integer  "frpm_total_undup_count_k_12", limit: 4
    t.float    "frpm_percent_eligible_k_12",  limit: 24
    t.integer  "enrollment_5_17",             limit: 4
    t.integer  "free_meal_count_5_17",        limit: 4
    t.float    "percent_eligible_5_17",       limit: 24
    t.integer  "frpm_total_undup_count_5_17", limit: 4
    t.float    "frpm_percent_eligible_5_17",  limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "school_free_reduced_meal_data", ["date"], name: "index_school_free_reduced_meal_data_on_date", using: :btree
  add_index "school_free_reduced_meal_data", ["school_id"], name: "index_school_free_reduced_meal_data_on_school_id", using: :btree

  create_table "school_programs", force: :cascade do |t|
    t.integer  "school_id",              limit: 4
    t.integer  "community_program_id",   limit: 4
    t.integer  "user_id",                limit: 4
    t.integer  "student_population_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_verified_at"
    t.boolean  "active",                               default: true
    t.integer  "active_changed_by",      limit: 4
    t.datetime "active_changed_on"
    t.boolean  "site_agreement_on_file"
    t.float    "completion_rate",        limit: 24,    default: 0.0
    t.string   "missing_fields",         limit: 15000, default: "[]"
  end

  add_index "school_programs", ["active", "community_program_id"], name: "index_school_programs_on_active_and_community_program_id", using: :btree
  add_index "school_programs", ["community_program_id", "active"], name: "index_school_programs_on_community_program_id_and_active", using: :btree
  add_index "school_programs", ["community_program_id", "school_id"], name: "sp_cpid_sid", using: :btree
  add_index "school_programs", ["school_id", "community_program_id"], name: "sp_sid_cpid", using: :btree
  add_index "school_programs", ["student_population_id"], name: "index_school_programs_on_student_population_id", using: :btree
  add_index "school_programs", ["user_id"], name: "school_program_user_id", using: :btree

  create_table "school_quality_indicator_sub_areas", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",                                limit: 255
    t.integer  "region_id",                           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state_cde_code",                      limit: 255
    t.boolean  "direct_funded_charter_school"
    t.string   "direct_funded_charter_school_number", limit: 255
    t.boolean  "active",                                          default: true
    t.string   "site_code",                           limit: 255
    t.string   "site_type",                           limit: 255
    t.string   "site_type_norm",                      limit: 255
    t.string   "address",                             limit: 255
    t.string   "city",                                limit: 255
    t.string   "zip_code",                            limit: 255
    t.string   "grades_served",                       limit: 255
    t.string   "low_grade",                           limit: 255
    t.string   "high_grade",                          limit: 255
    t.float    "lat",                                 limit: 24
    t.float    "lng",                                 limit: 24
    t.string   "network",                             limit: 255
    t.string   "net_cluster",                         limit: 255
  end

  add_index "schools", ["active", "direct_funded_charter_school"], name: "index_schools_on_active_and_direct_funded_charter_school", using: :btree
  add_index "schools", ["direct_funded_charter_school", "active"], name: "index_schools_on_direct_funded_charter_school_and_active", using: :btree
  add_index "schools", ["site_code"], name: "index_schools_on_site_code", unique: true, using: :btree
  add_index "schools", ["state_cde_code"], name: "index_schools_on_state_cde_code", unique: true, using: :btree

  create_table "service_times", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_populations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   limit: 4, default: 1
  end

  add_index "user_roles", ["position"], name: "index_user_roles_on_position", using: :btree
  add_index "user_roles", ["role_id", "user_id"], name: "index_user_roles_on_role_id_and_user_id", using: :btree
  add_index "user_roles", ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", using: :btree

  create_table "user_schools", force: :cascade do |t|
    t.integer  "school_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_schools", ["school_id", "user_id"], name: "us_s_id_u_id", using: :btree
  add_index "user_schools", ["user_id", "school_id"], name: "us_u_id_s_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.string   "subdomain",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                   limit: 255, default: "",    null: false
    t.string   "encrypted_password",      limit: 255, default: ""
    t.string   "reset_password_token",    limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      limit: 255
    t.string   "last_sign_in_ip",         limit: 255
    t.string   "phone_number",            limit: 255
    t.integer  "organization_id",         limit: 4
    t.string   "invitation_token",        limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",        limit: 4
    t.integer  "invited_by_id",           limit: 4
    t.string   "invited_by_type",         limit: 255
    t.boolean  "active",                              default: false
    t.string   "title",                   limit: 255
    t.date     "attended_orientation_at"
    t.integer  "orientation_type_id",     limit: 4
  end

  add_index "users", ["active"], name: "index_users_on_active", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", using: :btree
  add_index "users", ["invited_by_id", "invited_by_type"], name: "u_ib_id_ib_type", using: :btree
  add_index "users", ["invited_by_type", "invited_by_id"], name: "u_ib_type_ib_id", using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",       limit: 255,      null: false
    t.integer  "item_id",         limit: 4,        null: false
    t.string   "event",           limit: 255,      null: false
    t.string   "whodunnit",       limit: 255
    t.text     "object",          limit: 16777215
    t.text     "associations",    limit: 16777215
    t.integer  "current_user_id", limit: 4
    t.datetime "created_at"
  end

  add_index "versions", ["current_user_id"], name: "index_versions_on_current_user_id", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
