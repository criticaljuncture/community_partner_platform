class QualityElement < ActiveRecord::Base
  has_many :quality_element_service_types
  has_many :service_types, through: :quality_element_service_types

  #has_many :community_partners
  has_many :community_partner_quality_elements
  has_many :community_partners, through: :community_partner_quality_elements

  has_many :schools, through: :community_partners
  has_many :organizations, through: :community_partners

  validates :name, presence: true
  validates :element_type, presence: true
end
