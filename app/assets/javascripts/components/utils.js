$(document).ready(function() {
  $('.toggle').on('click', function(event) {
    event.preventDefault();

    var $link = $(this);

    $( $link.data('target') ).toggle();
  });
});
