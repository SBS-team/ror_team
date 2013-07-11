root = exports ? this
root.addField = () ->
  if maxFieldLimit is 0
    div = document.createElement("div")
    div.innerHTML = "<input name=\"resume[upload_files_attributes][filename]\" type=\"file\" id=\"fileinput\"> <a onclick=\"return deleteField(this)\" href=\"#\">[X]</a> <br> <input name=\"resume[upload_files_attributes][id]\" type=\"hidden\" />"
    document.getElementById("file").appendChild div
    maxFieldLimit++
  else
    alert "You can only finish one file"
  false

root.deleteField = (a) ->

  # Получаем доступ к ДИВу, содержащему поле
  contDiv = a.parentNode

  # Удаляем этот ДИВ из DOM-дерева
  contDiv.parentNode.removeChild contDiv

  # Уменьшаем значение текущего числа полей
  maxFieldLimit--

  # Возвращаем false, чтобы не было перехода по сслыке
  false
maxFieldLimit = 0

$(document).ready ->
  $("#new_resume").validate
    rules:
      "resume[email]":
        required: true,
        email_tip: true,
        email: true
      "resume[name]":
        required: true,
        maxlength: 40,
        minlength: 2
      "resume[description]":
        required:
          depends: ->
            $.isEmptyObject $("[name='resume[upload_files_attributes][filename]']").val()
        maxlength: 40
        minlength: 2
      "resume[phone]":
        maxlength: 31                   #http://ru.wikipedia.org/wiki/E.164  ::  15 digits, 1 plus, and <= 15 delimiters "()-"
        phone_validation_allow_empty_number: true
