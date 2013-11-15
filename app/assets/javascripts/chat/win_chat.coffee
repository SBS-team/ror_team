# This class use: jquery & jquery-ui
(->
  class WinChat
    _win_chat: null
    _button: null
    _chat: null

    constructor: (button = $('.chat-button-fix')) ->
      # Button for showing chat window
      @_button = button
      self = @
      @_button.click (event) ->
        event.preventDefault()
        self._button.hide 500, ->
          self.show_dialog()
        false

      if $('#user_chat').length > 0
        self.connection(RorTeam.currentAdminChannel)
        self._win_chat = $('#user_chat')
        self.init()
        self.show_dialog()
        $('.comment').emoticonize()

    connection: (connection_string) ->
      @_chat = new Chat('presence-' + connection_string)

    init: ->
      self = @
      @_win_chat.draggable
        handle: '#chat_handle'
      #================================== Chat header button click action
      $('#user_chat_hide').click ->
        self.hide_dialog()
      $('#user_chat_close').click ->
        self.close_dialog()
      #================================== Send chat message button
      $('#msg_submit').click (event) ->
        event.preventDefault()
        $('#new_live_chat').submit()
        $("#message").val('')
        $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

    #************************************ Show chat function
    show_dialog: ->
      if $('#user_chat').length == 0
        @load_chat()
      else
        @_win_chat.show()

    #************************************ Hide chat function
    hide_dialog: ->
      @_button.show(600)
      button = @_button
      @_win_chat.effect "transfer",
        to: button,
        600
      @_win_chat.hide()

    #************************************ Close chat function
    close_dialog: ->
      self = @
      if $('#chat-history').length > 0
        close_chat = $.post 'chat/close'
        close_chat.success ->
          self._win_chat.remove()
          self._chat = null
      else
        self._win_chat.remove()
        self._chat = null
      @_button.show(600)

    #************************************ Helper chat function
    load_chat: ->
      self = @
      chat_load = $.post 'chat/new'
      chat_load.success ->
        self._win_chat = $('#user_chat')
        self.init()
        self.chat_on_create()
        self._win_chat.show()

    chat_on_create: ->
      self = @
      $('#user_chat_create').click (event) ->
        event.preventDefault()
        connection_string = $("#admin_user_id :selected").text().replace(' ', '-')
        form_data = $('#new_live_chat').serialize()

        $.post('chat/create', form_data, ->
            self.connection(connection_string)
            self.init()
          ).fail((data) ->
            data_new = $.parseJSON(data.responseText)
            new_span = ''
            index = 1

            $.each data_new.errors, (key, value) ->
              new_span += "<div>#{index++}) #{value}</div>"

            if $('.user_chat-error').length > 0
              $('.user_chat-error').remove()

            $('#user_chat_content').prepend "<div class='user_chat-error'>#{new_span}</div>"
            Recaptcha.reload()
        )

  window.WinChat = WinChat
)()