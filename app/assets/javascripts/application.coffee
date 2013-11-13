#= require jquery_new
#= require jquery-ui
#= require jquery_ujs
#= require jquery.localscroll-1.2.7-min
#= require jquery.modal
#= require jquery.mousewheel
#= require jquery.parallax-1.1.3
#= require jquery.scrollTo-1.4.2-min
#= require main
#= require skrollr
#= require pusher
#= require underscore
#= require jquery.validate
#= require additional-methods
#= require jquery-cookie
#= require lib/webs
#= require lib/timer
#= require chat/chat
#= require chat/win_chat

$(document).ready ->
  user_chat = new WinChat()