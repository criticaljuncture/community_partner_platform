class ApiController < ApplicationController
  skip_before_filter :authenticate_user!

  def community_partners
    @community_partners = CommunityPartner.includes(:school, :organization).all

    render :json => @community_partners, :root => "community_partners"
  end

  def school_sub_areas
    @schools = School.includes(:community_partners).all

    json = { 
      schools:  @schools.map do |school|
                  {
                    name: school.try(:name),
                    partners_by_sub_area: SchoolQualityIndicatorSubArea.all.map do |sub_area|
                        { name: sub_area.name,
                          id: sub_area.id,
                          count: school.community_partners.where(school_quality_indicator_sub_area_id: sub_area.id).count
                        }
                    end
                  }
                end
    }

    render :json => json
  end

  def school_hierarchy
    @schools = School.includes(:community_partners, :organizations).all
    
    json = {
            name: 'Schools',
            size: 100,
            child_count: 2,
            children: @schools.map do |object|
              {
                name: object.try(:name),
                size: 500,
                child_count: object.organizations.count,
                children: object.organizations.uniq.map do |org|
                  {
                    name: org.try(:name),
                    child_count: org.school_quality_indicator_sub_areas.uniq.size,
                    size: 800,
                    children: org.school_quality_indicator_sub_areas.uniq.map{ |sq| {name: sq.try(:name), size: 900} }
                  }
                end
              }
            end
          }
    render :json => json #@schools, :serializer => SchoolHierarchySerializer, :root => :school
  end

  def schools
    @schools = School.includes(:community_partners, :organizations).all

    render :json => @schools, :root => "schools"
  end
end
