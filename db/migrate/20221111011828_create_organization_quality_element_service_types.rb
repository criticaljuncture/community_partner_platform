class CreateOrganizationQualityElementServiceTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_quality_element_service_types do |t|
      t.integer :organization_quality_element_id
      t.integer :service_type_id
      t.timestamps
    end
  end
end
