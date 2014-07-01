class SchoolQualityIndicatorSubArea < ActiveRecord::Base
  has_many :community_programs
  has_many :schools, through: :community_programs
  has_many :organizations, through: :community_programs
end

