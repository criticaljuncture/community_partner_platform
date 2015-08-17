class CreateSchoolPrograms < ActiveRecord::Migration
  def change
    create_table :school_programs do |t|
      t.integer  "school_id"
      t.integer  "community_program_id"
      t.integer  "user_id"
      t.integer  "school_user_id"

      t.text     "notes"
      t.text     "service_description"
      t.integer  "student_population_id"

      t.timestamps
      t.datetime "last_verified_at"
      t.boolean  "active",                       default: true
      t.integer  "active_changed_by"
      t.datetime "active_changed_on"
    end

    add_index "school_programs", ["school_id", "community_program_id"],
      name: 'sp_sid_cpid'
    add_index "school_programs", ["community_program_id", "school_id"],
      name: 'sp_cpid_sid'

    add_index "school_programs", "user_id"
    add_index "school_programs", "school_user_id"
  end
end
