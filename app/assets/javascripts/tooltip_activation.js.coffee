$(document).ready ()->
  CJ.Tooltip.addFancyTooltip(
    '.cj-tooltip',
    {
      opacity: 1
      delay: 0.2
      fade: true
    },
    {
      position: 'centerTop'
      verticalOffset: -13
      horizontalOffset: -6
    }
  )
