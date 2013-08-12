#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require pusher
#= require underscore

$(document).ajaxSuccess (event, response, settings) ->
  $("#message").val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

$(document).ready ->

  # Pusher config for script *********************************
  Pusher.host = gon.pusher_config.host
  Pusher.sockjs_host = gon.pusher_config.host
  Pusher.ws_port = gon.pusher_config.port
  pusher = new Pusher(gon.pusher_config.key)
  #***********************************************************

  admin_main_channel = 'presence-' + gon.current_admin_channel

  # Massage send/receive Pusher event
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if $("#chat").length>0
      if data.is_admin
        msg_class = "<div class='msg-admin msg'>"
      else
        msg_class = "<div class='msg-user msg'>"
      msg_time = new Date(data.date * 1000)
      $("#chat").append msg_class+"(" + msg_time.toLocaleTimeString() + ") | <b><U>" + data.name + "</U></b> : " + $("<div/>").text(data.message).html() + "</div>"
      $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    else
      window.location.reload()