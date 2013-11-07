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

ActiveRecord::Schema.define(version: 20131107225305) do

  create_table "community_partner_quality_element_service_types", force: true do |t|
    t.integer  "community_partner_quality_element_id"
    t.integer  "service_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_partner_quality_element_service_types", ["community_partner_quality_element_id", "service_type_id"], name: "cpqest_cpqeid_stid", using: :btree
  add_index "community_partner_quality_element_service_types", ["service_type_id", "community_partner_quality_element_id"], name: "cpqest_stid_cpqeid", using: :btree

  create_table "community_partner_quality_elements", force: true do |t|
    t.integer  "community_partner_id"
    t.integer  "quality_element_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_partner_quality_elements", ["community_partner_id", "quality_element_id"], name: "cpqe_cpi_qei", using: :btree
  add_index "community_partner_quality_elements", ["quality_element_id", "community_partner_id"], name: "cpqe_qei_cpi", using: :btree

  create_table "community_partners", force: true do |t|
    t.integer  "school_id"
    t.integer  "school_quality_indicator_sub_area_id"
    t.string   "additional_school_quality_indicator_sub_area"
    t.integer  "organization_id"
    t.text     "service_provided"
    t.integer  "service_type_id"
    t.date     "date_collected"
    t.string   "point_of_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.integer  "user_id"
    t.integer  "school_user_id"
    t.text     "service_description"
    t.string   "target_population"
    t.string   "service_time_of_day"
    t.boolean  "site_agreement_on_file"
    t.integer  "primary_quality_element_id"
    t.string   "primary_service_type_ids"
    t.integer  "secondary_quality_element_id"
    t.string   "secondary_service_type_ids"
    t.boolean  "mou_on_file"
    t.integer  "student_population_id"
    t.string   "name"
    t.string   "legislative_file_number"
  end

  add_index "community_partners", ["organization_id"], name: "index_community_partners_on_organization_id", using: :btree
  add_index "community_partners", ["school_id"], name: "index_community_partners_on_school_id", using: :btree
  add_index "community_partners", ["school_user_id"], name: "index_community_partners_on_school_user_id", using: :btree
  add_index "community_partners", ["service_type_id"], name: "index_community_partners_on_service_type_id", using: :btree
  add_index "community_partners", ["user_id"], name: "index_community_partners_on_user_id", using: :btree

  create_table "community_partnership_demographic_groups", force: true do |t|
    t.integer  "demographic_group_id"
    t.integer  "community_partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_partnership_demographic_groups", ["community_partner_id", "demographic_group_id"], name: "cpdg_cpid_dgid", using: :btree
  add_index "community_partnership_demographic_groups", ["demographic_group_id", "community_partner_id"], name: "cpdg_dgid_cpid", using: :btree

  create_table "community_partnership_ethnicity_culture_groups", force: true do |t|
    t.integer  "community_partner_id"
    t.integer  "ethnicity_culture_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_partnership_ethnicity_culture_groups", ["community_partner_id", "ethnicity_culture_group_id"], name: "cpecg_cpid_ecgid", using: :btree
  add_index "community_partnership_ethnicity_culture_groups", ["ethnicity_culture_group_id", "community_partner_id"], name: "cpecg_ecgid_cpid", using: :btree

  create_table "community_partnership_grade_levels", force: true do |t|
    t.integer  "grade_level_id"
    t.integer  "community_partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_partnership_grade_levels", ["community_partner_id", "grade_level_id"], name: "cpgl_cpid_glid", using: :btree
  add_index "community_partnership_grade_levels", ["grade_level_id", "community_partner_id"], name: "cpgl_glid_cpid", using: :btree

  create_table "community_partnership_service_days", force: true do |t|
    t.integer  "community_partner_id"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_partnership_service_days", ["community_partner_id", "day_id"], name: "cpsd_cpid_did", using: :btree
  add_index "community_partnership_service_days", ["day_id", "community_partner_id"], name: "cpsd_did_cpid", using: :btree

  create_table "community_partnership_service_times", force: true do |t|
    t.integer  "community_partner_id"
    t.integer  "service_time_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_partnership_service_times", ["community_partner_id", "service_time_id"], name: "cpst_cpid_stid", using: :btree
  add_index "community_partnership_service_times", ["service_time_id", "community_partner_id"], name: "cpst_stid_cpid", using: :btree

  create_table "days", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demographic_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ethnicity_culture_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "address"
    t.string   "city"
    t.string   "zip_code"
    t.string   "phone_number"
    t.text     "notes"
    t.boolean  "mou_on_file"
    t.string   "legislative_file_number"
  end

  create_table "quality_element_service_types", force: true do |t|
    t.integer  "quality_element_id"
    t.integer  "service_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quality_elements", force: true do |t|
    t.string   "name"
    t.string   "element_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["identifier"], name: "index_roles_on_identifier", using: :btree

  create_table "school_free_reduced_meal_data", force: true do |t|
    t.integer  "school_id"
    t.datetime "date"
    t.string   "school_year"
    t.boolean  "provision_two_three_school"
    t.string   "data_source"
    t.string   "low_grade"
    t.string   "high_grade"
    t.integer  "enrollment_k_12"
    t.integer  "free_meal_count_k_12"
    t.float    "percent_eligible_free_k_12"
    t.integer  "frpm_total_undup_count_k_12"
    t.float    "frpm_percent_eligible_k_12"
    t.integer  "enrollment_5_17"
    t.integer  "free_meal_count_5_17"
    t.float    "percent_eligible_5_17"
    t.integer  "frpm_total_undup_count_5_17"
    t.float    "frpm_percent_eligible_5_17"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "school_free_reduced_meal_data", ["date"], name: "index_school_free_reduced_meal_data_on_date", using: :btree
  add_index "school_free_reduced_meal_data", ["school_id"], name: "index_school_free_reduced_meal_data_on_school_id", using: :btree

  create_table "school_quality_indicator_sub_areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school_code"
    t.boolean  "direct_funded_charter_school"
    t.string   "direct_funded_charter_school_number"
    t.boolean  "active",                              default: true
  end

  add_index "schools", ["school_code"], name: "index_schools_on_school_code", using: :btree

  create_table "service_times", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_populations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   default: 1
  end

  add_index "user_roles", ["position"], name: "index_user_roles_on_position", using: :btree
  add_index "user_roles", ["role_id", "user_id"], name: "index_user_roles_on_role_id_and_user_id", using: :btree
  add_index "user_roles", ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", using: :btree

  create_table "user_schools", force: true do |t|
    t.integer  "school_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone_number"
    t.integer  "organization_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.boolean  "active",                 default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",       null: false
    t.integer  "item_id",         null: false
    t.string   "event",           null: false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "associations"
    t.integer  "current_user_id"
    t.datetime "created_at"
  end

  add_index "versions", ["current_user_id"], name: "index_versions_on_current_user_id", using: :btree
  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
