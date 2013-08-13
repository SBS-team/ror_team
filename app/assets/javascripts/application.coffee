#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require pusher
#= require underscore
#= require jquery.validate
#= require extra_validations
#= require jobs
#= require jquery-ui
#= require live_chats
#= require load_comments
#= require jquery-cookie
#= require contact
#= require jquery.tagcanvas

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