class @CPP.UserFormHandler
  constructor: (form)->
    @form = form
    @userRoleEl = @form.find('#user_primary_role')

    @addChangeHandlers()
    @ensureFormConsistency()

  addChangeHandlers: ->
    formHandler = this

    @userRoleEl.on 'change', ()->
      formHandler.roleChange(
        $(this).find(":selected").data('role-type')
      )

    @_handleEmptyOrientationDate()

  _handleEmptyOrientationDate: ->
    $('#user_attended_orientation_at').on 'change', () =>
      if $('#user_attended_orientation_at').val().length == 0
        @form.find('#attended_orientation_at_hidden')
          .prop 'disabled', true
      else
        @form.find('#attended_orientation_at_hidden')
          .prop 'disabled', false

  ensureFormConsistency: ()->
    @userRoleEl.trigger('change');

  roleChange: (role)->
    @hideRoleRelatedFields role

    if role
      @showRoleRelatedFields role

  hideRoleRelatedFields: ->
    @form.find('.form-group.user_organization_id').hide()
    @form.find('#user_organization_id')
      .prop 'disabled', true

    @form.find('.form-group.user_school_ids').hide()
    @form.find('#user_school_ids')
      .prop 'disabled', true

    @form.find('#district-details').hide()

    @form.find('.form-group.user_orientation_type_id').hide()
    @form.find('#user_orientation_type_id')
      .prop 'disabled', true

    @form.find('.form-group.user_attended_orientation_at').hide()
    @form.find('#user_attended_orientation_at')
      .prop 'disabled', true

    @form.find('#attended_orientation_at_hidden')
      .prop 'disabled', true

  showRoleRelatedFields: (role)->
    if role == 'organization_member'
      @form.find('.form-group.user_organization_id')
      .show()
      .removeClass('hidden')

      @form.find('#user_organization_id')
        .prop 'disabled', false

      @form.find('#district-details').show()

      @form.find('.form-group.user_orientation_type_id')
      .show()
      .removeClass('hidden')

      @form.find('#user_orientation_type_id')
        .prop 'disabled', false

      @form.find('.form-group.user_attended_orientation_at')
      .show()
      .removeClass('hidden')

      @form.find('#user_attended_orientation_at')
        .prop 'disabled', false

      @form.find('#attended_orientation_at_hidden')
        .prop 'disabled', false

    else if role == 'school_manager'
      @form.find('.form-group.user_school_ids')
        .show()
        .removeClass('hidden')

      @form.find('#user_school_ids')
        .prop 'disabled', false
    else if role == 'district_manager'
        null
