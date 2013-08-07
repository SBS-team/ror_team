$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()


$(document).ready ->
  Pusher.host = gon.pusher_config.host
  Pusher.sockjs_host = gon.pusher_config.sockjs_host
  Pusher.ws_port = gon.pusher_config.ws_port
  admin_main_channel = 'presence-' + gon.current_admin_channel

  pusher = new Pusher("#{gon.pusher_config.key}")
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