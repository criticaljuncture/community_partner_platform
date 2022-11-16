class CreateOrganizationQualityElements < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_quality_elements do |t|
      t.integer :organization_id
      t.integer :quality_element_id
      t.string :element_type
      t.timestamps
    end
  end
end
