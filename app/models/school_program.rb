class SchoolProgram < ActiveRecord::Base
  include CommunityProgramAttributeRelationships
  include DelegationExtensions

  before_save :update_completion_rate

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
           to: :community_program

  delegate_if_blank :days,
    :demographic_groups,
    :ethnicity_culture_groups,
    :grade_levels,
    :service_times,
    :student_population,
    to: :community_program

  validates :school_id,
    presence: {
      message: "must choose a school"
    }

  validates :community_program_id,
    presence: {
      message: "must choose a community_program"
    }

  COMPLETION_WEIGHTS = CommunityProgram::COMPLETION_WEIGHTS

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

  def update_completion_rate
    self.completion_rate = completion_rate_calculator.completion_rate
  end
  end

  private

  def completion_rate_calculator
    @completion_rate_calculator ||= CompletionRateCalculator.new(
      self,
      COMPLETION_WEIGHTS
    )
  end

  # this is a stub method to allow us to calculate the school program
  # completion_rate the same way as it's parent community_program
  def school_programs
    community_program.school_programs
  end
end
