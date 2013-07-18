class LiveChatController < ApplicationController
  def new
    @admins = AdminUser.select(:id, :email).where(role: 'admin').order('random()')                 #add  .select(status)   .where(status: 'online')
    #@admins = {}
    if @admins.blank?
      render 'live_chat/sorry', layout: false
    else
      @live_chat = LiveChat.new
      render 'live_chat/new', layout: 'chat_layout'
    end
  end

  def create
#    render text: params
    @live_chat = LiveChat.new(live_chat_params)
    if @live_chat.save
      redirect_to live_chat_path(@live_chat)
    else
      render text: "error!"
    end
  end

  def show
    @live_chat = LiveChat.find(params[:id])
    render 'live_chat/show', layout: 'chat_layout'
  end

  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :guest_email, :admin_id)
  end
end
