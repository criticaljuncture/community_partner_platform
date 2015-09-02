class @CJ.Toggle
  constructor: (el, callback)->
    @el = $(el)
    @callback = callback

    @trigger = @el.data('toggle-trigger') || 'click'
    @triggerEl = @el.data('toggle-trigger-el') || null

    @addTriggerEvent()

  addTriggerEvent: ->
    @el.on @trigger, @triggerEl, (evt)=>
      evt.preventDefault()

      @getToggleTarget()
      @toggleToggleTarget()

      @updateElClass()
      @updateElText()

      @callCallback()

  # Allow scoping of the toggle target rather than just any with a class.
  # This allows multiple generic toggles on a page (from a loop for example).
  # toggle-target-scope is in the form [method, arguments], for example:
  # data-toggle-target-scope=['closest', '.my-wrapper']
  getToggleTarget: ->
    if @el.data 'toggle-target-scope'
      @toggleTarget = @el[@el.data('toggle-target-scope')[0]](@el.data('toggle-target-scope')[1])
        .find(@el.data('toggle-target'))
    else
      @toggleTarget = $(@el.data 'toggle-target')

  # Remove a class of hidden if one existed. Bootstrap's .hidden class is
  # quite aggressive and difficult to override. CJ.Toggle is now handling the
  # visibility so no longer needed (hidden is often desirable on page load)
  toggleToggleTarget: ->
    @toggleTarget.toggle().removeClass('hidden')

  # Update classes on the root el that represent the state of the toggle target.
  # This is useful for show/hiding icons that represent the toggle state, etc.
  updateElClass: ->
    if @toggleTarget.is(':visible')
      @el.removeClass('closed').addClass('open')
    else
      @el.removeClass('open').addClass('closed')

  # Often we want to change the text on an element when we show/hide something.
  # Unless the user opts out of this we toggle the text based on the state of the
  # toggle target.
  # We use the root el by default, but he user can also specify the text target.
  updateElText: ->
    if (!@el.data 'toggle-skip-text')
      @textTarget = $(@el.data 'toggle-text-node') || @el
      if @toggleTarget.is(':visible')
        @textTarget.text @el.data('toggle-hide-text') || 'hide'
      else
        @textTarget.text @el.data('toggle-show-text') || 'show'

  # When creating an instance of the toggle the user can pass a callback that
  # should be execute each time the toggle is triggered. This callback will be
  # called with the el that the toggle was created with (the root el).
  callCallback: ->
    if @callback
      @callback.call(@el)

$(document).ready ->
  _.each $('.toggle'), (el)->
    new CJ.Toggle(el)
