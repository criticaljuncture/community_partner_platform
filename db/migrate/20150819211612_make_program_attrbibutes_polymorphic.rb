class MakeProgramAttrbibutesPolymorphic < ActiveRecord::Migration[4.2]
  def change
    add_column :community_program_ethnicity_culture_groups, :attributable_type, :string, default: 'CommunityProgram'
    rename_column :community_program_ethnicity_culture_groups, :community_program_id, :attributable_id

    add_column :community_program_demographic_groups, :attributable_type, :string, default: 'CommunityProgram'
    rename_column :community_program_demographic_groups, :community_program_id, :attributable_id

    add_column :community_program_grade_levels, :attributable_type, :string, default: 'CommunityProgram'
    rename_column :community_program_grade_levels, :community_program_id, :attributable_id

    add_column :community_program_service_days, :attributable_type, :string, default: 'CommunityProgram'
    rename_column :community_program_service_days, :community_program_id, :attributable_id

    add_column :community_program_service_times, :attributable_type, :string, default: 'CommunityProgram'
    rename_column :community_program_service_times, :community_program_id, :attributable_id
  end
end
