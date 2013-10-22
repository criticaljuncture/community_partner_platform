var AddRoleFormHandler = (function() {
  var AddRoleFormHandler = function() {
    this.form = null;
  };

  AddRoleFormHandler.prototype = {
    initialize: function(form) {
      this.form = form;

      this.add_change_handler();
      this.ensure_form_consistency();
    },

    ensure_form_consistency: function() {
      this.form.find('#add_role_form_role').trigger('change');
    },

    add_change_handler: function() {
      var FormHandler = this;

      FormHandler.form.find('#add_role_form_role').on('change', function() {
        FormHandler.role_change( $(this).find(":selected").data('role-type') );
      });
    },

    role_change: function(role) {
      this.hide_role_related_fields(role)
      if( role ) {
        this.show_role_related_fields(role);
      }
    },

    show_role_related_fields: function(role) {
      var FormHandler = this;

      switch(role) {
        case 'organization_member':
          FormHandler.form.find('#add_role_form_organization_input').show();
          FormHandler.form.find('#add_role_form_organization').attr('disabled', false);
          break;
        case 'school_manager':
          FormHandler.form.find('#add_role_form_schools_input').show();
          FormHandler.form.find('#add_role_form_schools').attr('disabled', false);
          break;
        case 'district_manager':
          break;
      }
    },

    hide_role_related_fields: function() {
      var FormHandler = this;

      this.form.find('#add_role_form_organization_input').hide();
      this.form.find('#add_role_form_organization').attr('disabled', true);

      this.form.find('#add_role_form_schools_input').hide();
      this.form.find('#add_role_form_schools').attr('disabled', true);
    }
  };

  return AddRoleFormHandler;
})();

$(document).ready( function() {
  new AddRoleFormHandler().initialize( $('#new_add_role_form') );
});
