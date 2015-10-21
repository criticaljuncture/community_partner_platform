class @CPP.CommunityProgramFormHandler
  constructor: (form)->
    @form = form

    @organizationEl = @form.find('#community_program_organization_id')
    @organizationUserEl = @form.find('#community_program_user_id')

    @qualityElementEl = @form.find('#community_program_primary_quality_element_attributes_quality_element_id')

    @addChangeHandlers()
    @ensureFormConsistency()
    @addAjaxButtonHandlers()

  addChangeHandlers: ->
    formHandler = this

    @qualityElementEl.on 'change', ()->
      formHandler.qualityElementChange $(this).val()

    @organizationEl.on 'change', ()->
      formHandler.organizationChange $(this).val()

  ensureFormConsistency: ->
    if @qualityElementEl.val() == ""
      @qualityElementEl.trigger 'change'

    if @organizationUserEl.val() == "" && !@form.hasClass('errors')
      @organizationEl.trigger 'change'

    if @organizationEl.val() != ""
      @form.find('#add-org-user').show()


  ### QUALITY ELEMENT CHANGE METHODS ###
  qualityElementChange: (qualityElementId)->
    @removeQualityElementRelatedFields()

    if qualityElementId != ""
      @addQualityElementRelatedFields qualityElementId

  removeQualityElementRelatedFields: ()->
    @form
      .find('.community_program_primary_quality_element_service_type_ids')
      .remove()

  addQualityElementRelatedFields: (qualityElementId)->
    formHandler = this

    response = $.ajax({
      url: '/quality_elements/' + qualityElementId +
        '/service_type_inputs?type=primary',
      dataType: 'html'
    })

    response.done @addQualityElementRelatedHtmlToForm

  addQualityElementRelatedHtmlToForm: (html)->
    # updating available service types
    $('#community_program_primary_quality_element_attributes_quality_element_id')
      .closest '.form-group'
      .after html

  ### ORGANIZATION CHANGE METHODS ###
  organizationChange: (organizationId)->
    @removeOrganizationRelatedFields()

    if organizationId != ""
      @addOrganizationRelatedFields organizationId

  addOrganizationRelatedFields: (organizationId)->
    formHandler = this

    response = $.ajax({
      url: '/organizations/' + organizationId + '/primary_contact_input',
      dataType: 'html'
    })

    response.done @addOrganizationRelatedHtmlToForm

  addOrganizationRelatedHtmlToForm: (html)->
    $('#org-user-wrapper')
      .append html
      .show()

  removeOrganizationRelatedFields: ->
    $('form .community_program_user_id').remove()
    $('#org-user-wrapper').hide()


  ### UPDATE USER METHODS ###
  addAjaxButtonHandlers: ->
    @addOrgUserHandler()
    @addNewSchoolHandler()
    @addEditSchoolHandler()
    @addRemoveSchoolHandler()

  addOrgUserHandler: ->
    button = @form.find('#add-org-user')
    organizationId = @form.find('#community_program_organization_id').val()

    button.on 'click', (event)=>
      event.preventDefault()

      response = $.ajax({
        url: '/users/new',
        data: {
          role_id: 4,
          user: {
            organization_id: organizationId
          }
        },
        dataType: 'html'
      })

      @showModal '.user-modal'
      response.done (html)=>
        @updateModal '.user-modal', html
        new CPP.UserModalFormHandler $('form.modal-user')

  addNewSchoolHandler: ->
    button = @form.find('#add-school-program')
    communityProgramId = @form.find('#community-program-id')

    button.on 'click', (event)=>
      event.preventDefault()

      response = $.ajax({
        url: '/school_programs/new',
        data: {
          school_program: {
            community_program_id: if communityProgramId then communityProgramId.val() else null
          }
        },
        dataType: 'html'
      })

      @showModal '.school-program-modal'
      response.done (html)=>
        @updateModal '.school-program-modal', html
        new CPP.SchoolProgramFormHandler $('form.school-program')

  addEditSchoolHandler: ->
    formHandler = this

    $('fieldset.school-programs').on 'click', '.btn.edit-school-program', (event)->
      event.preventDefault()

      schoolProgramId = $(this).closest('tr').data('school-program-id')

      response = $.ajax({
        url: "/school_programs/#{schoolProgramId}/edit",
        dataType: 'html'
      })

      formHandler.showModal '.school-program-modal'

      response.done (html)=>
        formHandler.updateModal '.school-program-modal', html
        new CPP.SchoolProgramFormHandler $('form.school-program')

  addRemoveSchoolHandler: ->
    modal = $('#remove-school-program-modal')

    $('fieldset.school-programs').on 'click', '.btn.remove-school-program', (event)->
      event.preventDefault()

      schoolProgramId = $(this).closest('tr').data('school-program-id')

      modal.find('.modal-body a.remove')
        .attr('href', Routes.school_program_path(schoolProgramId))


    modal.find('a.remove').on 'click', (event)->
      event.preventDefault()
      link = $(this)

      response = $.ajax({
        url: link.attr('href'),
        method: 'DELETE',
        dataType: 'json'
      })

      response.success (response)=>
        CJ.Notifier.displayNotification(response.message, 'success')
        modal.modal 'hide'
        table
          .find("tbody tr[data-school-program-id='#{response.school_program_id}']")
          .remove()


  showModal: (modalClass)->
    $(modalClass).modal()

  updateModal: (modalClass, html)->
    $("#{modalClass} .modal-body").html(html)
