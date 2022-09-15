class SchoolsController < ApplicationController
  def index
    @overview_presenter = SchoolsOverviewPresenter.new(
      nil, view_context
    )
    authorize! :index, School

    @quality_elements = QualityElement.
      accessible_by(current_ability).
      order(:name)
  end

  def show
    @school = School.includes(
      community_programs: [:quality_element, :organization, :primary_service_types, :student_population],
      school_programs: :organization
    ).find(params[:id])
    authorize! :show, @school
  end

  def new
    @school = School.new
    authorize! :new, @school
  end

  def create
    @school = School.new(school_params)
    authorize! :create, @school

    @school.save!

    flash.notice = t('schools.flash_messages.create.success',
                      name: @school.name)
    redirect_to school_path(@school)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('errors.form_error', count: @school.errors.count)
    render :new
  end

  def edit
    @school = School.find(params[:id])
    authorize! :edit, @school
  end

  def update
    @school = School.find(params[:id])
    authorize! :update, @school

    @school.update!(school_params)

    flash.notice = t('schools.flash_messages.save.success',
                     name: @school.name)

    redirect_to school_path(@school)
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t('errors.form_error', count: @school.errors.count)
    render :edit
  end

  def primary_contact_input
    @collection = School.includes(:users).find(params[:id])
    authorize! :read, :primary_school_contact_input

    @form_object = :school_program
    render "/community_programs/primary_contact_input", layout: false
  end

  def table
    @schools_presenter = SchoolsListPresenter.new(
      School.
      includes(
        {:community_programs => :quality_element},
        :organizations
      ).
      accessible_by(current_ability).
      order(:name)
    )
    authorize! :index, School

    render layout: false
  end

  private

  def school_params
    params.require(:school).permit(:active, :name, :region_id)
  end
end
