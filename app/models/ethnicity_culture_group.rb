class EthnicityCultureGroup < ApplicationRecord
  has_many :community_program_ethnicity_groups
  has_many :community_programs, through: :community_program_ethnicity_groups

  def self.for_completeness
    all
  end
end
