var CommunityProgramFormHandler = (function() {
  var CommunityProgramFormHandler = function() {
    this.form = null;
  };

  CommunityProgramFormHandler.prototype = {
    initialize: function(form) {
      this.form = form;

      this.add_change_handler();
      this.ensure_form_consistency();
      this.add_ajax_button_handler();
    },

    ensure_form_consistency: function() {
      if( this.form.find('#community_program_primary_quality_element_attributes_quality_element_id').val() === "" ) {
        this.form.find('#community_program_primary_quality_element_attributes_quality_element_id').trigger('change');
      }
      if( this.form.find('#community_program_secondary_quality_element_attributes_quality_element_id').val() === "" ) {
        this.form.find('#community_program_secondary_quality_element_attributes_quality_element_id').trigger('change');
      }

      if( this.form.find('#community_program_user_id').val() === "" && !this.form.hasClass('errors') ) {
        this.form.find('#community_program_organization_id').trigger('change');
      }

      if( this.form.find('#community_program_school_user_id').val() === "" && !this.form.hasClass('errors') ) {
        this.form.find('#community_program_school_id').trigger('change');
      }

      if( this.form.find('#community_program_organization_id').val() !== "" ) {
        this.form.find('#add-org-user').css('display', 'block');
      }

      if( this.form.find('#community_program_school_id').val() !== "" ) {
        this.form.find('#add-school-user').css('display', 'block');
      }
    },

    add_change_handler: function() {
      var form_handler = this;

      /* quality element change */
      form_handler.form.find('#community_program_primary_quality_element_attributes_quality_element_id').on('change', function() {
        form_handler.primary_quality_element_change( $(this).val() );
      });
      form_handler.form.find('#community_program_secondary_quality_element_attributes_quality_element_id').on('change', function() {
        form_handler.secondary_quality_element_change( $(this).val() );
      });


      /* organization change */
      form_handler.form.find('#community_program_organization_id').on('change', function() {
        form_handler.organization_change( $(this).val() );
      });

      /* school change */
      form_handler.form.find('#community_program_school_id').on('change', function() {
        form_handler.school_change( $(this).val() );
      });
    },

    primary_quality_element_change: function(quality_element_id) {
      this.remove_primary_quality_element_related_fields();

      if( quality_element_id !== "") {
        this.add_primary_quality_element_related_fields(quality_element_id);
      }
    },

    add_primary_quality_element_related_fields: function(quality_element_id) {
      var form_handler = this;

      $.ajax({
        url: '/quality_elements/' + quality_element_id + '/service_type_inputs?type=primary',
        dataType: 'html',
      })
        .done(function(html) {
          form_handler.form.find('#community_program_primary_quality_element_attributes_quality_element_id_input').after(html);
        });
    },

    remove_primary_quality_element_related_fields: function() {
      this.form.find('#community_program_primary_quality_element_attributes_service_type_ids_input').remove();
    },

    secondary_quality_element_change: function(quality_element_id) {
      this.remove_secondary_quality_element_related_fields();

      if( quality_element_id !== "") {
        this.add_secondary_quality_element_related_fields(quality_element_id);
      }
    },

    add_secondary_quality_element_related_fields: function(quality_element_id) {
      var form_handler = this;

      $.ajax({
        url: '/quality_elements/' + quality_element_id + '/service_type_inputs?type=secondary',
        dataType: 'html',
      })
        .done(function(html) {
          form_handler.form.find('#community_program_secondary_quality_element_attributes_quality_element_id_input').after(html);
        });
    },

    remove_secondary_quality_element_related_fields: function() {
      this.form.find('#community_program_secondary_quality_element_attributes_service_type_ids_input').remove();
    },

    organization_change: function(organization_id) {
      this.remove_organization_related_fields();

      if( organization_id !== "") {
        this.add_organization_related_fields(organization_id);
      }
    },

    add_organization_related_fields: function(organization_id) {
      var form_handler = this;

      $.ajax({
        url: '/organizations/' + organization_id + '/primary_contact_input',
        dataType: 'html',
      })
        .done(function(html) {
          form_handler.form.find('#org-user-wrapper').prepend(html);
          $('#add-org-user').show();
        });
    },

    remove_organization_related_fields: function() {
      this.form.find('#community_program_user_id_input').remove();
      $('#add-org-user').hide();
    },

    school_change: function(school_id) {
      this.remove_school_related_fields();

      if( school_id !== "") {
        this.add_school_related_fields(school_id);
      }
    },

    add_school_related_fields: function(school_id) {
      var form_handler = this;

      $.ajax({
        url: '/schools/' + school_id + '/primary_contact_input',
        dataType: 'html',
      })
        .done(function(html) {
          form_handler.form.find('#school-user-wrapper').prepend(html);
          $('#add-school-user').show();
        });
    },

    remove_school_related_fields: function() {
      this.form.find('#community_program_school_user_id_input').remove();
    },

    add_ajax_button_handler: function() {
      this.add_org_user_handler();
      this.add_school_user_handler();
    },

    add_org_user_handler: function() {
      var FormHandler = this,
          button = FormHandler.form.find('#add-org-user'),
          select = FormHandler.form.find('#community_program_user_id');

      $(button).on('click', function(e) {
        $.ajax({
          url: '/users/new',
          data: {role_id: 4},
          dataType: 'html'
        })
        .done(function(html) {
          $('.user-modal .modal-body').html(html);

          $('.user-modal').modal({
            escapeClose: false,
            clickClose: false,
            showClose: false
          });
        });
      });
    },

    add_school_user_handler: function() {
      var FormHandler = this,
          button = FormHandler.form.find('#add-school-user'),
          select = FormHandler.form.find('#community_program_school_id');

      $(button).on('click', function(e) {
        $.ajax({
          url: '/users/new',
          data: {role_id: 3, school_id: select.val()},
          dataType: 'html'
        })
        .done(function(html) {
          $('.user-modal .modal-body').html(html);

          $('.user-modal').modal({
            escapeClose: false,
            clickClose: false,
            showClose: false
          });
        });
      });
    }
  };

  return CommunityProgramFormHandler;
})();

