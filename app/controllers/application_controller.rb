class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :assign_gon_properties

  protected

  def assign_gon_properties
    gon.pusher_config = Webs.pusher_config
  end

  def last_posts_and_jobs
    @last_posts = Post.order('updated_at desc').limit(4).includes(:admin)
    @last_jobs = Job.order('updated_at desc').limit(4)
  end

end
