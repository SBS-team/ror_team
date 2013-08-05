$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

$(document).ready ->
  if $("#live_chat_admin_id").length
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')
  else
    admin_main_channel = 'presence-' + gon.current_admin_channel

  Pusher.host    = '192.168.137.1'
  Pusher.ws_host    = '192.168.137.1'
  Pusher.ws_port = 3004
  Pusher.wss_port = 3004
  pusher = new Pusher("c46c644b78f84661ace01b35dffceabc")
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if data.is_admin
      msg_class = "<div class='msg-admin msg'>"
    else
      msg_class = "<div class='msg-user msg'>"
    $("#chat").append msg_class+"(" + data.date + ") | <b><U>" + data.name + "</U></b> : " + $("<div/>").text(data.message).html() + "</div>"
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()