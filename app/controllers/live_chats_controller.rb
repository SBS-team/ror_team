require 'pusher'

Pusher.app_id= '49562'
Pusher.key= '3719c0c90b25b237f538'
Pusher.secret= '628a05f0fcb9d19f4e8a'

class LiveChatsController < ApplicationController

  def new
    @admins = AdminUser.select(:id, :email).where(role: 'manager', status: 'online').order('random()')
    if @admins.blank?
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
          channel = admin_email
          Pusher[channel].trigger('msg-event',  {message: message.body, email: @live_chat.guest_email, date: message.created_at.strftime('%d-%m-%Y')})
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
        channel = chat.admin_user.email
        Pusher[channel].trigger('msg-event',  {message: message.body, email: chat.guest_email, date: message.created_at.strftime('%d-%m-%Y')})
      end
    end
    redirect_to :back
  end

  protected
  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :guest_email, :admin_id)
  end
end
