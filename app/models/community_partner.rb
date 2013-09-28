class CommunityPartner < ActiveRecord::Base
  belongs_to :school
  has_one :region, through: :school

  belongs_to :organization

  has_one :primary_quality_element,
          ->{where type: "PrimaryQualityElement"},
          class_name: CommunityPartnerQualityElement
  has_many :primary_service_types,
           through: :primary_quality_element,
           source: :service_types

  has_one :secondary_quality_element,
          ->{where type: "SecondaryQualityElement"},
          class_name: CommunityPartnerQualityElement

  has_many :secondary_service_types,
           through: :secondary_quality_element,
           source: :service_types


  accepts_nested_attributes_for :primary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }
  accepts_nested_attributes_for :secondary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }

  belongs_to :user
  belongs_to :school_user, foreign_key: :school_user_id, class_name: User


  validates :organization_id, presence: true
  validates :user_id, presence: true
  
  validates :school_id, presence: true
  #validates :school_user_id, presence: true
  
  validates :primary_quality_element, presence: true
  
end
