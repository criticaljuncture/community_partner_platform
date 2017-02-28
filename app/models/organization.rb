class Organization < ActiveRecord::Base
  include ApplicationConfig::Validations
  include OrganizationAudit

  attr_accessor :verification, :user_ids_to_assign

  before_save :update_completion_rate
  serialize :missing_fields, JSON
  before_save :update_missing_fields

  after_create :clear_associated_cache
  after_update :clear_associated_cache

  has_many :community_programs

  has_many :schools, through: :community_programs
  has_many :users

  belongs_to :legal_status
  belongs_to :primary_contact, foreign_key: :user_id, class_name: User
  belongs_to :verifier, foreign_key: :last_verified_by, class_name: User

  scope :ousd, -> { where("organizations.name LIKE 'OUSD%'") }
  scope :non_ousd, -> { where("organizations.name NOT LIKE 'OUSD%'") }

  scope :with_users, -> {
    joins(:users).where("users.organization_id IS NOT NULL").group("organizations.id")
  }

  scope :with_community_programs, -> {
    joins(
      'LEFT OUTER JOIN community_programs ON organizations.id = community_programs.organization_id'
    ).
    where(:community_programs => {active: true})
  }


  COMPLETION_WEIGHTS = [
    [
      0.25,
      Settings.app_config.organization.required_fields.map(&:attribute)
    ],
    [
      0.75,
      [:address, :city, :zip_code, :phone_number, :url,
       :mou_on_file, :mission_statement, :services_description, :program_impact,
       :cost_per_student]
    ],
  ]

  def quality_elements
    @qe ||= community_programs.map{|cp| cp.quality_element}.flatten.uniq
  end

  def service_types
    @st ||= community_programs.map{|cp| cp.service_types}.flatten.uniq
  end

  def self.needs_verification_path(organization)
    Rails.application.routes.url_helpers.
      verification_organization_path(organization)
  end

  def verification_required?
    !new_record? &&
      (last_verified_at.nil? ||
        last_verified_at < Settings.organization.verification_date)
  end

  def any_unverified_programs?
    unverified_program_count > 0
  end

  def any_users_attended_orientation?
    @orientation_attended ||= users.any? {|user| user.attended_orientation_at}
  end

  def user_last_orientation_attended
    if any_users_attended_orientation?
      users.where("attended_orientation_at IS NOT NULL").order("attended_orientation_at DESC").first
    end
  end

  def unverified_program_count
    sum = 0
    community_programs.each do |cp|
      sum += (cp.verification_required? ? 1 : 0)
    end
    sum
  end

  def inactive_community_programs
    community_programs.
      where(organization_id: self.id, active: false)
  end

  def update_completion_rate
    self.completion_rate = completion_rate_calculator.completion_rate
  end

  def update_missing_fields
    self.missing_fields = completion_rate_calculator.missing_fields
  end

  def average_program_completion_rate
    return 0 unless community_programs.present?

    sum = community_programs.inject(0) do |sum, program|
      sum += program.completion_rate
    end

    sum / community_programs.size
  end

  def last_sign_in
    users.map(&:last_sign_in_at).compact.sort.last
  end

  private

  def completion_rate_calculator
    @completion_rate_calculator ||= CompletionRateCalculator.new(
      self,
      COMPLETION_WEIGHTS
    )
  end

  def clear_associated_cache
    schools.each{|s| s.touch}
    community_programs.each{|cp| cp.touch}
  end
end
