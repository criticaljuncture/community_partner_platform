module ProgressBarHelper
  def progress_bar(type, percentage, text, options={})
    striped = options.fetch(:striped){ false }
    min = options.fetch(:min){ 0 }
    max = options.fetch(:max){ 100 }

    classes = ["progress-bar", "progress-bar-#{type}"]
    classes << ["progress-bar-striped"] if striped

    content_tag(:div, text, class: classes.join(' '),
      style: "width: #{percentage}%", role: "progressbar",
      aria: {valuenow: percentage, valuemin: min, valuemax: max})
  end
end
