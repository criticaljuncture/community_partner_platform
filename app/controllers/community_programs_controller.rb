class CommunityProgramsController < ApplicationController
  def index
    @community_programs = CommunityProgram.accessible_by(current_ability).includes(:organization).order("organizations.name")
    authorize! :index, CommunityProgram
  end

  def show
    @community_program = CommunityProgram.unscoped.find(params[:id])
    authorize! :show, @community_program
  end

  def new
    @community_program = params[:community_program].present? ? CommunityProgram.new(community_program_params) : CommunityProgram.new()
    authorize! :new, @community_program

    if params[:redirect_back]
      session[:redirect_back] = params[:redirect_back]
    end

    @community_program.build_primary_quality_element
    @community_program.build_secondary_quality_element
  end

  def create
    @community_program = CommunityProgram.new(community_program_params)
    authorize! :create, @community_program

    if current_user.role?(:organization_member)
      @community_program.last_verified_at = Time.now
    end

    @community_program.save!

    flash.notice = t('community_programs.flash_messages.create.success',
                      name: @community_program.name,
                      school_name: @community_program.school.name)

    if session[:redirect_back]
      redirect_back = session[:redirect_back]
      session[:redirect_back] = nil

      add_flash_js(:open_verification_modal, false)

      redirect_to redirect_back
    else
      redirect_to community_program_path(@community_program)
    end
  rescue ActiveRecord::RecordInvalid
    @community_program.build_primary_quality_element unless @community_program.primary_quality_element
    @community_program.build_secondary_quality_element unless @community_program.secondary_quality_element

    flash.now[:error] = t('errors.form_error', count: @community_program.errors.count)
    render :new
  end

  def edit
    @community_program = CommunityProgram.find(params[:id])
    authorize! :edit, @community_program

    if params[:redirect_back]
      session[:redirect_back] = params[:redirect_back]
    end

    @community_program.build_secondary_quality_element unless @community_program.secondary_quality_element.present?
  end

  def update
    @community_program = CommunityProgram.find(params[:id])
    authorize! :update, @community_program

    @community_program.update_attributes!(community_program_params)

    if params[:button] == "verify" && can?(:verify, @community_program)
      previously_needed_verified = @community_program.verification_required?
      @community_program.update_attributes!(last_verified_at: Time.now)
    end

    if current_user.role?(:organization_member) && previously_needed_verified
      flash.notice = t('community_programs.flash_messages.verified',
                       name: @community_program.name,
                       school_name: @community_program.school.name)
    else
      flash.notice = t('community_programs.flash_messages.save.success',
                       name: @community_program.name,
                       school_name: @community_program.school.name)
    end

    if session[:redirect_back]
      redirect_back = session[:redirect_back]
      session[:redirect_back] = nil

      add_flash_js(:open_verification_modal, false)

      redirect_to redirect_back
    else
      redirect_to community_program_path(@community_program)
    end
  rescue ActiveRecord::RecordInvalid
    @community_program.build_primary_quality_element unless @community_program.primary_quality_element
    @community_program.build_secondary_quality_element unless @community_program.secondary_quality_element

    flash.now[:error] = t('errors.form_error', count: @community_program.errors.count)
    render :edit
  end

  def toggle_active
    @community_program = CommunityProgram.unscoped.find(params[:id])
    authorize! :toggle_active, @community_program

    if @community_program.active?
      @community_program.active = false
    else
      @community_program.active = true
    end

    @community_program.active_changed_by = current_user.id
    @community_program.active_changed_on = Time.now
    @community_program.save

    respond_to do |wants|
      wants.json do
        render json: {active: @community_program.active}.to_json
      end
    end
  end

  private

  def community_program_params
    params.require(:community_program).permit(:mou_on_file,
                                              :name,
                                              :notes,
                                              :organization_id,
                                              :school_id,
                                              :school_user_id,
                                              :secondary_quality_element_id,
                                              :service_description,
                                              :service_time_of_day,
                                              :site_agreement_on_file,
                                              :student_population_id,
                                              :target_population,
                                              :user_id,
                                              day_ids: [],
                                              demographic_group_ids: [],
                                              ethnicity_culture_group_ids: [],
                                              grade_level_ids: [],
                                              primary_quality_element_attributes: [
                                                :id,
                                                :quality_element_id,
                                                service_type_ids: []
                                              ],
                                              secondary_quality_element_attributes: [
                                                :id,
                                                :quality_element_id,
                                                service_type_ids: []
                                              ],
                                              service_time_ids: []
                                             )
  end
end
