class RegionPresenter < BasePresenter
  def community_programs_count
    @cp_count ||= model.community_programs.count
  end

  def quality_element_counts
    @qe_counts ||= model.
      community_programs_by_quality_element.
      map{|id, qe| {
        id: id,
        name: qe.first.name,
        count: qe.count
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
      programmatic.
      all.
      map{|qe| qe.name}

    quality_elements - quality_element_counts.map{|qec| qec[:name]}
  end

  def service_types
    @sevice_types ||= model.
      community_programs.
      map{|cp| cp.primary_service_types}.
      flatten
  end

  def service_type_counts
    service_types.
      group_by(&:id).
      map{|id, st| {
        name: st.first.name,
        count: st.count
        }
      }.
      sort_by{|k| k[:count]}.
      reverse
  end
end
