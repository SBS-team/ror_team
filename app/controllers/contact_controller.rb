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
    flash.now[:error] = ''
    if @message.name.nil? || @message.name.empty?
      flash.now[:error] << 'Name cannot be blank.<br/>'
    end
    if @message.email.nil? || @message.email.empty?
      flash.now[:error] << 'Email cannot be blank.<br/>'
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
