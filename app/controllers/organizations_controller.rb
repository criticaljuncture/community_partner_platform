class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.accessible_by(current_ability).includes(community_programs: :school).sort_by(&:name)
    authorize! :index, @organizations
  end

  def show
    @organization = Organization.find(params[:id])
    authorize! :show, @organization
  end

  def new
    @organization = Organization.new
    authorize! :new, @organization
  end

  def create
    @organization = Organization.new(organization_params)
    authorize! :create, @organization

    @organization.save

    redirect_to organization_path(@organization)
  end

  def edit
    @organization = Organization.find(params[:id])
    authorize! :edit, @organization
  end

  def update
    @organization = Organization.find(params[:id])
    authorize! :update, @organization

    @organization.update_attributes(organization_params)

    if @organization.verification_required?
      redirect_to new_organization_program_verification_path(@organization)
    else
      redirect_to organization_path(@organization)
    end
  end

  def verification
    @organization = Organization.find(params[:id])
    authorize! :verification, @organization
  end

  def primary_contact_input
    @organization = Organization.includes(:users).find(params[:id])
    authorize! :edit, @organization

    render "/community_programs/primary_contact_input", layout: false
  end

  private
    def organization_params
      params
        .require(:organization)
        .permit(
                :address,
                :city,
                :cost_per_student,
                :legal_status_id,
                :legislative_file_number,
                :mission_statement,
                :mou_on_file,
                :name,
                :notes,
                :phone_number,
                :program_impact,
                :services_description,
                :url,
                :zip_code,
        )
    end
end
