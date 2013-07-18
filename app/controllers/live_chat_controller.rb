class LiveChatController < ApplicationController
  def new
    @admins = AdminUser.select(:email).where(role: 'admin').order('random()')                 #add  .select(status)   .where(status: 'online')
    #@admins = {}
    if @admins.blank?
      render 'live_chat/sorry', layout: false
    else
      @live_chat = LiveChat.new
      render 'live_chat/new', layout: 'chat_layout'
    end
  end

  def create
    render action: :show
  end

  def show
    render text: "showww", layout: false
  end
end
