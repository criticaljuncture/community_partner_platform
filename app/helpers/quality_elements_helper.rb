module QualityElementsHelper
  def quality_elements_coverage_display(quality_element_count)
    sub_area_count = QualityElement.
      programmatic.
      accessible_by(current_ability).
      count

    ratio = quality_element_count.to_f / sub_area_count.to_f

    display_class = ratio > 0.7 ? 'good' : (ratio > 0.5 ? 'satisfactory' : 'bad')

    content_tag(:span, class: display_class) do
      concat "#{quality_element_count}/#{sub_area_count}"
      concat content_tag(:span, '', class: 'status-circle' )
    end
  end

  def community_program_count_for_element(quality_element, school)
    count = school.community_programs.
      includes(:quality_element).
      reject{|cp| cp.quality_element.nil?}.
      select{|cp| cp.quality_element.id == quality_element.id}
      .count

    content_tag(:span, count, class: count > 0 ? 'satisfactory' : 'bad')
  end
end
