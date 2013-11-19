module ChartHelper
  def completeness_donut(title, complete, total)
    donut_chart(title, complete, total).html_safe
  end

  private

  def donut_chart(title, complete, total)
    width = 120
    height = 120
    radius = 60
    thickness = 20

    class_names = ''

    chart_data = [
      {label: 'complete',   count: complete},
      {label: 'incomplete', count: total-complete}
    ].to_json

    complete_color = color_for_completeness(complete.to_f/total.to_f)
    incomplete_color = "gray-30"

    chart_color_names = [complete_color, incomplete_color].to_json.html_safe

    "{{donut-chart  width=#{width}
                    height=#{height}
                    classNames='#{class_names}'
                    chartData='#{chart_data}'
                    chartColorNames='#{chart_color_names}'
                    donutRadius='#{radius}'
                    donutThickness='#{thickness}'
                    title='#{title}'
    }}".html_safe
  end

  def color_for_completeness(completeness)
    return "green"    if completeness > 0.75
    return "orange"   if completeness > 0.40
    return "red"
  end
end
