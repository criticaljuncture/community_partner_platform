class AddNewCpFieldsForSps < ActiveRecord::Migration[5.2]
  def change
    add_column :community_programs, :creative_advantage_roster, :boolean
    add_column :community_programs, :youth_services_programming_roster, :boolean
  end
end
