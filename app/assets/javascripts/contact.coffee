# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("form").validate
    rules:
      "message[name]":
        required: true,
        maxlength: 30,
        minlength: 2
      "message[email]":
        required: true,
        email: true
      "message[phone]":
        digits: true,
        maxlength: 31