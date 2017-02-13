class Public::HomePagePresenter
  def schools
    @schools ||= School.select(
      :name, :id, :site_type_norm
    ).order(:site_type_norm, :name).group_by(&:site_type_norm)
  end

  def organizations
    @organizations ||= Organization.select(:name, :id).order(:name)
      .group_by{|o| o.name.chars.first}
  end
end
