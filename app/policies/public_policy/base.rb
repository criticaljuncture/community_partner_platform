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

    missing_requirements
  end

  private

  def policy_config
    @policy_config ||= Settings.app_config.send(self.class.policy_model).public_policy
  end

  def completion_percentage
    model.completion_rate.to_f / 100
  end
end
