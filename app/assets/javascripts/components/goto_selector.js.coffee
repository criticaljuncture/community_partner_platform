class @CPP.GotoSelector
  constructor: (@form) ->
    @addListener()

  addListener: ->
    @_selectTag().change (event)=>
      window.location.href = Routes[@_namedRoute()](@_val()) + "##{@_anchor()}"

  _anchor: ->
    selectedOption = @_optionForSelectedVal(@_selectTag().val())

    if selectedOption.data('parent-id')
      selectedOption.val()

  _selectTag: ->
    @form.find('select')

  _namedRoute: ->
    @form.data('named-route')

  _val: ->
    selectedOption = @_optionForSelectedVal(@_selectTag().val())

    if selectedOption.data('parent-id')
      selectedOption.data('parent-id')
    else
      @_selectTag().val()

  _optionForSelectedVal: (val)->
    @_selectTag().find("option[value='#{val}']")
