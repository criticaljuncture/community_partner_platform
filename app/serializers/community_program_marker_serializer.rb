class CommunityProgramMarkerSerializer < BaseSerializer
  cache key: 'community_program_markers'
  attributes :type, :properties, :geometry

  def type
    "Feature"
  end

  def properties
    {
      "schoolName": object.name,
      "programCount": school_programs.size,
      "schoolUrl": school_url(object),
      "schoolProgramsByElement": school_programs_by_element,
    }
  end

  def geometry
    {
      "type": "Point",
      "coordinates": [object.lat, object.lng]
    }
  end

  private

  def school_programs
    object
      .school_programs
      .reject{|sp| sp.quality_element.nil?}
      .select{|sp| sp.approved_for_public?}
  end

  def school_programs_by_element
    school_programs
      .group_by(&:quality_element)
      .sort_by{|qe, p| qe.name}
      .map do |quality_element, school_programs|
        {
          name: quality_element.name,
          count: school_programs.count
        }
      end
  end

end
