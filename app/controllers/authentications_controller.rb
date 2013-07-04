class AuthenticationsController < ApplicationController

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    sign_in user
    redirect_to @url_back
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end