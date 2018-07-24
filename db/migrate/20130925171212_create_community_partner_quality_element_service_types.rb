class CreateCommunityPartnerQualityElementServiceTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :community_partner_quality_element_service_types do |t|
      t.integer :community_partner_quality_element_id
      t.integer :service_type_id
      t.timestamps
    end

    add_index :community_partner_quality_element_service_types, [:community_partner_quality_element_id, :service_type_id], name: "cpqest_cpqeid_stid"
    add_index :community_partner_quality_element_service_types, [:service_type_id, :community_partner_quality_element_id], name: "cpqest_stid_cpqeid"
  end
end
