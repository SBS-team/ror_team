$(document).ready ->

  $(".send-email").click ->
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

  $("#submit").click ->
    $("#new_live_chat").validate
      rules:
        "message":
          required: true
        "live_chat[guest_name]":
          required: true