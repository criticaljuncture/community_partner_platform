class Admin::DashboardController < Admin::ApplicationController

  def index
    authorize! :view, :admin_dashboard
    @presenter = Admin::DashboardPresenter.new
  end

end
