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

window.changeIcon = (newIconHref) ->
  $('#admin_chat_tab_icon').remove()
  link = document.createElement('link')
  link.type = "image/vnd.microsoft.icon"
  link.rel = 'shortcut icon'
  link.href = newIconHref
  link.id = 'admin_chat_tab_icon'
  document.getElementsByTagName('head')[0].appendChild(link)

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

