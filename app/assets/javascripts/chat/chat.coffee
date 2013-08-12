(->
  class Chat
    constructor: ->
      @initialize()

    initialize: ->
      @pusher = (new Webs()).pusher
      @testChannel = @pusher.subscribe 'test-channel'
      @listenTestChannel()

    listenTestChannel: ->
      @testChannelCallback = ((response)->
        alert response.data.message
        console.log response.data
      ).bind(@)
      @testChannel.bind "test-event", @testChannelCallback
  window.Chat = Chat
)()