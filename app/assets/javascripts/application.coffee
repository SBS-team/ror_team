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
#= require bootstrap-wysihtml5

$(document).ready ->
  $('.carousel').carousel()

  $('#post_description_input').each (i, elem) ->
    $(elem).wysihtml5()

