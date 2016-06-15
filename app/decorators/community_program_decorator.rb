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

  def schools_with_differing_completion_rates
    @schls ||= school_programs.select do |school_program|
      program_completion_rate != school_program.program_completion_rate
    end.sort_by{|s| s.school.name}
  end

  def school_program_summary
    #TODO: Someday consider refactoring #school_program_summary and #school_summary together.
    h.content_tag(:ul, class: 'no-bullets') do
      schools_with_differing_completion_rates.to_a[0..1].each do |school_program|
        h.concat h.content_tag(
          :li,
          "#{school_program.school.name} (#{school_program.program_completion_rate})"
        )
      end

      if schools_with_differing_completion_rates.count > 2
        schools_with_differing_completion_rates[2..-1].each do |school_program|
          h.concat h.content_tag(:li, "#{school_program.school.name} (#{school_program.program_completion_rate})", class: 'hidden overflow')
        end

        h.concat(
          h.content_tag(:li, class: 'toggler') do
            h.concat h.content_tag(:a, "view #{h.pluralize schools_with_differing_completion_rates.count-2, 'other'}")
          end
        )
      end
    end
  end

  def school_summary
    schls = schools.sort_by(&:name)

    h.content_tag(:ul, class: 'no-bullets') do
      schls.to_a[0..1].each do |school|
        h.concat h.content_tag(:li, school.name)
      end

      if schls.count > 2
        schls[2..-1].each do |school|
          h.concat h.content_tag(:li, school.name, class: 'hidden overflow')
        end

        h.concat(
          h.content_tag(:li, class: 'toggler') do
            h.concat h.content_tag(:a, "view #{h.pluralize schools.count-2, 'other'}")
          end
        )
      end
    end
  end

  def verification_header
    "#{should_verify?(h.current_user) ? 'Verify' : 'Edit'} #{name}"
  end


  def summary_for_select
    "#{name} (#{h.pluralize(schools.count, 'school')}), id: #{id}"
  end
end
