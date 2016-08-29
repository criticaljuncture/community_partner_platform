class ProgressBarPresenter
  include ActionView::Helpers
  include ContextualHelpHelper
  include IconHelper

  attr_private :options, :percentage, :color_ranges, :min, :max,
    :verification_required, :partial_progress_bar, :tooltip

  def self.perform(percentage:, options: {})
    new(percentage: percentage, options: options).perform
  end

  def initialize(percentage:, options: {})
    @percentage             = percentage
    @min                    = options.fetch(:min){ 0 }
    @max                    = options.fetch(:max){ 100 }
    @partial_progress_bar   = options.fetch(:partial_progress_bar){ false }
    @tooltip                = options.delete(:tooltip)
    @verification_required  = options.fetch(:verification_required){ false }
    @color_ranges           = options.fetch(:color_ranges) do
      {
        0..20    => "low",
        21..50   => "medium",
        51..99   => "high",
        100..100 => "complete",
      }
    end

    @options = options
  end

  def perform
    options = {
      class: progressbar_css_classes,
      style: "width: #{percentage}%",
      role: "progressbar",
      aria: {valuenow: percentage, valuemin: min, valuemax: max}
    }

    options.merge!({
      data: {tooltip: tooltip}
    }) if tooltip.present?

    inner_progress_bar = content_tag(:div, text, options)

    if partial_progress_bar
      inner_progress_bar
    else
      content_tag(
        :div,
        inner_progress_bar,
        class: "progress"
      )
    end
  end

  private

  def progressbar_css_classes
    classes = ["progress-bar"]
    types.each do |type|
      classes << "progress-bar-#{type}"
    end
    classes << color_class
    classes << 'cj-fancy-tooltip' if tooltip.present?

    classes.join(' ')
  end

  def types
   types = options[:type] ? Array(options[:type]) : []

   if complete? && verification_required?
     types << "striped"
   end

   types.uniq
 end

  def text
    return options[:text] if options[:text]

    text = number_to_percentage(
      percentage,
      precision: 0
    )

    if complete? && verification_required?
      text = "#{text} (verfication needed)"
    end

    text
  end

  def complete?
    percentage == 100
  end

  def verification_required?
    verification_required == true
  end

  def color_class
    if complete? && verification_required?
      return "complete-needing-verification"
    end

    color_ranges.
      select{|color_range, css_color_class| color_range.include? percentage}.
      values.first
  end

end
