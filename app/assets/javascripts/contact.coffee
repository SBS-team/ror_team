# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()


$(document).ready ->

  $(".send-email").click ->
    $("form").validate
      rules:
        "message[name]":
          required: true,
          maxlength: 30,
          minlength: 2
        "message[email]":
          required: true,
          email: true
        "message[phone]":
          digits: true,
          maxlength: 31

  $("#submit").click ->
    $("#new_live_chat").validate
      rules:
        "message":
          required: true
        "live_chat[guest_name]":
          required: true

  if $("#live_chat_admin_id").length
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text();
  else
    admin_main_channel = 'presence-' + gon.current_admin_email

  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if data.is_admin
      msg_class = "<div class='msg-admin msg'>"
    else
      msg_class = "<div class='msg-user msg'>"
    $("#chat").append msg_class+"(" + data.date + ")|<b><U>" + data.email + "</U></b>: " + data.message + "</div>"
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()