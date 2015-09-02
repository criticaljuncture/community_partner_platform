$(document).ready(function() {
  new UserFormHandler().initialize( $('.modal form.user') );

  $('form#new_user').on('submit', function(e) {
    e.preventDefault();

    var $form = $(this),
        $button = $form.find('button[type=submit]');

    $button.attr('disabled', true);

    // remove old flash messages
    $('div.alert').remove();

    $.ajax({
      url: $form.attr('action'),
      type: 'POST',
      dataType: 'json',
      data: $form.serialize()
    })
    .done(function(response) {
      var message = response.message,
          user = response.user;

      $('form.community_program').prepend(
        $(
          Handlebars.compile(
            $('#template-flash-message').html()
          )({
            type: 'success',
            message: message
          })
        )
      );

      if( user.role_id === 4 ) {
        var $select = $('#community_program_user_id');
      } else if ( user.role_id === 3 ) {
        var $select = $('#community_program_school_user_id');
      }

      $select.append(
        $('<option>').attr('value', user.id).text(user.name)
      );
      $select.val(user.id);

      $.modal.close()
    })
    .fail(function(xhr) {
      var message = xhr.responseJSON.message,
          errors = xhr.responseJSON.errors;

      $form.prepend(
        $(
          Handlebars.compile(
            $('#template-flash-message').html()
          )({
            type: 'error',
            message: message
          })
        )
      );
      $form.addClass('errors');

      _.each(errors, function(value, key) {
        var input = $form.find('input[name="user[' + key + ']"]')

        input.closest('.control-group').addClass('error');
        input.addClass('error');
        input.after(
          $('<span>').addClass('help-inline').html(value[0])
        );
      });

      $button.attr('disabled', false);
    });
  });
});
