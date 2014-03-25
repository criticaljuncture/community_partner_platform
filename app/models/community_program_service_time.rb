class CommunityProgramServiceTime < ActiveRecord::Base
  belongs_to :community_program
  belongs_to :service_time
end
