class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :sub_area_counts, :frpm_percent_eligible_k_12

  def sub_area_counts
    sub_area_counts = []
    SchoolQualityIndicatorSubArea.all.each do |sub_area|
      count = object.school_quality_indicator_sub_areas.where(id: sub_area.id).count
      sub_area_counts << {sub_area_id: sub_area.id, count: count}
    end
    sub_area_counts
  end

  def frpm_percent_eligible_k_12
    object.free_reduced_meal_data.map do |frm|
      {school_year: frm.school_year, percent: frm.frpm_percent_eligible_k_12, enrollment: frm.enrollment_k_12}
    end
  end
end
