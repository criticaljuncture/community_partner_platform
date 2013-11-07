class OrganizationsController < ApplicationController
  authorize_resource

  def index
    @organizations = Organization.accessible_by(current_ability).includes(community_partners: :school).sort_by(&:name)
  end

  def show
    @organization = Organization.accessible_by(current_ability).find(params[:id])
    @community_partnerships = CommunityPartner.accessible_by(current_ability).where(organization_id: @organization.id).includes(:school).order("schools.id asc")
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
    @organization = Organization.accessible_by(current_ability).find(params[:id])
  end

  def update
    @organization = Organization.accessible_by(current_ability).find(params[:id])
    @organization.update_attributes(organization_params)

    redirect_to organization_path(@organization)
  end

  def primary_contact_input
    @organization = Organization.accessible_by(current_ability).includes(:users).find(params[:id])

    render "/community_partners/primary_contact_input", layout: false
  end

  private
    def organization_params
      params
        .require(:organization)
        .permit(
                :address,
                :city,
                :legislative_file_number,
                :mou_on_file,
                :name,
                :notes,
                :phone_number,
                :url,
                :zip_code,
        )
    end
end
