(->
  class Timer
    _name: "timer"
    _seconds: 10
    _eventFun: null
    _timer: null

    constructor: (name, seconds, func) ->
      @_name = name
      @_seconds = seconds
      @_eventFun = func
      @_timer = null

    start: ->

      time = $.cookie @_name

      if time && (parseInt(time) > 1000) && (parseInt(time) < (@_seconds * 1000))
        @_time = parseInt time
      else if parseInt(time) > 0
        @_eventFun()
        $.cookie @_name, (@_seconds * 1000), { expires: 7 , path: '/' }
      else
        $.cookie @_name, (@_seconds * 1000), { expires: 7 , path: '/' }

      @startTimer this, @_eventFun

      true

    startTimer: (self, eventFun) ->

      if self._timer
        window.clearInterval(self._timer)

      self._timer = window.setInterval(
        ->
          time = $.cookie self._name

          time = time - 1000

          $.cookie self._name, time, { expires: 7 , path: '/' }

          if time <= 0

            eventFun()
            window.clearInterval self._timer
            $.cookie self._name, (self._seconds * 1000), { expires: 7 , path: '/' }
            self.startTimer self, eventFun

      , 1000
      )

      true

  window.Timer = Timer
)()