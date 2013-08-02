file = "<input id=\"resume_upload_file_attributes_filename\" type=\"file\" name=\"resume[upload_file_attributes][filename]\" >"

inputFileReset = ->
  filename = $("#resume_upload_file_attributes_filename").val().split("/").pop().split("\\").pop().split(".").pop().toLowerCase()
  flag = false
  if filename.toString() == "doc" || filename.toString() == "pdf"
    flag = true
  else
    filename = 'Your file not DOC or PDF types\n'
    flag = false
  if $("#resume_upload_file_attributes_filename")[0].files[0].size > 5*1000*1000
    filename += "You cannot upload a file greater than 5 Mb\n size your file is a: #{$("#resume_upload_file_attributes_filename")[0].files[0].size / 1000000 } Mb\n"
    flag = false
  if flag
    return true
  else
    $("#resume_upload_file_attributes_filename").replaceWith file
    alert filename
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
        email_tip: true,
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