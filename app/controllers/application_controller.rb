class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :assign_gon_properties
  before_action :initialize_chat

  def create_chat
    if session[:chat_id].blank?
      session[:show_chat] = true
      unless params[:message].blank?
        message = ChatMessage.new(:body => params[:message], :is_admin => false, :live_chat_id => 1)
        if message.valid?
          @live_chat = LiveChat.new(live_chat_params)
          if @live_chat.save
            session[:chat_id] = @live_chat.id
            message.live_chat = @live_chat
            if message.save
              admin_email = @live_chat.admin_user.email
              gon.current_admin_email = admin_email
              gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              channel = 'presence-' + @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              #Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
              #                                     message: message.body,
              #                                     name: @live_chat.guest_name,
              #                                     is_admin: message.is_admin,
              #                                     date: message.created_at.to_i})
              Webs.pusher
              Webs.notify(:test_event)
              @live_chat.admin_user.update_attribute(:status, 'chat')
            end
            redirect_to :back, :notice => 'Start chat'
          end
        else
          render text: 'error!'
        end
      else
        render text:'Invalid Message'
      end
    end
  end

  def chat

    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = session[:chat_id]
      if message.save
        chat = LiveChat.find(session[:chat_id])
        gon.current_admin_channel = chat.admin_user.first_name+'-'+chat.admin_user.last_name
        gon.current_admin_email = chat.admin_user.email
        channel = 'presence-' + chat.admin_user.first_name+'-'+chat.admin_user.last_name #chat.admin_user.email
        Webs.pusher
        Webs.notify(:test_event)
        #Pusher[channel].trigger('msg-event',  {:user_id => session[:user_id],
        #                                       message: message.body,
        #                                       name: chat.guest_name,
        #                                       is_admin: message.is_admin,
        #                                       date: message.created_at.to_i})
      end
    end
    redirect_to :back
  end

  def chat_close
    session[:chat_id] = nil
    session[:show_chat] = false
    render text: 'ok!'
  end

  protected

  def assign_gon_properties
    gon.pusher_config = Webs.pusher_config
  end

  def last_posts_and_jobs
    @last_posts = Post.includes(:upload_file).order('updated_at desc').limit(4)
    @last_jobs = Job.includes(:upload_file).order('updated_at desc').limit(4)
  end

  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :admin_id)
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if !!current_admin_user
      current_admin_user.update_attribute(:status, 'offline') if current_admin_user.role == 'manager'
    end
    root_path
  end

  def initialize_chat
    @admins = AdminUser.select(:id, :first_name, :last_name).where(role: 'manager', status: 'online').order('random()')
    @message = Message.new

    if session[:chat_id].blank?
      @live_chat = LiveChat.new
      gon.current_admin_email = nil
      gon.current_admin_channel = nil
      gon.show_chat = session[:show_chat]
    else
      @live_chat = LiveChat.find(session[:chat_id])
      gon.current_admin_email = @live_chat.admin_user.email
      gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
      gon.show_chat = session[:show_chat]
    end
  end

end
