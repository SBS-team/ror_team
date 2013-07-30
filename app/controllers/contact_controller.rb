require 'pusher'

Pusher.app_id= '49562'
Pusher.key= '3719c0c90b25b237f538'
Pusher.secret= '628a05f0fcb9d19f4e8a'

class ContactController < ApplicationController

  def index
    @message = Message.new
    @services = Service.all

    @admins = AdminUser.select(:id, :email).where(role: 'manager', status: 'online').order('random()')
    @live_chat = params[:live_chat_id].blank? ? LiveChat.new : LiveChat.find(params[:live_chat_id])
  end

  def create
    @services = Service.all
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => t('.contact_sent_msg'))
    else
      redirect_to contact_index_path  #render :index
    end
  end

  def create_chat
#    render text: params.to_s

    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      @live_chat = LiveChat.new(live_chat_params)
      if @live_chat.save
        message.live_chat = @live_chat
        if message.save
          admin_email = @live_chat.admin_user.email
          channel = 'presence-' + admin_email
          Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
                                                 message: message.body,
                                                 email: @live_chat.guest_name,
                                                 date: message.created_at.strftime('%d-%m-%Y')})
          @live_chat.admin_user.update_attribute(:status, 'chat')
        end
        redirect_to contact_index_path(live_chat_id: @live_chat.id)
      else
        render text: "error!"
      end
    else
      render text:"Invalid Message"
    end

  end

  def chat
#    @live_chat = LiveChat.where("id = :chat_id", chat_id: (params[:id]).to_i).includes(:chat_messages, :admin_user).take
#    gon.current_admin_email = @live_chat.admin_user.email

    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = params[:live_chat_id]
      if message.save
        chat = LiveChat.find(params[:live_chat_id])
        gon.current_admin_email = chat.admin_user.email
        channel = 'presence-' + chat.admin_user.email
        Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
                                               message: message.body,
                                               email: chat.guest_name,
                                               date: message.created_at.strftime('%d-%m-%Y')})
      end
    end
    redirect_to :back
  end


  protected
  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :admin_id)
  end

end
