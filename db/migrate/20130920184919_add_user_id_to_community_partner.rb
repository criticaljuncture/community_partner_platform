class AddUserIdToCommunityPartner < ActiveRecord::Migration[4.2]
  def change
    add_column :community_partners, :user_id, :integer
  end
end
