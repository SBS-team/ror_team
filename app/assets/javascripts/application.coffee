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
#= require turbolinks
#= require messages

$('.carousel').carousel()


$(document).ready(ready)
$(document).on('page:load', ready)


# $(document).on 'change', 'input[type=text]', ->
#  $('input[type=text]').unbind('change').change ->