class ContactController < ApplicationController

  def index
    @message = Message.new
  end

  def new
    @services = Service.all
    @tech_categories = TechnologyCategory.all
  end

  def create
    @message = Message.new(params[:message])
    if @message.name.blank? || @message.email.blank?
      flash.now[:error] << 'Name cannot be blank.<br/>'
    end
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => 'Message was successfully sent.')
    else
      flash.now[:error]
      render :index
    end
  end

end
