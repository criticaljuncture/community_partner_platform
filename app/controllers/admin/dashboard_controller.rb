class Admin::DashboardController < Admin::ApplicationController

  def index
    @page_views = PageView.limit(50).where("controller != 'api'").order('id DESC')
    @api_hits = PageView.limit(50).where("controller = 'api'").order('id DESC')
    @program_completions = Organization.all
    authorize! :view, :admin_dashboard
  end

end
