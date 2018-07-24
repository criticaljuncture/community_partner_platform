class CreateCommunityPartnershipGradeLevels < ActiveRecord::Migration[4.2]
  def change
    create_table :community_partnership_grade_levels do |t|
      t.integer :grade_level_id
      t.integer :community_partnership_id
      t.timestamps
    end

    add_index :community_partnership_grade_levels, [:community_partnership_id, :grade_level_id], name: "cpgl_cpid_glid"
    add_index :community_partnership_grade_levels, [:grade_level_id, :community_partnership_id], name: "cpgl_glid_cpid"
  end
end
