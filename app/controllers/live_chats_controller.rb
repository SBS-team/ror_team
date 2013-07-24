require 'pusher'

Pusher.app_id= '49562'
Pusher.key= '3719c0c90b25b237f538'
Pusher.secret= '628a05f0fcb9d19f4e8a'

class LiveChatsController < ApplicationController
  def new
    @admins = AdminUser.select(:id, :email).where(role: 'admin', status: 'online').order('random()')                 #add  .select(status)   .where(status: 'online')
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
        if message.save
          admin_email = @live_chat.admin_user.email
          channel = admin_email.rpartition("@")[0]
          Pusher[channel].trigger('msg-event', {:message => message.body, :chat_id => chat.id})
          @live_chat.admin_user.status='chat'
        end
        redirect_to live_chat_path(@live_chat)
      else
        render text: "error!"
      end
    else
      render text:"Invalid Message"
    end

  end

#Pusher['my-channel'].trigger('my-event', {:message => msg.name})


  def show
    @live_chat = LiveChat.where("id = :chat_id", chat_id: (params[:id]).to_i).includes(:chat_messages, :admin_user).take #.limit(1)#find(params[:id]) #
    @p = params
    render 'live_chats/show', layout: 'chat_layout'
  end

  def chat
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = params[:live_chat_id]
      if message.save
        chat = LiveChat.find(params[:live_chat_id])
        admin_email = chat.admin_user.email
        channel = admin_email.rpartition("@")[0]
        Pusher[channel].trigger('msg-event', {:message => message.body, :chat_id => chat.id})
      end
    end
    redirect_to :back #'/hello/world' #action: :world #'/hello/world'
  end

  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :guest_email, :admin_id)
  end
end
