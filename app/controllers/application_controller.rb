class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :assign_gon_properties

  protected

  def assign_gon_properties
    gon.pusher_config = Webs.pusher_config
  end
end
