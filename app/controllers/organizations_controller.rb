class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.accessible_by(current_ability).
      includes(:community_programs).sort_by(&:name)
    authorize! :index, Organization

    @organizations = OrganizationDecorator.decorate_collection(
      @organizations
    )
  end

  def show
    @organization = OrganizationDecorator.decorate(
      Organization.includes(:community_programs).find(params[:id])
    )
    authorize! :show, @organization
  end

  def new
    @organization = Organization.new
    authorize! :new, @organization
  end

  def create
    @organization = Organization.new(organization_params.except(:verification))
    authorize! :create, @organization

    @organization.save!

    flash.notice = t('organizations.flash_messages.create.success',
                      name: @organization.name)
    redirect_to organization_path(@organization)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('errors.form_error', count: @organization.errors.count)
    render :new
  end

  def edit
    @organization = Organization.find(params[:id])
    authorize! :edit, @organization
    @decorated_organization = OrganizationDecorator.decorate(@organization)
  end

  def update
    @organization = Organization.find(params[:id])
    authorize! :update, @organization

    @organization.update_attributes!(organization_params)

    if params["commit"] == t('forms.buttons.save_verify') &&
        can?(:verify, @organization)

      previously_needed_verified = @organization.verification_required?
      @organization.update_attributes!(
        last_verified_at: Time.now,
        last_verified_by: current_user.id
      )
    end

    if can?(:verify, @organization) && previously_needed_verified
      flash.notice = t('organizations.flash_messages.verified',
                       name: @organization.name)
    else
      flash.notice = t('organizations.flash_messages.save.success',
                       name: @organization.name)
    end

    redirect_to organization_path(@organization)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('errors.form_error', count: @organization.errors.count)
    render :edit
  end

  def verification
    @organization = Organization.find(params[:id])
    authorize! :verification, @organization
  end

  def primary_contact_input
    @collection = Organization.includes(:users).find(params[:id])
    authorize! :edit, @collection

    @form_object = :community_program
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
