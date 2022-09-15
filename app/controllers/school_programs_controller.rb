class SchoolProgramsController < ApplicationController
  def new
    @school_program = SchoolProgram.new(school_program_params)
    authorize! :new, @school_program

    if request.xhr?
      render :new, layout: false
    else
      redirect_to root_url
    end
  end

  def create
    @school_program = SchoolProgram.new(school_program_params)
    authorize! :create, @school_program

    @school_program.save!

    render json: {
      message: t('school_programs.create.success',
        name: @school_program.school.name),
      html: render_to_string(
        partial: "community_programs/school_program_form_item",
        locals: {school_program: @school_program}
      ),
      school_program_id: @school_program.id
    }

  rescue ActiveRecord::RecordInvalid
    errors = @school_program.errors

    render json: {errors: errors}, status: 400
  end

  def edit
    @school_program = SchoolProgram.find(params[:id])
    authorize! :edit, @school_program

    if request.xhr?
      render :edit, layout: false
    else
      redirect_to root_url
    end
  end

  def update
    @school_program = SchoolProgram.find(params[:id])
    authorize! :update, @school_program

    @school_program.update!(school_program_params)

    # If the form didn't pass any params for one of the delegated methods
    # then we want to remove that association as it should now be delegating
    # Our school_program form doesn't pass params when they match the parents
    # params.
    @school_program.remove_associations_no_longer_delegating(
      school_program_params
    )

    render json: {
      message: t('school_programs.update.success',
        name: @school_program.school.name),
      html: render_to_string(
        partial: "community_programs/school_program_form_item",
        locals: {school_program: @school_program}
      ),
      school_program_id: @school_program.id
    }

  rescue ActiveRecord::RecordInvalid
    errors = @school_program.errors

    render json: {errors: errors}, status: 400
  end

  def destroy
    @school_program = @school_program = SchoolProgram.find(params[:id])
    authorize! :delete, @school_program

    @school_program.active = !@school_program.active?
    @school_program.active_changed_by = current_user.id
    @school_program.active_changed_on = Time.now
    @school_program.save

    render json: {
      message: t('school_programs.remove.success',
        name: @school_program.school.name),
      school_program_id: @school_program.id
    }
  end

  def school_program_params
    params.
      require(:school_program).
      permit(
        :community_program_id,
        :school_id,
        :site_agreement_on_file,
        :student_population_id,
        :user_id,
        day_ids: [],
        demographic_group_ids: [],
        ethnicity_culture_group_ids: [],
        grade_level_ids: [],
        service_time_ids: []
      )
  end
end
