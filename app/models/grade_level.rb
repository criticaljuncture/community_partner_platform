class GradeLevel < ActiveRecord::Base
  has_many :community_program_grade_levels
  has_many :grade_levels, through: :community_program_grade_levels
end
