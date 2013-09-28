class School < ActiveRecord::Base
  has_many :community_partners
  has_many :organizations, through: :community_partners

  has_many :quality_elements, through: :community_partners
  has_many :service_types, through: :community_partners

  has_many :free_reduced_meal_data, class_name: FreeReducedMealData

  has_many :user_schools
  has_many :users, through: :user_schools

  belongs_to :region
end
