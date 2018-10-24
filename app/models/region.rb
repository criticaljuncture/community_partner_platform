class Region < ApplicationRecord
  has_many :schools
  has_many :community_programs, through: :schools

  def community_programs_by_quality_element
    community_programs.includes(:quality_element, :primary_service_types).
      map(&:quality_element).
      compact.
      group_by(&:id)
  end
end
