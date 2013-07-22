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
#= require turbolinks

$(document).on 'page:fetch', ->
  $('body').fadeOut 'slow'
  $('body').css('cursor','progress')

$(document).on 'page:receive', ->
  $('body').fadeIn 'slow'
  $('body').css('cursor','default')

ready = ->
  $('.carousel').carousel()

$(document).ready(ready)
$(document).on('page:load', ready)
