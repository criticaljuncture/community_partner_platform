class PublicPolicy::CommunityProgramPolicy < PublicPolicy::Base
  policy_for :community_program

    def eligible_to_be_made_public?
      eligible = required_attributes_present? &&
        minimally_complete? &&
          !verification_required?


      if User.current && User.current.can?(:make_public, Organization)
        eligible && model.organization.approved_for_public?
      else
        eligible
      end
    end

    def missing_requirements
      missing_requirements = super

      if User.current && User.current.can?(:make_public, Organization)
        unless model.organization.approved_for_public?
          missing_requirements << I18n.t(
            'public_policy.missing_requirements.organization_not_public'
          )
        end
      end

      missing_requirements
    end
end
