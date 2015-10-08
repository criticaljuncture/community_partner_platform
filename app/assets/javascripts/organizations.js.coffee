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

  $('li.toggler').on 'click', 'a', (e)->
    e.preventDefault()

    link = $(this)
    el = link.closest('li')
    listEls = el.siblings('li.overflow')

    if listEls.hasClass('hidden')
      listEls
      .removeClass('hidden')
      .show()
    else
      listEls.toggle()

    if listEls.first().is(":visible")
      link.text link.text().replace('view', 'hide')
    else
      link.text link.text().replace('hide', 'view')
