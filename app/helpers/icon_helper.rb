module IconHelper
  def gicon(name, options={})
    content_tag(:span, '',
      class: "icon glyphicon glyphicon-#{name}",
      "aria-hidden" => options.fetch(:aria_hidden){ true })
  end

  def link_to_gicon(text, url, options = {})
    icon_class = options.delete(:icon)

    raise ":icon required for link_to_icon" unless icon_class

    link_to(url, options) do
      "#{gicon(icon_class)} #{text}".html_safe
    end
  end
end
