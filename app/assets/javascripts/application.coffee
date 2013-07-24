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

ready = ->
  $('.carousel').carousel()

$(document).ready(ready)