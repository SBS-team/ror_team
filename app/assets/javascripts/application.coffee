#= require jquery
#= require jquery_ujs
#= require bootstrap.min
#= require pusher
#= require underscore
#= require jobs
#= require contact
#= require jquery.validate
#= require additional-methods
#= require extra_validations
#= require messages

$(document).on 'page:fetch', ->
  $('body').fadeOut 'slow'
  $('body').css('cursor','progress')

$(document).on 'page:receive', ->
  $('body').fadeIn 'slow'
  $('body').css('cursor','default')

$('.carousel').carousel()

$(document).ready ->
  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe("admin")
  channel.bind "msg-event", (data) ->
    $("#chat-history").append "<div class=msg>" + data.message + "</div>"
    alert "An event was triggered with message: " + data.message
