class CommunityProgramQualityElementServiceType < ActiveRecord::Base
  belongs_to :community_program_quality_element
  belongs_to :service_type
end
