class CommunityPartnershipServiceTime < ActiveRecord::Base
  belongs_to :community_partner
  belongs_to :service_time
end
