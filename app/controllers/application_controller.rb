class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def last_posts_and_jobs
    @last_posts = Post.includes(:upload_file).order('updated_at desc').limit(4)
    @last_jobs = Job.includes(:upload_file).order('updated_at desc').limit(4)
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if !!current_admin_user
      current_admin_user.update_attribute(:last_activity, 11.minutes.ago)
    end
    root_path
  end

end