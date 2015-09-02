class SchoolProgram < ActiveRecord::Base
  include CommunityProgramAttributeRelationships
  include DelegationExtensions

  belongs_to :community_program

  belongs_to :school_user,
    class_name: User,
    foreign_key: :school_user_id

    validates :school_id,
      presence: {
        message: "must choose a school"
      }
  delegate_if_blank :days,
    :demographic_groups,
    :ethnicity_culture_groups,
    :grade_levels,
    :service_times,
    :student_population,
    to: :community_program
end
