class @CPP.SchoolProgramFormHandler
  constructor: (form)->
    @form = form

    @schoolEl = @form.find('#school_program_school_id')
    @schoolUserEl = @form.find('#school_program_user_id')

    @addChangeHandlers()
    @ensureFormConsistency()
    @addInheritedValueBehavior()

    @addAjaxButtonHandlers()
    @addFormSubmissionEvents()
    @addToggleBehavior()


  addChangeHandlers: ->
    formHandler = this

    @schoolEl.on 'change', ()->
      formHandler.schoolChange $(this).val()

  ensureFormConsistency: ->
    if @schoolUserEl.val() == "" && !@form.hasClass('errors')
      @schoolEl.trigger 'change'

    if @schoolEl.val() != ""
      @form.find('#add-school-user').show()

    @highlightInheritance()

  highlightInheritance: ->
    _.each @form.find('.custom-school-inputs .form-group'), (formGroup)=>
      formGroup = $(formGroup)

      if formGroup.hasClass('select')
        input = formGroup.find('select')

        if input.val() == "" || input.val() == undefined
          inheritedValue = formGroup.data('inherited-values')

          # highlight form group and select the value
          formGroup.addClass('inheriting')
          input.val(inheritedValue)

      else if formGroup.hasClass('columized_checkboxes')
        checkedInputs = formGroup.find('input:checked')
        checkedInputVals = _.map checkedInputs, (input)->
          Number($(input).val())

        if _.isEqual(checkedInputVals, []) || _.isEqual(formGroup.data('inherited-values').sort(), checkedInputVals.sort())
          # highlight form group
          formGroup.addClass('inheriting')

        # always highlight the parent values so that a user can revert to the
        # parent values easily
        _.each formGroup.data('inherited-values'), (value)->
          formGroup.find("input[value='#{value}']")
            .prop('checked', true)
            .closest('label')
            .addClass('parent-value')

  addInheritedValueBehavior: ->
    _.each @form.find('.custom-school-inputs .form-group'), (formGroup)=>
      formGroup = $(formGroup)

      if formGroup.hasClass('select')
        @addSelectInheriting formGroup
      else if formGroup.hasClass('columized_checkboxes')
        @addCheckboxInheriting formGroup

  addSelectInheriting: (formGroup)->
    input = formGroup.find('select')
    inheritedValue = formGroup.data('inherited-values')

    input.on 'change', (event)->
      if Number($(this).val()) == inheritedValue
        formGroup.addClass('inheriting')
      else
        formGroup.removeClass('inheriting')

  addCheckboxInheriting: (formGroup)->
    inputs = formGroup.find('input')

    inputs.on 'change', (event)->
      checkedInputs = formGroup.find('input:checked')
      checkedInputVals = _.map checkedInputs, (input)->
        Number($(input).val())

      if _.isEqual(formGroup.data('inherited-values').sort(), checkedInputVals.sort())
        formGroup.addClass('inheriting')
        _.each formGroup.data('inherited-values'), (value)->
          formGroup.find("input[value='#{value}']")
            .closest('label')
            .addClass('inheriting')
      else
        formGroup.removeClass('inheriting')

  ### SCHOOL CHANGE METHODS ###
  schoolChange: (schoolId)->
    @removeSchoolRelatedFields()

    if schoolId != ""
      @addSchoolRelatedFields schoolId

  addSchoolRelatedFields: (schoolId)->
    formHandler = this

    response = $.ajax({
      url: '/schools/' + schoolId + '/primary_contact_input',
      dataType: 'html'
    })

    response.done @addSchoolRelatedHtmlToForm

  addSchoolRelatedHtmlToForm: (html)->
    $('#school-user-wrapper')
      .append html
      .show()

  removeSchoolRelatedFields: ->
    $('form .school_program_user_id').remove()
    $('#school-user-wrapper').hide()

  ### UPDATE USER METHODS ###
  addAjaxButtonHandlers: ->
    @addSchoolUserHandler()

  addSchoolUserHandler: ->
    formHandler = this
    button = @form.find('#add-school-user')

    button.on 'click', (event)=>
      response = $.ajax({
        url: '/users/new',
        data: {
          user: {first_name: ""}, #stub to pass strong params
          school_id: formHandler.schoolEl.find(':selected').val(),
          role_id: 3
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


  ### FORM SUBMISSION & errors ###
  addFormSubmissionEvents: ()->
    @form.on 'submit', @form, (event)=>
      event.preventDefault()
      @removeErrorsFromInputs()

      # disable any inputs that are inheriting
      _.each @form.find('.custom-school-inputs .form-group'), (formGroup)=>
        @disableInputsIfAllInherited $(formGroup)

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
    table = $("fieldset table.school-programs")

    noProgramsRow = table.find("tbody tr#no-school-programs")
    if noProgramsRow.length > 0
      noProgramsRow.remove()

    currentRow = table
      .find("tbody tr[data-school-program-id='#{response.school_program_id}']")

    if currentRow.length == 0
      table.find('tbody').append response.html
    else
      currentRow.replaceWith response.html

    CJ.Notifier.displayNotification(response.message, 'success')
    $("#school-program-modal").modal 'hide'

  formSubmitFail: (response)->
    _.each @form.find('.custom-school-inputs .form-group'), (formGroup)=>
      @disableInputs $(formGroup), false

    @jsonErrors = response.responseJSON.errors
    _.each @jsonErrors, (value, key)=>
      @addErrorToInput(key, value)

    $('#school-program-modal').scrollTop(0)

  disableInputsIfAllInherited: (formGroup)->
    if formGroup.hasClass('select')
      input = formGroup.find('select')
      inheritedValue = formGroup.data('inherited-values')

      if Number(input.val()) == inheritedValue
        @disableInputs formGroup, true

    else if formGroup.hasClass('columized_checkboxes')
      checkedInputs = formGroup.find('input:checked')
      checkedInputVals = _.map checkedInputs, (input)->
        Number($(input).val())

      if _.isEqual(formGroup.data('inherited-values').sort(), checkedInputVals.sort())
        @disableInputs formGroup, true

  disableInputs: (formGroup, disable)->
    if formGroup.hasClass('select')
      input = formGroup.find('select')
      input.prop('disabled', disable)

    else if formGroup.hasClass('columized_checkboxes')
      inputs = formGroup.find('input')
      _.each inputs, (input)->
        $(input).prop('disabled', disable)

  addErrorToInput: (name, message)->
    input = $("#school_program_#{name}")

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
    input = $("#school_program_#{name}")

    input
      .closest('.form-group')
      .removeClass('has-error')
      .find('.help-block')
      .remove()

  ### CUSTOM SCHOOL ATTRIBUTES TOGGLE ###
  addToggleBehavior: ->
    _.each $('.toggle'), (el)=>
      new CJ.Toggle(el)
