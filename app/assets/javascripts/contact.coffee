$(document).ready ->

  $("textarea#message").keypress ->
    unless $('#recaptcha-contact-chat #recaptcha').length>0
      $('#recaptcha-contact-chat').append($("#recaptcha"))

  $("input#message_email").keypress ->
    unless $('#recaptcha-contact-email #recaptcha').length>0
      $("#recaptcha-contact-email").append($('#recaptcha'))

  $("input#message_email").change ->
    $("input#message_email").keypress()

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
        "recaptcha_response_field":
          required: true

      messages:
        "recaptcha_response_field":
          required: "Captcha is required"

      errorPlacement: (error, element) ->
        if element.attr('name') == 'recaptcha_response_field'
          error.insertAfter('#recaptcha_area')
        else
          error.insertAfter(element)


  $("#new_live_chat").validate
    rules:
      "live_chat[guest_name]":
        required: true,
        maxlength: 150,
        minlength: 2
      "message":
        required: true,
        maxlength: 255,
        minlength: 2
      "recaptcha_response_field":
        required: true

    messages:
      "recaptcha_response_field":
        required: "Captcha is required"

    errorPlacement: (error, element) ->
      if element.attr('name') == 'recaptcha_response_field'
        error.insertAfter('#recaptcha_area')
      else
        error.insertAfter(element)