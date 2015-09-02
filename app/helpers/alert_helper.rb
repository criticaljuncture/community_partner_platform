module AlertHelper
  # add an alert type box anywhere on the page
  def alert(type, icon, content=nil, &block)
    message =  block_given? ? capture(&block) : content

    content_tag(:div, class: "alert alert-#{type}") do
      concat gicon(icon)
      concat content_tag(:p, message, class: "content")
    end
  end

  # add an alert type box to the top of the page (near flash notices)
  def alert_notice(type, icon, content=nil, &block)
    message = block_given? ? capture(&block) : content

    content_for :alert_notices do
      alert type, icon, message
    end
  end
end
