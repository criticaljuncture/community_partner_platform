class PublicPolicy::Base
  attr_reader :model
  cattr_reader :policy_model

  def self.policy_for(type)
    @@policy_model = type.to_s
  end

  def initialize(model)
    @model = model
  end

  def can_be_made_public?
    !model.approved_for_public? &&
      eligible_to_be_made_public?
  end

  def eligible_to_be_made_public?
    required_attributes_present? &&
      minimally_complete? &&
        !verification_required?
  end

  def required_attributes_present?
    required_attributes.all? do |attr|
      model.send(attr).present?
    end
  end

  def minimally_complete?
     completion_percentage >= minimum_completion_percentage
  end

  def verification_required?
    policy_config.verification_required && model.verification_required?
  end

  def required_attributes
    policy_config.required_attributes
  end

  def minimum_completion_percentage
    policy_config.percentage_complete
  end

  def public_attributes
    policy_config.public_attributes
  end

  def public_attribute?(attribute)
    public_attributes.include?(attribute)
  end

  def missing_requirements
    missing_requirements = []

    unless required_attributes_present?
      missing_requirements << I18n.t(
        'public_policy.missing_requirements.required_attributes'
      )
    end

    unless minimally_complete?
      missing_requirements << I18n.t(
        'public_policy.missing_requirements.minimally_complete',
        percentage: minimum_completion_percentage * 100
      )
    end

    if verification_required?
      missing_requirements << I18n.t(
        'public_policy.missing_requirements.verification_required',
        date: verification_date - 1.day
      )
    end

    missing_requirements
  end

  # TODO: BB move to verification policy
  def in_grace_period?
    in_verification_period? &&
       grace_period_end_date >= Date.current
  end

  # TODO: BB move to verification policy
  def in_verification_period?
     verification_date <= Date.current
  end

  # TODO: BB move to verification policy
  def grace_period_end_date
    Date.parse(verification_config.grace_period_end_date)
  end

  # TODO: BB move to verification policy
  def verification_date
    Date.parse(verification_config.verification_date)
  end

  private

  def policy_config
    @policy_config ||= Settings.app_config.send(self.class.policy_model).public_policy
  end

  # TODO: BB move to verification policy
  def verification_config
    @verification_config ||= Settings.app_config.send(self.class.policy_model).verification_policy
  end

  def completion_percentage
    model.completion_rate.to_f / 100
  end
end
