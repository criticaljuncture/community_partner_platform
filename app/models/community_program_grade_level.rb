class CommunityProgramGradeLevel < ApplicationRecord
  belongs_to :attributable, polymorphic: true
  belongs_to :grade_level

  delegate :name, to: :grade_level
end
