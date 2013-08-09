require 'pusher'

class LiveChatsController < ApplicationController

  def new
    @admins = AdminUser.select(:id, :first_name, :last_name).where(role: 'manager', status: 'online').order('random()')
    if @admins.blank?
      @message = Message.new
      render 'live_chats/sorry', layout: false
    else
      @live_chat = LiveChat.new
      render 'live_chats/new', layout: 'chat_layout'
    end
  end

  def create
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      @live_chat = LiveChat.new(live_chat_params)
      if @live_chat.save
        message.live_chat = @live_chat
        if message.save
          admin_email = @live_chat.admin_user.email
          channel = 'presence-' + @live_chat.admin_user.first_name+"-"+@live_chat.admin_user.last_name #admin_email
          Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
                                                 message: message.body,
                                                 name: @live_chat.guest_name,
                                                 is_admin: message.is_admin,
                                                 date: message.created_at.to_i})
          @live_chat.admin_user.update_attribute(:status, 'chat')
        end
        redirect_to live_chat_path(@live_chat)
      else
        render text: "error!"
      end
    else
      render text:"Invalid Message"
    end
  end


  def show
    @live_chat = LiveChat.where("id = :chat_id", chat_id: (params[:id]).to_i).includes(:chat_messages, :admin_user).take
    gon.current_admin_email = @live_chat.admin_user.email
    gon.current_admin_channel = @live_chat.admin_user.first_name+"-"+@live_chat.admin_user.last_name
    render 'live_chats/show', layout: 'chat_layout'
  end

  def chat
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = params[:live_chat_id]
      if message.save
        chat = LiveChat.find(params[:live_chat_id])
        channel = 'presence-' + chat.admin_user.first_name+"-"+chat.admin_user.last_name #chat.admin_user.email
        Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
                                               message: message.body,
                                               name: chat.guest_name,
                                               is_admin: message.is_admin,
                                               date: message.created_at.to_i})
      end
    end
    redirect_to :back
  end

  protected
  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :admin_id)
  end
end
