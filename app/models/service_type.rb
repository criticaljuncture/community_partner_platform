class ServiceType < ApplicationRecord
  has_many :quality_element_service_types, dependent: :destroy
  has_many :quality_elements, through: :quality_element_service_types

  has_many :community_program_quality_element_service_types
  has_many :community_program_quality_elements,
    through: :community_program_quality_element_service_types

  validates :name, presence: true
  validates :quality_elements, presence: true

  def default_display
    self.name
  end

  def quality_element_groups
    community_program_quality_elements.group_by(&:quality_element_id)
  end

  def community_programs_for_quality_element_service_type(quality_element)
    groups = quality_element_groups[quality_element.id]

    if groups
      groups.map{|g| g.community_program}
    else
      []
    end
  end

  def schools_for_quality_element_service_type(quality_element)
    community_programs_for_quality_element_service_type(quality_element).
      compact.map{|cp|
        cp.school_programs.map{|sp| sp.school}
      }.flatten.uniq
  end

  def organizations_for_quality_element_service_type(quality_element)
    community_programs_for_quality_element_service_type(quality_element).
      compact.map{|cp| cp.organization}.uniq
  end
end
