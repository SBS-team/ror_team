file = "<input id=\"resume_upload_file_attributes_filename\" type=\"file\" name=\"resume[upload_file_attributes][filename]\" >"

inputFileReset = ->
  patt1 = /\.[0-9a-z]+$/i
  filename = $("#resume_upload_file_attributes_filename").val().match(patt1)
  flag = false
  if filename == null
    filename = "Your file is not DOC or PDF types !<br>"
    flag = false
  if filename.toString().toLowerCase() == ".doc" || filename.toString().toLowerCase() == ".pdf"
    flag = true
    filename = ""
  else
    filename = "Your file is not DOC or PDF types !<br>"
    flag = false
  if $("#resume_upload_file_attributes_filename")[0].files[0].size > 5*1000*1000
    filename += "You cannot upload file greater than 5 Mb<br>size of your file is: #{Math.round($("#resume_upload_file_attributes_filename")[0].files[0].size / 1000000) } Mb"
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
  $(document).bind 'change', '#resume_upload_file_attributes_filename', ->
    inputFileReset()