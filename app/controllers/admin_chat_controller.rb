class AdminChatController < ApplicationController

  def chat
    if current_admin_user.role == 'manager'
      if current_admin_user.status.blank? || current_admin_user.status == 'offline'
        current_admin_user.update_attribute(:status, 'online')
      end
    end
    if !!current_admin_user
      if current_admin_user.status == 'chat'
        @live_chat = LiveChat.where(admin_user_id: current_admin_user.id).order('updated_at DESC').includes(:admin_user).take
        @messages = ChatMessage.where(live_chat_id: @live_chat.id)
      end
      gon.current_admin_email = current_admin_user.email
      gon.current_admin_channel = current_admin_user.first_name+"-"+current_admin_user.last_name
      render 'admin_chat/chat', layout: false
    else
      render text: 'You must log in as manager'
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
        channel = 'presence-' + chat.admin_user.first_name+'-'+chat.admin_user.last_name
        Webs.pusher
        Webs.notify(:send_chat_message, channel, 'msg-event', {user_id: session[:user_id],
                                                               message: message.body,
                                                               name: chat.admin_user.first_name+'-'+chat.admin_user.last_name,
                                                               is_admin: message.is_admin,
                                                               date: message.created_at.to_i})
      end
    end
    render nothing: true
  end

  def close
    current_admin_user.update_attribute(:status, 'online')
    channel = 'presence-' + current_admin_user.first_name+'-'+current_admin_user.last_name
    Webs.pusher
    Webs.notify(:notify_chat_closing, channel, 'admin-close-chat')
    redirect_to admin_start_chat_path
  end

end