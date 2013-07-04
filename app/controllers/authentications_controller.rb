class AuthenticationsController < ApplicationController

  def create
    user = User.create_from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    sign_in user
    redirect_to session[:return_to]
  end

  def destroy
    reset_session
    redirect_to :back
  end

end