class PublicPolicy::OrganizationPolicy < PublicPolicy::Base
  policy_for :organization

  include PublicPolicyHelper

  def public_criteria_notice
    return nil if eligible_to_be_made_public?

    I18n.t('organization.messages.public_criteria_not_met',
      missing_requirements: missing_requirements_list(missing_requirements))
  end

  def expiration_notice
    return nil unless in_grace_period?
    return nil unless model.approved_for_public? && !eligible_to_be_made_public?

    I18n.t('organization.messages.expiration_pending',
      date: grace_period_end_date)
  end
end
