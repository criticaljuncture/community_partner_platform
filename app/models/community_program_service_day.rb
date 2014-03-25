class CommunityProgramServiceDay < ActiveRecord::Base
  belongs_to :community_program
  belongs_to :day
end
