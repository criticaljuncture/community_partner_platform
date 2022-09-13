class SchoolsOverviewPresenter < BasePresenter
  def regions
    @regions ||= Region.all.map{|r| RegionPresenter.new(r, h)}
  end

  def schools_without_region
    @missing_regions ||= School.where("region_id IS NULL")
  end

  def page_nav_tabs
    tabs = []

    if h.can?(:view, :school_overview_program_breakdown_by_region) ||
      h.can?(:view, :school_overview_school_status)
        tabs << ['Overview', '#overview']
    end

    tabs << ['Schools', '#schools-table']

    if h.can?(:view, :school_overview_community_school_element_breakdown)
      tabs << ['Community Program Breakdown', '#community-program-breakdown']
    end

    tabs
  end
end
