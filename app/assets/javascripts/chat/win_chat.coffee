(->
  class WinChat
    _self: null
    _win_chat: null
    _button: null

    constructor: ->
      @_win_chat = $('#user_chat')
      @_win_chat.draggable
        handle: '#chat_handle'
      @_self = @

    hide_dialog: ->
      @_button.show(600)
      button = @_button
      @_win_chat.effect "transfer",
        to: button,
        600
      @_win_chat.hide()
      false

    show_dialog: ->
      @_button.hide(600)
      @_win_chat.show()
      false

    init: (button) ->
      @_button = button
      dialog = @_self

      @_win_chat.find('#chat_hide').click ->
        dialog.hide_dialog()

      @_button.click ->
        dialog.show_dialog()


  window.WinChat = WinChat
)()