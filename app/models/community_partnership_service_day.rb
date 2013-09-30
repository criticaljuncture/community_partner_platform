class CommunityPartnershipServiceDay < ActiveRecord::Base
  belongs_to :community_partner
  belongs_to :day
end
