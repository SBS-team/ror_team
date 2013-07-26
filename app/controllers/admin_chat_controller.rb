require 'pusher'

Pusher.app_id= '49562'
Pusher.key= '3719c0c90b25b237f538'
Pusher.secret= '628a05f0fcb9d19f4e8a'

class AdminChatController < ApplicationController

  def chat
    if current_admin_user.role == 'manager'
      if current_admin_user.status.blank? || current_admin_user.status == 'offline'
        current_admin_user.update_attribute(:status, 'online')
      end
    end
    if !!current_admin_user
      if current_admin_user.status == 'chat'
        @live_chat = LiveChat.where(admin_id: current_admin_user.id).order("updated_at DESC").includes(:admin_user).take
        @messages = ChatMessage.where(live_chat_id: @live_chat.id).limit(50)
      else
        @live_chat = nil
        @messages = nil
      end
      render 'admin_chat/chat', layout: false
    else
      render text: "You must log in as manager"
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
        channel = chat.admin_user.email
        Pusher[channel].trigger('msg-event', {message: message.body, email: chat.admin_user.email, date: message.created_at.strftime('%d-%m-%Y')})
      end
    end
    redirect_to :back
  end

  def close
    admin = AdminUser.where(email: params[:admin_email]).take
    admin.update_attribute(:status, 'online')
    redirect_to action: 'chat'
  end
end