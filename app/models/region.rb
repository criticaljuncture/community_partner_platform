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
      map(&:primary_quality_element).
      map(&:quality_element).
      group_by(&:id)
  end

  def schools
    @schools ||= School.where(region_id: id)
  end

  def community_programs
    @community_programs ||= schools.map{|s| s.community_programs}.flatten.uniq
  end
end
