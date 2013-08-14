$(document).ajaxComplete (event, response, settings) ->
  $("#message").val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

# Get/Set div(#live_chat) position
getLiveChatPosition = ->
  if ($.cookie 'position_left') == '0' || ($.cookie 'position_top') == '0'
    $("#live_chat").css 'top', '80px'
    $("#live_chat").css 'right', '10px'
  else
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

$(document).ready ->

  if ($.cookie 'nickname')
    $("#live_chat_guest_name").val($.cookie 'nickname')

  # Show div(#live_chat) on all pages if user to start chat
  if ($.cookie 'hide_win') == '1'
    $('#live_chat').show()
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    getLiveChatPosition()

  $("#live_chat").draggable
    handle: "#chat_handle",
    containment: "parent"

  # Set div(#live_chat) position into cookie
  $('#chat_handle').mouseup ->
    if ($.cookie 'hide_win') == '1'
      setLiveChatPosition()

  # Show/Hide div(#live_chat)
  $('#chat_hide').click ->
    $("#live_chat").effect "transfer",
      to: $("#chat_show"),
      600
    $('#live_chat').hide()
    $.cookie 'hide_win', 0, { path: '/' }

  $('#chat_start').click ->
    $.cookie 'hide_win', 1, { path: '/' }
    $.post "/new_chat", ->
      location.reload()

  $('#new_chat_submit').click ->
    unless ($.cookie 'nickname')
      $.cookie 'nickname', $("#live_chat_guest_name").val(),{ expires: 30 , path: '/'  }
    else
      if ($.cookie 'nickname').toString() != $("#live_chat_guest_name").val()
        $.cookie 'nickname', $("#live_chat_guest_name").val(),{ expires: 30 , path: '/'  }

  $('#chat_show').click ->
    if ($.cookie 'hide_win') == '0' || ($.cookie 'hide_win') == undefined
      $('#live_chat').show()
      $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
      $.cookie 'hide_win', 1, { path: '/' }
      getLiveChatPosition()

  # Close chat
  $('#chat_close').click ->
    $.post "/chat_close"
    $('#live_chat').hide "blind", 600, ->
      resetLiveChatPosition()
      location.reload()

  # Create Pusher channel name
  unless $("#live_chat_admin_id")
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')
  else
    admin_main_channel = 'presence-' + RorTeam.currentAdminChannel

  chat = new Chat(admin_main_channel)

  $("#new_live_chat").validate
    rules:
      "live_chat[guest_name]":
        required: true,
        maxlength: 150,
        minlength: 2
      "message":
        required: true,
        maxlength: 2048,
        minlength: 2