class AddLastVerifiedByToOrgAndProgram < ActiveRecord::Migration[4.2]
  def change
    add_column :community_programs, :last_verified_by, :integer
    add_column :organizations, :last_verified_by, :integer

    add_index :community_programs, :last_verified_by
    add_index :organizations, :last_verified_by
  end
end
