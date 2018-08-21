class PublicPolicy::CommunityProgramPolicy < PublicPolicy::Base
  policy_for :community_program

  def eligible_to_be_made_public?(org_check: true)
    eligible = required_attributes_present? &&
      minimally_complete? &&
        !verification_required?

    if org_check && User.current && User.current.can?(:make_public, Organization)
      eligible && model.organization.approved_for_public?
    else
      eligible
    end
  end

  def missing_requirements(org_check: true)
    missing_requirements = super

    if org_check && User.current && User.current.can?(:make_public, Organization)
      unless model.organization.approved_for_public?
        missing_requirements << I18n.t(
          'public_policy.missing_requirements.organization_not_public'
        )
      end
    end

    missing_requirements
  end

  def eligible_to_be_made_public_notice
    return nil unless eligible_to_be_made_public?

    I18n.t("#{self.class.policy_model}.public_policy.messages.eligible_to_be_made_public",
      url: "/admin/public_authorizations/#{model.organization.id}"
    )
  end
end
