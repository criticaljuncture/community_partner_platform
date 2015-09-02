class Organization < ActiveRecord::Base
  include OrganizationAudit
  attr_accessor :verification

  serialize :reported_school_programs, JSON

  after_create :clear_associated_cache
  after_update :clear_associated_cache

  has_many :community_programs

  has_many :schools, through: :community_programs
  has_many :users

  scope :with_users, -> { joins(:users).where("users.organization_id IS NOT NULL").group("organizations.id") }

  validates :name, presence: true
  validates :legal_status_id, inclusion: {
    in: LegalStatus.all.map(&:id),
    message: 'Please choose from the list above'
  }

  def quality_elements
    @qe ||= community_programs.map{|cp| cp.quality_element}.flatten.uniq
  end

  def service_types
    @st ||= community_programs.map{|cp| cp.service_types}.flatten.uniq
  end

  def self.needs_verification_path(organization)
    Rails.application.routes.url_helpers.verification_organization_path(organization)
  end

  def verification_required?
    last_verified_at.nil?
  end

  def any_unverified_programs?
    unverified_program_count > 0
  end

  def unverified_program_count
    sum = 0
    community_programs.each do |cp|
      sum += (cp.verification_required? ? 1 : 0)
    end
    sum
  end

  def reported_program_count
    reported_school_programs.sum{|k,v| v}
  end

  def reported_program_discrepency
    reported_program_count - community_programs.count
  end

  def reported_program_discrepency?
    reported_program_discrepency > 0
  end

  def show_verification_modal?(current_user)
    current_user.role?(:organization_member) &&
      (any_unverified_programs? || reported_program_discrepency?)
  end

  def reported_school_programs
    read_attribute(:reported_school_programs) ? read_attribute(:reported_school_programs) : []
  end

  def inactive_community_programs
    community_programs.unscoped.where(organization_id: self.id, active: false).includes(:school)
  end

  private
  def clear_associated_cache
    schools.each{|s| s.touch}
    community_programs.each{|cp| cp.touch}
  end
end
