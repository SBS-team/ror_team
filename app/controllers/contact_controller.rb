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
      if params[:small_window]
        render text: t('.contact_sent_msg')
      else
        redirect_to(root_path, :notice => t('.contact_sent_msg'))
      end
    else
      if params[:small_window]
        render 'live_chats/sorry', layout: false
      else
        redirect_to contact_index_path
      end
    end
  end

end