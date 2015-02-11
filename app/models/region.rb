class Region < ActiveRecord::Base
  has_many :schools
  has_many :community_programs, through: :schools

  def community_programs_by_quality_element
    community_programs.
      includes(primary_quality_element: :quality_element).
      map(&:primary_quality_element).
      map(&:quality_element).
      group_by(&:id)
  end
end
