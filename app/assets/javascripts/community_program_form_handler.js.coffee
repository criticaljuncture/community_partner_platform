class @CPP.CommunityProgramFormHandler
  constructor: (form)->
    @form = form

    @organizationEl = @form.find('#community_program_organization_id')
    @organizationUserEl = @form.find('#community_program_user_id')

    @qualityElementEl = @form.find('#community_program_primary_quality_element_attributes_quality_element_id')

    #@schoolEl = @form.find('#community_program_school_id')
    #@schoolUserEl = @form.find('#community_program_school_user_id_input')

    @addChangeHandler()
    @ensureFormConsistency()
    @addAjaxButtonHandler()

  addChangeHandler: ->
    formHandler = this

    @qualityElementEl.on 'change', ()->
      formHandler.qualityElementChange $(this).val()

    @organizationEl.on 'change', ()->
      formHandler.organizationChange $(this).val()

    #@schoolEl.on 'change', ()->
      #formHandler.schoolChange $(this).val()

  ensureFormConsistency: ->
    if @qualityElementEl.val() == ""
      @qualityElementEl.trigger 'change'

    if @organizationUserEl.val() == "" && !@form.hasClass('errors')
      @organizationEl.trigger 'change'

    #if @form.find('#community_program_school_user_id').val() == "" && !@form.hasClass('errors')
      #@schoolEl.trigger 'change'

    if @form.find('#community_program_organization_id').val() != ""
      @form.find('#add-org-user').show()

    #if @form.find('#community_program_school_id').val() != ""
      #@form.find('#add-school-user').show()

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
    addOrgUser = $('#org-user-wrapper')

    addOrgUser
      .prepend html
      .show()

  removeOrganizationRelatedFields: ->
    @organizationUserEl.remove()
    $('#add-org-user').hide()

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
    addSchoolUser = $('#add-school-user')

    addSchoolUser
      .prepend html
      .show()

  removeSchoolRelatedFields: ->
    @schoolUserEl.remove()

  ### UPDATE USER METHODS ###
  addAjaxButtonHandler: ->
    @addOrgUserHandler()
    #@addSchoolUserHandler()

  addOrgUserHandler: ->
    formHandler = this
    button = @form.find('#add-org-user')

    button.on 'click', (event)->
      response = $.ajax({
        url: '/users/new',
        data: {role_id: 4},
        dataType: 'html'
      })

      response.done @showNewUserModal

  addSchoolUserHandler: ->
    formHandler = this
    button = @form.find('#add-school-user')

    button.on 'click', (event)->
      response = $.ajax({
        url: '/users/new',
        data: {
          school_id: formHandler.schoolEl.val()
          role_id: 3
        },
        dataType: 'html'
      })

      response.done @showNewUserModal

  showNewUserModal: (html)->
    $('.user-modal .modal-body').html(html);

    $('.user-modal').modal({
      escapeClose: false,
      clickClose: false,
      showClose: false
    });
