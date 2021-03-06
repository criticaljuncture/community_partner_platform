class SchoolProgram < ApplicationRecord
  include ApplicationConfig::Validations

  include CommunityProgramAttributeRelationships
  include DelegationExtensions

  before_save CompletionPolicy::SchoolProgramPolicy
  serialize :missing_fields, JSON

  belongs_to :community_program
  belongs_to :school
  belongs_to :student_population
  belongs_to :user

  has_one :organization, through: :community_program

  default_scope -> {where(active: true)}

  delegate :name,
           :organization,
           :service_description,
           :service_types,
           :quality_element,
           :programmatic?,
           :foundational?,
           :approved_for_public?,
           to: :community_program

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

  # this makes it possible for a school_program to revert back to it's parent
  # program's values at any point
  def remove_associations_no_longer_delegating(school_program_params)
    delegated_if_blank_methods.each do |method|
      param = if ["student_population"].include?(method.to_s)
        "student_population_id"
      else
        (method.slice(0...-1) + '_ids')
      end

      unless school_program_params.keys.include?(param)
        self.send("#{param}=", nil)
      end

      self.save
    end
  end

  def completion_policy
    @completion_policy ||= CompletionPolicy::SchoolProgramPolicy.new(self)
  end

  private

  # this is a stub method to allow us to calculate the school program
  # completion_rate the same way as it's parent community_program
  def school_programs
    community_program.school_programs
  end
end
