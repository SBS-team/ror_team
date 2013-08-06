
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
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')
  else
    admin_main_channel = 'presence-' + gon.current_admin_channel

  Pusher.host = '127.0.0.1'
  Pusher.sockjs_host = '127.0.0.1'
  Pusher.ws_port = 3004
  pusher = new Pusher("765ec374ae0a69f4ce44")
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if data.is_admin
      msg_class = "<div class='msg-admin msg'>"
    else
      msg_class = "<div class='msg-user msg'>"
    $("#chat").append msg_class+"(" + data.date + ") | <b><U>" + data.name + "</U></b> : " + $("<div/>").text(data.message).html()+ "</div>"
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()