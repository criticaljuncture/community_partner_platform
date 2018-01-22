class ApiController < ApplicationController
  skip_before_action :authenticate_user!
  skip_authorization_check

  def community_program_markers
    unless %w(CDC Elementary Middle Senior).include?(params[:site_type_norm])
      render text: nil and return
    end

    site_type_norm = params[:site_type_norm]
    if site_type_norm == 'Elementary'
      site_type_norm = ['Elementary', 'K-8']
    elsif site_type_norm == 'Senior'
      site_type_norm = ['Senior', '6-12']
    end

    @schools = School.where(
      active: true,
      site_type_norm: site_type_norm
    ).includes(school_programs: {community_program: :quality_element})

    render json: GeoJsonSerializer.new(@schools, {serializer: CommunityProgramMarkerSerializer})
  end

  def community_programs
    @community_programs = CommunityProgram.active.accessible_by(current_ability).includes(:school, :organization).all

    render :json => @community_programs, :root => "community_programs"
  end

  def school_sub_areas
    @schools = School.accessible_by(current_ability).includes(:community_programs).all

    json = {
      schools:  @schools.map do |school|
                  {
                    name: school.try(:name),
                    partners_by_sub_area: QualityElement.accessible_by(current_ability).map do |element|
                        { name: element.name,
                          id: element.id,
                          count: school.quality_elements.where(id: element.id).count
                        }
                    end
                  }
                end
    }

    render :json => json
  end

  def school_hierarchy
    @schools = School.accessible_by(current_ability).includes(:community_programs, :organizations).all

    json = {
            name: 'Schools',
            size: 100,
            child_count: 2,
            children: @schools.map do |school|
              {
                name: school.try(:name),
                size: 500,
                child_count: school.organizations.count,
                children: school.organizations.uniq.map do |org|
                  {
                    name: org.try(:name),
                    child_count: org.quality_elements.uniq.size,
                    size: 950,
                    children: org.quality_elements.uniq.map{ |sq| {name: sq.try(:name), size: 1050} }
                  }
                end
              }
            end
          }
    render :json => json #@schools, :serializer => SchoolHierarchySerializer, :root => :school
  end

  def schools
    @schools = School.accessible_by(current_ability).includes(:community_programs, :organizations)

    max_partner_count = @schools.map do |school|
                          school.quality_elements.group_by(&:id).map do |id, quality_elements|
                            quality_elements.size
                          end.compact.max
                        end.compact.max

    render json: @schools, root: "schools", meta: {max_partner_count: max_partner_count}
  end
end
