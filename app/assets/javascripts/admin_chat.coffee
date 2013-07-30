
$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()


$(document).ready ->
  admin_main_channel = 'presence-' + gon.current_admin_email

  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if $("#chat").length>0
      $("#chat").append "<div class='msg-admin msg'>"+"(" + data.date + ")|<b><U>" + data.email + "</U></b>: " + data.message + "</div>"
      $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    else
      window.location.reload true

  channel.bind 'pusher:member_removed', (member) ->
    if channel.members.me != member
      $.post '/admin_chat/close',
        admin_email: gon.current_admin_email
      window.location.reload true
      alert "User go out"