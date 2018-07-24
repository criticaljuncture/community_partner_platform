class AddActiveFlagToSchool < ActiveRecord::Migration[4.2]
  def change
    add_column :schools, :active, :boolean, default: true
  end
end
