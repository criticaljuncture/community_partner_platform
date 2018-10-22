class RenameStateCdeCodeToStateCode < ActiveRecord::Migration[5.2]
  def change
    rename_column :schools, :state_cde_code, :state_code
  end
end
