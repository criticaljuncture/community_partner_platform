class Public::SchoolsController < Public::ApplicationController
  def show
    @school = School
      .includes(school_programs: :community_program)
      .find(params[:id])

    @school_programs = @school.school_programs.select{|p| p.approved_for_public?}
  end
end
