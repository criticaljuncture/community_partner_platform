class CommunityPartnerQualityElementServiceType < ActiveRecord::Base
  belongs_to :community_partner_quality_element
  belongs_to :service_type
end
