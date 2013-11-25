class School < ActiveRecord::Base
  include SchoolAudit

  after_create :clear_associated_cache
  after_update :clear_associated_cache
  after_touch  :clear_associated_cache

  has_many :community_partners
  has_many :organizations, through: :community_partners

  has_many :free_reduced_meal_data, class_name: FreeReducedMealData

  has_many :user_schools
  has_many :users, through: :user_schools

  belongs_to :region

  default_scope -> { where(direct_funded_charter_school: false) }

  def cached_community_partners
    Rails.cache.fetch([self, "cached_community_partners"]) do
      community_partners
    end
  end

  def cached_community_partner_count
    Rails.cache.fetch([self, "cached_community_partner_count"]) do
      cached_community_partners.count
    end
  end

  def cached_organizations
    Rails.cache.fetch([self, "cached_organizations"]) do
      organizations
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

  def student_populations_with_partnerships
    Rails.cache.fetch([self, "student_populations_with_partnerships"]) do
      cached_community_partners.map{|cp| cp.student_population}.compact.uniq
    end
  end

  def ethnicity_culture_groups_with_partnerships
    Rails.cache.fetch([self, "ethnicity_culture_groups_with_partnerships"]) do
      cached_community_partners.map{|cp| cp.ethnicity_culture_groups}.flatten.compact.uniq
    end
  end

  def demographic_groups_with_partnerships
    Rails.cache.fetch([self, "demographic_groups_with_partnerships"]) do
      cached_community_partners.map{|cp| cp.demographic_groups}.flatten.compact.uniq
    end
  end

  def service_days_with_partnerships
    Rails.cache.fetch([self, "service_days_with_partnerships"]) do
      cached_community_partners.map{|cp| cp.days}.flatten.compact.uniq
    end
  end

  def service_times_with_partnerships
    Rails.cache.fetch([self, "service_times_with_partnerships"]) do
      cached_community_partners.map{|cp| cp.service_times}.flatten.compact.uniq
    end
  end

  private
  def clear_associated_cache
    region.touch if region_id.present?
  end
end
