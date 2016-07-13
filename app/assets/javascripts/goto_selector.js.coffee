$(document).ready ->
  goto_forms = $('form.goto-selection')
  if goto_forms.length > 0
    goto_forms.each (index, element) ->
      new CPP.GotoSelector($(element))

class @CPP.GotoSelector
  constructor: (@form) ->
    @addListener()

  addListener: () ->
    @_selectTag().change =>
      window.location.href = Routes[@_namedRoute()](@_selectTag().val())

  _selectTag: () ->
    @form.find('select')

  _namedRoute: () ->
    @form.data('named-route')
