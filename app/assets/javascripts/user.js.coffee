$(document).ready ->
  userForm = $('form.user')
  if userForm.length > 0
    new CPP.UserFormHandler(userForm)
