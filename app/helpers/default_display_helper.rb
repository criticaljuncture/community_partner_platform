module DefaultDisplayHelper
  def default_value_for(model, attr, options: {})
    value = model.send(attr)

    if value.is_a?(String) && value != ''
      if attr == :url
        link_to value, value, target: "_blank"
      elsif options[:simple_format]
        auto_link(simple_format(value), link: :urls, html: {target: "_blank"})
      else
        value
      end
    elsif value.is_a?(TrueClass)
      I18n.t("app.yes")
    elsif value.is_a?(FalseClass)
      I18n.t("app.no")
    elsif value.is_a?(Date) || value.is_a?(DateTime) || value.is_a?(ActiveSupport::TimeWithZone)
      format = no_time?(attr, model) ? "%m/%d/%Y" : "%m/%d/%Y at %H:%M %p"
      value.in_time_zone.strftime(format)
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

  private

  def no_time?(attr, model)
    (attr == :start_date && model.send(:start_time).nil?) ||
      (attr == :end_date && model.send(:end_time).nil?)
  end
end
