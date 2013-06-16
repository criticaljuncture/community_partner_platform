class AddNotesToCommunityPartnerships < ActiveRecord::Migration
  def change
    add_column :community_partners, :notes, :text
  end
end
