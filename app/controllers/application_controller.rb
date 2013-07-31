class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#  before_filter :assign_gon_properties
  before_filter :banned?

  protected

  def assign_gon_properties
    gon.pusher_config = Webs.pusher_config
  end

  def last_posts_and_jobs
    @last_posts = Post.order('updated_at desc').limit(4)
    @last_jobs = Job.order('updated_at desc').limit(4)
  end

  def banned?
    if current_user.present? && current_user.ban
      sign_out current_user
      flash[:error] = 'This account is banned...'
      root_path
    end
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if !!current_admin_user
      current_admin_user.update_attribute(:status, 'offline') if current_admin_user.role == 'manager'
    end
    root_path
  end

end
