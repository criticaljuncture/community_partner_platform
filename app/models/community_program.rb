class CommunityProgram < ActiveRecord::Base
  include ApplicationConfig::Validations

  include ModelSerializable
  include CommunityProgramAudit
  include CommunityProgramAttributeRelationships

  attr_accessor :merge_target #for merging similar programs
  attr_accessor :wizard_step

  scope :active, -> { where(active: true) }

  before_save CompletionPolicy::CommunityProgramPolicy
  serialize :missing_fields, JSON

  has_many :school_programs, dependent: :destroy
  has_many :schools, through: :school_programs

  belongs_to :organization
  belongs_to :verifier, foreign_key: :last_verified_by, class_name: User

  has_one :primary_quality_element,
          ->{where type: "PrimaryQualityElement"},
          class_name: CommunityProgramQualityElement
  has_one :quality_element, through: :primary_quality_element

  has_many :primary_service_types,
           through: :primary_quality_element,
           source: :service_types

  accepts_nested_attributes_for :primary_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }

  belongs_to :user

  #############################################
  # view CommunityProgramAttributeRelationships for more (shared) relationships and validations
  #############################################


  def service_types
    primary_service_types
  end

  def verification_required?
    !new_record? &&
      (last_verified_at.nil? ||
        last_verified_at < Settings.community_program.verification_date)
  end

  def should_verify?(current_user)
      current_user.role?(:organization_member) &&
      verification_required?
  end

  def schools_with_differing_completion_rates
    @schools_with_differing_completion_rates ||= school_programs.select do |school_program|
      completion_rate != school_program.completion_rate
    end.sort_by{|s| s.school.name}
  end

  def completion_policy
    @completion_policy ||= CompletionPolicy::CommunityProgramPolicy.new(self)
  end

  def public_policy
    @public_policy ||= PublicPolicy::CommunityProgramPolicy.new(self)
  end
end
