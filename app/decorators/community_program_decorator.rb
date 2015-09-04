class CommunityProgramDecorator < Draper::Decorator
  delegate_all

  def verification_header
    "#{should_verify?(h.current_user) ? 'Verify' : 'Edit'} #{name}"
  end

  def school_summary
    str = schools[0..2].map(&:name).join(', ')

    if schools.count > 2
      str += " (and #{h.pluralize schools.count-2, 'other'})"
    end

    str
  end

  def display
    @display ||= AttributeDisplay.new(self)
  end

  class AttributeDisplay < ApplicationAttributeDisplay
    def demographic_groups
      d.demographic_groups.present? ?
        d.demographic_groups.map(&:name).join(', ') :
        d.h.not_provided

    end

    def student_population
      d.student_population.try(:name) || d.h.not_provided
    end
  end
end
