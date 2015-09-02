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
  # attributes uniquely assigned to this school program as distinct from
  # parent community program
  def customized_attributes
    return @customized_attributes if @customized_attributes

    @customized_attributes = []
    delegated_if_blank_methods.each do |method|
      @customized_attributes << method unless delegating?(method)
    end

    @customized_attributes
  end
end
