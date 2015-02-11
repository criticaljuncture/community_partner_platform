class RegionPresenter < BasePresenter
  def community_programs_count
    @cp_count ||= model.community_programs.count
  end

  def quality_element_counts
    @qe_counts ||= model.
      community_programs_by_quality_element.
      map{|qe| {
        id: qe[0],
        name: qe[1].first.name,
        count: qe[1].count
        }
      }.
      sort_by{|k| k[:count]}.
      reverse
  end

  def percentage_of_programs_with_quality_element(count)
    (count / community_programs_count.to_f * 100).round
  end

  def quality_elements_without_coverage
    quality_elements = QualityElement.
      accessible_by(h.current_ability).
      all.
      map{|qe| qe.name}

    quality_elements - quality_element_counts.map{|qec| qec[:name]}
  end

  def service_types
    @sevice_types ||= model.
      community_programs.
      includes(:primary_service_types).
      map{|cp| cp.primary_service_types}.
      flatten
  end

  def service_type_counts
    service_types.
      group_by(&:id).
      map{|st| {
        name: st[1].first.name,
        count: st[1].count
        }
      }.
      sort_by{|k| k[:count]}.
      reverse
  end
end
