class Public::SchoolsController < Public::ApplicationController

  def index
    @school = School.new
  end

  def show
    @school = School.includes(:community_programs).find(params[:id])
  end

end
