class CommunityPartnerQualityElement < ActiveRecord::Base
  belongs_to :community_partner
  belongs_to :quality_element

  has_many :community_partner_quality_element_service_types
  has_many :service_types, through: :community_partner_quality_element_service_types
  
  accepts_nested_attributes_for :service_types

  validates :community_partner_id, presence: true, unless: ->{ new_record? }
  validates :quality_element_id, presence: true
  validates :service_type_ids, presence: true, if: ->{ quality_element.present? }

  delegate :name, to: :quality_element
end
