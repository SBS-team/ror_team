addField = ->
  if maxFieldLimit is 0
    div = document.createElement("div")
    div.innerHTML = "<input name=\"resume[upload_files_attributes][filename]\" type=\"file\" id=\"fileinput\"> <a onclick=\"return deleteField(this)\" href=\"#\">[X]</a> <br> <input name=\"resume[upload_files_attributes][id]\" type=\"hidden\" />"
    document.getElementById("file").appendChild div
    maxFieldLimit++
  else
    alert "NoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
  false
deleteField = (a) ->

  # Получаем доступ к ДИВу, содержащему поле
  contDiv = a.parentNode

  # Удаляем этот ДИВ из DOM-дерева
  contDiv.parentNode.removeChild contDiv

  # Уменьшаем значение текущего числа полей
  maxFieldLimit--

  # Возвращаем false, чтобы не было перехода по сслыке
  false
maxFieldLimit = 0
div = undefined