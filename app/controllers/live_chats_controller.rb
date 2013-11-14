class LiveChatsController < ApplicationController

  def new
    @managers = AdminUser.online.select(:id, :first_name, :last_name).where(role: 'manager', busy: false).order('random()')
    @live_chat = LiveChat.new
    respond_to do |format|
      format.js
    end
  end

  def create
    if session[:chat_id].blank?
      @live_chat = LiveChat.new(params.permit(:guest_name, :admin_user_id))
      if verify_recaptcha(model: @live_chat, message: 'You enter wrong captcha', attribute: :base) && @live_chat.save
        session[:chat_id] = @live_chat.id
        channel = 'presence-' + @live_chat.admin_user.first_name + '-' + @live_chat.admin_user.last_name
        # Hello message
        message = @live_chat.chat_messages.create(body: "Hi, #{@live_chat.guest_name} !!!", is_admin: true)
        Webs.pusher
        Webs.notify(:send_chat_message, channel, 'msg-event', {user_id: session[:user_id],
                                                               message: message.body,
                                                               name: @live_chat.guest_name,
                                                               is_admin: message.is_admin,
                                                               date: message.created_at.to_i})
        @live_chat.admin_user.update_attribute(:busy, true)
        respond_to do |format|
          format.js
        end
      else
        render status: 404
      end
    end
  end

  def msg_send
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = session[:chat_id]
      if message.save
        chat = LiveChat.find(session[:chat_id])
        gon.current_admin_channel = chat.admin_user.first_name+'-'+chat.admin_user.last_name
        channel = 'presence-' + chat.admin_user.first_name+'-'+chat.admin_user.last_name
        Webs.pusher
        Webs.notify(:send_chat_message, channel, 'msg-event', {user_id: session[:user_id],
                                                               message: message.body,
                                                               name: @live_chat.guest_name,
                                                               is_admin: message.is_admin,
                                                               date: message.created_at.to_i})
      end
    end
    render nothing: true, status: 200
  end

  def close
    admin_user = AdminUser.joins(:live_chats).where('live_chats.id = :live_chat_id', live_chat_id: session[:chat_id].to_i).readonly(false).take
    if admin_user.busy
      admin_user.update_attribute(:busy, false)
      channel = 'presence-' + admin_user.first_name+'-'+admin_user.last_name
      Webs.pusher
      Webs.notify(:notify_chat_closing, channel, 'user-close-chat')
    end
    session[:chat_id] = nil
    render nothing: true, status: 200
  end

  protected
  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :admin_user_id)
  end

end