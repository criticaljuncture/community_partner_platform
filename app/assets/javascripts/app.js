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
});
