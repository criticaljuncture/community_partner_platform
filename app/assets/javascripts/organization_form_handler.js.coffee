class @CPP.OrganizationFormHandler
  constructor: (form) ->
    @form = form
    @addCTEParticipationHandler()
    @addOrgUserHandler()

  addCTEParticipationHandler: ->
    input = @form.find('#organization_participates_in_cte')

    dependentInputs = [
      $('.form-group.organization_cte_quality_element_service_type_ids'),
      $('.form-group.organization_cte_event_type_ids')
    ]

    input.on 'change', (event)=>
      if input.val() == 'true'
        dependentInputs.forEach (input)=>
          $(input).show().prop('disabled', false)
      else
        dependentInputs.forEach (input)=>
          $(input).hide().prop('disabled', true)

    # trigger initial state
    input.trigger('change')

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
