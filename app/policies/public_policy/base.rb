class PublicPolicy::Base
  attr_reader :model
  cattr_reader :policy_model

  delegate :approved_for_public?,
    :approved_for_public_by,
    :approved_for_public_on,
    to: :model

  def self.policy_for(type)
    @@policy_model = type.to_s
  end

  def initialize(model)
    @model = model
  end

  def can_be_made_public?
    !model.approved_for_public? &&
      required_attributes_present? &&
      minimally_complete?
  end

  def required_attributes_present?
    required_attributes.all? do |attr|
      model.send(attr).present?
    end
  end

  def minimally_complete?
    model.completion_rate >= minumum_completion_percentage
  end

  def required_attributes
    policy_config.required_attributes
  end

  def minumum_completion_percentage
    policy_config.percentage_complete
  end

  private

  def policy_config
    Settings.app_config.send(self.class.policy_model).public_policy
  end
end
