$(document).ready ->
  $('.table.community-program-public-authorizations').on 'click', '.btn.authorize', (e)->
    e.preventDefault()
    e.stopPropagation()

    currentButton = $(this)

    $.ajax({
      url: currentButton.attr('href'),
      method: 'POST',
      dataType: 'json'
    })
    .done (response)->
      button = HandlebarsTemplates['community_program_public_authorization_button']({data: response})

      $(currentButton).replaceWith(button)
