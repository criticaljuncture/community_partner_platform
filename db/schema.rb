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

ActiveRecord::Schema.define(version: 20130616174249) do

  create_table "community_partners", force: true do |t|
    t.integer  "school_id"
    t.integer  "region_id"
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
  add_index "community_partners", ["region_id"], name: "index_community_partners_on_region_id", using: :btree
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
  end

  create_table "service_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
