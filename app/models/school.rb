class School < ActiveRecord::Base
  has_many :community_partners
  has_many :organizations, through: :community_partners

  has_many :school_quality_indicator_sub_areas, through: :community_partners

  has_many :free_reduced_meal_data, class_name: FreeReducedMealData

  belongs_to :region
end
