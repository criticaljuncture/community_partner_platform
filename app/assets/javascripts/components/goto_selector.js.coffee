class @CPP.GotoSelector
  constructor: (@form) ->
    @addListener()

  addListener: ->
    @_selectTag().change =>
      window.location.href = Routes[@_namedRoute()](@_selectTag().val())

  _selectTag: ->
    @form.find('select')

  _namedRoute: ->
    @form.data('named-route')
