module NavigationHelper
  def active_for_controller(name)
    return 'active' if params[:controller] == name
  end

  def page_nav_tabs(tabs, options={})
    content = []

    tabs.each do |name, target|
      content << content_tag(:li, link_to(name, target, data: {toggle: 'tab'}) )
    end

    content_tag(:ul, content.join("\n").html_safe, class: "nav nav-tabs")
  end
end
