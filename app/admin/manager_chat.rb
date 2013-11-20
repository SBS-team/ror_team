ActiveAdmin.register_page 'Manager Chat' do

  page_action :index do
    if !!current_admin_user
      if current_admin_user.busy
        @live_chat = LiveChat.where(admin_user_id: current_admin_user.id).order('updated_at DESC').includes(:admin_user).take
        @messages = ChatMessage.where(live_chat_id: @live_chat.id)
      else
        current_admin_user.update_attribute(:last_activity, DateTime.now)
      end
      gon.pusher_config = Webs.pusher_config
      gon.current_admin_email = current_admin_user.email
      gon.current_admin_channel = current_admin_user.first_name + '-' + current_admin_user.last_name
      #render 'admin/chat', layout: false
      @managers_online = AdminUser.online.where(role: 'manager')
    end
  end

  content do
    panel 'Parse site' do
      div do
        render partial: 'admin/chat'
      end
    end
  end

end