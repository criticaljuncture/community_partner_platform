class AddLegislativeFileNumberToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :legislative_file_number, :string
  end
end
