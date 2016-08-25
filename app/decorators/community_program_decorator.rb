class CommunityProgramDecorator < Draper::Decorator
  delegate_all

  include AttrNotProvided
  attr_not_provided :service_description

  attr_not_provided :days,
    :demographic_groups,
    :ethnicity_culture_groups,
    :grade_levels,
    :primary_service_types,
    :service_times,
    :student_population,
    method: :name, association: true

  def last_verified
    if last_verified_at.present? && verifier.present?
      "#{last_verified_at} by #{verifier.try(:full_name)}"
    else
      nil
    end
  end

  def verification_header
    "#{should_verify?(h.current_user) ? 'Verify' : 'Edit'} #{name}"
  end

  def summary_for_select
    "#{name} (#{h.pluralize(schools.count, 'school')}), id: #{id}"
  end
end
