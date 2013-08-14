$(document).ready ->

  $(".form-search").validate
    rules:
      "search":
        required: true
        maxlength: 50