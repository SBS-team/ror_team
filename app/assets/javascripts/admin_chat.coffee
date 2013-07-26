
$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()


$(document).ready ->
  inp = $("#current_admin_email")
  txt = inp.val()

  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe(txt)
  channel.bind "msg-event", (data) ->
    if $("#chat").length>0
      $("#chat").append "<div class='msg-admin msg'>"+"(" + data.date + ")|<b><U>" + data.email + "</U></b>: " + data.message + "</div>"
      $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
    else
      window.location.reload true