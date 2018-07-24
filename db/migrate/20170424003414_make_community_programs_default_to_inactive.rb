class MakeCommunityProgramsDefaultToInactive < ActiveRecord::Migration[4.2]
  def change
    change_column :community_programs, :active, :boolean, default: false
  end
end
