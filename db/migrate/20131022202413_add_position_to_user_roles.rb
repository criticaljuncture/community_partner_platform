class AddPositionToUserRoles < ActiveRecord::Migration
  def change
    add_column :user_roles, :position, :integer, default: 1
    add_index :user_roles, :position
  end
end
