class OrganizationQualityElement < ApplicationRecord
  belongs_to :organization
  belongs_to :quality_element

  has_many :organization_quality_element_service_types
  has_many :service_types, through: :organization_quality_element_service_types

  accepts_nested_attributes_for :service_types

  validates :organization_id,
    presence: true,
    unless: ->{ new_record? }

  validates :quality_element_id,
    presence: true

  validates :service_type_ids,
    presence: {
      message: "must choose at least one"
    },
    if: ->{ quality_element.present? }
end
