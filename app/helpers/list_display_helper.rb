module ListDisplayHelper

  def view_more_toggle_list(objects, threshold: 2, toggler_position: :last, toggler_label: '')
    content_tag(:ul, class: 'view-more-list no-bullets') do
      if objects.size > threshold && toggler_position == :first
        concat(
          content_tag(:li, class: 'toggler') do
            if toggler_label.present?
              concat "#{toggler_label} "
            end
            concat content_tag(:a, "view #{objects.size - threshold} more")
          end
        )
      end

      objects.to_a[0..threshold-1].each do |obj|
        concat content_tag(:li, yield(obj))
      end

      if objects.size > threshold
        objects[threshold..-1].each do |obj|
          concat content_tag(:li, yield(obj), class: 'hidden overflow')
        end

        if toggler_position == :last
          concat(
            content_tag(:li, class: 'toggler') do
              if toggler_label.present?
                concat "#{toggler_label} "
              end
              concat content_tag(:a, "view #{objects.size - threshold} more")
            end
          )
        end
      end
    end
  end

end
