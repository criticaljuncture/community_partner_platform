class UserDecorator < Draper::Decorator
  delegate_all

  def invitation_status
    h.invitation_status_for(model)
  end

  def last_login
    current_sign_in_at < 3.months.ago ?
      current_sign_in_at.to_s(:date_at_time_with_year) :
      current_sign_in_at.to_s(:date_at_time)
  end

  def phone_number
    model.phone_number.present? ?
      h.number_to_phone(model.phone_number) : h.not_provided
  end

  def title
    model.title || h.not_provided
  end

  def display
    @display ||= AttributeDisplay.new(self)
  end

  class AttributeDisplay < ApplicationAttributeDisplay
    def role(role)
      capture do
        concat(
          content_tag(:tr) do
            concat content_tag(:td, t('user.role'))
            concat content_tag(:td, role.name)
          end
        )

        concat(
          case role.identifier.to_sym
          when :school_manager
            role_school_display(model.schools)
          when :organization_member
            role_organization_display(model.organization)
          end
        )
      end
    end

    private

    def role_school_display(schools)
      content_tag(:tr) do
        concat content_tag(:td, t('school.class.name'))
        concat content_tag(
          :td,
          schools.map{|s| h.link_to(s.name, h.school_path(s)) }.join(', ').html_safe
        )
      end
    end

    def role_organization_display(org)
      content_tag(:tr) do
        concat content_tag(:td, t('organization.class.name'))
        concat content_tag(
          :td,
          h.link_to(org.name, h.organization_path(org))
        )
      end
    end
  end
end
