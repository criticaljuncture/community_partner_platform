class RenameCommunityPartnerColumnsToCommunityProgram < ActiveRecord::Migration[4.2]
  def change
    rename_column :community_program_quality_elements, :community_partner_id, :community_program_id
    rename_column :community_program_demographic_groups, :community_partner_id, :community_program_id
    rename_column :community_program_ethnicity_culture_groups, :community_partner_id, :community_program_id
    rename_column :community_program_grade_levels, :community_partner_id, :community_program_id
    rename_column :community_program_service_days, :community_partner_id, :community_program_id
    rename_column :community_program_service_times, :community_partner_id, :community_program_id
    rename_column :community_program_quality_element_service_types, :community_partner_quality_element_id, :community_program_quality_element_id
  end
end
