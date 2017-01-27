module CommunityProgramAttributeRelationships
  extend ActiveSupport::Concern

  included do
    belongs_to :student_population

    has_many :community_program_ethnicity_culture_groups,
      as: :attributable,
      dependent: :destroy
    has_many :ethnicity_culture_groups, through: :community_program_ethnicity_culture_groups

    has_many :community_program_demographic_groups,
      as: :attributable,
      dependent: :destroy
    has_many :demographic_groups, through: :community_program_demographic_groups

    has_many :community_program_grade_levels,
      as: :attributable,
      dependent: :destroy
    has_many :grade_levels, through: :community_program_grade_levels

    has_many :community_program_service_days,
      as: :attributable,
      dependent: :destroy
    has_many :days, through: :community_program_service_days

    has_many :community_program_service_times,
      as: :attributable,
      dependent: :destroy
    has_many :service_times, through: :community_program_service_times,
      dependent: :destroy
  end

  def inheritable_attributes
    [
      :community_program_demographic_groups,
      :community_program_ethnicity_culture_groups,
      :community_program_grade_levels,
      :community_program_service_days,
      :community_program_service_times,
      :student_population,
    ]
  end
end
