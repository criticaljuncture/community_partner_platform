class CreateCommunityPartnerQualityElements < ActiveRecord::Migration
  def change
    create_table :community_partner_quality_elements do |t|
      t.integer :community_partner_id
      t.integer :quality_element_id
      t.string :type

      t.timestamps
    end

    add_index :community_partner_quality_elements, [:community_partner_id, :quality_element_id], name: "cpqe_cpi_qei"
    add_index :community_partner_quality_elements, [:quality_element_id, :community_partner_id], name: "cpqe_qei_cpi"
  end
end
