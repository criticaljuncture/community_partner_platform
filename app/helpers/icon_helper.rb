module IconHelper
  def gicon(name, options={})
    content_tag(:span, '',
      class: "icon glyphicon glyphicon-#{name}",
      "aria-hidden" => options.fetch(:aria_hidden){ true })
  end

  def link_to_gicon(text, url, options = {})
    icon_class = options.delete(:icon)
    raise ":icon required for link_to_icon" unless icon_class

    # support multiple icons - usually the user will set one of them to
    # hidden for something like a toggle action
    icon_classes = icon_class.split(' ')

    wrapper_span = options.fetch(:wrapper_span) { false }
    text = wrapper_span ?
      "<span class='text' id='#{wrapper_span[:id]}'>#{text}</span>" : text

    link_to(url, options) do
      "#{icon_classes.map{|i| gicon(i)}.join(' ')} #{text}".html_safe
    end
  end
end
