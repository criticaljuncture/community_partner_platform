class FixGradeLevelAssociation < ActiveRecord::Migration[4.2]
  def change
    rename_column :community_partnership_grade_levels, :community_partnership_id, :community_partner_id
  end
end
