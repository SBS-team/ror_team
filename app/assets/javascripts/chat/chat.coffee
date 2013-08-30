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
        if $('div').length==0 || ($("#admin-chat").length>0 && !response.data.is_admin)
          tmp = 0
          clearInterval(window.animationTimer)
          tabIconElement = $('#admin_chat_tab_icon')
          window.originalIcon ||= tabIconElement.attr("href")
          receiveMessageIcon = "/receiveMessageIcon.png"
          emptyIcon = "/empty.ico"

          window.animationTimer = window.setInterval(
            ->
              if tmp == 0
                changeIcon(receiveMessageIcon)
                tmp = 1
              else
                changeIcon(emptyIcon)
                tmp = 0
          , 1000
          )

        if $("#chat").length>0
          if response.data.is_admin
            msg_class = "<div class='msg-admin msg'>"
          else
            msg_class = "<div class='msg-user msg'>"
          msg_time = new Date(response.data.date * 1000)
          $("#chat").append msg_class+"(" + msg_time.toLocaleTimeString() + ") | <b><U>" + response.data.name + "</U></b> : " + $("<div/>").text(response.data.message).html() + "</div>"
          $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()
        else
          $(document).mousemove ->
            window.clearInterval(window.animationTimer)
            changeIcon(window.originalIcon)
            window.location.reload()

          $(document).keydown ->
            window.clearInterval(window.animationTimer)
            changeIcon(window.originalIcon)
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