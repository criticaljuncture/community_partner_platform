$(document).ready ->
  if $('form.school-selection').length > 0
    new CPP.SchoolSelector($('form.school-selection #school_name'))

class @CPP.SchoolSelector
  constructor: (@selectTag) ->
    @addListener()

  addListener: () ->
    @selectTag.change =>
      window.location.href = Routes.public_school_path(@selectTag.val())
