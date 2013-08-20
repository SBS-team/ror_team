class LiveChatsController < ApplicationController

  def new_chat
    @admins = AdminUser.select(:id, :first_name, :last_name).where(role: 'manager', status: 'online').order('random()')
    @live_chat = LiveChat.new
    respond_to do |format|
      format.js { render :new_chat }
    end
  end

  def create_chat
    if session[:chat_id].blank?
      unless params[:message].blank?
        message = ChatMessage.new(:body => params[:message], :is_admin => false, :live_chat_id => 1)
        if message.valid?
          @live_chat = LiveChat.new(live_chat_params)
          if @live_chat.save
            session[:chat_id] = @live_chat.id
            message.live_chat = @live_chat
            if message.save
              gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              channel = 'presence-' + @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              Webs.pusher
              Webs.notify(:send_chat_message, channel, 'msg-event', { :user_id => session[:user_id],
                                                                      message: message.body,
                                                                      name: @live_chat.guest_name,
                                                                      is_admin: message.is_admin,
                                                                      date: message.created_at.to_i})
              @live_chat.admin_user.update_attribute(:status, 'chat')
            else
              redirect_to :back, :notice => 'Invalid Message'
            end
              respond_to do |format|
                format.js { render :create_chat }
              end
          else
            redirect_to :back, :alert =>  'Chat start error! Invalid name !'
          end
        else
          redirect_to :back, :alert =>  'error!'
        end
      else
        redirect_to :back, :alert => 'Invalid Message'
      end
    else
      redirect_to :back, :alert => 'Chat already start'
    end
  end

  def send_msg
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = session[:chat_id]
      if message.save
        chat = LiveChat.find(session[:chat_id])
        gon.current_admin_channel = chat.admin_user.first_name+'-'+chat.admin_user.last_name
        channel = 'presence-' + chat.admin_user.first_name+'-'+chat.admin_user.last_name #chat.admin_user.email
        Webs.pusher
        Webs.notify(:send_chat_message, channel, 'msg-event', { :user_id => session[:user_id],
                                                                message: message.body,
                                                                name: @live_chat.guest_name,
                                                                is_admin: message.is_admin,
                                                                date: message.created_at.to_i})
      end
    end
    render nothing: true
  end

  def chat_close
    admin_user = AdminUser.joins(:live_chats).where("live_chats.id = :live_chat_id", live_chat_id: session[:chat_id].to_i).readonly(false).take
    if admin_user.status == 'chat'
      admin_user.update_attribute(:status, 'online')
      channel = 'presence-' + admin_user.first_name+'-'+admin_user.last_name
      Webs.pusher
      Webs.notify(:notify_chat_closing, channel, 'user-close-chat')
    end
    session[:chat_id] = nil

    @admins = AdminUser.select(:id, :first_name, :last_name).where(role: 'manager', status: 'online').order('random()')

    respond_to do |format|
      format.js { render :chat_close }
    end
  end

  protected

  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :admin_id)
  end

end
