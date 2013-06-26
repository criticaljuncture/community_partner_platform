class RemoveRegionIdFromCommunityPartners < ActiveRecord::Migration
  def change
    remove_column :community_partners, :region_id
  end
end
