class AdminChatController < ApplicationController

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
    current_admin_user.update_attribute(:busy, false)
    channel = 'presence-' + current_admin_user.first_name+'-'+current_admin_user.last_name
    Webs.pusher
    Webs.notify(:notify_chat_closing, channel, 'admin-close-chat')
    redirect_to admin_manager_chat_index_path
  end

  def go_offline
    if current_admin_user.busy
      channel = 'presence-' + current_admin_user.first_name+'-'+current_admin_user.last_name
      Webs.pusher
      Webs.notify(:notify_chat_closing, channel, 'admin-close-chat')
    end
    current_admin_user.update_attribute(:busy, 'false')
    current_admin_user.update_attribute(:last_activity, 11.minutes.ago)
    render text: 'ok'
  end

end