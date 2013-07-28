$(document).ajaxSuccess (event, response, settings) ->
  $('#message').val('')
  $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()


$(document).ready ->
  if $("#live_chat_admin_id").length
    txt = $("#live_chat_admin_id :selected").text();
  else
    txt = gon.current_admin_email

  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe(txt)
  channel.bind "msg-event", (data) ->
    $("#chat").append "<div class='msg-admin msg'>"+"(" + data.date + ")|<b><U>" + data.email + "</U></b>: " + data.message + "</div>"
    $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()