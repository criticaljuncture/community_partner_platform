class ServiceType < ActiveRecord::Base
  has_many :quality_element_service_types
  has_many :quality_elements, through: :quality_element_service_types

  has_many :community_partner_quality_element_service_types
  has_many :quality_elements, through: :community_partner_quality_element_service_types

  has_many :community_partners, through: :quality_elements

  has_many :schools, through: :community_partners
  has_many :organizations, through: :community_partners

  validates :name, presence: true
  validates :quality_elements, presence: true
end
