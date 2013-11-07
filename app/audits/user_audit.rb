module UserAudit
  extend ActiveSupport::Concern
  include Audit

  def associations_for_audit
    {
      role_ids: role_ids,
      school_ids: school_ids,
      community_partnerships_as_organization_contact_ids: community_partnerships_as_organization_contact_ids,
      community_partnerships_as_school_contact_ids: community_partnerships_as_school_contact_ids,
    }.to_json
  end

  def update_association_versions
    organization.update_version if organization_id && organization.changed?
  end
end
