class Day < ActiveRecord::Base
  has_many :community_partnership_service_days
  has_many :community_partnerships, through: :community_partnership_service_days
end
