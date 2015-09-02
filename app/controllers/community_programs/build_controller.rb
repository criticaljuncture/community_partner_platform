class CommunityPrograms::BuildController < ApplicationController
  include Wicked::Wizard

  steps :add_program_details, :add_schools

  def show
    @community_program = CommunityProgram.find(params[:community_program_id])
    authorize! :edit, @community_program

    render_wizard
  end

  def update
    @community_program = CommunityProgram.find(params[:community_program_id])
    authorize! :edit, @community_program

    @community_program.update_attributes(community_program_params)

    render_wizard @community_program
  end

  def community_program_params
    params.
      require(:community_program).
      permit(
        :student_population_id,
        day_ids: [],
        demographic_group_ids: [],
        ethnicity_culture_group_ids: [],
        grade_level_ids: [],
        service_time_ids: []
      )
  end
end
