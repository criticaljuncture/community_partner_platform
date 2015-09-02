class CommunityProgramDetailsSerializer < ActiveModel::Serializer
  attributes :ethnicity_culture_group_ids,
    :day_ids,
    :demographic_group_ids,
    :grade_level_ids,
    :id,
    :primary_quality_element_id,
    :primary_service_type_ids,
    :service_time_ids,
    :service_type_ids,
    :student_population_id


  def primary_quality_element_id
    object.primary_quality_element.id
  end

  def service_type_ids
    object.service_types.map(&:id)
  end
end
