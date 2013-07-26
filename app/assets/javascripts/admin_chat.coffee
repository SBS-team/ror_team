# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()


$(document).ready ->

  inp = $("#current_admin_email")
  txt = inp.val()

  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe(txt)
  channel.bind "msg-event", (data) ->
    window.location.reload true
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()