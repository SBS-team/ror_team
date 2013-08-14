$(document).ajaxComplete (event, response, settings) ->
  $("#message").val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

newLiveChat = false

chat = null
admin_main_channel = null

$(document).ajaxSuccess (event, response, settings) ->
  if newLiveChat
    chat = new Chat(admin_main_channel)
    startLiveChat()
    newLiveChat = false

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

startLiveChat = ->

  $('#live_chat').show()
  getLiveChatPosition()
  $.cookie 'hide_win', 1, { path: '/' }

  # Get nickname from cookie
  if ($.cookie 'nickname')
    $("#live_chat_guest_name").val($.cookie 'nickname')

  # Validation for creating LiveChat
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

  $("#live_chat").draggable
    handle: "#chat_handle",
    containment: "parent"

  unless $("#live_chat_admin_id")
    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')
  else
    admin_main_channel = 'presence-' + RorTeam.currentAdminChannel

$(document).ready ->

  if ($.cookie 'nickname')
    $("#live_chat_guest_name").val($.cookie 'nickname')

#*************************************** Action header menu button: "Live Chat"
  # Start new LiveChat
  $(document).on "click", "#chat_start", ->
    $.post "/new_chat", ->
      chageButton = $("#chat_start")[0]
      chageButton.id = 'chat_show'
      $("#chat_start").replaceWith chageButton
      startLiveChat()

  # Show current LiveChat
  $(document).on "click", "#chat_show", ->
    $('#live_chat').show()
    getLiveChatPosition()
    false
#*************************************** Action LiveChat menu button
  # Close current LiveChat
  $(document).on "click", "#chat_close", ->
    $.post "/chat_close"
    $('#live_chat').hide "blind", 600, ->
      resetLiveChatPosition()
      $('#live_chat').remove()
      chageButton = $("#chat_show")[0]
      chageButton.id = 'chat_start'
      $("#chat_show").replaceWith chageButton

  $(document).on "click", "#contact_chat_close", ->
    $.post "/contact_chat_close"

  # Hide LiveChat div
  $(document).on "click", "#chat_hide", ->
    $("#live_chat").effect "transfer",
        to: $("#chat_show"),
        600
      $('#live_chat').hide()
      $.cookie 'hide_win', 0, { path: '/' }


  $(document).on "click", "#new_chat_submit", ->
    unless ($.cookie 'nickname')
      $.cookie 'nickname', $("#live_chat_guest_name").val(),{ expires: 30 , path: '/'  }
    else
      if ($.cookie 'nickname').toString() != $("#live_chat_guest_name").val()
        $.cookie 'nickname', $("#live_chat_guest_name").val(),{ expires: 30 , path: '/'  }

    admin_main_channel = 'presence-' + $("#live_chat_admin_id :selected").text().replace(' ', '-')

    newLiveChat = true

#*************************************** LiveChat draggable and position
  $("#live_chat").draggable
    handle: "#chat_handle",
    containment: "parent"

  # Set current position
  $(document).on "mouseup", "#chat_handle", ->
    setLiveChatPosition()

  if ($.cookie 'hide_win') == '1'
    $('#live_chat').show()
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    getLiveChatPosition()
#*************************************** Create Pusher channel name

  admin_main_channel = 'presence-' + RorTeam.currentAdminChannel

  chat = new Chat(admin_main_channel)
