module ApplicationHelper
  def page_specific_javascript(file_name)
    content_for :javascripts, javascript_include_tag(file_name) 
  end
end
