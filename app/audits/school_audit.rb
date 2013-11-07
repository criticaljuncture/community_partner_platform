module SchoolAudit
  extend ActiveSupport::Concern
  include Audit

  def associations_for_audit
    {
      community_partner_ids: community_partner_ids,
      organization_ids: organization_ids,
      user_ids: user_ids,
    }.to_json
  end
end
