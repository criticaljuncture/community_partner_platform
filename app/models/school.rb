class School < ActiveRecord::Base
  include SchoolAudit

  has_many :community_partners
  has_many :organizations, through: :community_partners

  has_many :free_reduced_meal_data, class_name: FreeReducedMealData

  has_many :user_schools
  has_many :users, through: :user_schools

  belongs_to :region

  default_scope -> { where(direct_funded_charter_school: false) }

  def quality_elements
    community_partners.map{|cp| cp.quality_elements}.flatten.uniq
  end

  def service_types
    community_partners.map{|cp| cp.service_types}.flatten.uniq
  end
end
