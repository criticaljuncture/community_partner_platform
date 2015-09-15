class CommunityProgramDecorator < Draper::Decorator
  delegate_all

  include AttrNotProvided
  attr_not_provided :service_description

  attr_not_provided :days,
    :demographic_groups,
    :ethnicity_culture_groups,
    :grade_levels,
    :service_times,
    :service_types,
    :student_population,
    method: :name, association: true

  def last_verified
    if last_verified_at.present?
      "#{last_verified_at} by #{verifier.try(:full_name)}"
    else
      h.not_provided
    end
  end

  def school_summary
    str = schools[0..2].map(&:name).join(', ')

    if schools.count > 2
      str += " (and #{h.pluralize schools.count-2, 'other'})"
    end

    str
  end

  def verification_header
    "#{should_verify?(h.current_user) ? 'Verify' : 'Edit'} #{name}"
  end
end
