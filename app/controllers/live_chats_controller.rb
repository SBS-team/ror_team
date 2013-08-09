class LiveChatsController < ApplicationController

  before_action :initialize_chat

  def create_chat
    if session[:chat_id].blank?
      session[:show_chat] = true
      unless params[:message].blank?
        message = ChatMessage.new(:body => params[:message], :is_admin => false, :live_chat_id => 1)
        if message.valid?
          @live_chat = LiveChat.new(live_chat_params)
          if @live_chat.save
            session[:chat_id] = @live_chat.id
            message.live_chat = @live_chat
            if message.save
              admin_email = @live_chat.admin_user.email
              gon.current_admin_email = admin_email
              gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              channel = 'presence-' + @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
                                                     message: message.body,
                                                     name: @live_chat.guest_name,
                                                     is_admin: message.is_admin,
                                                     date: message.created_at.to_i})
              @live_chat.admin_user.update_attribute(:status, 'chat')
            else
              redirect_to :back, :notice => 'Invalid Message'
            end
            redirect_to :back, :notice => 'Start chat'
          else
            redirect_to :back, :alert =>  'Chat start error! Invalid name !'
          end
        else
          redirect_to :back, :alert =>  'error!'
        end
      else
        redirect_to :back, :alert => 'Invalid Message'
      end
    end
  end

  def chat
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = session[:chat_id]
      if message.save
        chat = LiveChat.find(session[:chat_id])
        gon.current_admin_channel = chat.admin_user.first_name+'-'+chat.admin_user.last_name
        gon.current_admin_email = chat.admin_user.email
        channel = 'presence-' + chat.admin_user.first_name+'-'+chat.admin_user.last_name #chat.admin_user.email
        Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
                                               message: message.body,
                                               name: chat.guest_name,
                                               is_admin: message.is_admin,
                                               date: message.created_at.to_i})
      end
    end
    redirect_to :back
  end

  def chat_close
    session[:chat_id] = nil
    session[:show_chat] = false
    render text: 'ok!'
  end


  protected

  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :admin_id)
  end

  def initialize_chat
    @admins = AdminUser.select(:id, :first_name, :last_name).where(role: 'manager', status: 'online').order('random()')
    @message = Message.new

    if session[:chat_id].blank?
      @live_chat = LiveChat.new
      gon.current_admin_email = nil
      gon.current_admin_channel = nil
      gon.show_chat = session[:show_chat]
    else
      @live_chat = LiveChat.find(session[:chat_id])
      gon.current_admin_email = @live_chat.admin_user.email
      gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
      gon.show_chat = session[:show_chat]
    end
  end

end
