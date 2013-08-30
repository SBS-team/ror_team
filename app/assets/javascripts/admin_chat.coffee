#= require jquery
#= require jquery_ujs
#= require jquery.validate
#= require bootstrap.min
#= require pusher
#= require underscore
#= require lib/webs
#= require chat/chat

$(document).ajaxComplete (event, response, settings) ->
  $("#message").val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

window.managerGoOffline = ->
  $.post '/admin_chat/go_offline'
  window.setTimeout('window.close()', 300);

$(document).ready ->

  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
  $("#new_live_chat").validate
    rules:
      "message":
        required: true,
        maxlength: 255,
        minlength: 2

  admin_main_channel = 'presence-' + RorTeam.currentAdminChannel
  chat = new Chat(admin_main_channel)

