(->
  class WinChat
    _win_chat: null
    _button: null
    _chat: null

    constructor: (button) ->
      @_button = button
      self = @

      @_button.click ->
        button.hide 500, ->
          self.load_chat()
        false

      if $('#user_chat').length > 0
        self._chat = new Chat('presence-' + RorTeam.currentAdminChannel)
        self._win_chat = $('#user_chat')
        self.init()
        self.show_dialog()

        $('#msg_submit').click (event) ->
          event.preventDefault()
          $('#new_live_chat').submit()
          $("#message").val('')
          $("#chat-history").scrollTop $("#chat").height()-$(".msg:last").height()

    init: ->
      self = @
      @_win_chat.draggable
        handle: '#chat_handle'
      $('#user_chat_hide').click ->
        self.hide_dialog()
      $('#user_chat_close').click ->
        $.post '/chat_close'
        self._win_chat.remove()
        self.hide_dialog()

    load_chat: ->
      self = @
      if $('#user_chat').length == 0
        chat_load = $.post 'chat/new'
        chat_load.success ->
          self._win_chat = $('#user_chat')
          self.init()
          self.show_dialog()
          self.chat_create()
      else
        self.show_dialog()

    chat_create: ->
      self = @
      $('#new_live_chat').submit ->
        alert "Submit"

    hide_dialog: ->
      @_button.show(600)
      button = @_button
      @_win_chat.effect "transfer",
        to: button,
        600
      @_win_chat.hide()
      false

    show_dialog: ->
      @_win_chat.show()
      false


  window.WinChat = WinChat
)()