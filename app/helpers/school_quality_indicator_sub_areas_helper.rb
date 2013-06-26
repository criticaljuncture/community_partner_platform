module SchoolQualityIndicatorSubAreasHelper
  def school_quality_indicator_sub_area_display(school)
    school_sub_area_count = school.school_quality_indicator_sub_areas.uniq.count
    sub_area_count = SchoolQualityIndicatorSubArea.count

    ratio = school_sub_area_count.to_f / sub_area_count.to_f

    display_class = ratio > 0.7 ? 'good' : (ratio > 0.5 ? 'satisfactory' : 'bad')

    content_tag(:span,
                "#{school_sub_area_count}/#{sub_area_count}",
                class: display_class)
  end

  def community_partner_count_for_indictor(indicator, school) 
    count = school.community_partners.select{|cp| cp.school_quality_indicator_sub_area_id == indicator.id}.count

    content_tag(:span, count, class: count > 0 ? 'satisfactory' : 'bad')
  end
end
