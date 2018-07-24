class AddQualityElementIdToCommunityPartner < ActiveRecord::Migration[4.2]
  def change
    add_column :community_partners, :quality_element_id, :integer
  end
end
