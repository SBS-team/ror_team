$(document).ready ->

  if $("#live_chat_admin_id").length
    txt = $("#live_chat_admin_id :selected").text();
  else
    inp = $("#current_admin_email")
    txt = inp.val()

  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe(txt)
  channel.bind "msg-event", (data) ->
    $("#chat-history").append "<div class=msg-admin>"+"(" + data.date + ")|<b><U>" + data.email + "</U></b>:" + data.message + "</div>"