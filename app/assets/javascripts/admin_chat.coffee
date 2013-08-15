#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require pusher
#= require underscore
#= require lib/webs
#= require chat/chat

$(document).ajaxSuccess (event, response, settings) ->
  $("#message").val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

$(document).ready ->

  admin_main_channel = 'presence-' + RorTeam.currentAdminChannel
  chat = new Chat(admin_main_channel)