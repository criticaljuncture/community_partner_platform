$(document).ready(function() {
  if( $('.instruction-modal').length > 0 ) {
    $('.instruction-modal').modal({
      escapeClose: false,
      clickClose: false,
      showClose: false
    });

    $.modal.resize();
  }
});
