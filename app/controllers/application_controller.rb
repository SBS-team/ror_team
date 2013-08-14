class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :assign_gon_properties
  before_action :initialize_live_chat

  protected
  def assign_gon_properties
    gon.pusher_config = Webs.pusher_config
  end

  def last_posts_and_jobs
    @last_posts = Post.includes(:upload_file).order('updated_at desc').limit(4)
    @last_jobs = Job.includes(:upload_file).order('updated_at desc').limit(4)
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if !!current_admin_user
      current_admin_user.update_attribute(:status, 'offline') if current_admin_user.role == 'manager'
    end
    root_path
  end

  def initialize_live_chat
    if session[:chat_id]
      @live_chat = LiveChat.includes(:admin_user).find(session[:chat_id])
      gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
    end
  end

end