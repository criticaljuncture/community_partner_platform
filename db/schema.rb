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

ActiveRecord::Schema.define(version: 20130712174358) do

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
  end

  add_index "community_partners", ["organization_id"], name: "index_community_partners_on_organization_id", using: :btree
  add_index "community_partners", ["school_id"], name: "index_community_partners_on_school_id", using: :btree
  add_index "community_partners", ["service_type_id"], name: "index_community_partners_on_service_type_id", using: :btree

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
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  add_index "schools", ["school_code"], name: "index_schools_on_school_code", using: :btree

  create_table "service_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "subdomain"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
