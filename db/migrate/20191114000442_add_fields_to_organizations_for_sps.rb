class AddFieldsToOrganizationsForSps < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :personal_services_contract, :boolean
    add_column :organizations, :memorandum_of_understanding, :boolean
    add_column :organizations, :alignment_agreement, :boolean
    add_column :organizations, :data_sharing_agreement, :boolean
  end
end
