module FormHelper
  def collapsible_field_set_tag(legend, options, &block)
    options[:class] ||= ''
    options[:class] += ' collapsible-fieldset toggle'

    options[:data] ||= {}
    options[:data].deep_merge!(
      "toggle-target" => '.fieldset-collapsible-area',
      "toggle-target-scope" => ['closest', 'fieldset'],
      "toggle-trigger-el" => "legend",
      "toggle-skip-text" => true
    )

    legend = "#{gicon 'plus'} #{gicon 'minus'} #{legend}".html_safe

    output = tag(:fieldset, options, true)
    output.safe_concat(content_tag(:legend, legend))
    output.safe_concat("<div class='#{options[:data]["toggle-target"].gsub('.',' ')}'>")
    output.concat(capture(&block)) if block_given?
    output.safe_concat("</div>")
    output.safe_concat("</fieldset>")
  end
end
