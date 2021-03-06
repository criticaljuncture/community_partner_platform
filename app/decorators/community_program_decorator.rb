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
    elsif last_verified_at.present?
      last_verified_at
    else
      nil
    end
  end

  def verifiable?
    h.can?(:verify, community_program) && verification_required?
  end

  def verification_header
    txt =  verifiable? ? 'Verify' : 'Edit'

    "#{txt} #{name}"
  end

  def summary_for_select
    "#{name} (#{h.pluralize(schools.count, 'school')}), id: #{id}"
  end

  def completion_rate_tooltip
    if completion_rate != 100
      fields = missing_fields.map do |f|
        h.t("simple_form.labels.community_program.#{f.to_s}")
      end

      "Missing the following fields: <ul><li>#{fields.join('</li><li> ')}</li></ul>"
    else
      ""
    end
  end

  def page_header
    if approved_for_public?
      icon = h.content_tag(:span, '',
        class: 'icon-cpp icon-cpp-globe with-tooltip',
        data: {tooltip: 'This community program is publicly viewable'}
      )

      "#{name} #{icon}".html_safe
    else
      name
    end
  end
end
