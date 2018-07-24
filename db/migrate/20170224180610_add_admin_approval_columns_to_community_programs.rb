class AddAdminApprovalColumnsToCommunityPrograms < ActiveRecord::Migration[4.2]
  def change
    add_column :community_programs, :approved_for_public, :boolean, default: false
    add_column :community_programs, :approved_for_public_on, :datetime
    add_column :community_programs, :approved_for_public_by, :integer
  end
end
