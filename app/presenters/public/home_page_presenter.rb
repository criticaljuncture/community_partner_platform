class Public::HomePagePresenter
  def schools
    @schools ||= SchoolDecorator.decorate_collection(
      School.select(
        :name, :id, :site_type_norm
      ).order(:site_type_norm, :name)
    ).group_by(&:human_site_type)
  end

  def organizations
    @organizations ||= Organization.publicly_accessible
      .select(:name, :id).order(:name)
      .group_by{|o| o.name.chars.first}
  end
end
