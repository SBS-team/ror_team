class AuthenticationsController < ApplicationController

  def create
    if user_signed_in?
      redirect_to session[:return_to], :alert => 'Не стоит делать это дважды'
    else
      auth = (env['omniauth.auth'])
      @user = User.find_or_create_by(:uid => auth['uid']) do |user|
        user.password = Devise.friendly_token[0,20]

        auth['provider'] == 'vkontakte' ? user.email = "#{auth['provider']}@#{auth['extra']['screen_name']}.ru" : user.email = "#{auth['provider']}@#{auth['info']['nickname']}.ru"
        auth['provider'] == 'facebook' ? user.email = auth['info']['email'] : user.email = "#{auth['provider']}@#{auth['info']['nickname']}.ru"

        user.provider = auth['provider']
        user.uid = auth['uid']
        auth['provider'] == 'vkontakte' ? user.nickname = auth['info']['name'] : user.nickname = auth['info']['nickname']
        user.image = auth['info']['image']
      end
      sign_in @user
      redirect_to session[:return_to], :notice => 'Loggined successfully!'
    end

  end

  def destroy
    reset_session
    redirect_to :back, :notice => 'Logout successfully!'
  end

end