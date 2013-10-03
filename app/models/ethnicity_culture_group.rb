class EthnicityCultureGroup < ActiveRecord::Base
  has_many :community_partnership_ethnicity_groups
  has_many :community_partnerships, through: :community_partnership_ethnicity_groups
end
