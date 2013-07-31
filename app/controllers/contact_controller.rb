class ContactController < ApplicationController

  def index
    @message = Message.new
    @services = Service.all
  end

  def create
    @services = Service.all
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => t('.contact_sent_msg'))
    else
      render :index
    end
  end

end
