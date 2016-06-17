class @CPP.UserModalFormHandler
  constructor: (form)->
    @form = form
    @userEl = @form.find('#user_primary_role')

    @configureHiddenFields()
    @addFormSubmissionEvents()

  configureHiddenFields: ()->
    role = @userEl.find(":selected").data('role-type')
    hiddenEl = undefined

    if role == 'organization_member'
      hiddenEl = @form.find('#user_organization_id')
      @_enableOrientationFields()
    else if role == 'school_manager'
      hiddenEl = @form.find('#user_school_ids')
      @_disableOrientationFields()

    if hiddenEl.length > 0
      hiddenEl
        .prop 'disabled', false

  _enableOrientationFields: () ->
    @form.find('.form-group.user_orientation_type_id')
    .show()
    .removeClass('hidden')
    @form.find('#user_orientation_type_id')
      .prop 'disabled', false

    @form.find('#user_attended_orientation_at').prop 'disabled', false

  _disableOrientationFields: () ->
    @form.find('.form-group.user_orientation_type_id').hide()
    @form.find('#user_orientation_type_id')
      .prop 'disabled', true

    @form.find('.form-group.user_attended_orientation_at').hide()
    @form.find('#user_attended_orientation_at')
      .prop 'disabled', true
    @form.find('#attended_orientation_at_hidden')
      .prop 'disabled', true

  addFormSubmissionEvents: ()->
    @form.on 'submit', @form, (event)=>
      event.preventDefault()
      @removeErrorsFromInputs()

      request = $.ajax(
        {
          url: @form.attr('action')
          method: 'POST'
          dataType: 'json'
          data: @form.serialize()
        }
      )

      request.done (response)=>
        @formSubmitDone response

      request.fail (response)=>
        @formSubmitFail response

  formSubmitDone: (response)->
    message = response.message
    user = response.user

    if user.role_id == 4
      select = $('#community_program_user_id')
    else if user.role_id == 3
      select = $('#school_program_user_id')

    select.append(
      $('<option>').attr('value', user.id).text(user.name)
    )
    select.val(user.id)

    $('#user-modal')
      .modal('hide')
      .find('.modal-body')
        .html(
          $('<div>').addClass('.loader.loading')
        )

  formSubmitFail: (response)->
    @jsonErrors = response.responseJSON.errors
    _.each @jsonErrors, (value, key)=>
      @addErrorToInput(key, value)

  addErrorToInput: (name, message)->
    input = $("#user_#{name}")

    input
      .closest('.form-group')
      .addClass('has-error')

    input
      .after(
        $('<span>')
        .addClass 'help-block'
        .html message
      )

  removeErrorsFromInputs: ->
    _.each @jsonErrors, (value, key)=>
      @removeErrorFromInput(key, value)

  removeErrorFromInput: (name, message)->
    input = $("#user_#{name}")

    input
      .closest('.form-group')
      .removeClass('has-error')
      .find('.help-block')
      .remove()
