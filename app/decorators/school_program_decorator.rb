class SchoolProgramDecorator < Draper::Decorator
  delegate_all

  def extract_customized_attributes
    attrs = {}

    model.customized_attributes.each do |attribute|
      name = extract_name(attribute)
      objects = model.send(attribute)
      values = Array(objects).map{|o| o.name }

      attrs[name] = values.join(', ')
    end

    attrs
  end

  def extract_name(attribute)
    I18n.t("community_programs.#{attribute.to_s.gsub('community_program_', '')}")
  end
end
