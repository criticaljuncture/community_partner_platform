class CreateCommunityPartners < ActiveRecord::Migration
  def change
    create_table :community_partners do |t|
      t.integer :school_id
      t.integer :region_id
      t.integer :school_quality_indicator_sub_area_id
      t.string :additional_school_quality_indicator_sub_area
      t.integer :organization_id
      t.text :service_provided
      t.integer :service_type_id
      t.date :date_collected
      t.string :point_of_contact

      t.timestamps
    end

    add_index :community_partners, :school_id
    add_index :community_partners, :region_id
    add_index :community_partners, :organization_id
    add_index :community_partners, :service_type_id
  end
end
