class ServiceTime < ActiveRecord::Base
  has_many :community_partnership_service_times
  has_many :community_partners, through: :community_partnership_service_times
end
