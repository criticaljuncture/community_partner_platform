CommunityPartnerPlatform.DonutChartComponent = Ember.Component.extend({
  tagName: 'div',
  templateName: 'donut-chart',

  graphElement: '.graph',
  donutRadius: 50,
  donutThickness: 20,

  width: 100,
  height: 100,

  didInsertElement: function(){
    var width = this.get('width'),
        height = this.get('height'),
        graphElement = this.get('graphElement'),
        radius = this.get('donutRadius'),
        thickness = this.get('donutThickness')
        Donut = this;


    var chartData = JSON.parse( this.get('chartData') );
    var chartColorNames = JSON.parse( this.get('chartColorNames') );

    var arc = d3.svg.arc()
                .outerRadius(radius)
                .innerRadius(radius-thickness);

    var pie = d3.layout.pie()
                .sort(null)
                .value(function(d) { return d.count; });

    var id = this.$().attr('id');
    var svg = d3.select("#"+id)
                .select(graphElement)
                .append("svg")
                  .attr("class", "donut-chart")
                  .attr("width", width)
                  .attr("height", height)
                  .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    var arcs = svg.selectAll(".arc")
                  .data(pie(chartData));

    arcs.enter()
      .append("g")
        .append("path")
          .attr("d", arc)
          .attr("class", function(d,i) { return "arc " + chartColorNames[i] });

    svg.append("text")
      .attr("class", "chart_count " + chartColorNames[0])
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")
      .text(chartData[0].count);

    d3.select("#"+id)
        .select(graphElement)
        .select("svg")
          .attr("data-chart-info", Donut.get('chartHover'))

    add_tipsy(graphElement + " svg", {gravity: 'w',
                                      title: function(){
                                        return this.getAttribute('data-chart-info')
                                      }
    });
  },

  chartHover: function() {
    data = JSON.parse( this.get('chartData') );

    complete = data[0].count;
    total = data[1].count + complete;

    return Math.round(complete/total*100) + "% (" + complete + "/" + total + ")"
  }.property('chartData'),
});
