class RenameCommunityPartnerTablesToCommunityProgram < ActiveRecord::Migration
  def change
    rename_table :community_partners, :community_programs
    rename_table :community_partner_quality_elements, :community_program_quality_elements
    rename_table :community_partner_quality_element_service_types, :community_program_quality_element_service_types
    rename_table :community_partnership_demographic_groups, :community_program_demographic_groups
    rename_table :community_partnership_ethnicity_culture_groups, :community_program_ethnicity_culture_groups
    rename_table :community_partnership_grade_levels, :community_program_grade_levels
    rename_table :community_partnership_service_days, :community_program_service_days
    rename_table :community_partnership_service_times, :community_program_service_times
  end
end
