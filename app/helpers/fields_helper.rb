module FieldsHelper
  def render_field?(model, field)
    if model.is_a?(Symbol)
      model = model
    else
      case model.class.name.underscore.to_sym
      when :event, :event_decorator
        model = :event
      when :community_program, :community_program_decorator
        model = :community_program
      when :organization, :organization_decorator
        model = :organization
      end
    end

    # properly handle rendering question mark ('eh') methods/fields
    field = field.to_s.gsub('?', '').to_sym

    ! Settings.app_config[model].fields.fields_to_skip.include?(field.to_sym)
  end

  def boolean_yes_no(val)
    val.is_a?(TrueClass) ? I18n.t("app.yes") : I18n.t("app.no")
  end
end
