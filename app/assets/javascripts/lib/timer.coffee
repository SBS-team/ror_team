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

      if time
        if (Math.round((new Date()).getTime() / 1000) - parseInt(time)) >= @_seconds
          @_eventFun()
          $.cookie @_name, (Math.round((new Date()).getTime() / 1000)), { expires: 7 , path: '/' }
          window.clearInterval @_timer
      else
        $.cookie @_name, (Math.round((new Date()).getTime() / 1000)), { expires: 7 , path: '/' }

      @startTimer this, @_eventFun

      true

    startTimer: (self, eventFun) ->

      if self._timer
        window.clearInterval(self._timer)

      self._timer = window.setInterval(
        ->
          time = $.cookie self._name

          if (Math.round((new Date()).getTime() / 1000) - parseInt(time)) >= self._seconds
            eventFun()
            window.clearInterval self._timer
            $.cookie self._name, (Math.round((new Date()).getTime() / 1000)), { expires: 7 , path: '/' }

          self.startTimer self, eventFun

      , 1000
      )

      true

  window.Timer = Timer
)()