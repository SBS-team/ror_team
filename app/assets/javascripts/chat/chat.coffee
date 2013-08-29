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
          tmp = 0
          window.setInterval(
            ->
              if tmp == 0
                $('title').text("title")
                tmp = 1
              else
                $('title').text("*****")
                tmp = 0
          , 500
          )
          $('body').mousemove ->
            window.location.reload()

      ).bind(@)

      @userCloseChatCallback = (->
        alert "User close chat"
        window.location.reload()
      ).bind(@)

      @adminCloseChatCallback = (->
        new_height = $("#chat-history").height() + $('.chat-msg').height()
        $('.chat-msg').remove()
        $("#chat-history").height(new_height)
        $("#chat").append "<div><span class='label label-danger'>Admin close this chat</span></div>"
        $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

        $.post "/chat_close"
      ).bind(@)

      @testChannel.bind "msg-event", @testChannelCallback
      @testChannel.bind "user-close-chat", @userCloseChatCallback if $("#admin-chat").length>0
      @testChannel.bind "admin-close-chat", @adminCloseChatCallback unless $("#admin-chat").length>0
  window.Chat = Chat
)()