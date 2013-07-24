require 'pusher'

Pusher.app_id= '49562'
Pusher.key= '3719c0c90b25b237f538'
Pusher.secret= '628a05f0fcb9d19f4e8a'

class AdminChatController < ApplicationController

  def chat
    if !!current_admin_user
      if current_admin_user.status == 'chat'
        @current_admin_user = current_admin_user
        @live_chat = LiveChat.where(admin_id: current_admin_user.id).order("updated_at DESC").includes(:admin_user).take
        @messages = ChatMessage.where(live_chat_id: @live_chat.id).limit(50)  ###
      else
        @live_chat = nil
        @messages = nil
      end
    end
    render 'admin_chat/chat', layout: false
  end

  def send_msg
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = true
      message.live_chat_id = params[:live_chat_id]
      if message.save
        chat = LiveChat.find(params[:live_chat_id])
        #admin_email = chat.admin_user.email
        #channel = admin_email.rpartition("@")[0]
        #Pusher[channel].trigger('msg-event', {:message => message.body})
        channel = chat.admin_user.email
        Pusher[channel].trigger('msg-event', {:message => message.body})
      end
    end
    redirect_to :back #'/hello/world' #action: :world #'/hello/world'
  end
end
