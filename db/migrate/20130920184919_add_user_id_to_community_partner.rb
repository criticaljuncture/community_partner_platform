class AddUserIdToCommunityPartner < ActiveRecord::Migration
  def change
    add_column :community_partners, :user_id, :integer
  end
end
