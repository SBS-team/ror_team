# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $.validator.addMethod "phone_tip", ((value) -> /()|(^\+\d{1,2})?((\(\d{3}\))|(\-?\d{3}\-)|(\d{3}))((\d{3}\-\d{4})|(\d{3}\-\d\d\-\d\d)|(\d{7})|(\d{3}\-\d\-\d{3}))/.test value),
    "You enter invalid phone. Fix it"     #reg_exp from http://skillcoding.com/Default.aspx?id=244

  $("#new_message").validate
    rules:
      "message[name]":
        required: true,
        maxlength: 100
      "message[email]":
        required: true,
        email: true
      "message[phone]":
        phone_tip: true,
        maxlength: 16                   #http://ru.wikipedia.org/wiki/E.164
      "message[work_type]":
        required: true

    messages:
      "message[phone]":
        maxlength: "Phone can`t have more then 16 characters (standard E.164)"
        phone_tip: "We mean, you enter invalid phone. Try another phone"