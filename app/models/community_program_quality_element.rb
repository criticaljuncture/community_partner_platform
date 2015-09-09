class CommunityProgramQualityElement < ActiveRecord::Base
  belongs_to :community_program
  belongs_to :quality_element

  has_many :community_program_quality_element_service_types
  has_many :service_types, through: :community_program_quality_element_service_types

  accepts_nested_attributes_for :service_types

  validates :community_program_id,
    presence: true,
    unless: ->{ new_record? }

  validates :quality_element_id,
    presence: true

  validates :service_type_ids,
    presence: {
      message: "must choose at least one"
    },
    length: {
      maximum: 2,
      message: "can not choose more than 2 service types"
    },
    if: ->{ quality_element.present? }

  delegate :name, to: :quality_element, allow_nil: true
end
