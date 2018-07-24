class RemoveUnusedColumnsFromCommunityPartner < ActiveRecord::Migration[4.2]
  def change
    remove_column :community_partners, :school_quality_indicator_sub_area_id
    remove_column :community_partners, :additional_school_quality_indicator_sub_area
    remove_column :community_partners, :service_provided
    remove_column :community_partners, :service_type_id
    remove_column :community_partners, :date_collected
    remove_column :community_partners, :point_of_contact
  end
end
