_file = false

file_input = ->
  if _file
    $('#file_upload_input').remove()
    $('#linkfile').text('add File')
    _file = false
  else
    div = "<div id=\"file_upload_input\"><input name=\"resume[upload_file_attributes][filename]\" type=\"file\" id=\"fileinput\"></div>"
    $('#file').append(div)
    _file = true
    $('#linkfile').text('delete File')

$(document).ready ->
  $('#linkfile').click ->
    file_input()
  $("#new_resume").validate
    rules:
      "resume[email]":
        required: true,
        email_tip: true,
        email: true
      "resume[name]":
        required: true,
        maxlength: 30,
        minlength: 2
      "resume[phone]":
        digits: true,
        maxlength: 31 #http://ru.wikipedia.org/wiki/E.164  ::  15 digits, 1 plus, and <= 15 delimiters "()-"