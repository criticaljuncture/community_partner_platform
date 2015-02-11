module QualityElementsHelper
  def quality_elements_coverage_display(quality_element_count)
    sub_area_count = QualityElement.accessible_by(current_ability).count

    ratio = quality_element_count.to_f / sub_area_count.to_f

    display_class = ratio > 0.7 ? 'good' : (ratio > 0.5 ? 'satisfactory' : 'bad')

    content_tag(:span,
                "#{quality_element_count}/#{sub_area_count}",
                class: display_class)
  end

  def community_program_count_for_element(quality_element, school)
    count = school.quality_elements.select{|qe| qe.id == quality_element.id}.count

    content_tag(:span, count, class: count > 0 ? 'satisfactory' : 'bad')
  end
end
