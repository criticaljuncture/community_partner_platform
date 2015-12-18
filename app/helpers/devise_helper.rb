module DeviseHelper
  def devise_error_messages!
   return '' if resource.errors.empty?

   messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
   html = alert_notice(:danger, 'warning-sign') do
      "<ul>
        #{messages}
      </ul>".html_safe
   end

   html.try(:html_safe)
  end
end
