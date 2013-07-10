# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $("#new_message").validate
    rules:
      "message[name]":
        required: true,
        maxlength: 100
      "message[email]":
        required: true,
        email: true
      "message[phone]":
        maxlength: 16                   #http://ru.wikipedia.org/wiki/E.164
      "message[work_type]":
        required: true

    messages:
      "message[phone]":
        maxlength: "Phone can`t have more then 16 characters (standard E.164)"