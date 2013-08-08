# Pusher config for script *********************************
Pusher.host = '127.0.0.1'
Pusher.sockjs_host = '127.0.0.1'
Pusher.ws_port = 3004
pusher = new Pusher("c46c644b78f84661ace01b35dffceabc")
#***********************************************************

$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

  # Set div(#live_chat) position & reload window only first submit
  if ($.cookie 'position_left').toString() == 'null'
    position = $("#live_chat").offset()
    $.cookie 'position_left', position.left
    $.cookie 'position_top', position.top
    window.location.reload()

$(document).ready ->

  # Show div(#live_chat) on all pages if user to start chat
  if gon.show_chat
    $('#live_chat').css('display', 'block')
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    $("#live_chat").offset
      top: $.cookie 'position_top'
      left: $.cookie 'position_left'

  $("#live_chat").draggable
    handle: "#chat_handle",
    containment: "parent"

  # Set div(#live_chat) position into cookie
  $('#chat_handle').mouseup ->
    if gon.show_chat
      position = $("#live_chat").offset()
      $.cookie 'position_left', position.left
      $.cookie 'position_top', position.top

  # Show/Hide div(#live_chat)
  $('#chat_hide').click ->
    $('#live_chat').hide "blind", 600
  $('#chat_start').click ->
    $('#live_chat').show "blind", 600, ->
      $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

  # Close chat & reset cookies
  $('#chat_close').click ->
    $.post "/chat_close"
    $('#live_chat').hide "blind", 600, ->
      $.cookie 'position_left', null
      $.cookie 'position_top', null
      pusher.disconnect()
      window.location.reload()

  # Create Pusher channel name
  if $("#live_chat_admin_id").length
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')
  else
    admin_main_channel = 'presence-' + gon.current_admin_channel

  # Massage send/receive Pusher event
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if data.is_admin
      msg_class = "<div class='msg-admin msg'>"
    else
      msg_class = "<div class='msg-user msg'>"
    $("#chat").append msg_class+"(" + data.date + ") | <b><U>" + data.name + "</U></b> : " + $("<div/>").text(data.message).html() + "</div>"
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()