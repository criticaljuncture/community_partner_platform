class @CPP.UserFormHandler
  constructor: (form)->
    @form = form
    @userEl = @form.find('#user_primary_role')

    @addChangeHandlers()
    @ensureFormConsistency()

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
    @form.find('.form-group.user_organization_id').hide()
    @form.find('#user_organization_id')
      .prop 'disabled', true

    @form.find('.form-group.user_school_ids').hide()
    @form.find('#user_school_ids')
      .prop 'disabled', true

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
