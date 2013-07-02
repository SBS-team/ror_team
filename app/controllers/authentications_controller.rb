class AuthenticationsController < ApplicationController

  def create
    user = User.create_from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    sign_in user
    redirect_to '/posts'
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end