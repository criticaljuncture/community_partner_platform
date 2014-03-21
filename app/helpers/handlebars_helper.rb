module HandlebarsHelper
  def embed_ember_template(name, path)
    html = ["<script type='text/handlebars' id='template-#{name}'>"]
    html << File.read( File.join(Rails.root, 'app', 'assets', 'javascripts', 'templates', path + '.hbs') )
    html << "</script>"
    html.join("\n").html_safe
  end
end
