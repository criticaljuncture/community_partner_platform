class CommunityProgramDemographicGroup < ActiveRecord::Base
  belongs_to :community_program
  belongs_to :demographic_group
end
