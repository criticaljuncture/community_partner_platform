$(document).ready ->
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
