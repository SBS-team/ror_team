$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

# Get/Set div(#live_chat) position
getLiveChatPosition = ->
  $("#live_chat").offset
    top: $.cookie 'position_top'
    left: $.cookie 'position_left'
setLiveChatPosition = ->
  position = $("#live_chat").offset()
  $.cookie 'position_left', position.left, { path: '/' }
  $.cookie 'position_top', position.top, { path: '/' }
resetLiveChatPosition = ->
  $.cookie 'position_left', 0, { path: '/' }
  $.cookie 'position_top', 0, { path: '/' }
  $.cookie 'hide_win', 0, { path: '/' }

startLiveChat = ->
  if ($.cookie 'position_left') == undefined
    setLiveChatPosition()
  else
    if ($.cookie 'position_left') == '0'
      setLiveChatPosition()

$(document).ready ->

  # Show div(#live_chat) on all pages if user to start chat
  if gon.show_chat
    if ($.cookie 'hide_win') == '1'
      $('#live_chat').show()
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    getLiveChatPosition()

  $("#live_chat").draggable
    handle: "#chat_handle",
    containment: "parent"

  # Set div(#live_chat) position into cookie
  $('#chat_handle').mouseup ->
    if gon.show_chat
      setLiveChatPosition()

  # Start live chat
  $('#new_chat_submit').click ->
    startLiveChat()

  # Show/Hide div(#live_chat)
  $('#chat_hide').click ->
    $("#live_chat").effect "transfer",
      to: $("#chat_start"),
      600
    $('#live_chat').hide()
    $.cookie 'hide_win', 0, { path: '/' }

  $('#chat_start').click ->
    $('#live_chat').show()
    $("#chat_start").effect "transfer",
      to: $("#live_chat")
      , 600
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    $.cookie 'hide_win', 1, { path: '/' }

  # Close chat & reset cookies
  $('#chat_close').click ->
    $.post "/chat_close"
    $('#live_chat').hide "blind", 600, ->
      resetLiveChatPosition()
      pusher.disconnect()
      location.reload()

  # Create Pusher channel name
  if $("#live_chat_admin_id").length
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')
  else
    admin_main_channel = 'presence-' + gon.current_admin_channel

  # Pusher config for script *********************************
  Pusher.host = gon.pusher_config.host
  Pusher.sockjs_host = gon.pusher_config.sockjs_host
  Pusher.ws_port = gon.pusher_config.ws_port
  pusher = new Pusher("#{gon.pusher_config.key}")
  #***********************************************************

  # Massage send/receive Pusher event
  channel = pusher.subscribe(admin_main_channel)
  channel.bind "msg-event", (data) ->
    if data.is_admin
      msg_class = "<div class='msg-admin msg'>"
    else
      msg_class = "<div class='msg-user msg'>"
    msg_time = new Date(data.date * 1000)
    $("#chat").append msg_class+"(" + msg_time.toLocaleTimeString() + ") | <b><U>" + data.name + "</U></b> : " + $("<div/>").text(data.message).html() + "</div>"
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()