class MakeCommunityProgramsDefaultToInactive < ActiveRecord::Migration
  def change
    change_column :community_programs, :active, :boolean, default: false
  end
end
