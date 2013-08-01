file = "<input id=\"resume_upload_file_attributes_filename\" type=\"file\" name=\"resume[upload_file_attributes][filename]\">"

$(document).ready ->
  $("#resume_upload_file_attributes_filename").bind "change", ->
    if $("#resume_upload_file_attributes_filename")[0].files[0].size > 5*1000*1000
      alert "You cannot upload a file greater than 5 Mb\n size your file is a: #{$("#resume_upload_file_attributes_filename")[0].files[0].size / 1000000 } Mb"
      $("#resume_upload_file_attributes_filename").replaceWith file
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