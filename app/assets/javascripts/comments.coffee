HtmlEncode = (val) ->
  $("<div/>").text(val).html()
HtmlDecode = (val) ->
  $("<div/>").html(val).text()

$(document).ready ->

  if ($.cookie 'nickname')
    $("#comment_nickname").val($.cookie 'nickname')

  # LOAD COMMENTS
  $("#close_comments").hide()
  $("#all_comments").on "click", ->
    id = $(".img img").attr("class")
    $.ajax
      url: "/comment_load"
      data:
        id: id

      type: "post"
      dataType: "json"
      success: (response) ->
        $("#all_comments").hide()
        $("#close_comments").show()
        comments = response.comments
        str = undefined
        i = 0
        $(".comments").slideDown 500, ->
          $.each comments, (key, value) ->
            str = HtmlEncode(comments[key].description)
            $(".comments").prepend "<blockquote style =\"display:none;\" id = " + i + ">" + "<b><span class =\"comment_nickname text-primary\">" + comments[key].nickname + "</span></b><br>" + "<span class = \"comment_description\">" + str + "</span><br>" + "<hr></blockquote>"
            $(".comments blockquote").slideDown "slow"
            i++

        $("#close_comments").on "click", ->
          count = $("blockquote").length
          i = 0

          while i <= count
            $("#" + i + "").slideToggle 500, ->
              $(this).remove()
            i++

          $("#all_comments").show()
          $("#close_comments").hide()

  $("#go_comment").click ->
    $("#new_comment").validate rules:
      "comment[nickname]":
        required: true
        maxlength: 40
        minlength: 2

      "comment[description]":
        required: true
        maxlength: 2048
        minlength: 2

  #CREATE NEW COMMENT
  comment = undefined
  nickname = undefined

  $(document).ajaxSuccess (event, response, settings) ->

    unless ($.cookie 'nickname')
      $.cookie 'nickname', $("#comment_nickname").val(),{ expires: 30 , path: '/'  }
    else
      if ($.cookie 'nickname').toString() != $("#comment_nickname").val()
        $.cookie 'nickname', $("#comment_nickname").val(),{ expires: 30 , path: '/'  }

    if response.responseJSON.stat is "success"

      # IF BEFORE WE GOT INVALID ERRORS CLEAN THEM BEFORE
      if $(".error_messages")
        $("#comment_description").css "box-shadow", "none"
        $("#comment_nickname").css "box-shadow", "none"
        $(".error_messages").remove()
      if response.responseJSON.comment

        # Init variables and add new comment
        comment = HtmlEncode(response.responseJSON.comment.description)
        nickname = response.responseJSON.comment.nickname
        $(".comments").append "<blockquote style =\"display:none;\">" + "<b><span class =\"comment_nickname text-primary\">" + nickname + "</span></b><br>" + "<span class = \"comment_description\">" + comment + "</span><br>" + "<small class = \"comment_time\">just now</small>" + "<hr></blockquote>"
        $(".comments blockquote").slideDown "slow"
      $("#comment_description").val ""
      count = $(".comments_count").text()
      count = parseInt(count) + 1
      if count == 1
        $(".comments_count").text count + " comment"
      else
        $(".comments_count").text count + " comments"