class ContactController < ApplicationController

  def index
    @message = Message.new
    @services = Service.includes(:upload_file)
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => t('.contact_sent_msg'))
    else
      redirect_to(contact_index_path, :alert => @message.errors.full_messages.join(' '))
    end
  end

end