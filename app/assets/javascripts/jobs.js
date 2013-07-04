  var maxFieldLimit = 0;
  var div
  function addField(){
      if  (maxFieldLimit == 0) {
          div = document.createElement("div");
          div.innerHTML = "<input name=\"resume[upload_files_attributes][filename]\" type=\"file\" /> <a onclick=\"return deleteField(this)\" href=\"#\">[X]</a> <br> <input name=\"resume[upload_files_attributes][id]\" type=\"hidden\" />";
          document.getElementById("file").appendChild(div);
          maxFieldLimit++;
      }else{
          alert('NoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO')
      }
      return false;
  }
  function deleteField(a) {
      // Получаем доступ к ДИВу, содержащему поле
      var contDiv = a.parentNode;
      // Удаляем этот ДИВ из DOM-дерева
      contDiv.parentNode.removeChild(contDiv);
      // Уменьшаем значение текущего числа полей
      maxFieldLimit--;
      // Возвращаем false, чтобы не было перехода по сслыке
      return false;
  }