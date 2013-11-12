OusdCommunityPartners.DonutChartComponent = Ember.Component.extend({
  tagName: 'svg',
  templateName: 'donut-chart',

  didInsertElement: function(){
    var width = this.get('width');
    var height = this.get('height');

    var chartData = JSON.parse( this.get('chartData') );
    var chartColorNames = JSON.parse( this.get('chartColorNames') );

    var radius = Math.min(width, height) / 2;
    var arc = d3.svg.arc()
                .outerRadius(radius)
                .innerRadius(radius-20);

    var pie = d3.layout.pie()
                .sort(null)
                .value(function(d) { return d.count; });

    var id = this.$().attr('id');
    var svg = d3.select("#"+id)
                .append("svg")
                  .attr("width", width)
                  .attr("height", height)
                  .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    var g = svg.selectAll(".arc")
                  .data(pie(chartData))
                  .enter()
                    .append("g")
                      .attr("class", function(d,i) { return "arc " + chartColorNames[i] });

    g.append("path")
      .attr("d", arc);
  }
});
