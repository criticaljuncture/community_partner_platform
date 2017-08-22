class Admin::DashboardPresenter
  def nav_tabs
    tabs = []

    if User.current.can? :view, :super_admin_dashboard_items
      tabs << ['Page Views', '#page-views']
      tabs << ['API Hits', '#api-hits']
      tabs << ['Analytics', '#analytics']
    end

    if User.current.can? :manage, Organization
      tabs << ['Organizations', '#organization-status']
    end

    if User.current.can? :manage, CommunityProgram
      tabs << ['Community Programs', '#community-program-status']
    end

    tabs
  end

  def page_views
    @page_views ||= PageView.limit(50).where("controller != 'api'").order('id DESC')
  end

  def api_hits
    @api_hits ||= PageView.limit(50).where("controller = 'api'").order('id DESC')
  end

  def organizations
    @organizations ||= Organization.
      includes(:users, :community_programs).
      order('name').
      decorate
  end

  def community_programs
    @community_programs ||= CommunityProgram.
      active.
      includes(school_programs: :school).
      order('name').
      decorate
  end
end
