$(document).ready ->

  $(".send-email").click ->
    $("#new_message").validate
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

  $("#new_chat_submit").click ->
    $("#new_live_chat").validate
      rules:
        "live_chat[guest_name]":
          required: true,
          maxlength: 150,
          minlength: 2
        "message":
          required: true,
          maxlength: 2048,
          minlength: 2