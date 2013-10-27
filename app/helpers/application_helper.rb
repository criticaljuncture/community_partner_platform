module ApplicationHelper
  def page_specific_javascript(file_name)
    content_for :javascripts, javascript_include_tag(file_name)
  end

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

  def page_header(title, icon, &block)
    header = <<-HTML
      <div class="header">
        <div class="header_outer">
          <div class="header_inner">
            <h1>
              <span class="icon #{icon}"></span>
              #{title}
            </h1>
            #{capture(&block)}
          </div>
        </div>
      </div>
    HTML

    header.html_safe
  end
end
