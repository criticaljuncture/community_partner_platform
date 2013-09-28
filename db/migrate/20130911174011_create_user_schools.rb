class CreateUserSchools < ActiveRecord::Migration
  def change
    create_table :user_schools do |t|
      t.integer :school_id
      t.integer :user_id
      t.timestamps
    end
  end
end
