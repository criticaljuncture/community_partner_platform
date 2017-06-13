class SchoolDecorator < Draper::Decorator
  delegate_all

  def human_site_type
    case model.site_type_norm
    when '6-12', 'K-8'
      "Grades #{model.site_type_norm}"
    when 'Senior'
      'High Schools'
    when nil
      nil
    else
      "#{model.site_type_norm} Schools"
    end
  end
end
