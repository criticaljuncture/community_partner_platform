class Public::CommunityProgramsController < Public::ApplicationController
  def show
    @community_program = CommunityProgram.publicly_accessible.find(params[:id]).decorate
  end
end
