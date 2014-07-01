class Day < ActiveRecord::Base
  has_many :community_program_service_days
  has_many :community_programs, through: :community_program_service_days

  def self.for_completeness
    where("id != 8")
  end
end
