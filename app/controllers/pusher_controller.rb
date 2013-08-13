class PusherController < ApplicationController
  protect_from_forgery :except => :auth # stop rails CSRF protection for this action

  def auth
    channel = Pusher[params[:channel_name]]
    session[:user_id] ||= rand(1000000)

    # We're allowing anonymous users
    response = channel.authenticate(params[:socket_id], {
        :user_id => session[:user_id],
        :user_info => {}
    })
    render :json => response
  end

end
