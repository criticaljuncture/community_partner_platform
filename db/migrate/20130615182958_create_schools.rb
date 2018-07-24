class CreateSchools < ActiveRecord::Migration[4.2]
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :region_id

      t.timestamps
    end
  end
end
