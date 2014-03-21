$(document).ready(function() {
  if( $('form.verify-programs').length > 0 ) {
    $('select#schools').on('change', function(e) {
      var $select = $(this),
          $option_el = $select.find('option:selected');

      $option_el.prop('disabled', true);

      $('.school-programs-list').prepend(
        $(  Handlebars.compile(
              $('#template-school-program-verification-input').html()
            )({
              name: $option_el.text(),
              id: $option_el.val()
             })
         )
      );

      $select.val('');
    });
  }
});
