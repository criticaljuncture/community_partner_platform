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
    else if role == 'school_manager'
      hiddenEl = @form.find('#user_school_ids')

    if hiddenEl.length > 0
      hiddenEl
        .prop 'disabled', false

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
      select = @_organizationMemberSelectTagEl()

    else if user.role_id == 3
      select = $('#school_program_user_id')

    select.append(
      $('<option>').attr('value', user.id).text(user.name)
    )
    select.val(user.id)

    if @_isOrganizationPage()
      $('#user_ids_to_assign').append(
        "<option selected='selected' value='#{user.id}'>#{user.id}</option>"
      )

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

  _organizationMemberSelectTagEl: ->
    if @_isOrganizationPage()
      $('#organization_user_id')
    else
      $('#community_program_user_id')

  _isOrganizationPage: ->
    $('.organization-page').length > 0
