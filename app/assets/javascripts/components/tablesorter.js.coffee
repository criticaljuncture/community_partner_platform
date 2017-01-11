class @CJ.Tablesorter
  constructor: (el)->
    @el = $(el)
    @config = {
      theme : "bootstrap"

      textExtraction: (node)->
        # nodes are <td> here
        attr = $(node).attr('data-sort-value')
        if typeof attr != 'undefined'
          attr
        else # look for an item in this td with a sort value
          attr = $(node).find('[data-sort-value]')
          if typeof attr != 'undefined'
            attr.first().attr('data-sort-value')
          else # do the default and sort by text of tc
            $(node).text()

      widthFixed: false

      # new in v2.7. Needed to add the bootstrap icon!
      headerTemplate : '{content} {icon}'

      # widget code contained in the jquery.tablesorter.widgets.js file
      # use the zebra stripe widget if you plan on hiding any rows (filter widget)
      widgets : [ "uitheme", "filter", "zebra" ]

      widgetOptions : {
        # using the default zebra striping class name, so it actually isn't included in the theme variable above
        # this is ONLY needed for bootstrap theming if you are using the filter widget, because rows are hidden
        zebra : ["even", "odd"],

        #reset filters button
        filter_reset : ".reset"
      }
    }

    @create()

  create: ->
    @el.tablesorter(@config)
