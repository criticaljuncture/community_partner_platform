class RemoveRegionIdFromCommunityPartners < ActiveRecord::Migration[4.2]
  def change
    remove_column :community_partners, :region_id
  end
end
