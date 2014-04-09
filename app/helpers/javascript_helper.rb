module JavascriptHelper
  def page_specific_javascript(file_name)
    content_for :javascripts, javascript_include_tag(file_name)
  end

  def embed_javascript(file_name)
    "<script type='text/javascript'>
      #{File.read( File.join(Rails.root, 'app', 'assets', 'javascripts', file_name + '.js') )}
     </script>".html_safe
  end
end
