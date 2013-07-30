class ContactController < ApplicationController

  def index
    @message = Message.new
    @services = Service.all

    @admins = AdminUser.select(:id, :email).where(role: 'manager', status: 'online').order('random()')
    @live_chat ||= LiveChat.new
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
    render text: params.to_s
=begin
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
                                                 email: @live_chat.guest_email,
                                                 date: message.created_at.strftime('%d-%m-%Y')})
          @live_chat.admin_user.update_attribute(:status, 'chat')
        end
        redirect_to contact_index_path
      else
        render text: "error!"
      end
    else
      render text:"Invalid Message"
    end
=end
  end

end
