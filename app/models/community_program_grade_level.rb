class CommunityProgramGradeLevel < ActiveRecord::Base
  belongs_to :grade_level
  belongs_to :community_program
end
