class CommunityProgramMarkerSerializer < ActiveModel::Serializer
  attributes :type, :properties, :geometry

  def type
    "Feature"
  end

  def properties
    {
      "schoolName": object.name,
      "programCount": object.school_programs.size,
      "url": "http://www.google.com",
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

  def school_programs_by_element
    object
      .school_programs
      .reject{|sp| sp.quality_element.nil?}
      .group_by(&:quality_element)
      .sort_by{|qe, p| qe.name}
      .map do |quality_element, school_programs|
        {name: quality_element.name, count: school_programs.count}
      end
  end

end
