class SchoolsController < ApplicationController
  def index
    @schools = School.accessible_by(current_ability).order(:name)
    authorize! :index, @schools

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
    @school = School.includes(:users).find(params[:id])
    authorize! :read, :primary_school_contact_input

    render "/community_programs/primary_school_contact_input", layout: false
  end

  private

  def school_params
    params.require(:school).permit(:active, :name, :region_id)
  end
end
