file = "<input id=\"resume_upload_file_attributes_filename\" type=\"file\" name=\"resume[upload_file_attributes][filename]\" >"

inputFileReset = ->
  patt1 = /\.[0-9a-z]+$/i
  filename = $("#resume_upload_file_attributes_filename").val().match(patt1)
  flag = false
  if filename == null
    filename = "Your file not DOC or PDF types !<br>"
    flag = false
  if filename.toString().toLowerCase() == ".doc" || filename.toString().toLowerCase() == ".pdf"
    flag = true
    filename = ""
  else
    filename = "Your file not DOC or PDF types !<br>"
    flag = false
  if $("#resume_upload_file_attributes_filename")[0].files[0].size > 5*1000*1000
    filename += "You cannot upload a file greater than 5 Mb<br>size your file is a: #{Math.round($("#resume_upload_file_attributes_filename")[0].files[0].size / 1000000) } Mb"
    flag = false
  if flag
    $("#filename_error").remove()
    return true
  else
    $("#resume_upload_file_attributes_filename").replaceWith file
    $("#filename_error").remove()

    $("#resume_upload_file_attributes_filename").after("<label id=\"filename_error\" class=\"error\" for=\"resume[upload_file_attributes][filename]\">" + filename + "</label>")

    $("#resume_upload_file_attributes_filename").bind "change", ->
      inputFileReset()
    return false

$(document).ready ->
  $("#resume_upload_file_attributes_filename").bind "change", ->
    inputFileReset()
  $("#new_resume").validate
    rules:
      "resume[email]":
        required: true,
        email: true
      "resume[name]":
        required: true,
        maxlength: 30,
        minlength: 4
      "resume[phone]":
        required: true,
        digits: true,
        maxlength: 31 #http://ru.wikipedia.org/wiki/E.164  ::  15 digits, 1 plus, and <= 15 delimiters "()-"
      "resume[description]":
        required: true,
        minlength: 2,
        maxlength: 3000
      "recaptcha_response_field":
        required: true

    messages:
      "recaptcha_response_field":
        required: "Captcha is required"

    errorPlacement: (error, element) ->
      if element.attr('name') == 'recaptcha_response_field'
        error.insertAfter('#recaptcha_area')
      else
        error.insertAfter(element)