
$(document).ready ->
  pusher = new Pusher("3719c0c90b25b237f538")
  channel = pusher.subscribe("admin")
  channel.bind "msg-event", (data) ->
    $("#chat-history").append "<div class=msg>" + data.message + "</div>"
    alert "An event was triggered with message: " + data.message