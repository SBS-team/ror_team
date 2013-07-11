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
        maxlength: 31                   #http://ru.wikipedia.org/wiki/E.164  ::  15 digits, 1 plus, and <= 15 delimiters "()-"
        phone_validation_allow_empty_number: true
      "message[work_type]":
        required: true
      "message[service_type]":
        required: true

    messages:
      "message[phone]":
        maxlength: "Phone can`t have more then 16 digits and less then 15 delimiters (standard E.164)"

    errorPlacement: (error, element) ->
      error.insertBefore $("div[class=icons]")  if element.attr("name") is "message[service_type]"
      error.insertBefore $("div[class=choose]")  if element.attr("name") is "message[work_type]"
      error.insertAfter $("input[id=message_email]")  if element.attr("name") is "message[email]"
      error.insertAfter $("input[id=message_phone]")  if element.attr("name") is "message[phone]"
      error.insertAfter $("input[id=message_name]")  if element.attr("name") is "message[name]"
