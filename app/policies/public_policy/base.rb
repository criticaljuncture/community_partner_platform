class PublicPolicy::Base
  attr_reader :model
  class_attribute :policy_model

  include PublicPolicyHelper

  def self.policy_for(type)
    self.policy_model = type.to_s
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
    return true unless required_attributes

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

  def missing_requirements(options={})
    missing_requirements = []

    unless required_attributes_present?
      missing_requirements << I18n.t(
        'public_policy.missing_requirements.required_attributes',
        required_attributes: policy_config.required_attributes.map do |attr|
          "'#{attr.to_s.gsub('_',' ')}'"
        end.join(', ')
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

  def public_criteria_notice
    return nil if eligible_to_be_made_public?

    I18n.t("#{self.class.policy_model}.public_policy.messages.public_criteria_not_met",
      missing_requirements: missing_requirements_list(missing_requirements))
  end

  def expiration_notice
    return nil unless in_grace_period?
    return nil unless model.approved_for_public? && !eligible_to_be_made_public?

    I18n.t("#{self.class.policy_model}.public_policy.messages.expiration_pending",
      date: grace_period_end_date)
  end

  def eligible_to_be_made_public_notice
    return nil unless eligible_to_be_made_public?

    I18n.t("#{self.class.policy_model}.public_policy.messages.eligible_to_be_made_public",
      url: "/admin/public_authorizations/#{model.id}"
    )
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
