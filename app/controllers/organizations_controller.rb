class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.accessible_by(current_ability).
      includes(
        {:community_programs => [:quality_element, :primary_service_types, :schools]},
        :schools
      ).
      sort_by(&:name)
    authorize! :index, Organization

    @organizations = OrganizationDecorator.decorate_collection(
      @organizations
    )
  end

  def show
    @organization = OrganizationDecorator.decorate(
      Organization.includes(
        {community_programs: [:quality_element, :primary_service_types, :schools]}
      ).find(params[:id])
    )
    authorize! :show, @organization

    @verification_process = session[:verification_process] || false
    session.delete(:verification_process)
  end

  def new
    @organization = Organization.new
    @organization.user_ids_to_assign = []
    authorize! :new, @organization
    @organization = OrganizationDecorator.decorate(@organization)
  end

  def create
    @organization = Organization.new(organization_params.except(:verification))
    authorize! :create, @organization

    @organization.user_ids_to_assign = users_to_assign.map(&:id)

    ActiveRecord::Base.transaction do
      begin
        @organization.save!

        users_to_assign.each do |user|
          user.update!(organization_id: @organization.id, active: true)
        end

        flash.notice = t('organization.flash_messages.create.success',
                          name: @organization.name)
        redirect_to organization_path(@organization)
      rescue ActiveRecord::RecordInvalid
        flash.now[:error] = t('errors.form_error', count: @organization.errors.count)
        @organization = OrganizationDecorator.decorate(@organization)
        render :new
      end
    end
  end

  def edit
    @organization = Organization.find(params[:id])
    authorize! :edit, @organization
    @organization = OrganizationDecorator.decorate(@organization)
  end

  def update
    @organization = Organization.find(params[:id])
    authorize! :update, @organization

    @organization.update!(
      organization_params.except(:verification_process)
    )

    if params["commit"] == t('forms.buttons.save_verify') &&
        can?(:verify, @organization)

      previously_needed_verified = @organization.verification_required?
      @organization.update!(
        last_verified_at: Time.now,
        last_verified_by: current_user.id
      )
    end

    if can?(:verify, @organization) && previously_needed_verified
      flash.notice = t('organization.flash_messages.verified',
                       name: @organization.name)
    else
      flash.notice = t('organization.flash_messages.save.success',
                       name: @organization.name)
    end

    session[:verification_process] = organization_params.fetch(:verification_process, false)
    redirect_to organization_path(@organization)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('errors.form_error', count: @organization.errors.count)
    @organization = OrganizationDecorator.decorate(@organization)
    render :edit
  end

  def verification
    @organization = Organization.find(params[:id])
    @organization.user_ids_to_assign = []
    authorize! :verification, @organization

    @organization = OrganizationDecorator.decorate(@organization)
  end

  def primary_contact_input
    @collection = Organization.includes(:users).find(params[:id])
    authorize! :edit, @collection

    @form_object = :community_program
    render "/community_programs/primary_contact_input", layout: false
  end

  def table
    @organizations = Organization.accessible_by(current_ability).
      includes(
        {:community_programs => [:quality_element, :primary_service_types, :schools]},
        :schools
      ).
      sort_by(&:name)
    authorize! :index, Organization

    @organizations = OrganizationDecorator.decorate_collection(
      @organizations
    )

    render layout: false
  end

  private
    def organization_params
      params
        .require(:organization)
        .permit(
                :address,
                :city,
                :total_cost,
                :legal_status_id,
                :legislative_file_number,
                :mission_statement,
                :board_approved_contract,
                :name,
                :notes,
                :phone_number,
                :program_impact,
                :receives_district_funding,
                :services_description,
                :subcontractor_with_lead_agency,
                :url,
                :user_id,
                :verification_process,
                :zip_code
        )
    end

    def users_to_assign
      @users_to_assign ||= Array.wrap(params["user_ids_to_assign"]).
        reject{|user_id| user_id.empty?}.
        map{|user_id| User.find(user_id)}
    end
end
