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
