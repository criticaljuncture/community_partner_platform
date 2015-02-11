class Region < ActiveRecord::Base
  has_many :schools
  has_many :community_programs, through: :schools

  def community_programs_by_quality_element
    community_programs.
      map{|cp| cp.primary_quality_element}.
      map{|pqe| pqe.quality_element}.
      group_by(&:id)
  end
end
