(->
  class Chat
    constructor: (channel_name) ->
      @initialize channel_name

    initialize: (channel_name) ->
      @pusher = (new Webs()).pusher
      @testChannel = @pusher.subscribe channel_name
      @listenTestChannel()

    listenTestChannel: ->
      @testChannelCallback = ((response)->
        if $("#chat").length>0
          if response.data.is_admin
            msg_class = "<div class='msg-admin msg'>"
          else
            msg_class = "<div class='msg-user msg'>"
          msg_time = new Date(response.data.date * 1000)
          $("#chat").append msg_class+"(" + msg_time.toLocaleTimeString() + ") | <b><U>" + response.data.name + "</U></b> : " + $("<div/>").text(response.data.message).html() + "</div>"
          $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
        else
          window.location.reload()
      ).bind(@)
      @testChannel.bind "msg-event", @testChannelCallback
  window.Chat = Chat
)()