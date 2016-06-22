module SchoolSummaryHelper

  def school_summary(schls)
    schls = schls.sort_by{|s| s.name}

    content_tag(:ul, class: 'no-bullets') do
      schls.to_a[0..1].each do |school|
        concat content_tag(:li, school.name)
      end

      if schls.count > 2
        schls[2..-1].each do |school|
          concat content_tag(:li, school.name, class: 'hidden overflow')
        end

        concat(
          content_tag(:li, class: 'toggler') do
            concat content_tag(:a, "view #{pluralize schools.count-2, 'other'}")
          end
        )
      end
    end
  end

end
