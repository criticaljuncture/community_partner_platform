class RemoveOldColumnsFromCommunityPrograms < ActiveRecord::Migration[4.2]
  def change
    remove_column :community_programs, :target_population
    remove_column :community_programs, :service_time_of_day
    remove_column :community_programs, :primary_quality_element_id
    remove_column :community_programs, :primary_service_type_ids
    remove_column :community_programs, :secondary_quality_element_id
    remove_column :community_programs, :secondary_service_type_ids
  end
end
