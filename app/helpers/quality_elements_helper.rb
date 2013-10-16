module QualityElementsHelper
  def quality_elements_coverage_display(school)
    school_sub_area_count = school.quality_elements.count
    sub_area_count = QualityElement.accessible_by(current_ability).count

    ratio = school_sub_area_count.to_f / sub_area_count.to_f

    display_class = ratio > 0.7 ? 'good' : (ratio > 0.5 ? 'satisfactory' : 'bad')

    content_tag(:span,
                "#{school_sub_area_count}/#{sub_area_count}",
                class: display_class)
  end

  def community_partner_count_for_element(quality_element, school)
    count = school.quality_elements.select{|qe| qe.id == quality_element.id}.count

    content_tag(:span, count, class: count > 0 ? 'satisfactory' : 'bad')
  end
end
