class CommunityProgram < ActiveRecord::Base
  include ModelSerializable
  include CommunityProgramAudit
  include CommunityProgramAttributeRelationships

  attr_accessor :merge_target #for merging similar programs

  default_scope { where(active: true) }

  after_save :update_program_completion_rate

  has_many :school_programs
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
      [:name, :service_description, :primary_quality_element,
       :primary_service_types, :organization, :user]
    ],
    [
      0.35,
      [:student_population, :ethnicity_culture_groups, :demographic_groups,
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

  def update_program_completion_rate
    update_column(
      :program_completion_rate, ProgramCompletionRateCalculator.new(
        self,
        COMPLETION_WEIGHTS
      ).completion_rate
    )
  end

end
