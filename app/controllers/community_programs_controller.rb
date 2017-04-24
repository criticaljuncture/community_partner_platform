class CommunityProgramsController < ApplicationController

  def index
    @community_programs = CommunityProgram.active.accessible_by(current_ability)
    authorize! :index, CommunityProgram
  end

  def show
    @community_program = CommunityProgram.
      includes(school_programs: [:school, :user, :days, :demographic_groups, :ethnicity_culture_groups, :grade_levels, :service_times, :student_population]).
      find(params[:id])
    authorize! :show, @community_program

    @community_program = CommunityProgramDecorator.decorate(
      @community_program
    )
  end

  def new
    @community_program = params[:community_program].present? ? CommunityProgram.new(community_program_params) : CommunityProgram.new()
    authorize! :new, @community_program

    if params[:redirect_back]
      session[:redirect_back] = params[:redirect_back]
    end

    @community_program.build_primary_quality_element
    @community_program = CommunityProgramDecorator.decorate(
      @community_program
    )
  end

  def create
    @community_program = CommunityProgram.new(
      community_program_params.except(:primary_quality_element)
    )
    authorize! :create, @community_program

    if @community_program.primary_quality_element
      if community_program_params[:primary_quality_element_attributes][:service_type_ids].present?
        @community_program.primary_quality_element.service_type_ids = community_program_params[:primary_quality_element_attributes][:service_type_ids]
      elsif community_program_params[:primary_quality_element][:service_type_ids].present?
        @community_program.primary_quality_element.service_type_ids = community_program_params[:primary_quality_element][:service_type_ids].reject{|a| a.blank?}
      end
    end

    if current_user.role?(:organization_member)
      @community_program.last_verified_at = Time.now
    end

    @community_program.save!

    flash.notice = t('community_programs.flash_messages.create.success',
                      name: @community_program.name)

    if session[:redirect_back]
      redirect_back = session[:redirect_back]
      session[:redirect_back] = nil

      add_flash_js(:open_verification_modal, false)

      redirect_to redirect_back
    else
      redirect_to community_program_build_path(@community_program.id, :add_program_details)
    end
  rescue ActiveRecord::RecordInvalid
    @community_program.build_primary_quality_element unless @community_program.primary_quality_element

    flash.now[:error] = t('errors.form_error', count: @community_program.errors.count)

    @community_program = CommunityProgramDecorator.decorate(@community_program)
    render :new
  end

  def edit
    @community_program = CommunityProgram.find(params[:id])
    authorize! :edit, @community_program

    if params[:redirect_back]
      session[:redirect_back] = params[:redirect_back]
    end

    @community_program = CommunityProgramDecorator.decorate(@community_program)
  end

  def update
    @community_program = CommunityProgram.find(params[:id])
    authorize! :update, @community_program

    @community_program = CommunityProgramDecorator.decorate(@community_program)

    @community_program.update_attributes!(community_program_params)

    if params["commit"] == t('forms.buttons.save_verify') &&
        can?(:verify, @community_program)

      previously_needed_verified = @community_program.verification_required?
      @community_program.update_attributes!(
        last_verified_at: Time.now,
        last_verified_by: current_user.id
      )
    end

    if can?(:verify, @community_program) && previously_needed_verified
      flash.notice = t('community_programs.flash_messages.verified',
                       name: @community_program.name)
    else
      flash.notice = t('community_programs.flash_messages.save.success',
                       name: @community_program.name)
    end

    if session[:redirect_back]
      redirect_back = session[:redirect_back]
      session[:redirect_back] = nil

      redirect_to redirect_back
    else
      redirect_to community_program_path(@community_program)
    end
  rescue ActiveRecord::RecordInvalid
    @community_program.build_primary_quality_element unless @community_program.primary_quality_element

    flash.now[:error] = t('errors.form_error', count: @community_program.errors.count)

    @community_program = CommunityProgramDecorator.decorate(@community_program)
    render :edit
  end

  def toggle_active
    @community_program = CommunityProgram.find(params[:id])
    authorize! :toggle_active, @community_program

    if @community_program.active?
      @community_program.active = false
      @community_program.school_programs.each do |program|
        program.active = false
        program.active_changed_by = current_user.id
        program.active_changed_on = Time.now
        program.save(verify: false)
      end
    else
      @community_program.active = true
      @community_program.school_programs.each do |program|
        program.active = true
        program.active_changed_by = current_user.id
        program.active_changed_on = Time.now
        program.save(verify: false)
      end
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

  def table
    @community_programs = CommunityProgram.active.accessible_by(current_ability).
      includes(:organization, :school_programs, :schools, :quality_element).
      order("organizations.name")
    authorize! :index, CommunityProgram

    render layout: false
  end

  def merge
    community_program = CommunityProgram.active.find(params[:id])
    authorize! :merge_program, community_program

    master_program = CommunityProgram.find(community_program_params[:merge_target])

    flash.notice = t('community_programs.flash_messages.merge.success',
                     name: community_program.name,
                     merged_name: master_program.name)

    if can?(:edit, master_program)
      SimilarProgramCollapser.perform(master_program, community_program)
    end

    redirect_to community_program_path(master_program)
  end

  private

  def community_program_params
    params.require(:community_program).permit(
      :merge_target,
      :mou_on_file,
      :name,
      :notes,
      :organization_id,
      :receives_district_funding,
      :school_id,
      :school_user_id,
      :secondary_quality_element_id,
      :service_description,
      :site_agreement_on_file,
      :student_population_id,
      :user_id,
      day_ids: [],
      demographic_group_ids: [],
      ethnicity_culture_group_ids: [],
      grade_level_ids: [],
      primary_quality_element_attributes: [
        :id,
        :quality_element_id,
        service_type_ids: [],
      ],
      primary_quality_element: [
        service_type_ids: [],
      ],
      service_time_ids: []
    )
  end
end
