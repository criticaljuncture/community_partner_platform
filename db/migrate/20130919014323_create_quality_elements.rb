class CreateQualityElements < ActiveRecord::Migration[4.2]
  def change
    create_table :quality_elements do |t|
      t.string :name
      t.string :element_type
      t.timestamps
    end
  end
end
