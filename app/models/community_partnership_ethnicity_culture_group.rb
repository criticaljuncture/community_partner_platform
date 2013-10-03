class CommunityPartnershipEthnicityCultureGroup < ActiveRecord::Base
  belongs_to :community_partner
  belongs_to :ethnicity_culture_group
end
