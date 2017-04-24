class CommunityPrograms::BuildController < ApplicationController
  include Wicked::Wizard

  steps :add_program_details, :add_schools

  def show
    @community_program = CommunityProgram
      .includes(school_programs: [:school, :user, :days, :demographic_groups, :ethnicity_culture_groups, :grade_levels, :service_times, :student_population])
      .find(params[:community_program_id])
    authorize! :edit, @community_program

    render_wizard
  end

  def update
    @community_program = CommunityProgram.find(params[:community_program_id])
    authorize! :edit, @community_program

    @community_program.wizard_step = step

    if step == steps.last
      @community_program.active = true
      @community_program.last_verified_at = Time.now
      @community_program.last_verified_by = current_user.id
    end

    @community_program.update_attributes(community_program_params)

    render_wizard @community_program
  end

  def finish_wizard_path(params={})
    flash.notice = t('community_programs.flash_messages.save.success',
                     name: @community_program.name)
    community_program_path(@community_program)
  end

  def community_program_params
    params.
      require(:community_program).
      permit(
        :id,
        :student_population_id,
        day_ids: [],
        demographic_group_ids: [],
        ethnicity_culture_group_ids: [],
        grade_level_ids: [],
        service_time_ids: []
      )
  end
end
