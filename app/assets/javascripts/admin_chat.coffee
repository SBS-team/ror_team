$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()


$(document).ready ->
  Pusher.host    = '192.168.137.1'
  Pusher.ws_host    = '192.168.137.1'
  Pusher.ws_port = 3004
  Pusher.wss_port = 3004
  admin_main_channel = 'presence-' + gon.current_admin_channel

  pusher = new Pusher("c46c644b78f84661ace01b35dffceabc")
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if $("#chat").length>0
      if data.is_admin
        msg_class = "<div class='msg-admin msg'>"
      else
        msg_class = "<div class='msg-user msg'>"
      $("#chat").append msg_class+"(" + data.date + ") | <b><U>" + data.name + "</U></b> : " + $("<div/>").text(data.message).html() + "</div>"
      $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    else
      window.location.reload true
###
  channel.bind 'pusher:member_removed', (member) ->
    if channel.members.me != member
      $.post '/admin_chat/close',
        admin_email: gon.current_admin_email
      window.location.reload true
      alert "User go out"
###