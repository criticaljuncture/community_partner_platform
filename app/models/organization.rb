class Organization < ActiveRecord::Base
  include OrganizationAudit

  after_create :clear_associated_cache
  after_update :clear_associated_cache

  has_many :community_partners
  has_many :schools, through: :community_partners
  has_many :users

  scope :with_users, -> { joins(:users).where("users.organization_id IS NOT NULL").group("organizations.id") }

  def cached_community_partners
    Rails.cache.fetch([self, "cached_community_partners"]) do
      community_partners.includes(:school)
    end
  end

  def cached_schools
    Rails.cache.fetch([self, "cached_schools"]) do
      community_partners.map(&:school).uniq
    end
  end

  def cached_user_count
    Rails.cache.fetch([self, "cached_users"]) do
      users.count
    end
  end

  def quality_elements
    Rails.cache.fetch([self, "quality_elements"]) do
      cached_community_partners.map{|cp| cp.quality_elements}.flatten.uniq
    end
  end

  def service_types
    Rails.cache.fetch([self, "service_types"]) do
      cached_community_partners.map{|cp| cp.service_types}.flatten.uniq
    end
  end

  private
  def clear_associated_cache
    schools.each{|s| s.touch}
    community_partners.each{|cp| cp.touch}
  end
end
