class AddUrlToCommunityPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :community_programs, :url, :string
  end
end
