class AddFieldsToOrganization < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :mission_statement, :text
    add_column :organizations, :services_description, :text
    add_column :organizations, :program_impact, :text
    add_column :organizations, :cost_per_student, :text
    add_column :organizations, :legal_status_id, :integer
  end
end
