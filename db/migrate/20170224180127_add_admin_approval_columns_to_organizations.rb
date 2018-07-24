class AddAdminApprovalColumnsToOrganizations < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :approved_for_public, :boolean, default: false
    add_column :organizations, :approved_for_public_on, :datetime
    add_column :organizations, :approved_for_public_by, :integer
  end
end
