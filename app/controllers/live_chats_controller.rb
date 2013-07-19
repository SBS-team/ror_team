class LiveChatsController < ApplicationController
  def new
    @admins = AdminUser.select(:id, :email).where(role: 'admin').order('random()')                 #add  .select(status)   .where(status: 'online')
    #@admins = {}
    if @admins.blank?
      render 'live_chats/sorry', layout: false
    else
      @live_chat = LiveChat.new
      render 'live_chats/new', layout: 'chat_layout'
    end
  end

  def create
#    render text: params

    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      @live_chat = LiveChat.new(live_chat_params)
      if @live_chat.save
        message.live_chat = @live_chat
        message.save
        redirect_to live_chat_path(@live_chat)
      else
        render text: "error!"
      end
    else
      render text:"Invalid Message"
    end

  end

  def show
#    @live_chat = LiveChat.where("id = :chat_id", chat_id: (params[:id]).to_i).includes(:chat_messages, :admin_user).take #.limit(1)#find(params[:id]) #
#    @p = params
    render 'live_chats/show', layout: 'chat_layout'
  end

  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :guest_email, :admin_id)
  end

  def message_params
    params.permit(:message)
  end
end
