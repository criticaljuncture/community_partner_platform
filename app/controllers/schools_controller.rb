class SchoolsController < ApplicationController
  def index
    @schools = School.all
  end

  def show
    @school = School.includes(:community_partners).find(params[:id])
  end
end
