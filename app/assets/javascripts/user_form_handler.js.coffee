class @CPP.UserFormHandler
  constructor: (form)->
    @form = form
    @userEl = @form.find('#user_primary_role')

    @addChangeHandlers()
    @ensureFormConsistency()
    @addFormSubmissionEvents()

  addChangeHandlers: ->
    formHandler = this

    @userEl.on 'change', ()->
      formHandler.roleChange(
        $(this).find(":selected").data('role-type')
      )

  ensureFormConsistency: ()->
    @userEl.trigger('change');

  roleChange: (role)->
    @hideRoleRelatedFields role

    if role
      @showRoleRelatedFields role

  hideRoleRelatedFields: ->
    @form.find('#user_organization_input').hide()
    @form.find('#user_organization_id')
      .prop 'disabled', true

    @form.find('#user_schools_input').hide()
    @form.find('#user_school_ids')
      .prop 'disabled', true

  showRoleRelatedFields: (role)->
    if role == 'organization_member'
      @form.find('#user_organization_input').show()
      @form.find('#user_organization_id')
        .prop 'disabled', false
    else if role == 'school_manager'
      @form.find('#user_schools_input').show()
      @form.find('#user_school_ids')
        .prop 'disabled', false
    else if role == 'district_manager'
        null

  ### FORM SUBMISSION & errors ###
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
