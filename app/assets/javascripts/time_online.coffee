timerOnline = null
seconds = 10*60

setTime = ->
  time = $.cookie 'time'
  if (time != null)
    oldTime = new Date(time)
    curTime = new Date()
    subTime = curTime.getTime() - oldTime.getTime()
    if (subTime <= (seconds + 10) * 1000) && (subTime >= (seconds - 10) * 1000)
      $.cookie 'time', new Date(), { expires: 7 , path: '/' }
      time = seconds*1000
      $.post "/admin/time_online"
    else if (subTime <= (seconds + 1) * 1000)
      time = seconds*1000 - subTime
    else
      $.cookie 'time', new Date(), { expires: 7 , path: '/' }
      time = seconds*1000
  else
    $.cookie 'time', new Date(), { expires: 7 , path: '/' }
    time = seconds*1000
  clearInterval(timerOnline)
  timerOnline = window.setInterval(setTime, time)

$(document).ready ->
  setTime()