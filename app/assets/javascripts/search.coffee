$(document).ready ->

  $(".form-search").validate
    rules:
      "search":
        maxlength: 50