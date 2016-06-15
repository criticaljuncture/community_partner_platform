module ContextualHelpHelper
  def help(description)
    content_tag :div,
      class: 'contextual-help cj-tooltip',
      data: {tooltip: description} do
      gicon 'question-sign'
    end
  end
end
