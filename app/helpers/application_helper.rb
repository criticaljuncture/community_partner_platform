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

  def page_header(title, icon, &block)
    header = <<-HTML
      <div class="header">
        <div class="header_outer">
          <div class="header_inner">
            <h1>
              #{unless icon.blank?
                "<span class='icon #{icon}'icon></span>"
              end}
              #{title}
            </h1>
            #{capture(&block) if block_given?}
          </div>
        </div>
      </div>
    HTML

    header.html_safe
  end

  def message_box(type, content=nil, &block)
    message_box = <<-HTML
      <div class="#{type.to_s}">
        #{content ? content : capture(&block)}
      </div>
    HTML

    message_box.html_safe
  end

  def help_hover(options={}, &block)
    gravity   = options.fetch(:gravity) { 's' }
    classname = options.fetch(:classname) { 'help-hover-tooltip' }

    help_hover = <<-HTML
      <span class="help-hover icon-cpp-help"
        data-tooltip-content="#{capture(&block)}"
        data-tooltip-gravity="#{gravity}"
        data-tooltip-classname="#{classname}"></span>
    HTML

    help_hover.html_safe
  end
end
