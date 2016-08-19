module ListDisplayHelper

  def view_more_toggle_list(objects, threshold=2)
    content_tag(:ul, class: 'no-bullets') do
      objects.to_a[0..threshold-1].each do |obj|
        concat content_tag(:li, yield(obj))
      end

      if objects.count > threshold
        objects[threshold..-1].each do |obj|
          concat content_tag(:li, yield(obj), class: 'hidden overflow')
        end

        concat(
          content_tag(:li, class: 'toggler') do
            concat content_tag(:a, "view #{objects.count-2} more")
          end
        )
      end
    end
  end

end
