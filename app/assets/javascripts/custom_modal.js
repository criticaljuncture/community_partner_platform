/* we use a custom modal handler but still want to play nice
 * with the bootstrap modal defaults */
$(document).ready(function() {
  $('.modal').on('click', 'button[data-dismiss="modal"]', function(e) {
    $.modal.close();
  });


  $('body').on('click', 'a[data-toggle="modal"]', function(e) {
    $( $(this).data('target') ).modal( $(this).data('options') );
  });

});
