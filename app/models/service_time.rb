class ServiceTime < ActiveRecord::Base
  has_many :community_program_service_times
  has_many :community_programs, through: :community_program_service_times

  def self.for_completeness
    where("id != 8")
  end
end
