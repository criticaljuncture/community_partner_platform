class CommunityPartnershipDemographicGroup < ActiveRecord::Base
  belongs_to :community_partner
  belongs_to :demographic_group
end
