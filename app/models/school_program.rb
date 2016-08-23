class SchoolProgram < ActiveRecord::Base
  include CommunityProgramAttributeRelationships
  include DelegationExtensions

  after_save :update_completion_rate

  belongs_to :community_program
  belongs_to :school
  belongs_to :student_population
  belongs_to :user

  has_one :organization, through: :community_program

  default_scope -> {where(active: true)}

  delegate :name,
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

  COMPLETION_WEIGHTS = [
    [
      0.3,
      [:name, :service_description, :quality_element,
       :service_types, :organization, :user]
    ],
    [
      0.35,
      [:student_population, :ethnicity_culture_groups, :demographic_groups,
       :grade_levels, :service_times, :days]
    ],
    [
      0.35,
      [:community_program]
    ]
  ]

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
    update_column(
      :completion_rate, CompletionRateCalculator.new(
        self,
        COMPLETION_WEIGHTS
      ).completion_rate
    )
  end
end
