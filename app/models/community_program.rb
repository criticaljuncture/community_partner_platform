class CommunityProgram < ActiveRecord::Base
  include ModelSerializable
  include CommunityProgramAudit
  include CommunityProgramAttributeRelationships

  default_scope { where(active: true) }

  after_create :clear_associated_cache
  after_update :clear_associated_cache

  has_many :school_programs
  has_many :schools, through: :school_programs
  #has_many :regions, through: :schools

  belongs_to :organization

  has_one :primary_quality_element,
          ->{where type: "PrimaryQualityElement"},
          class_name: CommunityProgramQualityElement
  has_many :primary_service_types,
           through: :primary_quality_element,
           source: :service_types

  accepts_nested_attributes_for :primary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }

  belongs_to :user

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

  validates :primary_quality_element,
    presence: {
      message: "must choose a primary quality element"
    }

  def quality_element
    primary_quality_element.try(:quality_element)
  end

  def service_types
    primary_service_types
  end

  def verification_required?
    !new_record? && last_verified_at.nil?
  end

  def should_verify?(current_user)
      current_user.role?(:organization_member) &&
      verification_required?
  end

  private
  def clear_associated_cache
    organization.touch
  end
end
