function global_var(var_name) {
  return window['GLOBAL_' + var_name];
}

function open_modal(var_name) {
  return global_var(var_name) !== false;
}

$(document).ready(function() {
  if( $('.instruction-modal').length > 0 && open_modal('open_verification_modal') ) {
    $('.instruction-modal').modal({
      escapeClose: false,
      clickClose: false,
      showClose: false
    });

    $.modal.resize();
  }
});
