class Admin::DashboardController < Admin::ApplicationController

  def index
    @page_views = PageView.limit(50).where("controller != 'api'").order('id DESC')
    @api_hits = PageView.limit(50).where("controller = 'api'").order('id DESC')

    @organizations = Organization.
      includes(:users, :community_programs).
      order('name').
      decorate

    @community_programs = CommunityProgram.
      includes(:school_programs).
      order('name').
      decorate

    authorize! :view, :admin_dashboard
  end

end
