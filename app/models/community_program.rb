class CommunityProgram < ActiveRecord::Base
  include CommunityProgramAudit

  after_create :clear_associated_cache
  after_update :clear_associated_cache

  belongs_to :school
  has_one :region, through: :school

  belongs_to :organization
  belongs_to :student_population

  has_one :primary_quality_element,
          ->{where type: "PrimaryQualityElement"},
          class_name: CommunityProgramQualityElement
  has_many :primary_service_types,
           through: :primary_quality_element,
           source: :service_types

  has_one :secondary_quality_element,
          ->{where type: "SecondaryQualityElement"},
          class_name: CommunityProgramQualityElement

  has_many :secondary_service_types,
           through: :secondary_quality_element,
           source: :service_types

  has_many :community_program_ethnicity_culture_groups
  has_many :ethnicity_culture_groups, through: :community_program_ethnicity_culture_groups

  has_many :community_program_demographic_groups
  has_many :demographic_groups, through: :community_program_demographic_groups

  has_many :community_program_grade_levels
  has_many :grade_levels, through: :community_program_grade_levels

  has_many :community_program_service_days
  has_many :days, through: :community_program_service_days

  has_many :community_program_service_times
  has_many :service_times, through: :community_program_service_times

  accepts_nested_attributes_for :primary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }
  accepts_nested_attributes_for :secondary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }

  belongs_to :user

  belongs_to :school_user,
             class_name: User,
             foreign_key: :school_user_id


  validates :name,
    presence: {
      message: "must choose a program name"
    }
  validates :organization_id,
    presence: {
      message: "must choose an organization"
    }
  validates :user_id,
    presence: {
      message: "must choose an organization contact"
    }
  validates :school_id,
    presence: {
      message: "must choose a school"
    }
  validates :primary_quality_element,
    presence: {
      message: "must choose a primary quality element"
    }

  def quality_elements
    Rails.cache.fetch([self, "quality_elements"]) do
      [primary_quality_element.try(:quality_element), secondary_quality_element.try(:quality_element)].flatten.compact
    end
  end

  def service_types
    Rails.cache.fetch([self, "service_types"]) do
      (primary_service_types + secondary_service_types).flatten.compact
    end
  end

  def cached_organization
    Rails.cache.fetch([self, "cached_organization"]) do
      organization
    end
  end

  def verification_required?
    !new_record? && last_verified_at.nil?
  end

  private
  def clear_associated_cache
    school.touch
    organization.touch
  end
end
