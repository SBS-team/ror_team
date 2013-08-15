#= require jquery
#= require jquery_ujs
#= require jquery.validate
#= require bootstrap.min
#= require pusher
#= require underscore
#= require lib/webs
#= require chat/chat

$(document).ajaxComplete (event, response, settings) ->
  $('.chat-send-msg-btn').enable()

$(document).ajaxSuccess (event, response, settings) ->
  $("#message").val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

$(document).ready ->

  $('.chat-send-msg-btn').click ->
    $("#new_live_chat").validate
      rules:
        "message":
          required: true,
          maxlength: 2048,
          minlength: 2

  admin_main_channel = 'presence-' + RorTeam.currentAdminChannel
  chat = new Chat(admin_main_channel)

