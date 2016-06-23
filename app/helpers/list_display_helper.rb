module ListDisplayHelper

  def partially_hidden_list(objects)
    content_tag(:ul, class: 'no-bullets') do
      objects.to_a[0..1].each do |obj|
        concat content_tag(
          :li,
          yield(obj)
        )
      end

      if objects.count > 2
        objects[2..-1].each do |obj|
          concat content_tag(
            :li,
            yield(obj),
            class: 'hidden overflow')
        end

        concat(
          content_tag(:li, class: 'toggler') do
            concat content_tag(:a, "view #{pluralize objects.count-2, 'other'}")
          end
        )
      end
    end

  end

end
