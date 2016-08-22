module ApplicationHelper
  def icon_link_to(name, path, options={})
    dropdown = options.delete(:dropdown)

    link = content_tag(:span, "", class:"icon #{options.delete(:icon_class)}") +
            content_tag(:span, name, class: "nav-label #{options.delete(:nav_label_class)}")

    link = link + content_tag(:span, "", class: "caret") if dropdown

    link_to(link.html_safe, path, options)
  end

  def join_with_br(items, method=nil, joiner=",")
    if method
      items.map{|i| i.send(method)}.join("#{joiner} <br />").html_safe
    else
      items.join("#{joiner} <br />").html_safe
    end
  end

  def page_header(title, icon, options={}, &block)
    wrapper_class = options.fetch(:wrapper_class){ '' }

    buttons = block_given? ? capture(&block) : ''

    render partial: 'components/page_header', locals: {
      buttons: buttons,
      icon: icon,
      title: title,
      wrapper_class: wrapper_class
    }
  end

  def not_provided
    content_tag(:span, 'not provided', class: 'hint')
  end
end
