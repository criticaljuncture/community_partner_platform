module NavigationHelper
  def active_for_controller(name)
    return 'active' if params[:controller] == name
  end

  def page_nav_tabs(tabs, options={})
    content = []

    tabs.each do |name, target, count|
      text = count ? "#{name} #{exclamation_bubble(count)}".html_safe : name

      content << content_tag(:li, link_to(text, target, data: {toggle: 'tab'}) )
    end

    content_tag(:ul, content.join("\n").html_safe, class: "nav nav-tabs")
  end
end
