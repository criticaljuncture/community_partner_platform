var UserFormHandler = (function() {
  var UserFormHandler = function() {
    this.form = null;
  };

  UserFormHandler.prototype = {
    initialize: function(form) {
      this.form = form;

      this.add_change_handler();
      this.ensure_form_consistency();
    },

    ensure_form_consistency: function() {
      this.form.find('#user_primary_role').trigger('change');
    },

    add_change_handler: function() {
      var form_handler = this;

      form_handler.form.find('#user_primary_role').on('change', function() {
        form_handler.role_change( $(this).find(":selected").data('role-type') );
      });
    },

    role_change: function(role) {
      this.hide_role_related_fields(role)
      if( role ) {
        this.show_role_related_fields(role);
      }
    },

    show_role_related_fields: function(role) {
      var user_form_handler = this;

      switch(role) {
        case 'organization_member':
          user_form_handler.form.find('#user_organization_input').show();
          user_form_handler.form.find('#user_organization_id').attr('disabled', false);
          break;
        case 'school_manager':
          user_form_handler.form.find('#user_schools_input').show();
          user_form_handler.form.find('#user_school_ids').attr('disabled', false);
          break;
        case 'district_manager':
          break;
      }
    },

    hide_role_related_fields: function() {
      var user_form_handler = this;

      this.form.find('#user_organization_input').hide();
      this.form.find('#user_organization_id').attr('disabled', true);

      this.form.find('#user_schools_input').hide();
      this.form.find('#user_school_ids').attr('disabled', true);
    }
  };

  return UserFormHandler;
})();
