class AddOrientationFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :attended_orientation_at, :date
    add_column :users, :orientation_type_id,     :integer
  end
end
