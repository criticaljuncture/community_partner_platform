class CreateGradeLevels < ActiveRecord::Migration[4.2]
  def change
    create_table :grade_levels do |t|
      t.string :name
      t.timestamps
    end
  end
end
