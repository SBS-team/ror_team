class AdminChatController < ApplicationController

  def chat
    if current_active_admin_user?
      if current_active_admin_user.status == 'chat'
        @live_chat = LiveChat.where(admin_id: current_active_admin_user.id).order("updated_at DESC").take
        @messages = Message.where(live_chat_id: @live_chat.id).limit(10)  ###
      else
        @live_chat = nil
      end
    end
  end

  def send_msg
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = true
      message.live_chat_id = params[:live_chat_id]
      if message.save
        chat = LiveChat.find(params[:live_chat_id])
        admin_email = chat.admin_user.email
        channel = admin_email.rpartition("@")[0]
        Pusher[channel].trigger('msg-event', {:message => message.body, :chat_id => chat.id})
      end
    end
    redirect_to :back #'/hello/world' #action: :world #'/hello/world'
  end
end
