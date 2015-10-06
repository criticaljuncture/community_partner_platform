$(document).ready ->
  communityProgramsTableWrapper = $('#community-programs-table')
  if communityProgramsTableWrapper.length > 0
    $.ajax(
      {
        url: Routes.table_community_programs_path({format: ''})
        method: 'GET'
        dataType: 'html'
        success: (response)->
          communityProgramsTableWrapper.html(response)
          new CJ.Tablesorter(
            communityProgramsTableWrapper.find('table.table-sorter')
          )
      }
    )

  communityProgramForm = $('form.community-program')
  if communityProgramForm.length > 0
    new CPP.CommunityProgramFormHandler communityProgramForm

  $('#deactivation-warning-modal')
    .on 'click', '.deactivate-program.btn', (e)->
      e.preventDefault()
      button = $(this)

      $.ajax(
        {
          url: "/community_programs/#{button.data('community-program-id')}/toggle_active"
          method: 'PUT'
          dataType: 'json'
          success: (response) ->
            if response.active
              button.text 'Deactivate'
              $('.header .btn-warning').text 'Deactivate'
            else
              button.text 'Activate'
              $('.header .btn-warning').text 'Activate'
              $('.header .btn-primary').hide()

            button
              .siblings '.btn-primary'
              .text 'Close'
        }
      )
