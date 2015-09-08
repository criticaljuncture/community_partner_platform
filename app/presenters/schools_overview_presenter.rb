class SchoolsOverviewPresenter < BasePresenter
  def regions
    Region.all.map{|r| RegionPresenter.new(r, h)}
  end

  def schools_without_region
    School.where("region_id IS NULL")
  end

  def page_nav_tabs
    tabs = [
      ['Overview', '#overview'],
      ['Schools', '#schools']
    ]

    if h.can?(:view, :school_overview_community_school_element_breakdown)
      tabs << ['Community Program Breakdown', '#community-program-breakdown']
    end

    tabs
  end
end
