class AddActiveFieldToCommunityPrograms < ActiveRecord::Migration
  def change
    add_column :community_programs, :active, :boolean, default: true
    add_column :community_programs, :active_changed_by, :integer
    add_column :community_programs, :active_changed_on, :datetime

    add_index :community_programs, :active
  end
end
