class Region < ActiveHash::Base
  include I18nAccessor

  i18n_accessor :name

  self.data = [
    {id: 1, identifier: :elementary_area_1, network: 'A1'},
    {id: 2, identifier: :elementary_area_2, network: 'A2'},
    {id: 3, identifier: :elementary_area_3, network: 'A3'},
    {id: 4, identifier: :middle,            network: 'MS'},
    {id: 5, identifier: :high_school,       network: 'HS'},
  ]

  def community_programs_by_quality_element
    community_programs.
      map(&:quality_element).
      compact.
      group_by(&:id)
  end

  def schools
    @schools ||= School.
      includes(:community_programs).
      where(region_id: id)
  end

  def community_programs
    @community_programs ||= schools.map do |s|
      s.community_programs.
        includes(:quality_element, :primary_service_types)
    end.flatten.uniq
  end
end
