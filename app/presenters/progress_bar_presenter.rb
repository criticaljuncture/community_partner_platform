class ProgressBarPresenter
  include ActionView::Helpers
  include ContextualHelpHelper
  include IconHelper

  def self.perform(percentage:, text:, options: {})
    new(percentage: percentage, text: text, options: options).perform
  end

  def initialize(percentage:, text:, options: {})
    @percentage             = percentage
    @text                   = text
    @type                   = options.fetch(:type){ nil }
    @striped                = options.fetch(:striped){ false }
    @min                    = options.fetch(:min){ 0 }
    @max                    = options.fetch(:max){ 100 }
    @explanation            = options.fetch(:explanation){ nil }
    @special_complete_color = options.fetch(:special_complete_color){ false }
    @color_ranges           = options.fetch(:color_ranges) do
      {
        0..20    => "low",
        20..50   => "medium",
        50...100 => "high",
        100..100 => "complete",
      }
    end
  end

  def perform
    classes = ["progress-bar", "progress-bar-#{type}"]
    classes << ["progress-bar-striped"] if striped
    classes << [custom_color_class]

    #TODO: Handle the use of the second content_tag
    content_tag(
      :div,
      content_tag(:div, text, class: classes.join(' '),
        style: "width: #{percentage}%", role: "progressbar",
        aria: {valuenow: percentage, valuemin: min, valuemax: max}
      ),
      class: "progress"
    )
  end

  private

  attr_reader :percentage, :type, :striped, :color_ranges, :text, :min, :max,
              :special_complete_color

  def custom_color_class
    if percentage == 100 && special_complete_color
      return "complete-needing-verification"
    end

    css_class = ""

    catch :done do
      color_ranges.each do |color_range, css_color_class|
        if color_range.include? percentage
          css_class = css_color_class
          throw :done
        end
      end
    end

    css_class
  end

end
