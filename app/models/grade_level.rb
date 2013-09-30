class GradeLevel < ActiveRecord::Base
  has_many :community_partnership_grade_levels
  has_many :grade_levels, through: :community_partnership_grade_levels
end
