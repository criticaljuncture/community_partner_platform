module DefaultDisplayHelper
  def default_value_for(model, attr)
    value = model.send(attr)

    if value.is_a?(String) && value != ''
      if attr == :url
        link_to value, value, target: :_blank
      else
        value
      end
    elsif value.is_a?(TrueClass)
      I18n.t("app.yes")
    elsif value.is_a?(FalseClass)
      I18n.t("app.no")
    elsif value && value.respond_to?(:to_a)
      value
        .map{|v| v.respond_to?(:default_display) ? v.default_display : v}
        .join(', ')
    elsif value.respond_to?(:default_display)
      value.default_display
    elsif value.blank?
      "<span class='hint'>#{I18n.t("app.not_provided")}</span>".html_safe
    else
      value
    end
  end
end
