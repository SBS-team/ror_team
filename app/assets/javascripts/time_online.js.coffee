actionTimer = ->
  $.post "/admin/time_online"

$(document).ready ->
  onlineTimer = new Timer("online", 600, actionTimer)
  onlineTimer.start()