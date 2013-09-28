var CommunityPartnerFormHandler = (function() {
  var CommunityPartnerFormHandler = function() {
    this.form = null;
  };

  CommunityPartnerFormHandler.prototype = {
    initialize: function(form) {
      this.form = form;

      this.add_change_handler();
      this.ensure_form_consistency();
    },

    ensure_form_consistency: function() {
      if( this.form.find('#community_partner_primary_quality_element_attributes_quality_element_id').val() === "" ) {
        this.form.find('#community_partner_primary_quality_element_attributes_quality_element_id').trigger('change');
      }
      if( this.form.find('#community_partner_secondary_quality_element_attributes_quality_element_id').val() === "" ) {
        this.form.find('#community_partner_secondary_quality_element_attributes_quality_element_id').trigger('change');
      }
      
      if( this.form.find('#community_partner_organization_id').val() === "" ) {
        this.form.find('#community_partner_organization_id').trigger('change');
      }

      if( this.form.find('#community_partner_school_id').val() === "" ) {
        this.form.find('#community_partner_school_id').trigger('change');
      }
    },

    add_change_handler: function() {
      var form_handler = this;

      /* quality element change */
      form_handler.form.find('#community_partner_primary_quality_element_attributes_quality_element_id').on('change', function() {
        form_handler.primary_quality_element_change( $(this).val() );
      });
      form_handler.form.find('#community_partner_secondary_quality_element_attributes_quality_element_id').on('change', function() {
        form_handler.secondary_quality_element_change( $(this).val() );
      });


      /* organization change */
      form_handler.form.find('#community_partner_organization_id').on('change', function() {
        form_handler.organization_change( $(this).val() );
      });

      /* school change */
      form_handler.form.find('#community_partner_school_id').on('change', function() {
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
          form_handler.form.find('#community_partner_primary_quality_element_attributes_quality_element_id_input').after(html);
        });
    },

    remove_primary_quality_element_related_fields: function() {
      this.form.find('#community_partner_primary_quality_element_attributes_service_type_ids_input').remove();
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
          form_handler.form.find('#community_partner_secondary_quality_element_attributes_quality_element_id_input').after(html);
        });
    },

    remove_secondary_quality_element_related_fields: function() {
      this.form.find('#community_partner_secondary_quality_element_attributes_service_type_ids_input').remove();
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
          form_handler.form.find('#community_partner_organization_id_input').after(html);
        });
    },

    remove_organization_related_fields: function() {
      this.form.find('#community_partner_user_id_input').remove();
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
          form_handler.form.find('#community_partner_school_id_input').after(html);
        });
    },

    remove_school_related_fields: function() {
      this.form.find('#community_partner_school_user_id_input').remove();
    }
  };

  return CommunityPartnerFormHandler;
})();

