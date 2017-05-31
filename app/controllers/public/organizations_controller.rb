class Public::OrganizationsController < Public::ApplicationController
  def show
    @organization = Organization.publicly_accessible.find(params[:id])
  end
end
