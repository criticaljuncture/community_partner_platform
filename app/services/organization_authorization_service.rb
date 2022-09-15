class OrganizationAuthorizationService
  attr_reader :organization

  def initialize(organization_or_id)
    @organization = organization_or_id.is_a?(Organization) ? organization_or_id : Organization.find(organization_or_id)
  end

  def make_public!(options={})
    organization.update!(
      approved_for_public: true,
      approved_for_public_on: DateTime.current,
      approved_for_public_by: User.current.id
    )

    if options[:include_eligible_programs] == "1"
      organization.eligible_programs.each do |community_program|
        CommunityProgramAuthorizationService.new(community_program).make_public!
      end
    end
  end

  def make_private!
    organization.update!(
      approved_for_public: false,
      approved_for_public_on: nil,
      approved_for_public_by: nil
    )

    organization.community_programs.each do |community_program|
      CommunityProgramAuthorizationService.new(community_program).make_private!
    end
  end
end
