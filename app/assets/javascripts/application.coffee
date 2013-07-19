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
  $('.container').fadeOut 'slow'

$(document).on 'page:restore', ->
  $('.container').fadeIn 'slow'

$('.carousel').carousel()
