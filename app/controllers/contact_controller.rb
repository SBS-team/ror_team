class ContactController < ApplicationController

  def index
    @message = Message.new
    @services = Service.includes(:upload_file)
  end

  def create
    @message = Message.new(params[:message])
    if verify_recaptcha(model: @message, message: 'You enter wrong captcha', attribute: :base) && @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, notice: t('.contact_sent_msg'))
    else
      flash.now[:error] = @message.errors.full_messages.join(', ')
      @services = Service.includes(:upload_file)
      render :index
    end
  end

end