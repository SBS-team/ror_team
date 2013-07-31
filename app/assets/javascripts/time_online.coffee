createCookie = (name, value, days) ->
  if days
    date = new Date()
    date.setTime date.getTime() + (days * 24 * 60 * 60 * 1000)
    expires = "; expires=" + date.toGMTString()
  else
    expires = ""
  document.cookie = escape(name) + "=" + escape(value) + expires + "; path=/"

readCookie = (name) ->
  nameEQ = escape(name) + "="
  ca = document.cookie.split(";")
  i = 0
  while i < ca.length
    c = ca[i]
    c = c.substring(1, c.length)  while c.charAt(0) is " "
    return unescape(c.substring(nameEQ.length, c.length))  if c.indexOf(nameEQ) is 0
    i++
  null

eraseCookie = (name) ->
  createCookie name, "", -1

timerOnline = null
seconds = 10*60

setTime = ->
  time = readCookie("time")
  if (time != null)
    oldTime = new Date(time)
    curTime = new Date()
    subTime = curTime.getTime() - oldTime.getTime()
    if (subTime <= (seconds + 10) * 1000) && (subTime >= (seconds - 10) * 1000)
      createCookie "time", new Date(), 10
      time = seconds*1000
      $.post "/admin/time_online"
    else if (subTime <= (seconds + 1) * 1000)
      time = seconds*1000 - subTime
    else
      createCookie "time", new Date(), 10
      time = seconds*1000
  else
    createCookie "time", new Date(), 10
    time = seconds*1000
  clearInterval(timerOnline)
  timerOnline = window.setInterval(setTime, time)

$(document).ready ->
  setTime()