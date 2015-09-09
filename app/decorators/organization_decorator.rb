class OrganizationDecorator < Draper::Decorator
  delegate_all

  include AttrNotProvided
  attr_not_provided :address,
    :cost_per_student,
    :mission_statement,
    :program_impact,
    :services_description

  attr_not_provided :legal_status, method: :name, association: true
  attr_not_provided :phone_number, method: ->(attr) {h.number_to_phone(attr)}

  def city_state_zip
    (city.present? && zip_code.present?) ?
      "#{city}, CA #{zip_code}" : h.not_provided
  end
end
