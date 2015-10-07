$(document).ready ->
  schoolsTableWrapper = $('#schools-table')
  if schoolsTableWrapper.length > 0
    $.ajax(
      {
        url: Routes.table_schools_path({format: ''})
        method: 'GET'
        dataType: 'html'
        success: (response)->
          schoolsTableWrapper.html(response)
          new CJ.Tablesorter(
            schoolsTableWrapper.find('table.table-sorter')
          )
      }
    )
