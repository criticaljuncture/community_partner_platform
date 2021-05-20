class AddLevyFundedFieldToCommunityProgramsForSps < ActiveRecord::Migration[5.2]
  def change
    add_column :community_programs, :levy_funded, :boolean
  end
end
