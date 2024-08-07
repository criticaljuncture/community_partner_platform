class Public::OrganizationsController < Public::ApplicationController
  include OrganizationConcerns

  def index
    @organizations = OrganizationDecorator.decorate_collection(
      Organization.publicly_accessible.
        includes(
          {
            community_programs: [
              :school_programs, :quality_element, :primary_service_types
            ],
          },
          :community_programs,
          :schools,
        ).
        sort_by(&:name)
    )

    @counts_by_org = counts_by_org
  end

  def show
    @organization = Organization.publicly_accessible.find(params[:id])
  end
end
