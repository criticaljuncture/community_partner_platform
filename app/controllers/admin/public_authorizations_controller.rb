class Admin::PublicAuthorizationsController < Admin::ApplicationController
  def show
    @organization = OrganizationDecorator.decorate(
      Organization.find(params[:id])
    )
    authorize! :authorize, @organization
  end

  def organization
    service = OrganizationAuthorizationService.new(organization_params[:id])
    authorize! :publish, service.organization

    if organization_params[:make_public] == "1"
      service.make_public!(
        include_eligible_programs: organization_params[:include_eligible_programs]
      )

      notice = t('organization.flash_messages.made_public',
        name: service.organization.name)
    else
      service.make_private!

      notice = t('organization.flash_messages.made_private',
        name: service.organization.name)
    end

    respond_to do |wants|
      wants.html do
        flash.notice = notice
        redirect_to params[:redirect_to] || admin_public_authorization_path(service.organization)
      end

      wants.json do
        render json: {notice: notice}.to_json
      end
    end
  end

  def community_program
    service = CommunityProgramAuthorizationService.new(community_program_params[:id])
    authorize! :publish, service.community_program

    if community_program_params[:make_public] == "1"
      service.make_public!

      notice = t('community_program.flash_messages.made_public',
        name: service.community_program.name)
    else
      service.make_private!

      notice = t('community_program.flash_messages.made_private',
        name: service.community_program.name)
    end

    respond_to do |wants|
      wants.html do
        flash.notice = notice
        redirect_to params[:redirect_to] || admin_public_authorization_path(service.community_program.organization)
      end

      wants.json do
        render json: {
          id: service.community_program.id,
          public: service.community_program.approved_for_public?
        }.to_json
      end
    end
  end

  private

  def organization_params
    params.require(:authorization).permit(
      :id,
      :include_eligible_programs,
      :make_public,
    )
  end

  def community_program_params
    params.require(:authorization).permit(
      :id,
      :make_public,
    )
  end
end
