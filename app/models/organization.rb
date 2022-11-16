class Organization < ApplicationRecord
  include ApplicationConfig::Validations
  include OrganizationAudit

  attr_accessor :verification, :user_ids_to_assign

  before_save CompletionPolicy::OrganizationPolicy
  serialize :missing_fields, JSON

  after_create :clear_associated_cache
  after_update :clear_associated_cache

  has_many :community_programs
  has_many :schools, through: :community_programs

  has_many :users

  has_one :cte_quality_element,
    ->{ where element_type: "cte"} ,
    class_name: 'OrganizationQualityElement'
  has_many :cte_service_types,
    through: :cte_quality_element,
    source: :service_types,
    dependent: :destroy

  has_many :cte_event_type_organizations
  has_many :cte_event_types,
    through: :cte_event_type_organizations

  accepts_nested_attributes_for :cte_quality_element, reject_if: proc {|attr| attr['quality_element_id'].blank? }

  belongs_to :legal_status
  belongs_to :primary_contact, foreign_key: :user_id, class_name: 'User'
  belongs_to :verifier, foreign_key: :last_verified_by, class_name: 'User'
  belongs_to :public_authorizer, foreign_key: :approved_for_public_by, class_name: 'User'


  scope :ousd, -> { where("organizations.name LIKE 'OUSD%'") }
  scope :non_ousd, -> { where("organizations.name NOT LIKE 'OUSD%'") }

  scope :with_users, -> {
    joins(:users).where("users.organization_id IS NOT NULL").group("organizations.id")
  }

  scope :with_community_programs, -> {
    joins(
      'LEFT OUTER JOIN community_programs ON organizations.id = community_programs.organization_id'
    ).
    where(community_programs: {active: true})
  }

  scope :publicly_accessible, -> {
    where(approved_for_public: true)
  }

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

  # TODO: BB move to verification policy
  def verification_required?
    !new_record? &&
      (
        last_verified_at.nil? ||
        last_verified_at < Date.parse(Settings.app_config.organization.verification_policy.verification_date)
      )
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
    community_programs.active.each do |cp|
      sum += (cp.verification_required? ? 1 : 0)
    end
    sum
  end

  def inactive_community_programs
    community_programs.
      where(organization_id: self.id, active: false)
  end

  def eligible_programs
    @programs ||= community_programs.active.select do |cp|
      !cp.approved_for_public? && cp.eligible_to_be_made_public?(org_check: false)
    end
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

  delegate :public_attribute?,
    :can_be_made_public?,
    to: :public_policy

  def public_policy
    @public_policy ||= PublicPolicy::OrganizationPolicy.new(self)
  end

  def completion_policy
    @completion_policy ||= CompletionPolicy::OrganizationPolicy.new(self)
  end

  private

  def clear_associated_cache
    schools.each{|s| s.touch}
    community_programs.each{|cp| cp.touch}
  end
end
