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
    if ($.cookie 'hide_win').toString() == '1'
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
    $("#live_chat").effect "transfer",
      to: $("#chat_start"),
      600
    $('#live_chat').hide()
    $.cookie 'hide_win', 0


  $('#chat_start').click ->
    $('#live_chat').show()
    $("#chat_start").effect "transfer",
      to: $("#live_chat")
      , 600
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    $.cookie 'hide_win', 1

  # Close chat & reset cookies
  $('#chat_close').click ->
    $.post "/chat_close"
    $('#live_chat').hide "blind", 600, ->
      $.cookie 'position_left', null
      $.cookie 'position_top', null
      $.cookie 'hide_win', null
      pusher.disconnect()
      window.location.reload()

  # Create Pusher channel name
  if $("#live_chat_admin_id").length
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')
  else
    admin_main_channel = 'presence-' + gon.current_admin_channel

  # Pusher config for script *********************************
  Pusher.host = gon.pusher_config.host
  Pusher.sockjs_host = gon.pusher_config.host
  Pusher.ws_port = gon.pusher_config.port
  pusher = new Pusher(gon.pusher_config.key)
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
    alert "6"