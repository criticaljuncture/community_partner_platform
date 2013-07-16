function add_tipsy(selector, options) {
  $(selector).tipsy(options);
}

$(document).ready(function() {
  add_tipsy('.tip_under', {gravity: 'n'});
});
