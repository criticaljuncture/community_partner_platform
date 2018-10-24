class School < ApplicationRecord
  include SchoolAudit

  has_many :school_programs
  has_many :community_programs, through: :school_programs
  has_many :organizations, through: :community_programs

  has_many :free_reduced_meal_data, class_name: 'FreeReducedMealData'

  has_many :user_schools
  has_many :users, through: :user_schools

  belongs_to_active_hash :region

  default_scope -> { where(active: true) }


  def ethnicity_culture_groups_with_programs
    community_programs.map{|cp| cp.ethnicity_culture_groups}.flatten.compact.uniq
  end

  def demographic_groups_with_programs
    community_programs.map{|cp| cp.demographic_groups}.flatten.compact.uniq
  end

  def service_days_with_programs
    community_programs.map{|cp| cp.days}.flatten.compact.uniq
  end

  def service_times_with_programs
    community_programs.map{|cp| cp.service_times}.flatten.compact.uniq
  end

  def service_types
    community_programs.map{|cp| cp.service_types}.flatten.uniq
  end

  def student_populations_with_programs
    community_programs.map{|cp| cp.student_population}.compact.uniq
  end

  def quality_elements
    community_programs.map{|cp| cp.quality_element}.flatten.uniq
  end
end
