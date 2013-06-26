class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.includes(community_partners: :school).all
  end

  def show
    @organization = Organization.find(params[:id])
    @community_partnerships = CommunityPartner.where(organization_id: @organization.id)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.save

    redirect_to organization_path(@organization)
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    @organization.update_attributes(organization_params)

    redirect_to organization_path(@organization)
  end

  private
    def organization_params
      params.require(:organization).permit(:name, :url, :phone_number, :address, :city, :zip_code, :notes)
    end
end
