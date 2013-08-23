class ContactController < ApplicationController

  before_action :initialize_live_chat

  def index
    @message = Message.new
    @services = Service.includes(:upload_file)
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, notice: t('.contact_sent_msg'))
    else
      flash[:error] = @message.errors.full_messages.join(', ')
      @services = Service.includes(:upload_file)
      render :index
    end
  end

  def initialize_live_chat
    if session[:chat_id]
      @live_chat = LiveChat.includes(:admin_user).find(session[:chat_id])
      gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
    else
      @admins = AdminUser.online.select(:id, :first_name, :last_name).where(role: 'manager', status: 'online').order('random()')
      @live_chat = LiveChat.new
    end
  end

end