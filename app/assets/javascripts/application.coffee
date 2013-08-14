#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require bootstrap.min
#= require pusher
#= require underscore
#= require jquery.validate
#= require additional-methods
#= require jquery.tagcanvas
#= require jquery-cookie
#= require jobs
#= require live_chats
#= require comments
#= require contact
#= require lib/webs
#= require chat/chat

$(document).ready ->
  $('.carousel').carousel()

  $("#myCanvas").tagcanvas(
    textColour: "#008DF0"
    outlineColour: "#008DF0"
    weight: true
    outlineThickness: 1
    zoom: 1
    maxSpeed: 0.04
    depth: 0.75
    textHeight: 14
  , "tagcloud")
