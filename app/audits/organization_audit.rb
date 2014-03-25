module OrganizationAudit
  extend ActiveSupport::Concern
  include Audit

  def associations_for_audit
    {
      community_program_ids: community_program_ids,
      user_ids: user_ids,
    }.to_json
  end
end
