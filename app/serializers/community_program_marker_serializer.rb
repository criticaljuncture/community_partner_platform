class CommunityProgramMarkerSerializer < ActiveModel::Serializer
  attributes :type, :properties, :geometry

  def type
    "Feature"
  end

  def properties
    {
      "programCount": object.school_programs.size,
      "url": "http://www.google.com",
      "description": "<h1>#{object.name}</h1>
        <dl>
          <dt>Total Program Count</dt>
          <dd>#{object.school_programs.size}</dd>
          #{school_programs_by_element}
        </dl>"
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
    object.
      school_programs.
      reject{|sp| sp.quality_element.nil?}.
      group_by(&:quality_element).
      sort_by{|qe, p| qe.name}.map do |quality_element, school_programs|
        "<dt>#{quality_element.name}</dt>
         <dd>#{school_programs.count}</dd>
        "
      end.
      join
  end

end
