class AddNotesToCommunityPartnerships < ActiveRecord::Migration[4.2]
  def change
    add_column :community_partners, :notes, :text
  end
end
