class Public::SchoolsController < Public::ApplicationController
  def index
    @schools_presenter = SchoolsListPresenter.new(
      School.
      includes(
        {community_programs: [:quality_element, :primary_service_types]},
        :organizations
      ).
      order(:name)
    )
  end

  def show
    @school = School
      .includes(school_programs: :community_program)
      .find(params[:id])

    @school_programs = @school.school_programs.select{|p| p.approved_for_public?}
  end
end
