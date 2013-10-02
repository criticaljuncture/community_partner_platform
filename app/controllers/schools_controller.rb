class SchoolsController < ApplicationController
  authorize_resource

  def index
    @schools = School.accessible_by(current_ability).includes(:community_partners, :quality_elements).order(:name)
    @quality_elements = QualityElement.accessible_by(current_ability).order(:name)
  end

  def show
    @school = School.includes(:community_partners).find(params[:id])
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    @school.save

    redirect_to school_path(@school)
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    @school.update_attributes(school_params)

    redirect_to school_path(@school)
  end

  def primary_contact_input
    @school = School.accessible_by(current_ability).includes(:users).find(params[:id])

    render "/community_partners/primary_school_contact_input", layout: false
  end

  private

  def school_params
    params.require(:school).permit(:active, :name, :region_id)
  end
end
