class SchoolsController < ApplicationController
  def index
    @schools = School.all
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

  private

  def school_params
    params.require(:school).permit(:name)
  end
end
