class SchoolQualityIndicatorSubArea < ActiveRecord::Base
  has_many :community_partners
  has_many :schools, through: :community_partners
  has_many :organizations, through: :community_partners
end

