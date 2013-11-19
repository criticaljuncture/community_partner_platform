class Day < ActiveRecord::Base
  has_many :community_partnership_service_days
  has_many :community_partnerships, through: :community_partnership_service_days

  def self.for_completeness
    where("id != 8")
  end
end
