class OrganizationDecorator < Draper::Decorator
  delegate_all

  include AttrNotProvided
  attr_not_provided :address,
    :total_cost,
    :mission_statement,
    :program_impact,
    :services_description

  attr_not_provided :legal_status, method: :name, association: true
  attr_not_provided :phone_number, method: ->(attr) {h.number_to_phone(attr)}

  def city_state_zip
    (city.present? && zip_code.present?) ?
      "#{city}, CA #{zip_code}" : h.hint_tag(h.t('app.not_provided'))
  end

  def show_verification_modal?
    h.can?(:verify, organization) && any_unverified_programs?
  end

  def verifiable?
    h.can?(:verify, organization) && verification_required?
  end

  def programs_verifiable?
    h.can?(:verify, organization) && any_unverified_programs?
  end

  def last_verified
    if last_verified_at.present?
      "#{last_verified_at} by #{verifier.try(:full_name)}"
    else
      h.hint_tag(h.t('app.not_provided'))
    end
  end

  def last_orientation_attended_tooltip
    if any_users_attended_orientation?
      user = user_last_orientation_attended
      "Last orientation attended on #{user.attended_orientation_at} by #{user.try(:full_name)}"
    else
      h.t('user.orientation_never_attended')
    end
  end

  def completion_rate_tooltip
    if completion_rate != 100
      fields = missing_fields.map do |f|
        h.t("simple_form.labels.organization.#{f.to_s}")
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
        data: {tooltip: 'This organization is publicly viewable'}
      )

      "#{name} #{icon}".html_safe
    else
      name
    end
  end
end
