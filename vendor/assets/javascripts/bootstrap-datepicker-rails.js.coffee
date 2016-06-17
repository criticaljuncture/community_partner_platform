$(document).ready ()->
  # convert bootstrap-datepicker value to rails date format
  # (yyyy-mm-dd) on our hidden field
  $(document).on 'changeDate', '.bootstrap-datepicker', (evt) ->

    # ensure that the date isn't less than 100
    # supports users entering 10/12/15 as a US date
    # meaning 2015 not 0015
    # this works for this application (but not all)
    year = evt.date.getFullYear()

    if year < 100
      year += 2000

    rails_date = year + '-' +
      ('0' + (evt.date.getMonth() + 1)).slice(-2) + '-' +
      ('0' + evt.date.getDate()).slice(-2)

    $(this)
      .closest('.input-group')
      .next("input[type=hidden]")
      .val(rails_date)
