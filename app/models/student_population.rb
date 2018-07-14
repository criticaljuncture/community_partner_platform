class StudentPopulation < ApplicationRecord
  has_many :community_programs

  def self.for_completeness
    where("id != 1")
  end
end
