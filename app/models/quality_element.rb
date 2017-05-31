class QualityElement < ActiveRecord::Base
  has_many :quality_element_service_types
  has_many :service_types, through: :quality_element_service_types

  has_many :community_program_quality_elements
  has_many :community_programs, through: :community_program_quality_elements

  has_many :school_programs, through: :community_programs

  has_many :schools, through: :community_programs
  has_many :organizations, through: :community_programs

  validates :name, presence: true
  validates :element_type, presence: true

  scope :programmatic, -> { where(element_type: 'programmatic') }
  scope :foundational, -> { where(element_type: 'foundational') }

  def default_display
    self.name
  end

  def foundational?
    element_type == 'foundational'
  end

  def programmatic?
    element_type == 'programmatic'
  end
end
