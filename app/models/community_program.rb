class CommunityProgram < ActiveRecord::Base
  include ModelSerializable
  include CommunityProgramAudit
  include CommunityProgramAttributeRelationships

  attr_accessor :merge_target #for merging similar programs

  scope :active, -> { where(active: true) }

  before_save :update_completion_rate

  serialize :missing_fields, JSON
  before_save :update_missing_fields

  has_many :school_programs, dependent: :destroy
  has_many :schools, through: :school_programs
  #has_many :regions, through: :schools

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

  COMPLETION_WEIGHTS = [
    [
      0.30,
      [:name, :service_description, :quality_element,
       :service_types, :organization]
    ],
    [
      0.35,
      [:user, :student_population, :ethnicity_culture_groups, :demographic_groups,
       :grade_levels, :service_times, :days]
    ],
    [
      0.35,
      [:school_programs]
    ]
  ]

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

  def update_completion_rate
    self.completion_rate = completion_rate_calculator.completion_rate
  end

  def update_missing_fields
    self.missing_fields = completion_rate_calculator.missing_fields
  end

  def schools_with_differing_completion_rates
    @schools_with_differing_completion_rates ||= school_programs.select do |school_program|
      completion_rate != school_program.completion_rate
    end.sort_by{|s| s.school.name}
  end

  private

  def completion_rate_calculator
    @completion_rate_calculator ||= CompletionRateCalculator.new(
      self,
      COMPLETION_WEIGHTS
    )
  end
end
