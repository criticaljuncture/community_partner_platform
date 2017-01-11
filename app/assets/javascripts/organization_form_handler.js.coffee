class @CPP.OrganizationFormHandler
  constructor: (form) ->
    @form = form
    @addOrgUserHandler()

  addOrgUserHandler: ->
    button = @form.find('#add-org-user')

    button.on 'click', (event)=>
      event.preventDefault()
      organizationId = $(".organization-page").data( "organization-id" )

      response = $.ajax({
        url: '/users/new',
        data: {
          role_id: 4,
          user: {
            organization_id: organizationId,
            new_org_creation: true
          },
        },
        dataType: 'html'
      })

      @showModal '.user-modal'
      response.done (html)=>
        @updateModal '.user-modal', html
        new CPP.UserModalFormHandler $('form.modal-user')

  showModal: (modalClass)->
    $(modalClass).modal()

  updateModal: (modalClass, html)->
    $("#{modalClass} .modal-body").html(html)
