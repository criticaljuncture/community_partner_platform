class SchoolsController < ApplicationController
  def index
    @overview_presenter = SchoolsOverviewPresenter.new(nil, view_context)
    @schools_presenter = SchoolsListPresenter.new(
      School.accessible_by(current_ability).order(:name)
    )
    authorize! :index, School

    @quality_elements = QualityElement.accessible_by(current_ability).order(:name)
  end

  def show
    @school = School.includes(:community_programs).find(params[:id])
    authorize! :show, @school
  end

  def new
    @school = School.new
    authorize! :new, @school
  end

  def create
    @school = School.new(school_params)
    authorize! :create, @school

    @school.save

    redirect_to school_path(@school)
  end

  def edit
    @school = School.find(params[:id])
    authorize! :edit, @school
  end

  def update
    @school = School.find(params[:id])
    authorize! :update, @school

    @school.update_attributes(school_params)

    redirect_to school_path(@school)
  end

  def primary_contact_input
    @collection = School.includes(:users).find(params[:id])
    authorize! :read, :primary_school_contact_input

    @form_object = :school_program
    render "/community_programs/primary_contact_input", layout: false
  end

  private

  def school_params
    params.require(:school).permit(:active, :name, :region_id)
  end
end
