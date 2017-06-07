class ChangeColumnNamesOnOrganizations < ActiveRecord::Migration
  def change
    rename_column :organizations, :cost_per_student, :total_cost
    rename_column :organizations, :mou_on_file, :board_approved_contract
  end
end
