class Organization < ActiveRecord::Base
  include OrganizationAudit

  serialize :reported_school_programs, JSON

  after_create :clear_associated_cache
  after_update :clear_associated_cache

  has_many :community_programs
  has_many :schools, through: :community_programs
  has_many :users

  scope :with_users, -> { joins(:users).where("users.organization_id IS NOT NULL").group("organizations.id") }

  def cached_community_programs
    Rails.cache.fetch([self, "cached_community_programs"]) do
      community_programs.includes(:school)
    end
  end

  def cached_schools
    Rails.cache.fetch([self, "cached_schools"]) do
      community_programs.map(&:school).uniq
    end
  end

  def cached_user_count
    Rails.cache.fetch([self, "cached_users"]) do
      users.count
    end
  end

  def quality_elements
    Rails.cache.fetch([self, "quality_elements"]) do
      cached_community_programs.map{|cp| cp.quality_elements}.flatten.uniq
    end
  end

  def service_types
    Rails.cache.fetch([self, "service_types"]) do
      cached_community_programs.map{|cp| cp.service_types}.flatten.uniq
    end
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
    cached_community_programs.sum{|cp| cp.verification_required? ? 1 : 0}
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

  private
  def clear_associated_cache
    schools.each{|s| s.touch}
    community_programs.each{|cp| cp.touch}
  end
end
