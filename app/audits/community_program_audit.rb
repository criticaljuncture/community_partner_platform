module CommunityProgramAudit
  extend ActiveSupport::Concern
  include Audit

  def associations_for_audit
    {
      primary_quality_element_id: primary_quality_element.id,
      primary_service_type_ids: primary_service_type_ids,
      ethnicity_culture_group_ids: ethnicity_culture_groups.map(&:id),
      demographic_group_ids: demographic_groups.map(&:id),
      grade_level_ids: grade_levels.map(&:id),
      day_ids: days.map(&:id),
      service_time_ids: service_times.map(&:id),
    }.to_json
  end

  def update_association_versions
    school.update_version if school_id_changed?
    organization.update_version if organization_id_changed?

    user.update_version if user_id_changed?
  end
end
