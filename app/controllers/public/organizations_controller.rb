class Public::OrganizationsController < Public::ApplicationController

  def show
    @organization = Organization.find(params[:id])
  end

end
