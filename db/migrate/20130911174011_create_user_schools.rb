class CreateUserSchools < ActiveRecord::Migration[4.2]
  def change
    create_table :user_schools do |t|
      t.integer :school_id
      t.integer :user_id
      t.timestamps
    end
  end
end
