class AddLegislativeFileNumberToOrganization < ActiveRecord::Migration[4.2]
  def change
    add_column :organizations, :legislative_file_number, :string
  end
end
