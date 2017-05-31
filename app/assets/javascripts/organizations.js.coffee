$(document).ready ->
  organizationsTableWrapper = $('#organizations-table')
  if organizationsTableWrapper.length > 0
    $.ajax(
      {
        url: Routes.table_organizations_path({format: ''})
        method: 'GET'
        dataType: 'html'
        success: (response)->
          organizationsTableWrapper.html(response)
          new CJ.Tablesorter(
            organizationsTableWrapper.find('table.table-sorter')
          )
      }
    )  
