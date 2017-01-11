# If the MODAL variable exists we check to see if we should be
# setting a cookie.
# If we shouldn't be setting a cookie we ensure that any old
# cookie is removed and we show the modal.
# If we should be setting a cookie we check to see if a cookie
# already exists; if it doesn't we show the modal and set the
# cookie.

$(document).ready ->

  if window['MODAL']?
    if ! window['MODAL'].setCookie
      $.removeCookie window['MODAL'].modalTarget
      $(window['MODAL'].modalTarget).modal()
    else if ! $.cookie(window['MODAL'].modalTarget)?
      $(window['MODAL'].modalTarget).modal()

      if window['MODAL'].setCookie
        $.cookie window['MODAL'].modalTarget, 'shown', {path: '/'}

  $('body').on 'click', '.modal-link', (e)->
    e.preventDefault()

    $( $(this).attr('href') ).modal()
