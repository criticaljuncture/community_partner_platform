module IconHelper
  def gicon(name, options={})
    content_options = {
      class: "icon glyphicon glyphicon-#{name} #{options[:class_name]}",
      "aria-hidden" => options.fetch(:aria_hidden){ true }
    }

    if options[:data]
      content_options.merge!(data: options[:data])
    end

    content_tag(:span, '', content_options)
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

  def boolean_checkmark_gicon(bool, options={})
    data = options.fetch(:data, {})
    additional_class_name = 'cj-tooltip' if data[:tooltip]

    if bool
      gicon('ok', class_name: "positive #{additional_class_name}", data: data.merge(sort_value: true))
    else
      gicon('remove', class_name: "negative #{additional_class_name}", data: data.merge(sort_value: false))
    end
  end
end
