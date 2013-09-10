class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :identifier
      t.timestamps
    end

    add_index :roles, :identifier
  end
end
