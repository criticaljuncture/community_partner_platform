class Public::HomePagePresenter
  def schools
    ordered_site_types = ["Childhood Development Centers", "Elementary Schools", "Grades K-8", "K-8 Schools", "Middle Schools", "Grades 6-12", "High Schools", "Alternative & Service Schools", "Other Schools"]

    @schools ||= SchoolDecorator.decorate_collection(
      School.select(
        :name, :id, :site_type_norm
      ).order(:site_type_norm, :name)
    )
    .group_by(&:human_site_type)
    .compact
    .reject{|site_type, schools| site_type.blank?}
    .sort do |site_type_1, site_type_2|
      ordered_site_types.index(site_type_1[0]) <=> ordered_site_types.index(site_type_2[0])
    end
  end

  def organizations
    @organizations ||= Organization.publicly_accessible
      .select(:name, :id).order(:name)
      .group_by{|o| o.name.chars.first}
  end

  def quality_elements
    @quality_elements ||= QualityElement.all
      .select(:name, :id)
      .includes(:service_types)
      .order(:name)

    elements = []

    @quality_elements.each do |quality_element|
      elements << [quality_element.name, quality_element.id]

      quality_element.service_types.each do |st|
        elements << ["&nbsp;&nbsp;&nbsp;&nbsp; #{st.name}".html_safe,
          st.name.downcase.gsub(/\s+/, '-'),
          {'data-parent-id' => quality_element.id}]
      end
    end

    elements
  end
end
