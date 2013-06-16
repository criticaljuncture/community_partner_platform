class SchoolHierarchySerializer < ActiveModel::Serializer
  attributes :hierarchy

  def hierarchy
    {
      name: object.try(:name),
      children: object.organizations.map do |org|
        {
          name: org.try(:name),
          children: org.school_quality_indicator_sub_areas.uniq.map{ |sq| {name: sq.try(:name)} }
        }
      end
    }
  end
end
