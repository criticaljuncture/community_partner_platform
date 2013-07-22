class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :sub_area_counts, :frpm_percent_eligible_k_12 

  def frpm_percent_eligible_k_12
    object.free_reduced_meal_data.map do |frm|
      {school_year: frm.school_year, percent: frm.frpm_percent_eligible_k_12, enrollment: frm.enrollment_k_12}
    end
  end
end
