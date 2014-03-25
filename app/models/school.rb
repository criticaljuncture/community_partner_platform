class School < ActiveRecord::Base
  include SchoolAudit

  after_create :clear_associated_cache
  after_update :clear_associated_cache
  after_touch  :clear_associated_cache

  has_many :community_programs
  has_many :organizations, through: :community_programs

  has_many :free_reduced_meal_data, class_name: FreeReducedMealData

  has_many :user_schools
  has_many :users, through: :user_schools

  belongs_to :region

  default_scope -> { where(direct_funded_charter_school: false).where(active: true) }

  def cached_community_programs
    Rails.cache.fetch([self, "cached_community_programs"]) do
      community_programs
    end
  end

  def cached_community_program_count
    Rails.cache.fetch([self, "cached_community_program_count"]) do
      cached_community_programs.count
    end
  end

  def cached_organizations
    Rails.cache.fetch([self, "cached_organizations"]) do
      organizations
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

  def student_populations_with_programs
    Rails.cache.fetch([self, "student_populations_with_programs"]) do
      cached_community_programs.map{|cp| cp.student_population}.compact.uniq
    end
  end

  def ethnicity_culture_groups_with_programs
    Rails.cache.fetch([self, "ethnicity_culture_groups_with_programs"]) do
      cached_community_programs.map{|cp| cp.ethnicity_culture_groups}.flatten.compact.uniq
    end
  end

  def demographic_groups_with_programs
    Rails.cache.fetch([self, "demographic_groups_with_programs"]) do
      cached_community_programs.map{|cp| cp.demographic_groups}.flatten.compact.uniq
    end
  end

  def service_days_with_programs
    Rails.cache.fetch([self, "service_days_with_programs"]) do
      cached_community_programs.map{|cp| cp.days}.flatten.compact.uniq
    end
  end

  def service_times_with_programs
    Rails.cache.fetch([self, "service_times_with_programs"]) do
      cached_community_programs.map{|cp| cp.service_times}.flatten.compact.uniq
    end
  end

  private
  def clear_associated_cache
    region.touch if region_id.present?
  end
end
