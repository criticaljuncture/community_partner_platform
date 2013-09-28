class CreateQualityElementServiceTypes < ActiveRecord::Migration
  def change
    create_table :quality_element_service_types do |t|
      t.integer :quality_element_id
      t.integer :service_type_id
      t.timestamps
    end
  end
end
