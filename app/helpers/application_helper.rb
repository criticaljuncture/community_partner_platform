module ApplicationHelper
  def page_specific_javascript(file_name)
    content_for :javascripts, javascript_include_tag(file_name) 
  end

  def join_with_br(items, method=nil, joiner=",")
    if method
      items.map{|i| i.send(method)}.join("#{joiner} <br />").html_safe
    else
      items.join("#{joiner} <br />").html_safe
    end
  end
end
