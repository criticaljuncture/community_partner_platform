module ChartHelper
  def completeness_donut(complete, total)
    html = []
    html << "<script type='text/x-handlebars' data-template-name='application'>"
    html << donut_chart(complete, total)
    html << "</script>"

    html.join("\n").html_safe
  end

  private

  def donut_chart(complete, total)
    width = 300
    height = 100
    class_names = 'donut'
    chart_data = [
      {label: 'complete', count: complete},
      {label: 'total',    count: total}
    ].to_json
    chart_color_names = ["purple", "gray-30"].to_json.html_safe

    "{{donut-chart  width=#{width}
                    height=#{height}
                    classNames='#{class_names}'
                    chartData='#{chart_data}'
                    chartColorNames='#{chart_color_names}'}}".html_safe
  end
end
