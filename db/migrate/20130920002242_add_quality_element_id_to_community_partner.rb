class AddQualityElementIdToCommunityPartner < ActiveRecord::Migration
  def change
    add_column :community_partners, :quality_element_id, :integer
  end
end
