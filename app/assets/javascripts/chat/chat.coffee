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

      @userCloseChatCallback = (->
        alert "User close chat"
        window.location.reload()
      ).bind(@)

      @adminCloseChatCallback = (->
        alert "Admin close chat"
        $("#chat").append "<div>Admin close this chat</div>"
        $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
      ).bind(@)

      @testChannel.bind "msg-event", @testChannelCallback
      @testChannel.bind "user-close-chat", @userCloseChatCallback unless $(".controls-chat").length>0
      @testChannel.bind "admin-close-chat", @adminCloseChatCallback if $(".controls-chat").length>0
  window.Chat = Chat
)()