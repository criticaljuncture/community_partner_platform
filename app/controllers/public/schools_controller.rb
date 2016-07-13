class Public::SchoolsController < Public::ApplicationController

  def show
    @school = School.includes(:community_programs).find(params[:id])
  end

end
