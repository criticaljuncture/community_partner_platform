class CommunityProgramEthnicityCultureGroup < ActiveRecord::Base
  belongs_to :community_program
  belongs_to :ethnicity_culture_group
end
