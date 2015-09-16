module LayoutHelper
  def alert_message(type, message)
    alert_class = case type.to_s
    when "warning"
      'warning'
    when "notice"
      'success'
    when "error"
      "danger"
    else
      "warning"
    end

    content_tag(:div, class: "alert alert-#{alert_class} alert-dismissable",
      role: "alert") do

      concat(message)
      concat(
        content_tag(:button, class: "close", data: {dismiss: "alert"},
          aria: {label: "Close"}) do

          content_tag(:span, 'x', aria: {hidden: true})
        end
      )
    end
  end
end
