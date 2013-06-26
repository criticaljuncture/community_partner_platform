module BreadcrumbHelper

  def breadcrumb(crumbs, options={})
    content = []

    exclude_home = options.delete(:exclude_home) || false
    unless exclude_home
      content << crumb_element('Home', root_path, false)
    end

    crumbs.each do |name, path|
      active = name == crumbs.last.first ? true : false
      content << crumb_element(name, path, active)
    end

    content_for :breadcrumbs, content.join("\n").html_safe
  end

  def crumb_element(name, path, active)
    content_tag(:li, class: active ? 'active' : '') do
      if active
        name
      else
        link_to(name, path) +
          content_tag(:span, '/', class: 'divider')
      end
    end
  end

end
