class StudentPopulation < ActiveRecord::Base
  has_many :community_partnerships

  def self.for_completeness
    where("id != 1")
  end
end
