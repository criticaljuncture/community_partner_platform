class ServiceType < ActiveRecord::Base
  has_many :quality_element_service_types
  has_many :quality_elements, through: :quality_element_service_types

  has_many :community_programs, through: :quality_elements

  has_many :schools, through: :community_programs
  has_many :organizations, through: :community_programs

  validates :name, presence: true
  validates :quality_elements, presence: true
end
