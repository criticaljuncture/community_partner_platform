class Region < ActiveRecord::Base
  has_many :schools
  has_many :community_programs, through: :schools

  def cached_community_program_count
    Rails.cache.fetch([self, "cached_community_program_count"]) do
      schools.map{|s| s.cached_community_program_count}.sum
    end
  end

  def cached_community_programs
    Rails.cache.fetch([self, "cached_community_programs"]) do
      community_programs
    end
  end

  def community_programs_by_quality_element
    Rails.cache.fetch([self, "community_programs_by_quality_element"]) do
      cached_community_programs.map{|cp| cp.primary_quality_element}.map{|pqe| pqe.quality_element}.group_by(&:id)
    end
  end
end
