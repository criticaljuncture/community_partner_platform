$(function () {
  /* add tab behavior */
  $('.nav.nav-tabs a').on('click', function (event) {
    event.preventDefault();
    $(this).tab('show');
  });

  $('.nav.nav-tabs li').on('click', function (event) {
    event.preventDefault();
    $(this).find('a').tab('show');
  });

  /* make the active tab/pane visible */
  var active_pane = $('.tab-content .tab-pane.active').attr('id')
  $('.nav.nav-tabs a').filter('[href=#'+active_pane+']').tab('show');

  /* allow for direct navigation to a particular tab on a page */
  var query_keys = $.parsequery(location.search).keys;
      active_tab = query_keys["active_tab"];
      
  if( active_tab ) {
    $('a[data-toggle="tab"][href="#' + active_tab + '"]').trigger('click')
  }

  /* remove error state when an input is changed */
  $('form.formtastic div.input.required.error').on('change', 'input, select', function() {
    var $this = $(this);

    if( $this.val() !== "" ) {
      $this.closest('div.input.required').removeClass('error');
    }
  });

});

$(document).ready(function() {
  setTimeout(function() {
    /* select first tab on page load */
    $('.nav.nav-tabs').find('a').first().tab('show');
  }, 25);
});
