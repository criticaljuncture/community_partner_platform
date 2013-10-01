class CommunityPartner < ActiveRecord::Base
  belongs_to :school
  has_one :region, through: :school

  belongs_to :organization
  belongs_to :student_population

  has_many :community_partner_quality_elements
  has_many :quality_elements, through: :community_partner_quality_elements

  has_many :service_types, through: :quality_elements

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

  has_many :community_partnership_demographic_groups
  has_many :demographic_groups, through: :community_partnership_demographic_groups

  has_many :community_partnership_grade_levels
  has_many :grade_levels, through: :community_partnership_grade_levels

  has_many :community_partnership_service_days
  has_many :days, through: :community_partnership_service_days

  has_many :community_partnership_service_times
  has_many :service_times, through: :community_partnership_service_times

  accepts_nested_attributes_for :primary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }
  accepts_nested_attributes_for :secondary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }

  belongs_to :user
  belongs_to :school_user, foreign_key: :school_user_id, class_name: User


  validates :name, presence: true
  validates :organization_id, presence: true
  validates :user_id, presence: true
  
  validates :school_id, presence: true
  
  validates :primary_quality_element, presence: true  
end
