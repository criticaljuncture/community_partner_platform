class CommunityPartner < ActiveRecord::Base
  belongs_to :region
  belongs_to :school
  belongs_to :organization
  belongs_to :school_quality_indicator_sub_area
  belongs_to :service_type
end
