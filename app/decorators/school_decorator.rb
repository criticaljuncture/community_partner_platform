class SchoolDecorator < Draper::Decorator
  delegate_all

  def human_site_type
    case model.site_type_norm
    when '6-12', 'K-8'
      "Grades #{model.site_type_norm}"
    when 'Senior'
      'High Schools'
    when 'CDC'
      'Childhood Development Centers'
    when nil
      nil
    else
      if model.site_type_norm.match(/School\Z/)
        model.site_type_norm.pluralize
      else
        "#{model.site_type_norm} Schools"
      end
    end
  end
end
