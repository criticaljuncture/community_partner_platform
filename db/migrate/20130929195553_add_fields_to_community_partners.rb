class AddFieldsToCommunityPartners < ActiveRecord::Migration
  def change
    add_column :community_partners, :mou_on_file, :boolean
    add_column :community_partners, :student_population_id, :integer
    add_column :community_partners, :name, :string
    add_column :community_partners, :legislative_file_number, :string
  end
end
