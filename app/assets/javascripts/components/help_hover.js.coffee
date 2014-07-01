$(document).ready ->
  $('.help-hover')
    .tipsy({
      gravity: ->
        $(this).data 'tooltip-gravity'
      title: ->
        $(this).data('tooltip-content')
      className: ->
        $(this).data('tooltip-classname')
      fade: true
      html: true
      offset: 50
    })
    .mouseenter ()->
      tooltip = $('.help-hover-tooltip').first()

      leftPosition = -42
      topPosition = 45

      # we modify the css a custom class so we need to
      # reposition the tooltip so that it's centered
      tooltip
        .css(
          'left',
          tooltip
            .position()
            .left + leftPosition
        )
        .css(
          'top',
          tooltip
            .position()
            .top + topPosition
        )
