class CommunityProgramMarkerSerializer < ActiveModel::Serializer
  attributes :type, :properties, :geometry

  def type
    "Feature"
  end

  def properties
    {
      "programCount": object.school_programs.size,
      "url": "http://www.google.com",
      "description": object.name,
    }
  end

  def geometry
    {
      "type": "Point",
      "coordinates": [object.lat, object.lng]
    }
  end

end
