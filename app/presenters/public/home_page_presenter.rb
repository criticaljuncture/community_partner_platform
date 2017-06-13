class Public::HomePagePresenter
  def schools
    ordered_site_types = ["Elementary Schools", "Grades K-8", "Middle Schools", "Grades 6-12", "High Schools"]

    @schools ||= SchoolDecorator.decorate_collection(
      School.select(
        :name, :id, :site_type_norm
      ).order(:site_type_norm, :name)
    )
    .group_by(&:human_site_type)
    .compact
    .sort do |site_type_1, site_type_2|
      ordered_site_types.index(site_type_1[0]) <=> ordered_site_types.index(site_type_2[0])
    end
  end

  def organizations
    @organizations ||= Organization.publicly_accessible
      .select(:name, :id).order(:name)
      .group_by{|o| o.name.chars.first}
  end
end
