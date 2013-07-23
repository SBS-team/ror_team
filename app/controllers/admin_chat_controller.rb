class AdminChatController < ApplicationController

  def chat
    if current_active_admin_user?
      @live_chat = LiveChat.where(admin_id: current_active_admin_user.id).order("updated_at DESC").take
      @messages = Message.where(live_chat_id: @live_chat.id).limit(10)  ###

    end
  end
end
