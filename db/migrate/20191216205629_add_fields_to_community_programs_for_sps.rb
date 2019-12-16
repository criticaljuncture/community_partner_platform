class AddFieldsToCommunityProgramsForSps < ActiveRecord::Migration[5.2]
  def change
    add_column :community_programs, :personal_services_contract, :boolean, default: false
    add_column :community_programs, :memorandum_of_understanding, :boolean, default: false
    add_column :community_programs, :alignment_agreement, :boolean, default: false
    add_column :community_programs, :data_sharing_agreement, :boolean, default: false
  end
end
