#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require pusher
#= require underscore
#= require jquery.validate
#= require extra_validations
#= require jobs
#= require jquery-ui


$(document).ready ->
  $('.carousel').carousel()
  $("#chat").draggable
    handle: "#chat_handle",
    containment: "parent"
  $('#chat_hide').click ->
    $('#chat').hide "blind", 1000