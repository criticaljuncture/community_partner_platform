module ContextualHelpHelper
  def help(description, options={})
    content_tag :div,
      class: "contextual-help cj-tooltip",
      data: {
        tooltip: description,
        'tooltip-classname': options.delete(:class)
      } do
      gicon 'question-sign'
    end
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
