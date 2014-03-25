class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :sub_area_counts, :frpm_percent_eligible_k_12

  def frpm_percent_eligible_k_12
    object.free_reduced_meal_data.map do |frm|
      {school_year: frm.school_year, percent: frm.frpm_percent_eligible_k_12, enrollment: frm.enrollment_k_12}
    end
  end

  def sub_area_counts
    sub_area_counts = []
    school_quality_elements = object.community_programs.map{|cp| cp.quality_elements}.flatten
    QualityElement.accessible_by( Ability.new(scope) ).each do |element|
      count = school_quality_elements.select{|qe| qe.id == element.id}.count
      sub_area_counts << {sub_area_id: element.id, count: count}
    end
    sub_area_counts
  end
end
