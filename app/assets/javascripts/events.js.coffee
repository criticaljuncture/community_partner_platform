$(document).ready ->
  eventsTableWrapper = $('#events-table')
  if eventsTableWrapper.length > 0
    $.ajax(
      {
        url: Routes.table_events_path({format: ''})
        method: 'GET'
        dataType: 'html'
        success: (response)->
          eventsTableWrapper.html(response)
          new CJ.Tablesorter(
            eventsTableWrapper.find('table.table-sorter')
          )
      }
    )
